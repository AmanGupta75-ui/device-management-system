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

<div class="container pb-5">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white border-bottom-0 pt-4 pb-0 text-center">
                    <h4 class="fw-bold mb-0">
                        <c:if test="${device != null}">Edit Device</c:if>
                        <c:if test="${device == null}">Add New Device</c:if>
                    </h4>
                </div>
                <div class="card-body p-4">
                    <c:if test="${device != null}">
                        <form action="update" method="post">
                    </c:if>
                    <c:if test="${device == null}">
                        <form action="insert" method="post">
                    </c:if>

                        <c:if test="${device != null}">
                            <input type="hidden" name="id" value="<c:out value='${device.id}' />" />
                        </c:if>

                        <div class="mb-3">
                            <label for="name" class="form-label fw-semibold">Device Name</label>
                            <input type="text" value="<c:out value='${device.name}' />" class="form-control form-control-lg bg-light" id="name" name="name" required="required" placeholder="e.g. MacBook Pro M2">
                        </div>

                        <div class="mb-3">
                            <label for="type" class="form-label fw-semibold">Type</label>
                            <input type="text" value="<c:out value='${device.type}' />" class="form-control form-control-lg bg-light" id="type" name="type" required="required" placeholder="e.g. Laptop">
                        </div>

                        <div class="mb-3">
                            <label for="serialNumber" class="form-label fw-semibold">Serial Number</label>
                            <input type="text" value="<c:out value='${device.serialNumber}' />" class="form-control form-control-lg bg-light" id="serialNumber" name="serialNumber" required="required" placeholder="e.g. SN-XYZ-123">
                        </div>

                        <div class="mb-3">
                            <label for="status" class="form-label fw-semibold">Status</label>
                            <select class="form-select form-select-lg bg-light" id="status" name="status" required="required">
                                <option value="Active" <c:if test="${device.status == 'Active'}">selected</c:if>>Active</option>
                                <option value="Inactive" <c:if test="${device.status == 'Inactive'}">selected</c:if>>Inactive</option>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label for="lastMaintained" class="form-label fw-semibold">Last Maintained</label>
                            <input type="date" value="<c:out value='${device.lastMaintained}' />" class="form-control form-control-lg bg-light" id="lastMaintained" name="lastMaintained" required="required">
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg fw-bold shadow-sm">Save Device</button>
                            <a href="list" class="btn btn-light btn-lg">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
