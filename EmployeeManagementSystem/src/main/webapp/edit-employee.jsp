
<%-- 
<%@ page import="java.util.*, com.model.Employee, com.model.Department" %>

<%
Employee emp = (Employee) request.getAttribute("employee");
List<Department> deptList = (List<Department>) request.getAttribute("departments");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Employee</title>
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow p-4">
        <h3>Edit Employee</h3>

        <form action="employee" method="post">

            <input type="hidden" name="empId" value="<%= emp.getEmpId() %>">

            <div class="mb-3">
                <label>Name</label>
                <input type="text" name="name" class="form-control"
                       value="<%= emp.getName() %>" required>
            </div>

            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email" class="form-control"
                       value="<%= emp.getEmail() %>" required>
            </div>

            <div class="mb-3">
                <label>Salary</label>
                <input type="number" name="salary" class="form-control"
                       value="<%= emp.getSalary() %>" required>
            </div>

          
            <div class="mb-3">
                <label>Department</label>
                <select name="deptId" class="form-select" required>

                    <%
                    for (Department d : deptList) {
                    %>

                        <option value="<%= d.getDeptId() %>"
                            <%= (d.getDeptId() == emp.getDeptId()) ? "selected" : "" %>>
                            <%= d.getDeptName() %>
                        </option>

                    <%
                    }
                    %>

                </select>
            </div>

            <button type="submit" class="btn btn-success">Update</button>
            <a href="employee" class="btn btn-secondary">Back</a>

        </form>
    </div>

</div>

</body>
</html>--%>



<%@ page import="java.util.*, com.model.Employee, com.model.Department" %>

<%
Employee emp = (Employee) request.getAttribute("employee");
List<Department> deptList = (List<Department>) request.getAttribute("departments");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Employee</title>

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
        <h4 class="mb-4 text-center fw-bold text-warning">
            <i class="fa fa-pen"></i> Edit Employee
        </h4>

        <form action="employee" method="post">

            <input type="hidden" name="empId" value="<%= emp.getEmpId() %>">

            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="name" class="form-control"
                       value="<%= emp.getName() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control"
                       value="<%= emp.getEmail() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Salary</label>
                <input type="number" name="salary" class="form-control"
                       value="<%= emp.getSalary() %>" required>
            </div>

            <div class="mb-4">
                <label class="form-label">Department</label>
                <select name="deptId" class="form-select" required>
                    <%
                    for (Department d : deptList) {
                    %>
                        <option value="<%= d.getDeptId() %>"
                            <%= (d.getDeptId() == emp.getDeptId()) ? "selected" : "" %>>
                            <%= d.getDeptName() %>
                        </option>
                    <%
                    }
                    %>
                </select>
            </div>

            <div class="d-flex justify-content-between">
                <a href="employee" class="btn btn-outline-secondary">
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