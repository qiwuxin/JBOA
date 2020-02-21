package com.accp.dao;

import org.apache.ibatis.annotations.Param;

import com.accp.pojo.CheckInfo;

public interface CheckMapper {
	
	int insertCheck(@Param("check")CheckInfo checkInfo);

	

}
