package org.akak4456.service;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.ReplyPageDTO;
import org.akak4456.domain.ReplyVO;

public interface ReplyService {
	public int register(ReplyVO reply);
	
	public ReplyVO get(Long rno);
	
	public boolean modify(ReplyVO reply);
	
	public boolean remove(Long rno);
	
	public ReplyPageDTO getList(Criteria cri,Long bno);
}
