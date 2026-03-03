package com.device.controller;

import com.device.dao.DeviceDAO;
import com.device.model.Device;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/")
public class DeviceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DeviceDAO deviceDAO;

    public void init() {
        deviceDAO = new DeviceDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/new":
                    showNewForm(request, response);
                    break;
                case "/insert":
                    insertDevice(request, response);
                    break;
                case "/delete":
                    deleteDevice(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/update":
                    updateDevice(request, response);
                    break;
                case "/list":
                default:
                    listDevice(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listDevice(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Device> listDevice = deviceDAO.selectAllDevices();
        request.setAttribute("listDevice", listDevice);
        RequestDispatcher dispatcher = request.getRequestDispatcher("device-list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("device-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Device existingDevice = deviceDAO.selectDevice(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("device-form.jsp");
        request.setAttribute("device", existingDevice);
        dispatcher.forward(request, response);
    }

    private void insertDevice(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String serialNumber = request.getParameter("serialNumber");
        String status = request.getParameter("status");
        Date lastMaintained = Date.valueOf(request.getParameter("lastMaintained"));

        Device newDevice = new Device(name, type, serialNumber, status, lastMaintained);
        deviceDAO.insertDevice(newDevice);
        response.sendRedirect("list");
    }

    private void updateDevice(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String serialNumber = request.getParameter("serialNumber");
        String status = request.getParameter("status");
        Date lastMaintained = Date.valueOf(request.getParameter("lastMaintained"));

        Device device = new Device(id, name, type, serialNumber, status, lastMaintained);
        deviceDAO.updateDevice(device);
        response.sendRedirect("list");
    }

    private void deleteDevice(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        deviceDAO.deleteDevice(id);
        response.sendRedirect("list");
    }
}
