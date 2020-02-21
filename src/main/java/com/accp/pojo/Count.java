package com.accp.pojo;

public class Count {
	private Integer employeeId;				//用户Id
	private String  employeeName;			//用户名称
	private Integer departmentId;			//部门Id
	private String  departmentName;			//部门名称
	private Float   money;					//金额
	private Float   moneySUM;				//总金额
	private Integer year;					//年份
	private Integer month;					//月份
	public Float getMoneySUM() {
		return moneySUM;
	}
	public void setMoneySUM(Float moneySUM) {
		this.moneySUM = moneySUM;
	}
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	public Integer getMonth() {
		return month;
	}
	public void setMonth(Integer month) {
		if(month==null) {
			month=0;
		}
		this.month = month;
	}
	public Integer getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public Float getMoney() {
		return money;
	}
	public void setMoney(Float money) {
		this.money = money;
	}
	public Integer getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(Integer employeeId) {
		this.employeeId = employeeId;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
}
