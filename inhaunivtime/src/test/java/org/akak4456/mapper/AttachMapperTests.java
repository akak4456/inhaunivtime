package org.akak4456.mapper;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.List;

import org.akak4456.domain.AttachVO;
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
public class AttachMapperTests {
	@Setter(onMethod_ = @Autowired)
	private FreeBoardMapper freeBoardMapper;
	@Setter(onMethod_ = @Autowired)
	AttachMapper mapper;
	@Test
	public void alltest() {
		List<AttachVO> attachs = mapper.getList();
		attachs.forEach(attach->mapper.delete(attach.getUuid()));
		attachs = mapper.getList();
		assertThat(attachs.size(),is(0));
		AttachVO vo = new AttachVO();
		Long bno = generateFreeBoardForTest();
		vo.setBno(bno);
		vo.setFilename("파일이름입니다");
		vo.setUploadpath("파일경로입니다");
		vo.setUuid("파일 uuid입니다");
		int insertCount = mapper.insert(vo);
		assertThat(insertCount,is(1));
		List<AttachVO> getattachs = mapper.findByBno(bno);
		assertThat(getattachs.size(),is(1));
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
}
