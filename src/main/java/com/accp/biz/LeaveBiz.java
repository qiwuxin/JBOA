package com.accp.biz;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.accp.VO.EmployeeVO;
import com.accp.VO.LeaveVO;
import com.accp.VO.ReimburseVO;
import com.accp.dao.CheckMapper;
import com.accp.dao.LeaveMapper;
import com.accp.pojo.CheckInfo;
import com.accp.pojo.Leave;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@SuppressWarnings("all")
@Service("leaveBiz")
public class LeaveBiz {
	
	@Resource
	private LeaveMapper lMapper;
	
	@Resource
	private CheckMapper cMapper;
	
	/**
	 * 添加请假条
	 * @param leave
	 * @return
	 */
	public Boolean addLeave(Leave leave) {
		Boolean bool = false;
		try {
			bool =lMapper.insertLeave(leave)>0;
		}catch (Exception e) {
			bool =false;
		}finally {
			return bool;
		}
	}
	
	/**
	 * 查看请假
	 * @param eid
	 * @param pageNum
	 * @param pageSize
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public PageInfo<LeaveVO> findLeave(Integer eid,Integer pageNum,Integer pageSize,
			String startDate,String endDate,Integer grank,Integer did,Integer option){
		PageHelper.startPage(pageNum, pageSize);
		PageInfo<LeaveVO> info =new PageInfo<LeaveVO>(lMapper.selectLeaveId(eid, startDate, endDate, grank, did,option));
 		List<Integer> leaveIds = new ArrayList<Integer>(0);
 		if(info.getList().size()<1) {
 			return info;
 		}
 		for (LeaveVO lvo : info.getList()) {
			leaveIds.add(lvo.getLeaveId());
		}
 		info.setList(lMapper.selecLeave(leaveIds));
		return info;
	}
	
	
	/**
	 * 修改请假的审核状态
	 * @param leaveId
	 * @param statusId
	 * @return
	 */
	public Boolean modifyLeaveStatus(CheckInfo checkInfo,EmployeeVO evo,ReimburseVO rvo) {
		Boolean bool = false;
		try {
			Integer nextDealMan=getNext(checkInfo, evo.getPositionId(), rvo);
			lMapper.updateStatus(checkInfo.getBizId(),4,nextDealMan);
			if(checkInfo.getCheckResult()==7) {
				checkInfo.setCheckResult(1);
			}
			cMapper.insertCheck(checkInfo);
			bool = true;
		}catch (Exception e) {
			bool = false;
		}finally {
			return bool;
		}
	}
	
	/**
	 * 下一个审核人
	 * @param checkInfo
	 * @param pid
	 * @param rvo
	 * @return
	 */
	public Integer getNext(CheckInfo checkInfo,Integer pid,ReimburseVO rvo) {
		Integer nextDealMan = null;
		if(checkInfo.getTypeId()==1) {
			if((pid==1||pid==0)&&checkInfo.getCheckResult()==1) {
				nextDealMan = 1017;
			}else if(pid==4 || checkInfo.getCheckResult()==2) {
				nextDealMan = 10000;
			}
		}else {
			if(checkInfo.getCheckResult()==1) {
				if(pid==1&&rvo.getTotalCount()>=5000) {
					nextDealMan = 1000;
				}else if((pid==1||pid==0)&&rvo.getTotalCount()<5000) {
					nextDealMan = 1001;
				}else if(pid==3) {
					nextDealMan = 1002;
				}else if(pid==5) {
					nextDealMan = 10000;
				}
			}else if(checkInfo.getCheckResult()==3) {
				nextDealMan=rvo.getEmployeeId();
			}else {
				nextDealMan=10000;
			}
		}
		System.err.println(nextDealMan);
		return nextDealMan;
	}
}
