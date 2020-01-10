package org.akak4456.service;

import java.util.List;

import org.akak4456.domain.AttachVO;
import org.akak4456.domain.Criteria;
import org.akak4456.domain.FreeBoardVO;

public interface FreeBoardService {
	public void register(FreeBoardVO freeBoard);
	
	public FreeBoardVO get(Long bno);
	
	public boolean modify(FreeBoardVO freeBoard);
	
	public boolean remove(Long bno);
	
	public List<FreeBoardVO> getList(Criteria cri);
	
	public boolean recommendCountUp(Long bno);
	
	public int getTotal(Criteria cri);
	
	public List<AttachVO> getAttachList(Long bno);
}
