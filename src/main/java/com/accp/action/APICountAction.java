package com.accp.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.accp.VO.EmployeeVO;
import com.accp.biz.CountBiz;
import com.accp.pojo.Count;
import com.accp.util.OutExcel;
import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;

@RestController
@RequestMapping("/api/person/")
public class APICountAction {
	
	@Resource
	private CountBiz cb;
	
	@Resource
	private OutExcel outExcel;
	
	/**
	 * 查询年度报表
	 * @param pageNum
	 * @param pageSize
	 * @param startYear
	 * @param endYear
	 * @return
	 */
	@GetMapping("counts/year/all/{pageNum}/{pageSize}/{startYear}/{endYear}")
	public PageInfo<Count> findYearCount(@PathVariable Integer pageNum,@PathVariable Integer pageSize,
				@PathVariable Integer startYear,@PathVariable Integer endYear){
		startYear = startYear==0?null:startYear;
		endYear   = endYear  ==0?null:endYear;
		return cb.findCount(1, pageNum, pageSize, startYear, endYear, null, null, null, null);
	}
	/**
	 * 查询月度报表
	 * @param pageNum
	 * @param pageSize
	 * @param startYear
	 * @param startMonth
	 * @param endMonth
	 * @return
	 */
	@GetMapping("counts/month/all/{pageNum}/{pageSize}/{startYear}/{startMonth}/{endMonth}")
	public PageInfo<Count> findMonthCount(@PathVariable Integer pageNum,@PathVariable Integer pageSize,
			@PathVariable Integer startYear,@PathVariable Integer startMonth,@PathVariable Integer endMonth){
		startYear  = startYear==0?null:startYear;
		startMonth = startMonth==0?null:startMonth;
		endMonth   = endMonth==0?null:endMonth;
	return cb.findCount(2, pageNum, pageSize, startYear, null, startMonth, endMonth, null, null);
	}	
	/**
	 * 查询部门年份报表
	 * @param pageNum
	 * @param pageSize
	 * @param startYear
	 * @param departmentId
	 * @return
	 */
	@GetMapping("counts/year/department/{pageNum}/{pageSize}/{startYear}/{endYear}/{departmentId}")
	public PageInfo<Count> findYearDepartmentYearCount(@PathVariable Integer pageNum,@PathVariable Integer pageSize,
			@PathVariable Integer startYear,@PathVariable Integer endYear,@PathVariable Integer departmentId){
		startYear     = startYear==0?null:startYear;
		endYear       = endYear==0?null:endYear;
		departmentId  = departmentId==0?null:departmentId;
		return cb.findCount(3, pageNum, pageSize, startYear, endYear, null, null, departmentId, null);
	}
	
	/** 查询部门月份报表
	 * @param pageNum
	 * @param pageSize
	 * @param startYear
	 * @param departmentId
	 * @return
	 */
	@GetMapping("counts/month/department/{pageNum}/{pageSize}/{startYear}/{startMonth}/{endMonth}/{departmentId}")
	public PageInfo<Count> findMonthDepartmentYearCount(@PathVariable Integer pageNum,@PathVariable Integer pageSize,
			@PathVariable Integer startYear,@PathVariable Integer startMonth,
			@PathVariable Integer endMonth,@PathVariable Integer departmentId){
		
		startYear  = startYear==0?null:startYear;
		startMonth = startMonth==0?null:startMonth;
		endMonth   = endMonth==0?null:endMonth;
		departmentId  = departmentId==0?null:departmentId;
		
		return cb.findCount(4, pageNum, pageSize, startYear, null, startMonth, endMonth, departmentId, null);	
	}
	/**
	 * 查询个人年度报表
	 * @param pageNum
	 * @param pageSize
	 * @param startYear
	 * @return
	 */
	@GetMapping("counts/year/employee/{pageNum}/{pageSize}/{startYear}")
	public PageInfo<Count> findYearEmployeeYearCount(HttpSession session,@PathVariable Integer pageNum,@PathVariable Integer pageSize,
			@PathVariable Integer startYear){
		startYear  = startYear==0?null:startYear;
		return cb.findCount(5, pageNum, pageSize, startYear, null, null, null, ((EmployeeVO)session.getAttribute("evo")).getDepartmentId(), null);
	}
	/**
	 * 个人月度报表
	 * @param pageNum
	 * @param pageSize
	 * @param startYear
	 * @param startMonth
	 * @return
	 */
	@GetMapping("counts/month/employee/{pageNum}/{pageSize}/{startYear}/{startMonth}")
	public PageInfo<Count> findMonthEmployeeYearCount(HttpSession session,@PathVariable Integer pageNum,@PathVariable Integer pageSize,
			@PathVariable Integer startYear,@PathVariable Integer startMonth){
		startYear  = startYear==0?null:startYear;
		startMonth = startMonth==0?null:startMonth;
		System.err.println("123");
		return cb.findCount(6, pageNum, pageSize, startYear, null, startMonth, startMonth, ((EmployeeVO)session.getAttribute("evo")).getDepartmentId(), null);
	}
	
	@GetMapping("MonthCount")
	public ModelAndView monthCount() {
		System.err.println("123");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("CountMonth");
		return mav;
	}
	
	@GetMapping("YearCountInfo")
	public ModelAndView yearCountInfo() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("CountInfo");
		return mav;
	}
	
	@GetMapping("MonthCountInfo")
	public ModelAndView monthCountInfo() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("monthCount");
		return mav;
	}
	
	@PostMapping("counts/excel")
	public String outExcel(@RequestParam("tbTitles[]")String[] tbTitles,@RequestParam("counts[]")String[] counts,
			String fileName) {
		List<Count> count = new ArrayList<Count>(0);
		for (String string : counts) {
			count.add(JSON.parseObject(string,Count.class));
		}
		if(outExcel.outputStreamExcel(fileName, tbTitles, count)) {
			return "成功！";
		}else {
			return "失败！";
		}
	}
	
}
