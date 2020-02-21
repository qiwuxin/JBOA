import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.accp.VO.LeaveVO;
import com.accp.biz.LeaveBiz;
import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-ctx.xml"})
public class LeaveTest {
	
	@Resource
	private LeaveBiz lb;
	
	@Test
	public void querLeaveList() {
		PageInfo<LeaveVO> info=lb.findLeave(1004, 1, 5, null, null, 1, 3,1);
		for (LeaveVO lvo : info.getList()) {
			System.err.println(lvo.getCreateName());
		}
	}
	
	@Test
	public void statusLeave() {
		System.err.println();
	}
	
}
