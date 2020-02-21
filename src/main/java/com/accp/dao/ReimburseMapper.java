package com.accp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.accp.VO.ReimburseVO;
import com.accp.pojo.Reimburse;
import com.accp.pojo.ReimburseInfo;

public interface ReimburseMapper {

	/**
	 * 查询报销列表的报销ID
	 * @param grank  		职位级别
	 * @param eid			用户Id
	 * @param statusId		报销状态
	 * @param departmentId	部门id
	 * @return
	 */
	List<ReimburseVO> selectReimburesId(@Param("grank")Integer grank,@Param("createMan")Integer eid,@Param("statusId")Integer statusId,
			@Param("option")Integer option,@Param("startDate")String startDate,@Param("endDate")String endDate,@Param("departmentId") Integer departmentId);

	/**
	 * 财务查询列表的报销ID
	 * @param eid
	 * @param statusId
	 * @return
	 */
	List<ReimburseVO> selectReimId(@Param("startDate")String startDate,@Param("endDate")String endDate,@Param("createMan")Integer eid,@Param("statusId")Integer statusId);

	/**
	 * 分页的数据
	 * @param rids
	 * @return
	 */
	List<ReimburseVO> selectReimburseVO(@Param("rids")List<Integer> rids);

	/**
	 * 删除报销单主表
	 * @param reimburseId
	 * @return
	 */
	int deleteReimburse(@Param("reimburseId") Integer reimburseId);
	
	/**
	 * 删除报销单详表
	 * @param reimburseId
	 * @return
	 */
	int deleteReimburseInfo(@Param("reimburseId")Integer reimburseId);
	
	/**
	 * 添加主账单
	 * @param reim
	 * @return
	 */
	int insetReim(@Param("reim")Reimburse reim);

	/**
	 * 添加详表账单
	 * @param reiminfos
	 * @return
	 */
	int insertReimInfo(@Param("reiminfos")List<ReimburseInfo> reiminfos,@Param("reimId")Integer reimId);
	/**
	 * 查询最后一个报销单
	 * @return
	 */
	Reimburse seletReimId();

	/**
	 * 修改报销单主表
	 * @param reimburse
	 * @return
	 */
	int updateReimburse(@Param("reimburse") Reimburse reimburse);

	/**
	 * 修改报销详情表
	 * @param reims
	 * @return
	 */
	int updatereims(@Param("reims")List<ReimburseInfo> reims);
}
