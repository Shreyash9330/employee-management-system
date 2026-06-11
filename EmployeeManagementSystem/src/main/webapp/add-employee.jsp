<%--

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*, com.model.Department" %>

<%
List<Department> deptList = (List<Department>) request.getAttribute("departments");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Employee</title>

<!-- ✅ Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
    font-family: 'Segoe UI', sans-serif;
}

.navbar-brand {
    letter-spacing: 1px;
}

.card {
    border-radius: 15px;
}

.table th {
    font-weight: 600;
}

.btn {
    border-radius: 8px;
}

footer {
    font-size: 13px;
}
</style>
</head>
<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow p-4">
        <h3 class="mb-4">Add Employee</h3>

        <form action="employee" method="post">

            <div class="mb-3">
                <label class="form-label">Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Salary</label>
                <input type="number" name="salary" class="form-control" required>
            </div>

            <!-- ✅ Department Dropdown -->
            <div class="mb-3">
                <label class="form-label">Department</label>
                <select name="deptId" class="form-select" required>
                    <option value="">-- Select Department --</option>
                    <%
                    if(deptList != null){
                        for(Department d : deptList){
                    %>
                        <option value="<%= d.getDeptId() %>">
                            <%= d.getDeptName() %>
                        </option>
                    <%
                        }
                    }
                    %>
                </select>
            </div>

            <button type="submit" class="btn btn-success">Add Employee</button>
            <a href="employee" class="btn btn-secondary">Back</a>

        </form>
    </div>

</div>

</body>
</html>  --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.model.Department" %>

<%
List<Department> deptList = (List<Department>) request.getAttribute("departments");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Employee</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
body {
    background-color: #f8f9fc;
    font-family: 'Segoe UI', sans-serif;
}
.card {
    border-radius: 15px;
}
</style>
</head>

<body>

<div class="container mt-5">

    <div class="card shadow p-4 mx-auto" style="max-width:600px;">
        <h4 class="mb-4 text-center fw-bold text-primary">
            <i class="fa fa-user-plus"></i> Add New Employee
        </h4>

        <form action="employee" method="post">

            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-user"></i></span>
                    <input type="text" name="name" class="form-control" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-envelope"></i></span>
                    <input type="email" name="email" class="form-control" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Salary</label>
                <div class="input-group">
                    <span class="input-group-text">₹</span>
                    <input type="number" name="salary" class="form-control" required>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">Department</label>
                <select name="deptId" class="form-select" required>
                    <option value="">-- Select Department --</option>
                    <%
                    if(deptList != null){
                        for(Department d : deptList){
                    %>
                        <option value="<%= d.getDeptId() %>">
                            <%= d.getDeptName() %>
                        </option>
                    <%
                        }
                    }
                    %>
                </select>
            </div>

            <div class="d-flex justify-content-between">
                <a href="employee" class="btn btn-outline-secondary">
                    <i class="fa fa-arrow-left"></i> Back
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fa fa-check"></i> Add Employee
                </button>
            </div>

        </form>
    </div>

</div>

</body>
</html>