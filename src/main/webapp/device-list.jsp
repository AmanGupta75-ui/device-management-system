<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Device Management Hub</title>
            <!-- Modern Font -->
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
            <!-- FontAwesome for Icons -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

            <style>
                :root {
                    /* Premium Dark Theme Palette */
                    --bg-color: #0f172a;
                    /* Deep dark blue/gray */
                    --surface-color: #1e293b;
                    /* Darker surface */
                    --surface-hover: #334155;
                    /* Surface hover state */
                    --primary: #3b82f6;
                    /* Vibrant blue */
                    --primary-hover: #2563eb;
                    --text-main: #f8fafc;
                    /* Off-white read text */
                    --text-muted: #94a3b8;
                    /* Gray read text */
                    --border-color: rgba(255, 255, 255, 0.08);
                    /* Subtle border */

                    /* Status Colors */
                    --success-bg: rgba(16, 185, 129, 0.15);
                    --success-text: #34d399;
                    --inactive-bg: rgba(148, 163, 184, 0.15);
                    --inactive-text: #cbd5e1;

                    /* Utils */
                    --radius-lg: 16px;
                    --radius-md: 10px;
                    --radius-sm: 6px;
                    --shadow-glow: 0 0 20px rgba(59, 130, 246, 0.15);
                    --shadow-drop: 0 10px 30px -5px rgba(0, 0, 0, 0.5);
                    --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                }

                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                    font-family: 'Inter', sans-serif;
                }

                body {
                    background-color: var(--bg-color);
                    color: var(--text-main);
                    min-height: 100vh;
                    display: flex;
                    flex-direction: column;
                    overflow-x: hidden;
                    background-image:
                        radial-gradient(circle at 15% 50%, rgba(59, 130, 246, 0.08) 0%, transparent 50%),
                        radial-gradient(circle at 85% 30%, rgba(139, 92, 246, 0.08) 0%, transparent 50%);
                }

                /* --- Navbar --- */
                .navbar {
                    background-color: rgba(15, 23, 42, 0.8);
                    backdrop-filter: blur(12px);
                    -webkit-backdrop-filter: blur(12px);
                    border-bottom: 1px solid var(--border-color);
                    padding: 1rem 0;
                    position: sticky;
                    top: 0;
                    z-index: 100;
                }

                .container {
                    width: 100%;
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 0 1.5rem;
                }

                .nav-content {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .brand {
                    font-size: 1.5rem;
                    font-weight: 700;
                    color: var(--text-main);
                    text-decoration: none;
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                    letter-spacing: -0.5px;
                }

                .brand i {
                    color: var(--primary);
                }

                .nav-links {
                    display: flex;
                    align-items: center;
                    gap: 1.5rem;
                }

                .nav-link {
                    color: var(--text-muted);
                    text-decoration: none;
                    font-weight: 500;
                    font-size: 0.95rem;
                    transition: var(--transition);
                }

                .nav-link:hover {
                    color: var(--text-main);
                }

                .btn-primary {
                    background: linear-gradient(135deg, var(--primary), #60a5fa);
                    color: white;
                    padding: 0.6rem 1.2rem;
                    border-radius: var(--radius-sm);
                    text-decoration: none;
                    font-weight: 600;
                    font-size: 0.9rem;
                    transition: var(--transition);
                    border: none;
                    cursor: pointer;
                    box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
                    display: inline-flex;
                    align-items: center;
                    gap: 0.5rem;
                }

                .btn-primary:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 6px 16px rgba(59, 130, 246, 0.4);
                    filter: brightness(1.1);
                }

                /* --- Main Content --- */
                .main-content {
                    flex: 1;
                    padding: 3rem 0;
                    animation: fadeIn 0.6s ease-out forwards;
                }

                @keyframes fadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(20px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .header-section {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 2rem;
                }

                .page-title {
                    font-size: 2rem;
                    font-weight: 700;
                    letter-spacing: -0.5px;
                    background: linear-gradient(to right, #fff, #94a3b8);
                    -webkit-background-clip: text;
                    background-clip: text;
                    -webkit-text-fill-color: transparent;
                }

                /* --- Glassmorphism Card --- */
                .card {
                    background-color: var(--surface-color);
                    border-radius: var(--radius-lg);
                    border: 1px solid var(--border-color);
                    box-shadow: var(--shadow-drop);
                    overflow: hidden;
                    position: relative;
                }

                /* Optional shine effect on card edge */
                .card::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    height: 1px;
                    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
                }

                /* --- Table Styling --- */
                .table-container {
                    width: 100%;
                    overflow-x: auto;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    text-align: left;
                }

                th {
                    background-color: rgba(15, 23, 42, 0.4);
                    color: var(--text-muted);
                    font-weight: 600;
                    font-size: 0.8rem;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    padding: 1.2rem 1.5rem;
                    border-bottom: 1px solid var(--border-color);
                }

                td {
                    padding: 1.2rem 1.5rem;
                    border-bottom: 1px solid var(--border-color);
                    color: var(--text-main);
                    font-size: 0.95rem;
                    transition: var(--transition);
                }

                tbody tr {
                    transition: var(--transition);
                }

                tbody tr:hover {
                    background-color: rgba(255, 255, 255, 0.03);
                    transform: scale(1.002);
                    box-shadow: inset 3px 0 0 var(--primary);
                }

                tbody tr:last-child td {
                    border-bottom: none;
                }

                /* --- Specific Table Cell Styles --- */
                .device-id {
                    color: var(--text-muted);
                    font-family: monospace;
                    font-size: 0.85rem;
                }

                .device-name {
                    font-weight: 600;
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                }

                /* Icon based on type (simple hardcoded logic for display purposes in CSS) */
                .device-icon {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    width: 36px;
                    height: 36px;
                    background: rgba(255, 255, 255, 0.05);
                    border-radius: var(--radius-sm);
                    color: var(--text-muted);
                    font-size: 1rem;
                }

                .serial-number {
                    color: var(--text-muted);
                    font-family: monospace;
                    background: rgba(0, 0, 0, 0.2);
                    padding: 0.2rem 0.6rem;
                    border-radius: 4px;
                    font-size: 0.85rem;
                }

                /* --- Status Badges --- */
                .badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 0.4rem;
                    padding: 0.4rem 0.8rem;
                    border-radius: 2rem;
                    font-size: 0.75rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                }

                .status-dot {
                    width: 6px;
                    height: 6px;
                    border-radius: 50%;
                }

                .badge.active {
                    background-color: var(--success-bg);
                    color: var(--success-text);
                    border: 1px solid rgba(16, 185, 129, 0.2);
                }

                .badge.active .status-dot {
                    background-color: var(--success-text);
                    box-shadow: 0 0 5px var(--success-text);
                }

                .badge.inactive {
                    background-color: var(--inactive-bg);
                    color: var(--inactive-text);
                    border: 1px solid rgba(148, 163, 184, 0.2);
                }

                .badge.inactive .status-dot {
                    background-color: var(--inactive-text);
                }

                /* --- Action Buttons --- */
                .actions {
                    display: flex;
                    gap: 0.5rem;
                    justify-content: flex-end;
                }

                .btn-icon {
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    width: 32px;
                    height: 32px;
                    border-radius: var(--radius-sm);
                    color: var(--text-muted);
                    text-decoration: none;
                    transition: var(--transition);
                    background: transparent;
                    border: 1px solid transparent;
                }

                .btn-edit:hover {
                    color: var(--primary);
                    background: rgba(59, 130, 246, 0.1);
                    border-color: rgba(59, 130, 246, 0.2);
                }

                .btn-delete:hover {
                    color: #ef4444;
                    /* red */
                    background: rgba(239, 68, 68, 0.1);
                    border-color: rgba(239, 68, 68, 0.2);
                }

                /* --- Empty State --- */
                .empty-state {
                    padding: 4rem 2rem;
                    text-align: center;
                    color: var(--text-muted);
                }

                .empty-state i {
                    font-size: 3rem;
                    margin-bottom: 1rem;
                    opacity: 0.5;
                }

                .empty-state p {
                    font-size: 1.1rem;
                    margin-bottom: 1.5rem;
                }

                /* Layout utility */
                .text-right {
                    text-align: right;
                }

                /* Responsive */
                @media (max-width: 768px) {
                    .header-section {
                        flex-direction: column;
                        align-items: flex-start;
                        gap: 1rem;
                    }

                    .nav-link.text {
                        display: none;
                    }

                    /* Hide text links on mobile */
                }
            </style>
        </head>

        <body>

            <!-- Navigation -->
            <nav class="navbar">
                <div class="container nav-content">
                    <a class="brand" href="<%=request.getContextPath()%>/list">
                        <i class="fa-solid fa-server"></i>
                        NexusDM
                    </a>
                    <div class="nav-links">
                        <a class="nav-link text" href="<%=request.getContextPath()%>/list">Registry</a>
                        <a class="btn-primary" href="<%=request.getContextPath()%>/new">
                            <i class="fa-solid fa-plus"></i>
                            <span>Register Device</span>
                        </a>
                    </div>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="main-content">
                <div class="container">

                    <div class="header-section">
                        <div>
                            <h1 class="page-title">Device Registry</h1>
                            <p style="color: var(--text-muted); margin-top: 0.5rem; font-size: 0.95rem;">Manage and
                                monitor your infrastructure</p>
                        </div>
                    </div>

                    <div class="card">
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Name & Type</th>
                                        <th>Serial Number</th>
                                        <th>Status</th>
                                        <th>Last Maintenance</th>
                                        <th class="text-right">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="device" items="${listDevice}">
                                        <tr>
                                            <td>
                                                <div class="device-name">
                                                    <div class="device-icon">
                                                        <i class="fa-solid fa-laptop"></i>
                                                    </div>
                                                    <div>
                                                        <div>
                                                            <c:out value="${device.name}" />
                                                        </div>
                                                        <div
                                                            style="font-size: 0.8rem; color: var(--text-muted); font-weight: 500; margin-top: 2px;">
                                                            <c:out value="${device.type}" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="serial-number">
                                                    <c:out value="${device.serialNumber}" />
                                                </span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${device.status == 'Active'}">
                                                        <span class="badge active">
                                                            <span class="status-dot"></span> Active
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge inactive">
                                                            <span class="status-dot"></span> Inactive
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="color: var(--text-muted);">
                                                <i class="fa-regular fa-calendar" style="margin-right: 6px;"></i>
                                                <c:out value="${device.lastMaintained}" />
                                            </td>
                                            <td>
                                                <div class="actions">
                                                    <a href="edit?id=<c:out value='${device.id}' />"
                                                        class="btn-icon btn-edit" title="Edit Device">
                                                        <i class="fa-solid fa-pen"></i>
                                                    </a>
                                                    <a href="delete?id=<c:out value='${device.id}' />"
                                                        class="btn-icon btn-delete"
                                                        onclick="return confirm('Disconnect and remove this device?');"
                                                        title="Remove Device">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <c:if test="${empty listDevice}">
                                        <tr>
                                            <td colspan="5">
                                                <div class="empty-state">
                                                    <i class="fa-solid fa-box-open"></i>
                                                    <p>No devices found in the registry.</p>
                                                    <a class="btn-primary" href="<%=request.getContextPath()%>/new">
                                                        <i class="fa-solid fa-plus"></i> Initialize First Device
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </main>

        </body>

        </html>