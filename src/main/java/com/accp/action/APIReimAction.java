package com.accp.action;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.accp.VO.EmployeeVO;
import com.accp.VO.ReimburseVO;
import com.accp.biz.LeaveBiz;
import com.accp.biz.ReimburseBiz;
import com.accp.pojo.CheckInfo;
import com.accp.pojo.Reimburse;
import com.alibaba.fastjson.JSON;

@RestController
@RequestMapping("api/person/")
public class APIReimAction {

	@Resource
	private ReimburseBiz rb;
	
	@Resource
	private LeaveBiz lb;
	
	@Resource
	private ReimburseAction ra;
	
	/**
	 * 添加报销单
	 * @param session
	 * @param reim
	 * @return
	 */
	@PostMapping("Reims/Reim")
	public String addReim(HttpSession session,@RequestBody Reimburse reim) {
		EmployeeVO evo = (EmployeeVO) session.getAttribute("evo");
		System.err.println(evo.getDepartmentId()+"==="+evo.getPid());
		reim.setDepartmentId(evo.getDepartmentId());
		reim.setNextDealMan(evo.getPid());
		System.err.println(JSON.toJSON(reim));
		
		  if(rb.addReimburse(reim)) { return "成功！"; }else { return "失败！"; }
		 
	}
	
	/**
	 * 修改报销单
	 */
	@PutMapping("Reims/Reim")
	public String updateReim(HttpSession session,@RequestBody Reimburse reim) {
		if(rb.modifyReimburse(reim, reim.getReiminfos())) {
			return "成功！";
		}else {
			return "失败！";
		}
	}
	
	/**
	 * 删除报销单
	 * @param session
	 * @param reimId
	 * @return
	 */
	@DeleteMapping("Reims/Reim/{reimId}")
	public String deleteReim(HttpSession session,@PathVariable Integer reimId) {
		if(rb.removeReimburse(reimId)) {
			return "成功！";
		}else {
			return "失败！";
		}
	}
	/**
	 * 添加审核单
	 * @param session
	 * @param checkInfo
	 * @return
	 */
	@PostMapping("checks/check")
	public String addCheckApply(HttpSession session,@RequestBody CheckInfo checkInfo) {
		EmployeeVO evo = (EmployeeVO) session.getAttribute("evo");
		if(rb.modifyReimStatus(checkInfo, evo,ra.returnValue(checkInfo.getBizId()))) {
			return "已";
		}else {
			return "未";
		}
	}
	
	@PutMapping("Reims/Riem/Sub/{rid}")
	public String checkRiem(HttpSession session,@PathVariable Integer rid) {
		Reimburse reim = new Reimburse();
		EmployeeVO evo = (EmployeeVO) session.getAttribute("evo");
		reim.setNextDealMan(evo.getPid());
		reim.setStatusId(2);
		reim.setReimburseId(rid);
		if(rb.modifyRiem(reim)) {
			return "成功!";
		}else {
			return "失败!";
		}
	}
}
