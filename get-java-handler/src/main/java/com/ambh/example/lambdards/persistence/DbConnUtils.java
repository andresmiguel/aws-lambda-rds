package com.ambh.example.lambdards.persistence;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import software.amazon.awssdk.auth.credentials.DefaultCredentialsProvider;
import software.amazon.awssdk.core.SdkSystemSetting;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.rds.RdsUtilities;
import software.amazon.awssdk.services.rds.model.GenerateAuthenticationTokenRequest;

import java.io.File;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;


public class DbConnUtils {

    private static final Logger logger = LoggerFactory.getLogger(DbConnUtils.class);
    public static final String SSL_CERTIFICATE = "rds-ca-2019-root.pem";
    private static final String DB_USER = System.getenv("DB_USER");
    private static final String DB_ENDPOINT = System.getenv("DB_ENDPOINT");
    private static final String DB_NAME = System.getenv("DB_NAME");
    private static final String AWS_REGION = Region.of(System.getenv(SdkSystemSetting.AWS_REGION.environmentVariable())).toString();
    private static final int DB_PORT = 5432;

    public DbConnUtils() {
    }

    /**
     * Creates a DB Connection using IAM Authentication
     *
     * @return DB Connection
     */
    public Connection createConnectionViaIamAuth() {
        Connection connection;
        try {
            connection = DriverManager.getConnection(
                    String.format("jdbc:postgresql://%s:%d/%s", DB_ENDPOINT, DB_PORT, DB_NAME),
                    getPostgresConnectionProperties());
            return connection;

        } catch (Exception e) {
            logger.error("Connection FAILED: {}", e.getMessage());
            throw new RuntimeException("Error creating DB connection");
        }
    }

    /**
     * Refreshes the DB connection if a warm lambda has a stale connection.
     *
     * @param currConn the current connection to refresh
     *
     * @return the fresh connection or the existing one in case is still valid
     */
    public Connection refreshConnection(Connection currConn) {
        try {
            if (currConn == null || !currConn.isValid(1)) {
                return createConnectionViaIamAuth();
            }
            return currConn;
        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
            throw new RuntimeException("There was a problem refreshing the DB Connection");
        }
    }

    public String generateAuthToken(String username, String dbEndpoint, String region, int port) {
        RdsUtilities utilities = RdsUtilities.builder()
                .credentialsProvider(DefaultCredentialsProvider.create())
                .region(Region.of(region))
                .build();

        GenerateAuthenticationTokenRequest authTokenRequest = GenerateAuthenticationTokenRequest.builder()
                .username(username)
                .hostname(dbEndpoint)
                .port(port)
                .build();

        return utilities.generateAuthenticationToken(authTokenRequest);
    }

    private Properties getPostgresConnectionProperties() {
        Properties connectionProperties = new Properties();
        connectionProperties.setProperty("sslmode", "verify-full");
        connectionProperties.setProperty("sslrootcert", getCertPath());
        connectionProperties.setProperty("user", DB_USER);
        connectionProperties.setProperty("password",
                generateAuthToken(DB_USER, DB_ENDPOINT, AWS_REGION, DB_PORT)
        );

        return connectionProperties;
    }

    private String getCertPath() {
        try {
            URL url = DbConnUtils.class.getResource("/" + SSL_CERTIFICATE);
            File file = Paths.get(url.toURI()).toFile();
            return file.getAbsolutePath();
        } catch (URISyntaxException e) {
            throw new RuntimeException(e);
        }
    }

}