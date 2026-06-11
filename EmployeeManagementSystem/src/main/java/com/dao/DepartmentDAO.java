package com.dao;




//public class DepartmentDAO {
//
//    public List<Department> getAllDepartments() throws Exception {
//
//        List<Department> list = new ArrayList<>();
//
//        Connection con = DBConnection.getConnection();
//        String sql = "SELECT * FROM departments";
//        Statement st = con.createStatement();
//        ResultSet rs = st.executeQuery(sql);
//
//        while (rs.next()) {
//            Department d = new Department();
//            d.setDeptId(rs.getInt("dept_id"));
//            d.setDeptName(rs.getString("dept_name"));
//            list.add(d);
//        }
//
//        con.close();
//        return list;
//    }
//}




import java.sql.*;
import java.util.*;
import com.model.Department;

public class DepartmentDAO {

    // ✅ GET ALL DEPARTMENTS
    public List<Department> getAllDepartments() throws Exception {

        List<Department> list = new ArrayList<>();

        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM departments";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Department d = new Department();
            d.setDeptId(rs.getInt("dept_id"));
            d.setDeptName(rs.getString("dept_name"));
            d.setLocation(rs.getString("location")); // ✅ if column exists
            list.add(d);
        }

        con.close();
        return list;
    }

    // ✅ GET SINGLE DEPARTMENT
    public Department getDepartment(int id) throws Exception {

        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM departments WHERE dept_id = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, id);

        ResultSet rs = ps.executeQuery();

        Department d = null;

        if (rs.next()) {
            d = new Department();
            d.setDeptId(rs.getInt("dept_id"));
            d.setDeptName(rs.getString("dept_name"));
            d.setLocation(rs.getString("location"));
        }

        con.close();
        return d;
    }

    // ✅ ADD DEPARTMENT
    public void addDepartment(Department d) throws Exception {

        Connection con = DBConnection.getConnection();
        String sql = "INSERT INTO departments (dept_name, location) VALUES (?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, d.getDeptName());
        ps.setString(2, d.getLocation());

        ps.executeUpdate();
        con.close();
    }

    // ✅ UPDATE DEPARTMENT
    public void updateDepartment(Department d) throws Exception {

        Connection con = DBConnection.getConnection();
        String sql = "UPDATE departments SET dept_name=?, location=? WHERE dept_id=?";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, d.getDeptName());
        ps.setString(2, d.getLocation());
        ps.setInt(3, d.getDeptId());

        ps.executeUpdate();
        con.close();
    }

    // ✅ DELETE DEPARTMENT
    public void deleteDepartment(int id) throws Exception {

        Connection con = DBConnection.getConnection();
        String sql = "DELETE FROM departments WHERE dept_id=?";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, id);
        ps.executeUpdate();

        con.close();
    }
}
