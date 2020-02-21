package com.accp.biz;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.accp.VO.EmployeeVO;
import com.accp.VO.ReimburseVO;
import com.accp.dao.CheckMapper;
import com.accp.dao.ReimburseMapper;
import com.accp.pojo.CheckInfo;
import com.accp.pojo.Reimburse;
import com.accp.pojo.ReimburseInfo;
import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@SuppressWarnings("all")
@Service("reimburseBiz")
public class ReimburseBiz {
	
	@Resource
	private ReimburseMapper rMapper;
	
	@Resource
	private LeaveBiz lb;
	
	@Resource
	private CheckMapper cMapper;
	
	/**
	 * 查询分页数据
	 * @param grank
	 * @param eid
	 * @param statusId
	 * @param departmentId
	 * @param pageNum
	 * @param pageSize
	 * @param startDate
	 * @param endDate
	 * @param option
	 * @return
	 */
	public  PageInfo<ReimburseVO> findReimburse(Integer grank,Integer eid,Integer statusId,String startDate,
			String endDate,Integer option,Integer departmentId,Integer pageNum,Integer pageSize){
		List<Integer> rids = new ArrayList<Integer>(0);
		PageHelper.startPage(pageNum, pageSize);
		PageInfo<ReimburseVO> info = null;
		if(grank==3) {
			System.err.println(grank);
			info = new PageInfo<ReimburseVO>(rMapper.selectReimId(startDate, endDate, eid, statusId));
		}else {
			info = new PageInfo<ReimburseVO>(rMapper.selectReimburesId(grank, eid, statusId, option, startDate, endDate, departmentId));
		}
		if(info.getList().size()>0) {
			for (ReimburseVO rvo : info.getList()) {
				rids.add(rvo.getReimburseId());
			}
			info.setList(rMapper.selectReimburseVO(rids));
		}
		
		return info;
	}
	
	/**
	 * 删除报销单
	 * @param reimburseId 报销单id
	 * @return
	 */
	public Boolean removeReimburse(Integer reimburseId) {
		Boolean bool = false;
		try {
			if(rMapper.deleteReimburse(reimburseId)>0) {
				rMapper.deleteReimburseInfo(reimburseId);
				bool = true;
			}
		}catch (Exception e) {
			// TODO: handle exception
		}finally {
			return bool;
		}
	}
	/**
	 * 修改报销单信息
	 * @param rvo
	 * @return
	 */
	public Boolean modifyReimburse(Reimburse reimburse,List<ReimburseInfo> reims) {
		Boolean bool = false;
		try {
			getNext(reimburse);
			System.err.println(JSON.toJSON(reimburse));
			if(rMapper.updateReimburse(reimburse)>0) {
				rMapper.deleteReimburseInfo(reimburse.getReimburseId());
				rMapper.insertReimInfo(reims, reimburse.getReimburseId());
				bool=true;
			}
		}catch (Exception e) {
			bool = false;
		}
		return bool;
	}
	
	/**
	 * 添加报销单信息
	 * @param reim
	 * @return
	 */
	public Boolean addReimburse(Reimburse reim) {
		System.err.println(JSON.toJSON(reim));
		Boolean bool =false;
		getNext(reim);
		Integer reimId = null;
		
		  if(rMapper.insetReim(reim)>0) { reimId =
		  rMapper.seletReimId().getReimburseId();
		  System.err.println(reimId);
		   bool = true; }
		  rMapper.insertReimInfo(reim.getReiminfos(), reimId);
		   return bool;
		 
	}
	
	public void getNext(Reimburse reim) {
		System.err.println(JSON.toJSON(reim));
		if(reim.getTotalCount()>=5000) {
			reim.setCreateMan(1000);
		}
	}
	
	/**
	 * 修改请假的审核状态
	 * @param leaveId
	 * @param statusId
	 * @return
	 */
	public Boolean modifyReimStatus(CheckInfo checkInfo,EmployeeVO evo,ReimburseVO rvo) {
		Boolean bool = false;
		try {
			Reimburse reim = new Reimburse();
			reim.setReimburseId(rvo.getReimburseId());
			reim.setTypeId(rvo.getTypeId());
			reim.setNextDealMan(lb.getNext(checkInfo, evo.getPositionId(), rvo));
			Integer statusId = 3;
			if(reim.getNextDealMan()==1002||checkInfo.getCheckResult()==2) {
				statusId = 4;
			}else if(reim.getNextDealMan()==reim.getCreateMan()) {
				statusId = 6;
			}else if(checkInfo.getCheckMan()==1002) {
				statusId = 5;
			}
			reim.setStatusId(statusId);
			rMapper.updateReimburse(reim);
			cMapper.insertCheck(checkInfo);
			bool = true;
		}catch (Exception e) {
			bool = false;
		}finally {
			return bool;
		}
	}
	
	public Boolean modifyRiem(Reimburse reim) {
		Boolean bool = false;
		try {
			rMapper.updateReimburse(reim);
			bool = true;
		}catch (Exception e) {
			bool = false;
		}finally {
			return bool;
		}
		
	}
}
