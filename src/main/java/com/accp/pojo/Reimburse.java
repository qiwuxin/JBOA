package com.accp.pojo;

import java.util.List;

public class Reimburse {
	private Integer reimburseId;		//编号
	private Integer typeId;				//类型
	private Integer createMan;			//用户Id
	private String  createTime;			//创建时间
	private Integer departmentId;		//部门id
	private Integer nextDealMan;		//下一个审核人
	private String  event;				//报销原因
	private Float   totalCount;			//报销总金额
	private Integer statusId;			//报销状态
	private List<ReimburseInfo> reiminfos;//报销的详情
	public List<ReimburseInfo> getReiminfos() {
		return reiminfos;
	}
	public void setReiminfos(List<ReimburseInfo> reiminfos) {
		this.reiminfos = reiminfos;
	}
	public Integer getReimburseId() {
		return reimburseId;
	}
	public void setReimburseId(Integer reimburseId) {
		this.reimburseId = reimburseId;
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
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Integer getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
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
	public Float getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Float totalCount) {
		this.totalCount = totalCount;
	}
	public Integer getStatusId() {
		return statusId;
	}
	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
	}
	
}
