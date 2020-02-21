package com.accp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.accp.pojo.Count;

public interface CountMapper {
	/**
	 * 年度总报销金额
	 * @param startYear 开始年份
	 * @param endYear   结束年份
	 * @return
	 */
	List<Count> selectYearCount(@Param("startYear")Integer startYear,@Param("endYear")Integer endYear); 
	/**
	 * 月度总报销金额
	 * @param year		  年份
	 * @param startMonth 开始月份
	 * @param endMonth   结束月份
	 * @return
	 */
	List<Count> selectMonthCount(@Param("year")Integer year,@Param("startMonth")Integer startMonth,@Param("endMonth")Integer endMonth);
	/**
	 * 年度部门报表
	 * @param startYear		年份
	 * @param departmentId	部门Id null表示查询全部
	 * @return
	 */
	List<Count> selectDepartmentYearCount(@Param("startYear") Integer startYear,@Param("endYear")Integer endYear,@Param("departmentId")Integer departmentId);
	/**
	 * 月度部门报表
	 * @param startYear		年份
	 * @param startMonth	开始月份
	 * @param endMonth		结束月份
	 * @param departmentId  部门Id
	 * @return
	 */
	List<Count> selectDepartmentMonthCount(@Param("startYear") Integer startYear,@Param("startMonth")Integer startMonth,@Param("endMonth")Integer endMonth,@Param("departmentId")Integer departmentId);
	/**
	 * 年度个人报表
	 * @param startYear		年份
	 * @param departmentId	部门Id
	 * @return
	 */
	List<Count> selectEmployeeYearCount(@Param("year") Integer startYear,@Param("departmentId")Integer employeeId);
	/**
	 * 月度个人报表
	 * @param startYear		年份
	 * @param startMonth	月份
	 * @param departmentId	部门Id
	 * @return
	 */
	List<Count> selectEmployeeMonthCount(@Param("year")Integer startYear,@Param("month")Integer startMonth,@Param("departmentId")Integer departmentId);


	 int insertCount(@Param("counts")List<Count> counts); 
	
	List<Count> selectCounts(@Param("date")String date);
} 
