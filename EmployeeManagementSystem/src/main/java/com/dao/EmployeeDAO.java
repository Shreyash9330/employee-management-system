package com.dao;



import java.sql.*;
import java.util.*;
import com.model.Employee;

public class EmployeeDAO {

    public void addEmployee(Employee emp) throws Exception {

        Connection con = DBConnection.getConnection();

        String sql = "INSERT INTO employees(name,email,salary,dept_id) VALUES(?,?,?,?)";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, emp.getName());
        ps.setString(2, emp.getEmail());
        ps.setDouble(3, emp.getSalary());
        ps.setInt(4, emp.getDeptId());

        ps.executeUpdate();
        con.close();
    }

    public List<Employee> getAllEmployees() throws Exception {

        List<Employee> list = new ArrayList<>();

        Connection con = DBConnection.getConnection();

        String sql = "SELECT e.emp_id, e.name, e.email, e.salary, " +
                     "e.dept_id, d.dept_name " +
                     "FROM employees e " +
                     "JOIN departments d ON e.dept_id = d.dept_id";

        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(sql);

        while (rs.next()) {

            Employee emp = new Employee();
            emp.setEmpId(rs.getInt("emp_id"));
            emp.setName(rs.getString("name"));
            emp.setEmail(rs.getString("email"));
            emp.setSalary(rs.getDouble("salary"));
            emp.setDeptId(rs.getInt("dept_id"));

            // ✅ VERY IMPORTANT
            emp.setDepartmentName(rs.getString("dept_name"));

            list.add(emp);
        }

        con.close();
        return list;
    }
    
    public void deleteEmployee(int id) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = DBConnection.getConnection();
            String sql = "DELETE FROM employees WHERE emp_id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            
            int rows = ps.executeUpdate();
            System.out.println("DEBUG: Rows deleted = " + rows);
            
        } finally {
            if(ps != null) ps.close();
            if(con != null) con.close();
        }
    }
    
    
    public void updateEmployee(Employee emp) throws Exception {

        Connection con = DBConnection.getConnection();

        String sql = "UPDATE employees SET name=?, email=?, salary=?, dept_id=? WHERE emp_id=?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, emp.getName());
        ps.setString(2, emp.getEmail());
        ps.setDouble(3, emp.getSalary());
        ps.setInt(4, emp.getDeptId());
        ps.setInt(5, emp.getEmpId());

        ps.executeUpdate();
        con.close();
    }
    
    public Employee getEmployeeById(int id) throws Exception {

        Connection con = DBConnection.getConnection();

        String sql = "SELECT * FROM employees WHERE emp_id = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, id);

        ResultSet rs = ps.executeQuery();

        Employee emp = null;

        if (rs.next()) {
            emp = new Employee();
            emp.setEmpId(rs.getInt("emp_id"));
            emp.setName(rs.getString("name"));
            emp.setEmail(rs.getString("email"));
            emp.setSalary(rs.getDouble("salary"));
            emp.setDeptId(rs.getInt("dept_id"));
        }

        con.close();
        return emp;
    }
    public List<Employee> searchEmployees(String keyword) throws Exception {

        List<Employee> list = new ArrayList<>();

        Connection con = DBConnection.getConnection();

        String sql = "SELECT e.*, d.dept_name FROM employees e " +
                     "JOIN departments d ON e.dept_id = d.dept_id " +
                     "WHERE e.name LIKE ?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, "%" + keyword + "%");

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Employee emp = new Employee();
            emp.setEmpId(rs.getInt("emp_id"));
            emp.setName(rs.getString("name"));
            emp.setEmail(rs.getString("email"));
            emp.setSalary(rs.getDouble("salary"));
            emp.setDepartmentName(rs.getString("dept_name"));
            list.add(emp);
        }

        con.close();
        return list;
    }
    
    public List<Employee> getEmployeesByPage(int offset, int limit) throws Exception {

        List<Employee> list = new ArrayList<>();

        Connection con = DBConnection.getConnection();

        String sql = "SELECT e.emp_id, e.name, e.email, e.salary, d.dept_name " +
                     "FROM employees e " +
                     "JOIN departments d ON e.dept_id = d.dept_id " +
                     "ORDER BY e.emp_id " +
                     "LIMIT ? OFFSET ?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, limit);
        ps.setInt(2, offset);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Employee emp = new Employee();

            emp.setEmpId(rs.getInt("emp_id"));
            emp.setName(rs.getString("name"));
            emp.setEmail(rs.getString("email"));
            emp.setSalary(rs.getDouble("salary"));
            emp.setDepartmentName(rs.getString("dept_name"));

            list.add(emp);
        }

        con.close();
        return list;
    }
    
    public int getTotalEmployeeCount() throws Exception {

        int count = 0;

        Connection con = DBConnection.getConnection();

        String sql = "SELECT COUNT(*) FROM employees";

        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            count = rs.getInt(1);
        }

        con.close();
        return count;
    }
//    
//    public List<Employee> getAllEmployees() throws Exception {
//        String sql = "SELECT e.*, d.dept_name FROM employee e JOIN department d ON e.dept_id = d.dept_id";
//        // your normal JDBC code here
//    }
}