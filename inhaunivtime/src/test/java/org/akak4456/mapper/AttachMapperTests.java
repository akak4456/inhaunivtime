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
		vo.setFilename("�����̸��Դϴ�");
		vo.setUploadpath("���ϰ���Դϴ�");
		vo.setUuid("���� uuid�Դϴ�");
		int insertCount = mapper.insert(vo);
		assertThat(insertCount,is(1));
		List<AttachVO> getattachs = mapper.findByBno(bno);
		assertThat(getattachs.size(),is(1));
	}
	private Long generateFreeBoardForTest() {
		List<FreeBoardVO> freeboards = freeBoardMapper.getList();
		if(freeboards.size() == 0) {
			FreeBoardVO vo = new FreeBoardVO();
			vo.setTitle("�����Դϴ�");
			vo.setContent("�����Դϴ�");
			vo.setWritername("�ۼ����Դϴ�");
			freeBoardMapper.insertSelectKey(vo);
			return vo.getBno();
		}else {
			return freeboards.get(0).getBno();
		}
	}
}
