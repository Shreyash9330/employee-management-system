package com.service;


import com.dao.DepartmentDAO;
import com.dao.EmployeeDAO;
import com.model.Department;
import com.model.Employee;
import java.util.List;

public class EmployeeService {

    EmployeeDAO dao = new EmployeeDAO();

    public void saveEmployee(Employee emp) throws Exception {

        if(emp.getSalary() < 0) {
            throw new Exception("Salary cannot be negative");
        }

        dao.addEmployee(emp);
    }

    public List<Employee> getEmployees() throws Exception {
        return dao.getAllEmployees();
    }
    
    public void deleteEmployee(int id) throws Exception {
        dao.deleteEmployee(id);
    }
    
    public Employee getEmployee(int id) throws Exception {
        return dao.getEmployeeById(id);
    }

    public void updateEmployee(Employee emp) throws Exception {
        dao.updateEmployee(emp);
    }
    
    public List<Department> getDepartments() throws Exception {
        DepartmentDAO dao = new DepartmentDAO();
        return dao.getAllDepartments();
    }
    
    public List<Employee> searchEmployees(String keyword) throws Exception {
        return dao.searchEmployees(keyword);
    }
    
    public List<Employee> getEmployeesByPage(int page, int pageSize) throws Exception {

        int offset = (page - 1) * pageSize;

        return dao.getEmployeesByPage(offset, pageSize);
    }

    public int getTotalEmployeeCount() throws Exception {
        return dao.getTotalEmployeeCount();
    }
    
    public List<Employee> getAllEmployees() throws Exception {
        return dao.getAllEmployees();
    }
    
}