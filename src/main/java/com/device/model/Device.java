package com.device.model;

import java.sql.Date;

public class Device {
    private String id;
    private String name;
    private String type;
    private String serialNumber;
    private String status;
    private Date lastMaintained;

    public Device() {
    }

    public Device(String name, String type, String serialNumber, String status, Date lastMaintained) {
        this.name = name;
        this.type = type;
        this.serialNumber = serialNumber;
        this.status = status;
        this.lastMaintained = lastMaintained;
    }

    public Device(String id, String name, String type, String serialNumber, String status, Date lastMaintained) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.serialNumber = serialNumber;
        this.status = status;
        this.lastMaintained = lastMaintained;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getSerialNumber() { return serialNumber; }
    public void setSerialNumber(String serialNumber) { this.serialNumber = serialNumber; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getLastMaintained() { return lastMaintained; }
    public void setLastMaintained(Date lastMaintained) { this.lastMaintained = lastMaintained; }
}
