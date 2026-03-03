<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Device Management Web Application</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/list">DeviceManager</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="<%=request.getContextPath()%>/list">Devices</a>
            <a class="nav-link btn btn-primary text-white ms-2 px-3" href="<%=request.getContextPath()%>/new">Add New Device</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="card shadow-sm border-0">
        <div class="card-body p-4">
            <h3 class="card-title text-center mb-4 fw-bold">List of Devices</h3>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Serial Number</th>
                            <th>Status</th>
                            <th>Last Maintained</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="device" items="${listDevice}">
                            <tr>
                                <td><c:out value="${device.id}" /></td>
                                <td class="fw-semibold"><c:out value="${device.name}" /></td>
                                <td><c:out value="${device.type}" /></td>
                                <td><span class="text-muted"><c:out value="${device.serialNumber}" /></span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${device.status == 'Active'}">
                                            <span class="badge rounded-pill bg-success px-3">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge rounded-pill bg-secondary px-3">Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td><c:out value="${device.lastMaintained}" /></td>
                                <td class="text-center">
                                    <a href="edit?id=<c:out value='${device.id}' />" class="btn btn-sm btn-outline-primary me-2">Edit</a>
                                    <a href="delete?id=<c:out value='${device.id}' />" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this device?');">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listDevice}">
                            <tr>
                                <td colspan="7" class="text-center py-4 text-muted">No devices found. Add a new device to get started.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
