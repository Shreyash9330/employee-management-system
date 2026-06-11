<%@ page import="com.model.Department" %>
<%
Department dept = (Department) request.getAttribute("department");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Department</title>

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
}
.content {
    margin-left: 240px;
    padding: 25px;
}
</style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4 class="text-center mb-4">
        <i class="fa fa-users"></i> EMS
    </h4>
    <a href="employee?action=dashboard">Dashboard</a>
    <a href="employee?action=list">Employees</a>
    <a href="department?action=list">Departments</a>
    <a href="logout">Logout</a>
</div>

<div class="content">
    <div class="topbar d-flex justify-content-between align-items-center shadow-sm">
        <h5 class="mb-0">Edit Department</h5>
        <span>Welcome, <b><%= ((com.model.User)session.getAttribute("user")).getUsername() %></b></span>
    </div>

    <div class="card shadow p-4 mx-auto" style="max-width:600px;">
        <h4 class="mb-4 text-center fw-bold text-warning">
            <i class="fa fa-pen"></i> Edit Department
        </h4>

        <form action="department" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="deptId" value="<%= dept.getDeptId() %>">

            <div class="mb-3">
                <label class="form-label">Department Name</label>
                <input type="text" name="deptName" class="form-control" 
                       value="<%= dept.getDeptName() %>" required>
            </div>

            <div class="mb-4">
                <label class="form-label">Location</label>
                <input type="text" name="location" class="form-control" 
                       value="<%= dept.getLocation() != null ? dept.getLocation() : "" %>">
            </div>

            <div class="d-flex justify-content-between">
                <a href="department?action=list" class="btn btn-outline-secondary">
                    <i class="fa fa-arrow-left"></i> Back
                </a>
                <button type="submit" class="btn btn-warning text-white">
                    <i class="fa fa-save"></i> Update
                </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>