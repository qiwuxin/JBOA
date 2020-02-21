package com.accp.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/c/person/count")
public class CountAction {

	@GetMapping("AllYear")
	public String getAllYear() {
		return "CountMenu";
	}
	
	
}
