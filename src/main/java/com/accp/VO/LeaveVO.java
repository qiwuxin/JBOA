package com.accp.VO;

import java.util.List;

import com.accp.pojo.Check;

public class LeaveVO {
	private Integer leaveId;				//请假条Id
	private String  createName;				//请假人
	private Integer positionId;				//职务id
	private String  departmentName;			//部门名称
	private String  startTime;				//开始时间
	private String  endTime;				//结束时间
	private Integer totalCount;				//请假天数
	private String  event;					//请假事由
	private String  createTime;				//创建时间
	private String  nextDealName;			//下一个审核人
	private Integer nextDealMan;			//下一个审核人Id
	private String  statusName;				//当前状态
	private List<Check> checks;				//审核人
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public Integer getNextDealMan() {
		return nextDealMan;
	}
	public void setNextDealMan(Integer nextDealMan) {
		this.nextDealMan = nextDealMan;
	}
	public Integer getPositionId() {
		return positionId;
	}
	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}
	public String getNextDealName() {
		return nextDealName;
	}
	public void setNextDealName(String nextDealName) {
		this.nextDealName = nextDealName;
	}
	public List<Check> getChecks() {
		return checks;
	}
	public void setChecks(List<Check> checks) {
		this.checks = checks;
	}
	public Integer getLeaveId() {
		return leaveId;
	}
	public void setLeaveId(Integer leaveId) {
		this.leaveId = leaveId;
	}
	public String getCreateName() {
		return createName;
	}
	public void setCreateName(String createName) {
		this.createName = createName;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public Integer getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getStatusName() {
		return statusName;
	}
	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
	
}
