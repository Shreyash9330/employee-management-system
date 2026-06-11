

<%
String error = (String) request.getAttribute("error");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EMS Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
body {
    height: 100vh;
    background: linear-gradient(135deg, #4e73df, #1cc88a);
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Segoe UI', sans-serif;
}

.login-card {
    width: 900px;
    border-radius: 20px;
    overflow: hidden;
}

.left-panel {
    background: rgba(255,255,255,0.15);
    color: white;
    padding: 60px 40px;
}

.right-panel {
    background: white;
    padding: 60px 50px;
}

.form-control {
    border-radius: 10px;
}
</style>
</head>

<body>

<div class="login-card shadow-lg">

    <div class="row g-0">

        <div class="col-md-6 left-panel d-flex flex-column justify-content-center">
            <h2 class="fw-bold">
                <i class="fa fa-users"></i> Employee Management System
            </h2>
            <p class="mt-3">
                Securely manage employees, departments, and payroll
                with role-based access control.
            </p>
            <small class="mt-5">© 2026 EMS | Internal Tool</small>
        </div>

        <div class="col-md-6 right-panel">

            <h4 class="mb-4 text-center fw-bold">Login to Dashboard</h4>
            
<% if (error != null) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fa fa-exclamation-triangle me-2"></i>
        <%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<% } %>
            <form action="login" method="post">

                <div class="mb-3">
                    <label>Username</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa fa-user"></i></span>
                        <input type="text" name="username" class="form-control" required>
                    </div>
                </div>

                <div class="mb-4">
                    <label>Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa fa-lock"></i></span>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa fa-sign-in-alt"></i> Login
                    </button>
                </div>

            </form>

        </div>

    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>