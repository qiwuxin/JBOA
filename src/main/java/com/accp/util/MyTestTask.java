package com.accp.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.accp.biz.CountBiz;

/**
 * 
 * @author lenovo
 * @此类作用定时器
 */
@Component
public class MyTestTask {
	
	@Autowired
	private CountBiz cb;
	
	@Scheduled(cron = "0 0 0 1 *  ?")
	public void taskCycle() {
		cb.addCount();
	}
}
