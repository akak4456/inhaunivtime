package org.akak4456.mapper;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.ArrayList;
import java.util.List;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.NoticeVO;
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
public class NoticeMapperTests {
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper mapper;
	@Test
	public void insertAndReadTest() {
		deleteAll();
		NoticeVO vo = new NoticeVO();
		vo.setTitle("나나나");
		vo.setContent("가가가");
		mapper.insertSelectKey(vo);
		List<NoticeVO> notices = mapper.getList();
		log.info("notices: "+notices);
		assertThat(notices.size(),is(1));
		//insert Test
		log.info("bno: "+vo.getBno());
		NoticeVO vo2 = mapper.read(vo.getBno());
		log.info("vo2: "+vo2);
		assertThat(vo2.getTitle(),is(vo.getTitle()));
		assertThat(vo2.getContent(),is(vo.getContent()));
	}
	@Test
	public void updateTest() {
		deleteAll();
		NoticeVO vo = new NoticeVO();
		vo.setTitle("나나나");
		vo.setContent("가가가");
		mapper.insertSelectKey(vo);
		log.info("bno: "+vo.getBno());
		Long bno = vo.getBno();
		NoticeVO vo2 = mapper.read(bno);
		log.info("vo2: "+vo2);
		vo2.setTitle("나나나2");
		vo2.setContent("가가가2");
		int updateCnt = mapper.update(vo2);
		NoticeVO vo3 = mapper.read(bno);
		assertThat(vo3.getTitle(),is("나나나2"));
		assertThat(vo3.getContent(),is("가가가2"));
		assertThat(updateCnt,is(1));
	}
	@Test
	public void getListTest() {
		deleteAll();
		Criteria cri = new Criteria();
		List<NoticeVO> notices = new ArrayList<>();
		for (int i = 0; i < 20; i++) {
			NoticeVO vo = new NoticeVO();
			vo.setTitle(i + "");
			vo.setContent(i + "");
			mapper.insertSelectKey(vo);
			notices.add(vo);
		}
		List<NoticeVO> getnotices = mapper.getListWithPaging(cri);
		assertThat(getnotices.size(), is(10));
		log.info("getnotices page1: "+getnotices);
		for(int i=0;i<10;i++) {
			assertThat(getnotices.get(i).getTitle(),is(notices.get(19-i).getTitle()));
		}
		cri.setPageNum(2);
		getnotices = mapper.getListWithPaging(cri);
		assertThat(getnotices.size(),is(10));
		log.info("getnotices page2: "+getnotices);
		for(int i=0;i<10;i++) {
			assertThat(getnotices.get(i).getTitle(),is(notices.get(9-i).getTitle()));
		}
	}
	private void deleteAll() {
		List<NoticeVO> notices = mapper.getList();
		notices.forEach(notice->mapper.delete(notice.getBno()));
		notices = mapper.getList();
		assertThat(notices.size(),is(0));
	}
}
