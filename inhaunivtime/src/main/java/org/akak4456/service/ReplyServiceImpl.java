package org.akak4456.service;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.ReplyPageDTO;
import org.akak4456.domain.ReplyVO;
import org.akak4456.mapper.FreeBoardMapper;
import org.akak4456.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
@Service
public class ReplyServiceImpl implements ReplyService {
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;
	@Setter(onMethod_ = @Autowired)
	private FreeBoardMapper freeBoardMapper;
	@Transactional
	@Override
	public int register(ReplyVO reply) {
		// TODO Auto-generated method stub
		freeBoardMapper.updateReplyCnt(reply.getBno(), 1);
		
		return replyMapper.insertSelectKey(reply);
	}

	@Override
	public ReplyVO get(Long rno) {
		// TODO Auto-generated method stub
		return replyMapper.read(rno);
	}

	@Override
	public boolean modify(ReplyVO reply) {
		// TODO Auto-generated method stub
		return replyMapper.update(reply) == 1;
	}
	@Transactional
	@Override
	public boolean remove(Long rno) {
		// TODO Auto-generated method stub
		ReplyVO reply = replyMapper.read(rno);
		freeBoardMapper.updateReplyCnt(reply.getBno(), -1);
		return replyMapper.updateStateToDelete(rno) == 1;
	}

	@Override
	public ReplyPageDTO getList(Criteria cri, Long bno) {
		// TODO Auto-generated method stub
		return new ReplyPageDTO(
				replyMapper.getCountByBno(bno),
				replyMapper.getListWithPaging(cri, bno)
				);
	}

}
