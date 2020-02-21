package com.accp.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.accp.VO.EmployeeVO;
import com.accp.VO.LeaveVO;
import com.accp.biz.LeaveBiz;
import com.accp.pojo.CheckInfo;
import com.accp.pojo.Leave;
import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/c/leave")
public class LeaveAction {

	@Resource
	private LeaveBiz lb;
	
	PageInfo<LeaveVO> lvos = null;
	
	/**
	 * 添加请假条
	 * @param request
	 * @param leave
	 * @return
	 */
	@PostMapping( value = "addLeave", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String addLeave(HttpServletRequest request,Leave leave) {
		EmployeeVO evo = (EmployeeVO) request.getSession().getAttribute("evo");
		leave.setCreateMan(evo.getEmployeeId());
		leave.setDepartmentId(evo.getDepartmentId());
		leave.setNextDealMan(evo.getPid());
		if(lb.addLeave(leave)) {
			return "ok";
		}else {
			return "no";
		}
	}

	/**
	 * 跳转查询
	 * @return
	 */
	@RequestMapping("showLeave")
	public String showLeave() {
		return "showLeave";
	}
	
	/**
	 * 查询所有的请假数据
	 * @param request
	 * @param pageNum
	 * @param pageSize
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	@PostMapping(value = "leaveList", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String leaveList(HttpServletRequest request,Integer pageNum,Integer pageSize
			,String startDate,String endDate,Integer option) {
		EmployeeVO evo = (EmployeeVO)request.getSession().getAttribute("evo");
		Integer eid  = evo.getEmployeeId();
		Integer did  = evo.getDepartmentId();
		Integer grank= evo.getPositionId();
		startDate = "".equals(startDate)?null:startDate;
		endDate   = "".equals(endDate)?null:endDate;
		 lvos = lb.findLeave(eid, pageNum, pageSize, startDate, endDate, grank, did,option);
		 for (LeaveVO lvo : lvos.getList()) {
			System.err.println(lvo.getCreateName());
		}
		 return JSON.toJSONString(lvos);
	}
	
	/**
	 * 查看请假详情
	 * @param model
	 * @param leaveId
	 * @return
	 */
	@GetMapping("queryLeave")
	public String queryLeave(Model model,Integer leaveId) {
		for (LeaveVO lvo : lvos.getList()) {
			if(lvo.getLeaveId()==leaveId) {
				model.addAttribute("lvo", lvo);
				return "queryLeave";
			}
		}
		return "Menu";
	}
	/**
	 * 进入请假审核
	 * @param model
	 * @param leaveId
	 * @return
	 */
	@GetMapping("queryCheckLeave")
	public String queryCheckLeave(Model model,Integer leaveId) {
		for (LeaveVO lvo : lvos.getList()) {
			if(lvo.getLeaveId()==leaveId) {
				model.addAttribute("lvo", lvo);
				return "checkLeave";
			}
		}
		return "showLeave";
	}
	
	/**
	 * 审核请假
	 * @param request
	 * @param checkInfo
	 * @return
	 */
	@PostMapping(value="submitLeave",produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String submitLeave(HttpServletRequest request,CheckInfo checkInfo) {
		EmployeeVO evo = (EmployeeVO) request.getSession().getAttribute("evo"); 
		checkInfo.setCheckMan(evo.getEmployeeId());
		checkInfo.setTypeId(1);
		if(lb.modifyLeaveStatus(checkInfo, evo , null)) {
			return "ok";
		}else {
			return "no";
		}
	}


}
