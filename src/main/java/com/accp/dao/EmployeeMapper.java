package com.accp.dao;

import org.apache.ibatis.annotations.Param;

import com.accp.VO.EmployeeVO;

public interface EmployeeMapper {

	EmployeeVO selectEmployee(@Param("id")String id,@Param("password")String password);
	
	
	
}
