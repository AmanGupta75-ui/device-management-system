<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Device - NexusDM</title>
    <!-- Modern Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            /* Premium Dark Theme Palette */
            --bg-color: #0f172a;           /* Deep dark blue/gray */
            --surface-color: #1e293b;      /* Darker surface */
            --surface-hover: #334155;      /* Surface hover state */
            --primary: #8b5cf6;            /* Vibrant Purple for forms */
            --primary-hover: #7c3aed;
            --text-main: #f8fafc;          /* Off-white read text */
            --text-muted: #94a3b8;         /* Gray read text */
            --border-color: rgba(255, 255, 255, 0.08); /* Subtle border */
            --input-bg: rgba(15, 23, 42, 0.6);
            --input-border: rgba(255, 255, 255, 0.12);
            --input-focus: rgba(139, 92, 246, 0.4);
            
            /* Utils */
            --radius-xl: 24px;
            --radius-lg: 16px;
            --radius-md: 10px;
            --radius-sm: 6px;
            --shadow-glow: 0 0 30px rgba(139, 92, 246, 0.15);
            --shadow-drop: 0 20px 40px -10px rgba(0, 0, 0, 0.6);
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
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        /* Abstract Background Elements */
        .bg-shape-1 {
            position: absolute; width: 600px; height: 600px;
            background: radial-gradient(circle, rgba(139, 92, 246, 0.15) 0%, transparent 70%);
            top: -200px; right: -100px; border-radius: 50%; z-index: 0; pointer-events: none;
        }
        .bg-shape-2 {
            position: absolute; width: 500px; height: 500px;
            background: radial-gradient(circle, rgba(59, 130, 246, 0.1) 0%, transparent 70%);
            bottom: -150px; left: -100px; border-radius: 50%; z-index: 0; pointer-events: none;
        }

        /* --- Panel Container --- */
        .form-panel {
            background-color: var(--surface-color);
            border-radius: var(--radius-xl);
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-drop), var(--shadow-glow);
            width: 100%;
            max-width: 520px;
            padding: 3rem;
            position: relative;
            z-index: 10;
            animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
        }

        .form-panel::before {
            content: ''; position: absolute; top: 0; left: 0; right: 0; height: 1px;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.15), transparent);
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(40px) scale(0.98); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        /* --- Header --- */
        .panel-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .panel-icon {
            display: inline-flex; align-items: center; justify-content: center;
            width: 64px; height: 64px;
            background: linear-gradient(135deg, rgba(139, 92, 246, 0.2), rgba(59, 130, 246, 0.2));
            color: var(--primary); font-size: 1.8rem;
            border-radius: 20px; border: 1px solid rgba(139, 92, 246, 0.3);
            margin-bottom: 1.5rem;
            box-shadow: inset 0 2px 10px rgba(255,255,255,0.05);
        }

        h2 { font-size: 1.8rem; font-weight: 700; letter-spacing: -0.5px; margin-bottom: 0.5rem; }
        .subtitle { color: var(--text-muted); font-size: 0.95rem; }

        /* --- Form Elements --- */
        .form-group {
            margin-bottom: 1.5rem; position: relative;
        }

        label {
            display: block; font-size: 0.85rem; font-weight: 600;
            color: var(--text-muted); margin-bottom: 0.5rem; text-transform: uppercase; letter-spacing: 0.5px;
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper i {
            position: absolute; left: 1rem; color: var(--text-muted); font-size: 1.1rem;
            transition: var(--transition);
        }

        input[type="text"], input[type="date"], select {
            width: 100%;
            background-color: var(--input-bg);
            border: 1px solid var(--input-border);
            color: var(--text-main);
            padding: 1rem 1rem 1rem 3rem; /* padding for icon */
            border-radius: var(--radius-md);
            font-size: 1rem;
            transition: var(--transition);
            outline: none;
            appearance: none; /* override default select style */
        }
        
        select { background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%2394a3b8' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 1rem center; background-size: 1em; }

        input[type="text"]:focus, input[type="date"]:focus, select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px var(--input-focus);
            background-color: rgba(15, 23, 42, 0.8);
        }

        input:focus + i.fa-regular, 
        input:focus + i.fa-solid,
        .input-wrapper:focus-within i {
            color: var(--primary);
        }

        /* Target the calendar icon specifically */
        input[type="date"]::-webkit-calendar-picker-indicator { filter: invert(1) opacity(0.5); cursor: pointer; }

        /* --- Action Buttons --- */
        .form-actions {
            display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-top: 2.5rem;
        }

        .btn {
            display: inline-flex; align-items: center; justify-content: center; gap: 0.5rem;
            padding: 1rem; border-radius: var(--radius-md); font-weight: 600; font-size: 1rem;
            cursor: pointer; transition: var(--transition); text-decoration: none; border: none;
        }

        .btn-submit {
            background: linear-gradient(135deg, var(--primary), #a855f7); color: white;
            box-shadow: 0 4px 15px rgba(139, 92, 246, 0.3);
        }
        
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(139, 92, 246, 0.4); filter: brightness(1.1); }

        .btn-cancel {
            background-color: transparent; border: 1px solid var(--border-color); color: var(--text-main);
        }

        .btn-cancel:hover { background-color: rgba(255,255,255,0.05); border-color: rgba(255,255,255,0.2); }

    </style>
</head>
<body>

    <div class="bg-shape-1"></div>
    <div class="bg-shape-2"></div>

    <div class="form-panel">
        <div class="panel-header">
            <div class="panel-icon">
                <i class="fa-solid <c:out value="${device != null ? 'fa-pen-to-square' : 'fa-microchip'}" />"></i>
            </div>
            <h2><c:out value="${device != null ? 'Modify Settings' : 'Initialize Device'}" /></h2>
            <p class="subtitle">Configure hardware parameters in the registry.</p>
        </div>

        <c:if test="${device != null}">
            <form action="update" method="post">
            <input type="hidden" name="id" value="<c:out value='${device.id}' />" />
        </c:if>
        <c:if test="${device == null}">
            <form action="insert" method="post">
        </c:if>

            <div class="form-group">
                <label for="name">Identifier</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-tag"></i>
                    <input type="text" id="name" name="name" value="<c:out value='${device.name}' />" required placeholder="e.g. Nexus Core Server">
                </div>
            </div>

            <div class="form-group">
                <label for="type">Classification</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-layer-group"></i>
                    <input type="text" id="type" name="type" value="<c:out value='${device.type}' />" required placeholder="e.g. Mainframe">
                </div>
            </div>

            <div class="form-group">
                <label for="serialNumber">Hardware Serial</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-barcode"></i>
                    <input type="text" id="serialNumber" name="serialNumber" value="<c:out value='${device.serialNumber}' />" required placeholder="e.g. NX-9921-A">
                </div>
            </div>

            <div class="form-group">
                <label for="status">Operational Status</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-bolt"></i>
                    <select id="status" name="status" required>
                        <option value="Active" <c:if test="${device.status == 'Active'}">selected</c:if>>Active / Online</option>
                        <option value="Inactive" <c:if test="${device.status == 'Inactive'}">selected</c:if>>Inactive / Offline</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="lastMaintained">Last Maintenance Cycle</label>
                <div class="input-wrapper">
                    <i class="fa-regular fa-calendar-check"></i>
                    <input type="date" id="lastMaintained" name="lastMaintained" value="<c:out value='${device.lastMaintained}' />" required>
                </div>
            </div>

            <div class="form-actions">
                <a href="list" class="btn btn-cancel">
                    <i class="fa-solid fa-arrow-left"></i> Abort
                </a>
                <button type="submit" class="btn btn-submit">
                    <c:out value="${device != null ? 'Deploy Updates' : 'Engage Device'}" /> <i class="fa-solid fa-paper-plane"></i>
                </button>
            </div>
        </form>
    </div>

</body>
</html>
