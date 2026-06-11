
<%-- 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*, com.model.Employee" %>

<%
List<Employee> list = (List<Employee>) request.getAttribute("employees");
Map<String, Integer> deptCount = (Map<String, Integer>) request.getAttribute("deptCount");
Map<String, Double> salaryMap = (Map<String, Double>) request.getAttribute("salaryMap");

String role = (String) session.getAttribute("role");

String action = request.getParameter("action");
if (action == null) {
    action = "dashboard";
}
%>
<h5 class="mb-0">
<%= "list".equals(action) ? "Employee List" : "Dashboard Overview" %>
</h5>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background-color: #f4f6f9;
}

/* Sidebar */
.sidebar {
    width: 240px;
    height: 100vh;
    position: fixed;
    background: linear-gradient(180deg,#4e73df,#224abe);
    padding-top: 20px;
    color: white;
    transition: all 0.3s ease;
    overflow-x: hidden;
}

.sidebar.collapsed {
    width: 70px;
}

.sidebar a {
    display: flex;
    align-items: center;
    color: white;
    padding: 12px 20px;
    text-decoration: none;
    transition: 0.3s;
}

.sidebar a i {
    min-width: 25px;
}

.sidebar.collapsed a span {
    display: none;
}

.sidebar h4 span {
    transition: 0.3s;
}

.sidebar.collapsed h4 span {
    display: none;
}

.content {
    margin-left: 240px;
    transition: all 0.3s ease;
}

.content.expanded {
    margin-left: 70px;
}

/* Header */
.topbar {
    background: white;
    padding: 10px 20px;
    border-radius: 10px;
    margin-bottom: 20px;
}

/* Cards */
.card-custom {
    border-radius: 15px;
}

.sidebar a.active-link {
    background-color: rgba(255,255,255,0.25);
    font-weight: 600;
    border-left: 4px solid white;
}
</style>
</head>

<body>

<!-- ✅ Sidebar -->
<div class="sidebar">

    <h4 class="text-center mb-4">
        <i class="fa fa-users"></i>
        <span> EMS</span>
    </h4>

    <a href="employee?action=dashboard">
        <i class="fa fa-chart-line"></i>
        <span class="ms-2">Dashboard</span>
    </a>

    <a href="employee?action=list">
        <i class="fa fa-user"></i>
        <span class="ms-2">Employees</span>
    </a>

    <a href="department?action=list">
        <i class="fa fa-building"></i>
        <span class="ms-2">Departments</span>
    </a>

    <a href="logout">
        <i class="fa fa-sign-out-alt"></i>
        <span class="ms-2">Logout</span>
    </a>

</div>

<!-- ✅ Main Content -->
<div class="content">

    <!-- Top Header -->
    <div class="topbar d-flex justify-content-between align-items-center shadow-sm">
        <h5 class="mb-0">Dashboard Overview</h5>
        <span>Welcome, <b><%= ((com.model.User)session.getAttribute("user")).getUsername() %></b></span>
    </div>
    <button class="btn btn-sm btn-light" onclick="toggleSidebar()">
    <i class="fa fa-bars"></i>
	</button>

    <!-- Cards -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card card-custom shadow-sm p-3 text-center">
                <h6>Total Employees</h6>
                <h3 class="text-primary fw-bold">
                    <%= list != null ? list.size() : 0 %>
                </h3>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card card-custom shadow-sm p-3 text-center">
                <h6>Departments</h6>
                <h3 class="text-success fw-bold">3</h3>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card card-custom shadow-sm p-3 text-center">
                <h6>Role</h6>
                <h3 class="text-danger fw-bold"><%= role %></h3>
            </div>
        </div>
    </div>
    
    <div class="d-flex justify-content-end mb-3">
    <% if ("ADMIN".equals(role)) { %>
        <a href="employee?action=add" class="btn btn-primary">
            Add Employee
        </a>
    <% } %>
</div>

    <!-- ✅ Chart Section -->
    <% if ("dashboard".equals(action)) { %>


<div class="card shadow-sm p-4 mb-4">
    <h5 class="mb-3">Total Salary by Department</h5>
    
    <% 
    Map<String, Double> salaryMap = (Map<String, Double>) request.getAttribute("salaryMap");
    if (salaryMap == null || salaryMap.isEmpty()) { 
    %>
        <p class="text-muted text-center py-4">No salary data available.</p>
    <% } else { %>
        <div style="height: 380px;">
            <canvas id="salaryChart"></canvas>
        </div>
    <% } %>
</div>


<div class="card shadow-sm p-4 mb-4">
    <h5 class="mb-3">Employees by Department</h5>

    <div style="width:300px; height:300px; margin:auto;">
        <canvas id="deptChart"></canvas>
    </div>
</div>

<% } %>


<div class="card shadow-sm p-3 mb-3">
    <form action="employee" method="get">
        <input type="hidden" name="action" value="search">
        <div class="row">
            <div class="col-md-8">
                <input type="text" name="keyword"
                       class="form-control"
                       placeholder="Search employee by name">
            </div>
            <div class="col-md-4">
                <button type="submit" class="btn btn-success w-100">
                    Search
                </button>
            </div>
        </div>
    </form>
</div>
   <!-- Employee Table -->
<div class="card shadow-sm p-3">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="mb-0">Employee List</h5>

        <% if ("ADMIN".equals(role)) { %>
            <a href="employee?action=add" class="btn btn-primary btn-sm">
                <i class="fa fa-plus"></i> Add Employee
            </a>
        <% } %>
    </div>

    <div class="table-responsive">
        <table class="table table-hover text-center align-middle">
            <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Department</th>
                    <th>Salary</th>
                    <% if ("ADMIN".equals(role)) { %>
                        <th width="120">Action</th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
            <%
            if (list != null && !list.isEmpty()) {
                for (Employee e : list) {
            %>
                <tr>
                    <td><%= e.getEmpId() %></td>
                    <td><%= e.getName() %></td>
                    <td><%= e.getEmail() %></td>
                    <td><%= e.getDepartmentName() %></td>
                    <td>₹ <%= e.getSalary() %></td>

                    <% if ("ADMIN".equals(role)) { %>
                    <td>
                        <a href="employee?action=edit&id=<%= e.getEmpId() %>"
                           class="btn btn-sm btn-warning me-1">
                            <i class="fa fa-pen"></i>
                        </a>

                        <a href="employee?action=delete&id=<%= e.getEmpId() %>"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('Are you sure you want to delete?')">
                            <i class="fa fa-trash"></i>
                        </a>
                    </td>
                    <% } %>

                </tr>
            <%
                }
            } else {
            %>
                <tr>
                    <td colspan="6" class="text-muted py-3">
                        No Employees Found
                    </td>
                </tr>
            <%
            }
            %>
            </tbody>
        </table>
    </div>
</div>

<!-- ✅ Chart Script -->
<% if ("dashboard".equals(action)) { %>

<script>
const deptLabels = [
<%
if (deptCount != null) {
    for (String key : deptCount.keySet()) {
%>
    "<%= key %>",
<%
    }
}
%>
];

const deptData = [
<%
if (deptCount != null) {
    for (Integer value : deptCount.values()) { %>
    <%= value %>,
<%
    }
}
%>
];

new Chart(document.getElementById('deptChart'), {
    type: 'doughnut',
    data: {
        labels: deptLabels,
        datasets: [{
            data: deptData,
            backgroundColor: [
                '#4e73df',
                '#1cc88a',
                '#f6c23e'
            ]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: true
    }
});
</script>

<% } %>


<% if ("dashboard".equals(action) && salaryMap != null && !salaryMap.isEmpty()) { %>

<script>
new Chart(document.getElementById('salaryChart'), {
    type: 'bar',
    data: {
        labels: [
            <% for (String key : salaryMap.keySet()) { %>
                "<%= key %>",
            <% } %>
        ],
        datasets: [{
            label: 'Total Salary (₹)',
            data: [
                <% for (Double value : salaryMap.values()) { %>
                    <%= value %>,
                <% } %>
            ],
            backgroundColor: '#4e73df'
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
</script>


<% } %>



<script>

function toggleSidebar() {
    document.querySelector('.sidebar').classList.toggle('collapsed');
    document.querySelector('.content').classList.toggle('expanded');
}
</script>
</body>
</html>

--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.model.Employee" %>

<%
// ✅ 1. ALL VARIABLES DECLARED ONLY ONCE AT THE VERY TOP
List<Employee> list = (List<Employee>) request.getAttribute("employees");
Map<String, Integer> deptCount = (Map<String, Integer>) request.getAttribute("deptCount");
Map<String, Double> salaryMap = (Map<String, Double>) request.getAttribute("salaryMap");

String role = (String) session.getAttribute("role");
String action = request.getParameter("action");

if (action == null) {
    action = "dashboard";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EMS - Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; overflow-x: hidden; }
.sidebar { width: 240px; height: 100vh; position: fixed; background: linear-gradient(180deg,#4e73df,#224abe); padding-top: 20px; transition: all 0.3s ease; z-index: 1000; }
.sidebar.collapsed { width: 70px; }
.sidebar a { display: flex; align-items: center; color: white; padding: 15px 20px; text-decoration: none; transition: 0.3s; }
.sidebar a:hover, .sidebar a.active-link { background-color: rgba(255,255,255,0.2); border-left: 4px solid white; }
.sidebar a i { min-width: 30px; font-size: 1.1rem; }
.sidebar.collapsed a span, .sidebar.collapsed h4 span { display: none; }
.content { margin-left: 240px; padding: 25px; transition: all 0.3s ease; }
.content.expanded { margin-left: 70px; }
.topbar { background: white; padding: 15px 25px; border-radius: 10px; margin-bottom: 25px; display: flex; justify-content: space-between; align-items: center; }
.card-custom { border-radius: 12px; border: none; border-left: 5px solid #4e73df; }
.card-success { border-left-color: #1cc88a; }
.card-danger { border-left-color: #e74a3b; }
</style>
</head>

<body>

<!-- ✅ Sidebar -->
<div class="sidebar">
    <h4 class="text-center mb-4 text-white fw-bold">
        <i class="fa fa-users"></i> <span>EMS</span>
    </h4>
    <a href="employee?action=dashboard" class="<%= "dashboard".equals(action) ? "active-link" : "" %>">
        <i class="fa fa-chart-line"></i> <span>Dashboard</span>
    </a>
    <a href="employee?action=list" class="<%= "list".equals(action) ? "active-link" : "" %>">
        <i class="fa fa-user"></i> <span>Employees</span>
    </a>
    <a href="department?action=list">
        <i class="fa fa-building"></i> <span>Departments</span>
    </a>
    <a href="logout" class="mt-auto">
        <i class="fa fa-sign-out-alt"></i> <span>Logout</span>
    </a>
</div>

<!-- ✅ Main Content -->
<div class="content">

    <!-- Top Header -->
    <div class="topbar shadow-sm">
        <div class="d-flex align-items-center">
            <button class="btn btn-sm btn-light me-3" onclick="toggleSidebar()">
                <i class="fa fa-bars fs-5"></i>
            </button>
            <h5 class="mb-0 fw-bold text-gray-800">
                <%= "list".equals(action) ? "Employee Management" : "Dashboard Overview" %>
            </h5>
        </div>
        <span>Welcome, <b class="text-primary"><%= ((com.model.User)session.getAttribute("user")).getUsername() %></b></span>
    </div>

    <!-- ✅ SHOW ONLY ON DASHBOARD -->
    <% if ("dashboard".equals(action)) { %>
    
        <!-- Cards -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="card card-custom shadow-sm p-4 text-center">
                    <h6 class="text-muted fw-bold">Total Employees</h6>
                    <h3 class="text-primary fw-bold mb-0"><%= list != null ? list.size() : 0 %></h3>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card card-custom card-success shadow-sm p-4 text-center">
                    <h6 class="text-muted fw-bold">Departments</h6>
                    <h3 class="text-success fw-bold mb-0">3</h3>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card card-custom card-danger shadow-sm p-4 text-center">
                    <h6 class="text-muted fw-bold">System Role</h6>
                    <h3 class="text-danger fw-bold mb-0"><%= role %></h3>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Salary Chart -->
            <div class="col-md-7 mb-4">
                <div class="card shadow-sm p-4 h-100">
                    <h5 class="mb-4 fw-bold text-gray-800">Total Salary by Department</h5>
                    <% if (salaryMap == null || salaryMap.isEmpty()) { %>
                        <p class="text-muted text-center py-4">No salary data available.</p>
                    <% } else { %>
                        <div style="height: 300px; width: 100%;">
                            <canvas id="salaryChart"></canvas>
                        </div>
                    <% } %>
                </div>
            </div>

            <!-- Dept Chart -->
            <div class="col-md-5 mb-4">
                <div class="card shadow-sm p-4 h-100">
                    <h5 class="mb-4 fw-bold text-gray-800">Employees by Department</h5>
                    <div style="height: 300px; width: 100%; display: flex; justify-content: center;">
                        <canvas id="deptChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        
    <% } %> <!-- End Dashboard Section -->

    <!-- ✅ Search Bar (Always visible) -->
    <div class="card shadow-sm p-3 mb-4 border-0">
        <form action="employee" method="get">
            <input type="hidden" name="action" value="search">
            <div class="row g-2">
                <div class="col-md-10">
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="fa fa-search text-muted"></i></span>
                        <input type="text" name="keyword" class="form-control border-start-0 ps-0" placeholder="Search employee by name...">
                    </div>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100 fw-bold">Search</button>
                </div>
            </div>
        </form>
    </div>

    <!-- ✅ Employee Table -->
    <div class="card shadow-sm p-4 border-0">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h5 class="mb-0 fw-bold text-gray-800">Employee Directory</h5>
            <% if ("ADMIN".equals(role)) { %>
                <a href="employee?action=add" class="btn btn-success shadow-sm">
                    <i class="fa fa-plus me-1"></i> Add Employee
                </a>
            <% } %>
        </div>

        <div class="table-responsive">
            <table class="table table-hover text-center align-middle">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Department</th>
                        <th>Salary</th>
                        <% if ("ADMIN".equals(role)) { %>
                            <th width="120">Action</th>
                        <% } %>
                    </tr>
                </thead>
                <tbody class="border-top-0">
                <% if (list != null && !list.isEmpty()) {
                    for (Employee e : list) { %>
                    <tr>
                        <td class="text-muted">#<%= e.getEmpId() %></td>
                        <td class="fw-bold"><%= e.getName() %></td>
                        <td><%= e.getEmail() %></td>
                        <td><span class="badge bg-info text-dark"><%= e.getDepartmentName() %></span></td>
                        <td class="text-success fw-bold">₹ <%= e.getSalary() %></td>
                        <% if ("ADMIN".equals(role)) { %>
                        <td>
                            <a href="employee?action=edit&id=<%= e.getEmpId() %>" class="btn btn-sm btn-outline-warning me-1">
                                <i class="fa fa-pen"></i>
                            </a>
                            <a href="employee?action=delete&id=<%= e.getEmpId() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this employee?')">
                                <i class="fa fa-trash"></i>
                            </a>
                        </td>
                        <% } %>
                    </tr>
                <% } } else { %>
                    <tr>
                        <td colspan="6" class="text-muted py-5">
                            <i class="fa fa-folder-open fs-2 mb-2"></i><br>No Employees Found
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- ✅ JavaScript Section -->
<script>
// Sidebar Toggle
function toggleSidebar() {
    document.querySelector('.sidebar').classList.toggle('collapsed');
    document.querySelector('.content').classList.toggle('expanded');
}
</script>

<% if ("dashboard".equals(action)) { %>
<script>
    // ✅ 1. Pie Chart (Employees per Dept)
    const deptCtx = document.getElementById('deptChart');
    if (deptCtx) {
        new Chart(deptCtx, {
            type: 'doughnut',
            data: {
                labels: [ <% if(deptCount!=null){ for(String k : deptCount.keySet()){ %> "<%= k %>", <% } } %> ],
                datasets: [{
                    data: [ <% if(deptCount!=null){ for(Integer v : deptCount.values()){ %> <%= v %>, <% } } %> ],
                    backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b']
                }]
            },
            options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { position: 'bottom' } } }
        });
    }

    // ✅ 2. Bar Chart (Salary per Dept)
    const salaryCtx = document.getElementById('salaryChart');
    if (salaryCtx) {
        new Chart(salaryCtx, {
            type: 'bar',
            data: {
                labels: [ <% if(salaryMap!=null){ for(String k : salaryMap.keySet()){ %> "<%= k %>", <% } } %> ],
                datasets: [{
                    label: 'Total Salary (₹)',
                    data: [ <% if(salaryMap!=null){ for(Double v : salaryMap.values()){ %> <%= v %>, <% } } %> ],
                    backgroundColor: '#4e73df',
                    borderRadius: 5
                }]
            },
            options: { 
                responsive: true, 
                maintainAspectRatio: false, 
                scales: { y: { beginAtZero: true } },
                plugins: { legend: { display: false } }
            }
        });
    }
</script>
<% } %>

</body>
</html>