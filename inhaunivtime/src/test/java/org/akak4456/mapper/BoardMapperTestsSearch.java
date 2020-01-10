package org.akak4456.mapper;

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
public class BoardMapperTestsSearch {
	@Setter(onMethod_ = @Autowired)
	private FreeBoardMapper mapper;
	
	@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("»õ·Î");
		cri.setType("W");
		
		List<FreeBoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board->log.info(board));
	}
}
