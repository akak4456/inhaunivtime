package org.akak4456.mapper;

import java.util.List;

import org.akak4456.domain.AttachVO;

public interface AttachMapper {
	public int insert(AttachVO attach);
	
	public int delete(String uuid);
	
	public List<AttachVO> findByBno(Long bno);
	
	public List<AttachVO> getList();
	
	public void deleteAll(Long bno);
}
