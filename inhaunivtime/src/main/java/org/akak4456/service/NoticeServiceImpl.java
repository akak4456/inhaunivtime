package org.akak4456.service;

import java.util.List;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.NoticeVO;
import org.akak4456.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
@Service
public class NoticeServiceImpl implements NoticeService {
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper noticeMapper;
	@Override
	public NoticeVO get(Long bno) {
		// TODO Auto-generated method stub
		return noticeMapper.read(bno);
	}
	@Override
	public int getTotal() {
		// TODO Auto-generated method stub
		return noticeMapper.getTotal();
	}
	@Override
	public List<NoticeVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return noticeMapper.getListWithPaging(cri);
	}
	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		return noticeMapper.delete(bno) == 1;
	}
	@Override
	public void register(NoticeVO notice) {
		// TODO Auto-generated method stub
		noticeMapper.insertSelectKey(notice);
	}

}
