package com.accp.pojo;

public class CheckInfo {
	private Integer bizId;		//单号id
	private Integer typeId;		//单号类型
	private Integer checkMan;	//审核人
	private Integer checkResult;//审核结果
	private String  checkComment;//审核批注
	public Integer getBizId() {
		return bizId;
	}
	public void setBizId(Integer bizId) {
		this.bizId = bizId;
	}
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	public Integer getCheckMan() {
		return checkMan;
	}
	public void setCheckMan(Integer checkMan) {
		this.checkMan = checkMan;
	}
	public Integer getCheckResult() {
		return checkResult;
	}
	public void setCheckResult(Integer checkResult) {
		this.checkResult = checkResult;
	}
	public String getCheckComment() {
		return checkComment;
	}
	public void setCheckComment(String checkComment) {
		this.checkComment = checkComment;
	}
	public CheckInfo() {
		// TODO Auto-generated constructor stub
	}
	public CheckInfo(Integer bizId, Integer typeId, Integer checkMan, Integer checkResult, String checkComment) {
		super();
		this.bizId = bizId;
		this.typeId = typeId;
		this.checkMan = checkMan;
		this.checkResult = checkResult;
		this.checkComment = checkComment;
	}
	
}
