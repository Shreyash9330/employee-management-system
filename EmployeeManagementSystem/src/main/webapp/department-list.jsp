<%-- 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.model.Department" %>

<%
List<Department> deptList = (List<Department>) request.getAttribute("departments");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Departments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .sidebar { width: 240px; height: 100vh; position: fixed; background: linear-gradient(180deg,#4e73df,#224abe); color: white; }
        .sidebar a { display: block; color: white; padding: 12px 20px; text-decoration: none; }
        .sidebar a:hover { background-color: rgba(255,255,255,0.15); }
        .content { margin-left: 240px; padding: 25px; }
        .topbar { background: white; padding: 10px 20px; border-radius: 10px; margin-bottom: 20px; }
    </style>
</head>
<body>

<div class="sidebar">
    <h4 class="text-center py-3"><i class="fa fa-users"></i> EMS</h4>
    <a href="employee?action=dashboard"><i class="fa fa-chart-line me-2"></i> Dashboard</a>
    <a href="employee?action=list"><i class="fa fa-user me-2"></i> Employees</a>
    <a href="employee?action=departments" class="bg-primary"><i class="fa fa-building me-2"></i> Departments</a>
    <a href="logout"><i class="fa fa-sign-out-alt me-2"></i> Logout</a>
</div>

<div class="content">
    <div class="topbar shadow-sm d-flex justify-content-between align-items-center">
        <h5>Manage Departments</h5>
    </div>

    <div class="card shadow-sm p-4">
        <table class="table table-hover">
            <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>Department Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                if(deptList != null && !deptList.isEmpty()) {
                    for(Department d : deptList) {
                %>
                    <tr>
                        <td><%= d.getDeptId() %></td>
                        <td><%= d.getDeptName() %></td>
                        <td>
                            <button class="btn btn-sm btn-warning"><i class="fa fa-pen"></i></button>
                            <button class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                        </td>
                    </tr>
                <% 
                    }
                } else {
                %>
                    <tr><td colspan="3" class="text-center">No Departments Found</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>

--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.model.Department" %>

<%
List<Department> list = (List<Department>) request.getAttribute("departments");
String role = (String) session.getAttribute("role");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Department List</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
body {
    background-color: #f8f9fc;
    font-family: 'Segoe UI', sans-serif;
}
.sidebar {
    width: 240px;
    height: 100vh;
    position: fixed;
    background: linear-gradient(180deg,#4e73df,#224abe);
    padding-top: 20px;
    color: white;
}
.sidebar a {
    display: block;
    color: white;
    padding: 12px 20px;
    text-decoration: none;
    transition: 0.3s;
}
.sidebar a:hover {
    background-color: rgba(255,255,255,0.15);
}
.content {
    margin-left: 240px;
    padding: 25px;
}
.topbar {
    background: white;
    padding: 10px 20px;
    border-radius: 10px;
    margin-bottom: 20px;
}
</style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4 class="text-center mb-4">
        <i class="fa fa-users"></i> EMS
    </h4>
    <a href="employee?action=dashboard">
        <i class="fa fa-chart-line me-2"></i> Dashboard
    </a>
    <a href="employee?action=list">
        <i class="fa fa-user me-2"></i> Employees
    </a>
    <a href="department?action=list" class="active">
        <i class="fa fa-building me-2"></i> Departments
    </a>
    <a href="logout">
        <i class="fa fa-sign-out-alt me-2"></i> Logout
    </a>
</div>

<!-- Content -->
<div class="content">

    <div class="topbar d-flex justify-content-between align-items-center shadow-sm">
        <h5 class="mb-0">Department Management</h5>
        <span>Welcome, <b><%= ((com.model.User)session.getAttribute("user")).getUsername() %></b></span>
    </div>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="fw-bold">Department List</h4>
        <% if ("ADMIN".equals(role)) { %>
            <a href="department?action=add" class="btn btn-primary">
                <i class="fa fa-plus"></i> Add Department
            </a>
        <% } %>
    </div>

    <div class="card shadow-sm">
        <div class="table-responsive">
            <table class="table table-hover align-middle text-center">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Department Name</th>
                        <th>Location</th>
                        <th width="150">Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                if (list != null && !list.isEmpty()) {
                    for (Department d : list) {
                %>
                    <tr>
                        <td><%= d.getDeptId() %></td>
                        <td><%= d.getDeptName() %></td>
                        <td><%= d.getLocation() != null ? d.getLocation() : "N/A" %></td>
                        <td>
                            <% if ("ADMIN".equals(role)) { %>
                                <a href="department?action=edit&id=<%= d.getDeptId() %>" 
                                   class="text-warning me-2">
                                   <i class="fa fa-pen"></i>
                                </a>
                                <a href="department?action=delete&id=<%= d.getDeptId() %>" 
                                   class="text-danger"
                                   onclick="return confirm('Are you sure?')">
                                   <i class="fa fa-trash"></i>
                                </a>
                            <% } %>
                        </td>
                    </tr>
                <%
                    }
                } else {
                %>
                    <tr>
                        <td colspan="4" class="text-center text-muted py-4">
                            No Departments Found
                        </td>
                    </tr>
                <%
                }
                %>
                </tbody>
            </table>
        </div>
    </div>

</div>

</body>
</html>