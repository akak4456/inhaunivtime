package org.akak4456.mapper;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.ArrayList;
import java.util.List;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.FreeBoardVO;
import org.akak4456.domain.ReplyVO;
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
public class ReplyTests {
	@Setter(onMethod_ = @Autowired)
	private FreeBoardMapper freeBoardMapper;
	@Setter(onMethod_ = @Autowired)
	ReplyMapper mapper;
	@Test
	public void insertAndUpdateTest() {
		deleteAll();
		List<FreeBoardVO> freeboards = freeBoardMapper.getList();
		Long bno=generateFreeBoardForTest();
		ReplyVO vo = new ReplyVO();
		vo.setBno(bno);
		vo.setReply("답장입니다");
		vo.setRepliername("답장작성자입니다");
		int insertCount = mapper.insertSelectKey(vo);
		assertThat(insertCount,is(1));
		Long rno = vo.getRno();
		ReplyVO vo2 = mapper.read(rno);
		assertThat(vo2.getReply(),is(vo.getReply()));
		assertThat(vo2.getRepliername(),is(vo.getRepliername()));
		vo.setReply("답장입니다2");
		mapper.update(vo);
		vo2 = mapper.read(rno);
		assertThat(vo2.getReply(),is("답장입니다2"));
	}
	@Test
	public void getListWithPagingTest() {
		deleteAll();
		Long bno=generateFreeBoardForTest();
		List<ReplyVO> replies = new ArrayList<>();
		Long[] topRno = new Long[3];
		for(int i=0;i<20;i++) {
			ReplyVO vo = new ReplyVO();
			vo.setBno(bno);
			vo.setReply(i+"");
			vo.setRepliername(i+"");
			if(3<=i&&i<=8) {
				vo.setReplyto(topRno[0]);
				mapper.insertSelectKey(vo);
			}else if(9<=i&&i<=15) {
				vo.setReplyto(topRno[1]);
				mapper.insertSelectKey(vo);
			}else if(i>=16){
				vo.setReplyto(topRno[2]);
				mapper.insertSelectKey(vo);
			}else {
				mapper.insertSelectKey(vo);
				topRno[i] = vo.getRno();
			}
			replies.add(vo);
		}
		Criteria cri = new Criteria();
		List<ReplyVO> getreplies = mapper.getListWithPaging(cri, bno);
		String[] wantReply = {"0","3","4","5","6","7","8","1","9","10"};
		assertThat(getreplies.size(),is(10));
		for(int i=0;i<10;i++) {
			assertThat(getreplies.get(i).getReply(), is(wantReply[i]));
		}
		cri.setPageNum(2);
		getreplies = mapper.getListWithPaging(cri, bno);
		String[] wantReply2 = {"11","12","13","14","15","2","16","17","18","19"};
		assertThat(getreplies.size(),is(10));
		for(int i=0;i<10;i++) {
			assertThat(getreplies.get(i).getReply(), is(wantReply2[i]));
		}
	}
	private Long generateFreeBoardForTest() {
		List<FreeBoardVO> freeboards = freeBoardMapper.getList();
		if(freeboards.size() == 0) {
			FreeBoardVO vo = new FreeBoardVO();
			vo.setTitle("제목입니다");
			vo.setContent("내용입니다");
			vo.setWritername("작성자입니다");
			freeBoardMapper.insertSelectKey(vo);
			return vo.getBno();
		}else {
			return freeboards.get(0).getBno();
		}
	}
	private void deleteAll() {
		List<ReplyVO> replies = mapper.getList();
		replies.forEach(vo->mapper.delete(vo.getRno()));
		replies = mapper.getList();
		assertThat(replies.size(),is(0));
	}
}
