package com.controller;


import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.model.Employee;
import com.service.EmployeeService;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    EmployeeService service = new EmployeeService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

    	String action = request.getParameter("action");
    	if (action == null || action.isEmpty()) {
    	    action = "dashboard"; // Default to dashboard
    	}
//        String action = request.getParameter("action");

        System.out.println("DEBUG: Action received = " + action);

        try {
        		
        	 if ("search".equals(action)) {

                 String keyword = request.getParameter("keyword");

                 List<Employee> employees = service.searchEmployees(keyword);

                 request.setAttribute("employees", employees);
                 request.getRequestDispatcher("/employee-list.jsp")
                        .forward(request, response);
                 
                 List<Employee> allEmployees = service.getAllEmployees();

                 Map<String, Integer> deptCount = new HashMap<>();

                 for (Employee e : allEmployees) {
                     String dept = e.getDepartmentName();
                     deptCount.put(dept, deptCount.getOrDefault(dept, 0) + 1);
                 }

                 request.setAttribute("deptCount", deptCount);
             }
        	
            // ✅ DELETE
        	 else if ("delete".equals(action)) {

        		    HttpSession session = request.getSession(false);
        		    String role = (String) session.getAttribute("role");

        		    if (!"ADMIN".equals(role)) {
        		        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
        		        return;
        		    }

        		    int id = Integer.parseInt(request.getParameter("id"));
        		    service.deleteEmployee(id);

        		    response.sendRedirect(request.getContextPath() + "/employee");
        		    return;
        		}
        	 
        	 

            // ✅ EDIT (LOAD DATA INTO FORM)
        	 else if ("edit".equals(action)) {

        		    HttpSession session = request.getSession(false);
        		    String role = (String) session.getAttribute("role");

        		    if (!"ADMIN".equals(role)) {
        		        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
        		        return;
        		    }

        		    int id = Integer.parseInt(request.getParameter("id"));
        		    Employee emp = service.getEmployee(id);

        		    request.setAttribute("employee", emp);
        		    request.setAttribute("departments", service.getDepartments());

        		    request.getRequestDispatcher("/edit-employee.jsp").forward(request, response);
        		}
        	 else if ("add".equals(action)) {

        		    HttpSession session = request.getSession(false);
        		    String role = (String) session.getAttribute("role");

        		    if (!"ADMIN".equals(role)) {
        		        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
        		        return;
        		    }

        		    request.setAttribute("departments", service.getDepartments());
        		    request.getRequestDispatcher("/add-employee.jsp").forward(request, response);
        		}
        	 
        	 else if ("dashboard".equals(action)) {

        		    List<Employee> allEmployees = service.getAllEmployees();

        		    // ✅ Department Count
        		    Map<String, Integer> deptCount = new HashMap<>();
        		    for (Employee e : allEmployees) {
        		        String dept = e.getDepartmentName();
        		        deptCount.put(dept, deptCount.getOrDefault(dept, 0) + 1);
        		    }

        		    // ✅ Salary Map (THIS IS PROBABLY MISSING)
        		    Map<String, Double> salaryMap = new HashMap<>();
        		    for (Employee e : allEmployees) {
        		        String dept = e.getDepartmentName();
        		        salaryMap.put(dept,
        		            salaryMap.getOrDefault(dept, 0.0) + e.getSalary());
        		    }

        		    // ✅ VERY IMPORTANT — SET ATTRIBUTES
        		    request.setAttribute("deptCount", deptCount);
        		    request.setAttribute("salaryMap", salaryMap);
        		    request.setAttribute("employees", allEmployees);

        		    request.getRequestDispatcher("/employee-list.jsp")
        		           .forward(request, response);
        		    return;
        		}
        	 
        	 else if ("list".equals(action)) {

        		    List<Employee> employees = service.getAllEmployees();

        		    request.setAttribute("employees", employees);

        		    request.getRequestDispatcher("/employee-list.jsp")
        		           .forward(request, response);
        		}
        	 	
        	 else if ("departments".equals(action)) {
        		    // Fetch departments from service
        		    request.setAttribute("departments", service.getDepartments());
        		    
        		    // Forward to new page
        		    request.getRequestDispatcher("/department-list.jsp").forward(request, response);
        		    return;
        		}
        	 
            // ✅ DEFAULT: SHOW LIST
        	 else {

        		    int page = 1;
        		    int pageSize = 5;

        		    String pageParam = request.getParameter("page");

        		    if (pageParam != null) {
        		        page = Integer.parseInt(pageParam);
        		    }

        		    int totalEmployees = service.getTotalEmployeeCount();
        		    int totalPages = (int) Math.ceil((double) totalEmployees / pageSize);

        		    List<Employee> employees = service.getEmployeesByPage(page, pageSize);

        		    // ✅ Dynamic Chart Data
        		    List<Employee> allEmployees = service.getAllEmployees();
        		    Map<String, Integer> deptCount = new HashMap<>();

        		    for (Employee e : allEmployees) {
        		        String dept = e.getDepartmentName();
        		        deptCount.put(dept, deptCount.getOrDefault(dept, 0) + 1);
        		    }

        		    request.setAttribute("deptCount", deptCount);
        		    request.setAttribute("employees", employees);
        		    request.setAttribute("currentPage", page);
        		    request.setAttribute("totalPages", totalPages);

        		    request.getRequestDispatcher("/employee-list.jsp")
        		           .forward(request, response);

        		    return;   // ✅ VERY IMPORTANT
        		}

        } catch (Exception e) {
            e.printStackTrace();
            if (!response.isCommitted()) {
                response.sendError(500, "Error: " + e.getMessage());
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        try {

        	HttpSession session = request.getSession(false);
        	String role = (String) session.getAttribute("role");

        	if (!"ADMIN".equals(role)) {
        	    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
        	    return;
        	}
            String idParam = request.getParameter("empId");

            String name = request.getParameter("name");
            String email = request.getParameter("email");

            String salaryStr = request.getParameter("salary");
            String deptStr = request.getParameter("deptId");

            double salary = Double.parseDouble(salaryStr);
            int deptId = Integer.parseInt(deptStr);

            Employee emp = new Employee();
            emp.setName(name);
            emp.setEmail(email);
            emp.setSalary(salary);
            emp.setDeptId(deptId);

            // ✅ UPDATE
            if (idParam != null && !idParam.isEmpty()) {

                int id = Integer.parseInt(idParam);
                emp.setEmpId(id);
                service.updateEmployee(emp);
            } 
            // ✅ ADD
            else {
                service.saveEmployee(emp);
            }

            response.sendRedirect(request.getContextPath() + "/employee?action=dashboard");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}