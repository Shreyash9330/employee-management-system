package com.service;

import java.util.List;
import com.dao.DepartmentDAO;
import com.model.Department;

public class DepartmentService {

    private DepartmentDAO dao = new DepartmentDAO();

    // ✅ Get all
    public List<Department> getAllDepartments() throws Exception {
        return dao.getAllDepartments();
    }

    // ✅ Get single
    public Department getDepartment(int id) throws Exception {
        return dao.getDepartment(id);
    }

    // ✅ Add
    public void addDepartment(Department d) throws Exception {
        dao.addDepartment(d);
    }

    // ✅ Update
    public void updateDepartment(Department d) throws Exception {
        dao.updateDepartment(d);
    }

    // ✅ Delete
    public void deleteDepartment(int id) throws Exception {
        dao.deleteDepartment(id);
    }
}