package com.accp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.accp.VO.LeaveVO;
import com.accp.pojo.Leave;

public interface LeaveMapper {
	
	/**
	 * 新建请假
	 * @param leave
	 * @return
	 */
	int insertLeave(@Param("leave") Leave leave);
	
	/**
	 * 查询请假信息
	 * @param createMan 登录用户id
	 * @param startDate 开始时间
	 * @param endDate   结束时间
	 * @param grank		登录用户权限
	 * @param did		登录用户部门
	 * @return
	 */
	List<LeaveVO> selecLeave(@Param("leaveIds")List<Integer> leaveIds);

	/**
	 * 修改请假条审批状态
	 * @param leaveId     请假条ID
	 * @param statusId	    请假条状态
	 * @param nextDealMan 下一个审核人
	 * @return
	 */
	int updateStatus(@Param("leaveId")Integer leaveId,@Param("statusId")Integer statusId,@Param("nextDealMan")Integer nextDealMan);

	List<LeaveVO> selectLeaveId(@Param("createMan")Integer createMan,@Param("startDate")String startDate,@Param("endDate")String endDate,
			@Param("grank")Integer grank,@Param("did")Integer did,@Param("option")Integer option);
}
