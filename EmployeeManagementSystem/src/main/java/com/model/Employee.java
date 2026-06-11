package com.model;

public class Employee {

	   private int empId;
	    private String name;
	    private String email;
	    private double salary;
	    private int deptId;
	    private String departmentName;
	    
	   
		public Employee() {}

	    public Employee(String name, String email, double salary, int deptId,String departmentName) {
	        this.name = name;
	        this.email = email;
	        this.salary = salary;
	        this.deptId = deptId;
	        this.departmentName = departmentName;
	    }
	    
	    
	     public String getDepartmentName() {
			return departmentName;
		}

		public void setDepartmentName(String departmentName) {
			this.departmentName = departmentName;
		}

	    
		public int getEmpId() {
			return empId;
		}
		public void setEmpId(int empId) {
			this.empId = empId;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public double getSalary() {
			return salary;
		}
		public void setSalary(double salary) {
			this.salary = salary;
		}
		public int getDeptId() {
			return deptId;
		}
		public void setDeptId(int deptId) {
			this.deptId = deptId;
		}
}
