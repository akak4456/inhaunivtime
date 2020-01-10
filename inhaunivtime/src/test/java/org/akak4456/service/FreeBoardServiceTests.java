package org.akak4456.service;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.ArrayList;
import java.util.List;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.FreeBoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class FreeBoardServiceTests {
	@Setter(onMethod_ = @Autowired)
	private FreeBoardService freeBoardService;
	@Test
	public void getListTest() {
		for (int i = 0; i < 20; i++) {
			FreeBoardVO vo = new FreeBoardVO();
			vo.setTitle(i + "");
			vo.setContent(i + "");
			vo.setWritername(i+"");
			freeBoardService.register(vo);
		}
		List<FreeBoardVO> vo = freeBoardService.getList(new Criteria());
		assertThat(vo.size(),is(10));
		vo.forEach(v->log.info("freeBoard: "+v));
	}
}
