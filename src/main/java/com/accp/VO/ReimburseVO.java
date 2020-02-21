package com.accp.VO;

import java.util.List;

import com.accp.pojo.Check;
import com.accp.pojo.ReimburseInfo;

public class ReimburseVO {
	private Integer reimburseId;				//报销单id
	private Integer typeId;						//单号类型
	private String  createTime;					//创建时间
	private Integer employeeId;					//报销人Id
	private String  employeeName;				//报销人名字
	private Float   totalCount;					//报销总金额
	private String  statusName;					//当前报销状态
	private String  departmentName;				//部门名称
	private Integer departmentId;				//部门id
	private String  positionName;				//职位名称
	private String  positionId;					//职位名称
	private String  nextDealMan;				//下一个处理人
	private List<Check> checks;					//审核人
	private String  event;						//报销原因
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	private List<ReimburseInfo> reims;			//报销详情
	public String getNextDealMan() {
		return nextDealMan;
	}
	public void setNextDealMan(String nextDealMan) {
		this.nextDealMan = nextDealMan;
	}
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	public Integer getReimburseId() {
		return reimburseId;
	}
	public void setReimburseId(Integer reimburseId) {
		this.reimburseId = reimburseId;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime.substring(0,createTime.indexOf("."));
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
	public Float getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Float totalCount) {
		this.totalCount = totalCount;
	}
	public String getStatusName() {
		return statusName;
	}
	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public Integer getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}
	public String getPositionName() {
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	public String getPositionId() {
		return positionId;
	}
	public void setPositionId(String positionId) {
		this.positionId = positionId;
	}
	public List<Check> getChecks() {
		return checks;
	}
	public void setChecks(List<Check> checks) {
		this.checks = checks;
	}
	public List<ReimburseInfo> getReims() {
		return reims;
	}
	public void setReims(List<ReimburseInfo> reims) {
		this.reims = reims;
	}
	
}
