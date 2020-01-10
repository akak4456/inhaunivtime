package org.akak4456.service;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

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
public class ReplyServiceTests {
	@Setter(onMethod_ = @Autowired)
	private ReplyService replyService;
	@Setter(onMethod_ = @Autowired)
	private FreeBoardService freeBoardService;
	/*
	@Test
	public void serviceTest() {
		List<FreeBoardVO> freeBoards = freeBoardService.getList(new Criteria());
		FreeBoardVO freeBoardVO = freeBoards.get(0);
		log.info("freeBoard: "+freeBoardVO);
		Long bno = freeBoardVO.getBno();
		Long replyCnt = freeBoardVO.getReplycnt();
		for(int i=0;i<20;i++) {
			ReplyVO reply = new ReplyVO();
			reply.setBno(bno);
			reply.setRepliername(i+"");
			reply.setReply(i+"");
			replyService.register(reply);
		}
		freeBoardVO = freeBoardService.get(bno);
		assertThat(freeBoardVO.getReplycnt(),is(replyCnt+20));
		List<ReplyVO> replies = replyService.getList(new Criteria(), bno);
		assertThat(replies.size(), is(10));
		replies.forEach(reply->replyService.remove(reply.getRno()));
		freeBoardVO = freeBoardService.get(bno);
		assertThat(freeBoardVO.getReplycnt(),is(replyCnt+10));
	}
	*/
}
