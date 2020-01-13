package org.akak4456.service;

import java.util.List;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.NoticeVO;

public interface NoticeService {
	public NoticeVO get(Long bno);
	public int getTotal();
	public List<NoticeVO> getList(Criteria cri);
	public boolean remove(Long bno);
	public void register(NoticeVO notice);
}
