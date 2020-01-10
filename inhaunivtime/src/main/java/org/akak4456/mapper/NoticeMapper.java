package org.akak4456.mapper;

import java.util.List;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.NoticeVO;

public interface NoticeMapper {
	public List<NoticeVO> getList();
	
	public List<NoticeVO> getListWithPaging(Criteria cri);
	
	public int insertSelectKey(NoticeVO notice);
	
	public NoticeVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(NoticeVO notice);
}
