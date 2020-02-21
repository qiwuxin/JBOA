package com.accp.pojo;

public class ReimburseInfo {
	private Integer id;						//详情id
	private Integer mainId;					//报销单Id
	private String  desc;					//消费说明
	private Float   subTotal;				//消费金额
	private String  pictureName;			//消费单据
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getMainId() {
		return mainId;
	}
	public void setMainId(Integer mainId) {
		this.mainId = mainId;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public Float getSubTotal() {
		return subTotal;
	}
	public void setSubTotal(Float subTotal) {
		this.subTotal = subTotal;
	}
	public String getPictureName() {
		return pictureName;
	}
	public void setPictureName(String pictureName) {
		this.pictureName = pictureName;
	}
	
}
