package com.accp.biz;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.accp.dao.CountMapper;
import com.accp.pojo.Count;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service("countBiz")
public class CountBiz {
	
	@Resource
	private CountMapper cMapper;
	
	/**
	 * 查询报表
	 * @param typeId          报表类型    1为 年度总报表  2为月度总报表 3为部门年度报表 4为部门月度报表 5为年度个人报表 6为月度个人报表
	 * @param pageNum		    当前页
	 * @param pageSize		    页大小
	 * @param startYear		    开始年份 当前年份 		
	 * @param endYear		    结束年份
	 * @param startMonth	    开始月份 当前月份
	 * @param endMonth		    结束月份
	 * @param departmentId	    部门Id null为全部
	 * @param employeeId	    用户Id null为全部
	 * @return
	 */
	public PageInfo<Count> findCount(Integer typeId,Integer pageNum,Integer pageSize,Integer startYear,Integer endYear,
			Integer startMonth,Integer endMonth,Integer departmentId,Integer employeeId){
		PageHelper.startPage(pageNum, pageSize);
		List<Count> counts = null;
		System.err.println(departmentId);
		switch (typeId) {
		case 1:
			counts = cMapper.selectYearCount(startYear, endYear);
			break;

		case 2:
			counts = cMapper.selectMonthCount(startYear, startMonth, endMonth);
			break;
		case 3:
			counts = cMapper.selectDepartmentYearCount(startYear,endYear, departmentId);
			break;
		case 4:
			counts = cMapper.selectDepartmentMonthCount(startYear, startMonth, endMonth, departmentId);
			break;
		case 5:
			
			counts = cMapper.selectEmployeeYearCount(startYear, departmentId);
			break;
		case 6:
			System.err.println(departmentId);
			counts = cMapper.selectEmployeeMonthCount(startYear, startMonth, departmentId);
			break;
		}
		return new PageInfo<Count>(counts);
	}
	
	
	
	public void addCount() {
		
		  Integer year = Calendar.getInstance().get(Calendar.YEAR); Integer month=
		  Calendar.getInstance().get(Calendar.MONTH)==0?12:Calendar.getInstance().get(Calendar.MONTH); 
		  String months=month>=10?month+"":"0"+month;
		  
		  List<Count> counts = cMapper.selectCounts(year+"-"+months);
		  counts.forEach(count->{ count.setYear(year); count.setMonth(month); });
		  cMapper.insertCount(counts);
		 
	}
}
