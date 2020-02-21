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
import com.accp.biz.EmployeeBiz;
import com.alibaba.fastjson.JSON;


@Controller
@RequestMapping("/c/person")
public class EmployeeAction {

	@Resource
	private EmployeeBiz eb;
	
	@PostMapping("giam")
	public String login(Model model,HttpServletRequest request,String employeeId,String password) {
		String url = null;
			if(request.getSession().getAttribute("evo")==null) {
				EmployeeVO evo = eb.getEmployeeVO(employeeId, password);
				if(evo!=null) {
					request.getSession().setAttribute("evo", evo);
					model.addAttribute("user",evo);
					url = "Menu";
				}else {
					url = "redirect:/login";
				}
			}else {
				EmployeeVO evo = (EmployeeVO) request.getSession().getAttribute("evo");
				model.addAttribute("user",evo);
				url = "Menu";
			}
		
		return url;
	}
	
	@GetMapping("giam")
	public String logins(HttpServletRequest request,Model model) {
		String url = null;
			EmployeeVO evo = (EmployeeVO) request.getSession().getAttribute("evo");
			if(evo!=null) {
				model.addAttribute("user", evo);
				url = "Menu";
			}else {
				url = "redirect:/login";
			}
		
		return url;
	}
	
	@GetMapping("cross")
	public String cross(HttpServletRequest request) {
		request.getSession().removeAttribute("evo");
		request.getSession().invalidate();
		return "redirect:/c/person/giam";
	}

	
	@GetMapping("leave")
	public String user(Model model,HttpServletRequest request) {
		
		EmployeeVO evo = (EmployeeVO) request.getSession().getAttribute("evo");
		model.addAttribute("user", evo);
		return "Leave";
	}

}
