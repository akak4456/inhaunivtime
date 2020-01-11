package org.akak4456.service;

import java.util.List;

import org.akak4456.domain.AttachVO;
import org.akak4456.domain.Criteria;
import org.akak4456.domain.FreeBoardVO;
import org.akak4456.domain.NoticeVO;
import org.akak4456.domain.ReportVO;
import org.akak4456.mapper.AttachMapper;
import org.akak4456.mapper.FreeBoardMapper;
import org.akak4456.mapper.NoticeMapper;
import org.akak4456.mapper.ReportMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;

@Service
public class FreeBoardServiceImpl implements FreeBoardService {
	@Setter(onMethod_ = @Autowired)
	private FreeBoardMapper freeBoardMapper;
	
	@Setter(onMethod_ = @Autowired)
	private AttachMapper attachMapper;
	
	@Setter(onMethod_ = @Autowired)
	private ReportMapper reportMapper;
	
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper noticeMapper;
	@Override
	public void register(FreeBoardVO freeBoard) {
		// TODO Auto-generated method stub
		freeBoardMapper.insertSelectKey(freeBoard);
		if(freeBoard.getAttachList() == null || freeBoard.getAttachList().size() <= 0) {
			return;
		}
		
		freeBoard.getAttachList().forEach(attach->{
			attach.setBno(freeBoard.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public FreeBoardVO get(Long bno) {
		// TODO Auto-generated method stub
		return freeBoardMapper.read(bno);
	}
	@Transactional
	@Override
	public boolean modify(FreeBoardVO freeBoard) {
		// TODO Auto-generated method stub
		attachMapper.deleteAll(freeBoard.getBno());
		
		boolean modifyResult = freeBoardMapper.update(freeBoard) == 1;
		if(modifyResult && freeBoard.getAttachList().size() > 0) {
			freeBoard.getAttachList().forEach(attach->{
				attach.setBno(freeBoard.getBno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}
	@Transactional
	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		attachMapper.deleteAll(bno);
		return freeBoardMapper.delete(bno) == 1;
	}

	@Override
	public List<FreeBoardVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return freeBoardMapper.getListWithPaging(cri);
	}
	@Transactional
	@Override
	public boolean recommendCountUp(Long bno) {
		// TODO Auto-generated method stub
		//���߿� tbl_member�� recommend�� ���� �ø���
		return freeBoardMapper.updateRecommendCnt(bno, 1) == 1;
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return freeBoardMapper.getTotalCount(cri);
	}

	@Override
	public List<AttachVO> getAttachList(Long bno) {
		// TODO Auto-generated method stub
		return attachMapper.findByBno(bno);
	}

	@Override
	public List<FreeBoardVO> getHotList(int amount) {
		// TODO Auto-generated method stub
		return freeBoardMapper.getHotBoard(amount);
	}

	@Override
	public void report(ReportVO report) {
		// TODO Auto-generated method stub
		reportMapper.insertSelectKey(report);
	}

	@Override
	public NoticeVO getRecentOneNotice() {
		// TODO Auto-generated method stub
		Criteria cri = new Criteria(1,1);
		return noticeMapper.getListWithPaging(cri).get(0);
	}

}
