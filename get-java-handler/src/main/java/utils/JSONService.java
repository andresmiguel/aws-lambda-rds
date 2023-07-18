package utils;

import com.fasterxml.jackson.jr.ob.JSON;

import java.io.IOException;
import java.util.List;

public class JSONService {

    private final JSON json;

    public JSONService() {
        this.json = JSON.std;
    }

    public JSONService(JSON json) {
        this.json = json;
    }

    public byte[] asBytes(Object o) {
        try {
            return this.json
                    .without(JSON.Feature.WRITE_NULL_PROPERTIES)
                    .asBytes(o);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public String asString(Object o) {
        try {
            return this.json
                    .without(JSON.Feature.WRITE_NULL_PROPERTIES)
                    .asString(o);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public <T> List<T> listFrom(String json, Class<T> targetClass) {
        try {
            return this.json.listOfFrom(targetClass, json);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
