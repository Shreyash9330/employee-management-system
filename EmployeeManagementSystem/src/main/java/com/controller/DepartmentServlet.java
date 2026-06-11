package com.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.model.Department;
import com.service.DepartmentService;

@WebServlet("/department")
public class DepartmentServlet extends HttpServlet {
    private DepartmentService service = new DepartmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);

        try {
            if ("list".equals(action) || action == null) {
                // List all departments
                List<Department> departments = service.getAllDepartments();
                request.setAttribute("departments", departments);
                request.getRequestDispatcher("/department-list.jsp").forward(request, response);
                return;
                
            } else if ("add".equals(action)) {
                request.getRequestDispatcher("/add-department.jsp").forward(request, response);
                return;
                
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Department dept = service.getDepartment(id);
                request.setAttribute("department", dept);
                request.getRequestDispatcher("/edit-department.jsp").forward(request, response);
                return;
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

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);

        try {
            if ("add".equals(action)) {
                String deptName = request.getParameter("deptName");
                String location = request.getParameter("location");
                
                Department dept = new Department();
                dept.setDeptName(deptName);
                dept.setLocation(location);
                
                service.addDepartment(dept);
                response.sendRedirect("department?action=list");
                return;
                
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("deptId"));
                String deptName = request.getParameter("deptName");
                String location = request.getParameter("location");
                
                Department dept = new Department();
                dept.setDeptId(id);
                dept.setDeptName(deptName);
                dept.setLocation(location);
                
                service.updateDepartment(dept);
                response.sendRedirect("department?action=list");
                return;
                
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                service.deleteDepartment(id);
                response.sendRedirect("department?action=list");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            if (!response.isCommitted()) {
                response.sendError(500, "Error: " + e.getMessage());
            }
        }
    }
}