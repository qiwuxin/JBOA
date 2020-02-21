import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.accp.biz.ReimburseBiz;
import com.accp.pojo.Reimburse;
import com.accp.pojo.ReimburseInfo;
import com.alibaba.fastjson.JSON;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-ctx.xml"})
public class ReimTest {

	@Resource
	private ReimburseBiz rb;
	
	@Test
	public void gg() {
		System.err.println(JSON.toJSONString(rb.findReimburse(1, 1004, null, null, null, 1, 3, 1, 3)));
	}
	
	@Test
	public void gc() {
		Reimburse reim = new Reimburse();
		reim.setCreateMan(1004);
		reim.setCreateTime("2019-10-21 10:00:00");
		reim.setDepartmentId(3);
		reim.setEvent("出差");
		reim.setNextDealMan(1000);
		reim.setReimburseId(null);
		reim.setStatusId(0);
		reim.setTotalCount(5000f);
		reim.setTypeId(2);
		List<ReimburseInfo> reiminfos = new ArrayList<ReimburseInfo>();
		ReimburseInfo info = new ReimburseInfo();
		info.setDesc("aaa");
		info.setMainId(84);
		info.setSubTotal(1231f);
		info.setPictureName("22222");
		reiminfos.add(info);
		reim.setReiminfos(reiminfos);
		System.err.println(rb.addReimburse(reim));
	}
	
}
