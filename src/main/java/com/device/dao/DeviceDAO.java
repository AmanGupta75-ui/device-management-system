package com.device.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.device.model.Device;

public class DeviceDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/device_db?useSSL=false";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";
    private static final String INSERT_DEVICE_SQL = "INSERT INTO devices (name, type, serial_number, status, last_maintained) VALUES (?, ?, ?, ?, ?);";
    private static final String SELECT_DEVICE_BY_ID = "SELECT id, name, type, serial_number, status, last_maintained FROM devices WHERE id = ?";
    private static final String SELECT_ALL_DEVICES = "SELECT * FROM devices";
    private static final String DELETE_DEVICE_SQL = "DELETE FROM devices WHERE id = ?;";
    private static final String UPDATE_DEVICE_SQL = "UPDATE devices SET name = ?, type = ?, serial_number = ?, status = ?, last_maintained = ? WHERE id = ?;";

    public DeviceDAO() {}

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void insertDevice(Device device) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_DEVICE_SQL)) {
            preparedStatement.setString(1, device.getName());
            preparedStatement.setString(2, device.getType());
            preparedStatement.setString(3, device.getSerialNumber());
            preparedStatement.setString(4, device.getStatus());
            preparedStatement.setDate(5, device.getLastMaintained());
            preparedStatement.executeUpdate();
        }
    }

    public Device selectDevice(int id) {
        Device device = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_DEVICE_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                String type = rs.getString("type");
                String serialNumber = rs.getString("serial_number");
                String status = rs.getString("status");
                Date lastMaintained = rs.getDate("last_maintained");
                device = new Device(id, name, type, serialNumber, status, lastMaintained);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return device;
    }

    public List<Device> selectAllDevices() {
        List<Device> devices = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_DEVICES)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String type = rs.getString("type");
                String serialNumber = rs.getString("serial_number");
                String status = rs.getString("status");
                Date lastMaintained = rs.getDate("last_maintained");
                devices.add(new Device(id, name, type, serialNumber, status, lastMaintained));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return devices;
    }

    public boolean deleteDevice(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_DEVICE_SQL)) {
            statement.setInt(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateDevice(Device device) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_DEVICE_SQL)) {
            statement.setString(1, device.getName());
            statement.setString(2, device.getType());
            statement.setString(3, device.getSerialNumber());
            statement.setString(4, device.getStatus());
            statement.setDate(5, device.getLastMaintained());
            statement.setInt(6, device.getId());
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }
}
