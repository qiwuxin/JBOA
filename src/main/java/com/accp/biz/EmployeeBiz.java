package com.accp.biz;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.accp.VO.EmployeeVO;
import com.accp.dao.EmployeeMapper;

@Service("employeeBiz")
public class EmployeeBiz {
	
	@Resource
	private EmployeeMapper eMapper;
	
	/**
	 * 登录查询
	 * @param id
	 * @param password
	 * @return
	 */
	public EmployeeVO getEmployeeVO(String id,String password ) {
		return eMapper.selectEmployee(id, password);
	}

	
}
