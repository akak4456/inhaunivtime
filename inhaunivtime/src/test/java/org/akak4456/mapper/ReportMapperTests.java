package org.akak4456.mapper;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.List;

import org.akak4456.domain.CourseRateVO;
import org.akak4456.domain.ReportVO;
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
public class ReportMapperTests {
	@Setter(onMethod_ = @Autowired)
	private ReportMapper mapper;
	@Test
	public void insertAndReadTest() {
		deleteAll();
		ReportVO vo = new ReportVO();
		vo.setTargetno(1L);
		vo.setCasekind('b');
		mapper.insertSelectKey(vo);
		List<ReportVO> boards = mapper.getList();
		log.info("report: "+boards);
		assertThat(boards.size(),is(1));
		//insert Test
		Long caseno = vo.getCaseno();
		log.info("caseno: "+caseno);
		ReportVO vo2 = mapper.read(caseno);
		log.info("vo2: "+vo2);
		assertThat(vo2.getTargetno(),is(vo.getTargetno()));
		assertThat(vo2.getCasekind(),is(vo.getCasekind()));
		
	}
	private void deleteAll() {
		List<ReportVO> notices = mapper.getList();
		notices.forEach(notice->mapper.delete(notice.getCaseno()));
		notices = mapper.getList();
		assertThat(notices.size(),is(0));
	}
}
