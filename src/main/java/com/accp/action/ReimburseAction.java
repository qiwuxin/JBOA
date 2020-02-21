package com.accp.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.accp.VO.EmployeeVO;
import com.accp.VO.ReimburseVO;
import com.accp.biz.ReimburseBiz;
import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/c/reimburse")
public class ReimburseAction {
	
	@Resource
	private ReimburseBiz rb;
	
	@GetMapping("apply")
	public String apply(Model model,HttpSession session) {
		EmployeeVO evo = (EmployeeVO) session.getAttribute("evo");
		model.addAttribute("user", evo);
		return "apply";
	}
	
	@GetMapping("applyList")
	public String applyList(Model model,HttpSession session) {
		EmployeeVO evo = (EmployeeVO) session.getAttribute("evo");
		model.addAttribute("user", evo);
		return "showReimburse";
	}
	
	public static PageInfo<ReimburseVO> rvo = null;
	
	/**
	 * 查询报销列表信息
	 * @param session
	 * @param statuId
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	@PostMapping("api/page")
	@ResponseBody
	public PageInfo<ReimburseVO> pageInfo(HttpSession session,Integer statusId,String startDate,String endDate,
			Integer option,Integer pageNum,Integer pageSize){
		EmployeeVO evo = (EmployeeVO) session.getAttribute("evo");
		System.err.println(evo.getEmployeeName()+"=="+evo.getDepartmentId()+"=="+evo.getEmployeeId()+"=="+option+"=="+evo.getPositionId()+"=="+pageNum+pageSize);
		System.err.println(statusId);
		statusId = statusId==0?null:statusId;
		startDate="".equals(startDate)?null:startDate;
		endDate  ="".equals(endDate)?null:endDate;
		rvo = rb.findReimburse(evo.getPositionId(), evo.getEmployeeId(), statusId, startDate, endDate,option,evo.getDepartmentId(),pageNum, pageSize);
		System.err.println(JSON.toJSONString(rvo));
		return rvo;
	}
	
	public ReimburseVO returnValue(Integer reimId) {
		for (ReimburseVO rvo : rvo.getList()) {
			if(reimId==rvo.getReimburseId()) {
				return rvo;
			}
		}
		return null;
	}
	
	/**
	 * 查询报销单
	 * @param model
	 * @param reimId
	 * @return
	 */
	@GetMapping("queryApply")
	public String queryApply(Model model,Integer reimId) {
		model.addAttribute("rvo", returnValue(reimId));
		return "queryApply";

	}
	
	/**
	 * 修改报销单
	 * @param model
	 * @param reimId
	 * @return
	 */
	@GetMapping("updateApply")
	public String updateApply(Model model,Integer reimId) {
		model.addAttribute("rvo", returnValue(reimId));
		return "updateApply";
	}
	
	/**
	 * 审核报销单
	 * @param model
	 * @param reimId
	 * @return
	 */
	@GetMapping("checkApply")
	public String checkApply(Model model,Integer reimId) {
		model.addAttribute("rvo", returnValue(reimId));
		return "checkApply";

	}



}
