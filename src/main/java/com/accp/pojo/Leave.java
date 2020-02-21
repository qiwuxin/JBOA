package com.accp.pojo;

public class Leave {
	private Integer leaveId;			//请假id
	private Integer typeId;				//1表示为请假表
	private Integer createMan;			//请假人编号
	private Integer departmentId;		//请假人部门编号
	private String  createTime	;		//创建时间
	private String  startTime	;		//请假开始时间
	private String  endTime	;			//请假结束时间
	private Integer nextDealMan;		//下个处理人，外键
	private String  event	;			//请假事由
	private Integer totalCount;			//请假总天数
	private Integer statusId;			//状态
	public Integer getLeaveId() {
		return leaveId;
	}
	public void setLeaveId(Integer leaveId) {
		this.leaveId = leaveId;
	}
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	public Integer getCreateMan() {
		return createMan;
	}
	public void setCreateMan(Integer createMan) {
		this.createMan = createMan;
	}
	public Integer getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
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
	public Integer getNextDealMan() {
		return nextDealMan;
	}
	public void setNextDealMan(Integer nextDealMan) {
		this.nextDealMan = nextDealMan;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public Integer getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
	public Integer getStatusId() {
		return statusId;
	}
	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
	}

}
