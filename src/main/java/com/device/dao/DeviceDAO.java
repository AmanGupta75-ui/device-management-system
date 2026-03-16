package com.device.dao;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.device.model.Device;

public class DeviceDAO {
    private static final String CONNECTION_STRING = "mongodb://localhost:27017";
    private static final String DATABASE_NAME = "device_db";
    private static final String COLLECTION_NAME = "devices";

    public DeviceDAO() {
    }

    private MongoClient getMongoClient() {
        return MongoClients.create(CONNECTION_STRING);
    }

    public void insertDevice(Device device) {
        try (MongoClient mongoClient = getMongoClient()) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);

            Document doc = new Document("name", device.getName())
                    .append("type", device.getType())
                    .append("serial_number", device.getSerialNumber())
                    .append("status", device.getStatus())
                    .append("last_maintained", device.getLastMaintained() != null ? device.getLastMaintained().toString() : null);

            collection.insertOne(doc);
        }
    }

    public Device selectDevice(String id) {
        Device device = null;
        try (MongoClient mongoClient = getMongoClient()) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);

            Document doc = collection.find(Filters.eq("_id", new ObjectId(id))).first();
            if (doc != null) {
                device = documentToDevice(doc);
            }
        }
        return device;
    }

    public List<Device> selectAllDevices() {
        List<Device> devices = new ArrayList<>();
        try (MongoClient mongoClient = getMongoClient()) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);

            for (Document doc : collection.find()) {
                devices.add(documentToDevice(doc));
            }
        }
        return devices;
    }

    public boolean deleteDevice(String id) {
        try (MongoClient mongoClient = getMongoClient()) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);

            return collection.deleteOne(Filters.eq("_id", new ObjectId(id))).getDeletedCount() > 0;
        }
    }

    public boolean updateDevice(Device device) {
        try (MongoClient mongoClient = getMongoClient()) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);

            Document doc = new Document("name", device.getName())
                    .append("type", device.getType())
                    .append("serial_number", device.getSerialNumber())
                    .append("status", device.getStatus())
                    .append("last_maintained", device.getLastMaintained() != null ? device.getLastMaintained().toString() : null);

            return collection.updateOne(Filters.eq("_id", new ObjectId(device.getId())), 
                    new Document("$set", doc)).getModifiedCount() > 0;
        }
    }

    private Device documentToDevice(Document doc) {
        ObjectId objectId = doc.getObjectId("_id");
        String id = objectId != null ? objectId.toHexString() : null;
        String name = doc.getString("name");
        String type = doc.getString("type");
        String serialNumber = doc.getString("serial_number");
        String status = doc.getString("status");
        String lastMaintainedStr = doc.getString("last_maintained");
        Date lastMaintained = lastMaintainedStr != null ? Date.valueOf(lastMaintainedStr) : null;
        return new Device(id, name, type, serialNumber, status, lastMaintained);
    }
}
