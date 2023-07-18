package com.ambh.example.lambdards.persistence;

import com.ambh.example.lambdards.model.Book;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class BookDao implements Dao<Book> {

    private final Logger logger = LoggerFactory.getLogger(BookDao.class);
    private Connection connection;
    private final DbConnUtils dbConnUtils;

    public BookDao(DbConnUtils dbConnUtils) {
        this.dbConnUtils = dbConnUtils;
        this.connection = dbConnUtils.createConnectionViaIamAuth();
    }

    @Override
    public Optional<Book> get(long id) {
        throw new UnsupportedOperationException();
    }

    @Override
    public List<Book> getAll() {
        connection = dbConnUtils.refreshConnection(connection);

        String SQL_SELECT = "SELECT * FROM book";
        List<Book> result = new ArrayList<>();

        try (PreparedStatement preparedStatement = connection.prepareStatement(SQL_SELECT)) {
            if (!connection.isValid(1)) throw new RuntimeException();
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {

                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String author = resultSet.getString("author");
                result.add(Book.builder()
                        .id(id)
                        .name(name)
                        .author(author)
                        .build()
                );
            }

            return result;

        } catch (SQLException e) {
            logger.error("SQL State: {}, Message: {}", e.getSQLState(), e.getMessage());
            throw new RuntimeException(e.getMessage());
        } catch (Exception e) {
            logger.error("Message: {}", e.getMessage());
            throw new RuntimeException(e.getMessage());
        }
    }

    @Override
    public void save(Book book) {
        throw new UnsupportedOperationException();
    }

    @Override
    public void update(Book book, String[] params) {
        throw new UnsupportedOperationException();
    }

    @Override
    public void delete(Book book) {
        throw new UnsupportedOperationException();
    }
}
