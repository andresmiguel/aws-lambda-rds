package com.ambh.example.lambdards;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.ambh.example.lambdards.model.Book;
import com.ambh.example.lambdards.persistence.BookDao;
import com.ambh.example.lambdards.persistence.DbConnUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import utils.JSONService;

import java.util.List;
import java.util.Map;

public class GetBooksHandler implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayProxyResponseEvent> {

    private final Logger logger = LoggerFactory.getLogger(GetBooksHandler.class);

    private final JSONService jsonService;
    private final BookDao bookDao;

    public GetBooksHandler() {
        DbConnUtils dbConnUtils = new DbConnUtils();
        this.jsonService = new JSONService();
        this.bookDao = new BookDao(dbConnUtils);
    }

    public APIGatewayProxyResponseEvent handleRequest(final APIGatewayV2HTTPEvent input, final Context context) {
        logger.debug("Starting GetPrivateConversationsHandler request");

        APIGatewayProxyResponseEvent response = new APIGatewayProxyResponseEvent()
                .withHeaders(HEADERS);

        try {
            List<Book> result = bookDao.getAll();
            int responseStatusCode = result != null && !result.isEmpty() ? 200 : 204;

            return response
                    .withBody(jsonService.asString(result))
                    .withStatusCode(responseStatusCode);
        } catch (Exception e) {
            logger.error("There was an error. See the stack trace for more info", e);
            return response
                    .withStatusCode(500);
        }
    }

    private static final Map<String, String> HEADERS = Map.of(
            "Content-Type", "application/json"
    );

}
