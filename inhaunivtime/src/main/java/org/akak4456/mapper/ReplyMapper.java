package org.akak4456.mapper;

import java.util.List;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.ReplyVO;
import org.apache.ibatis.annotations.Param;

public interface ReplyMapper {
	public int insertSelectKey(ReplyVO reply);
	
	public ReplyVO read(Long rno);
	
	public int updateStateToDelete(Long rno);
	
	public int delete(Long rno);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);
	
	public List<ReplyVO> getList();
	
	public int getCountByBno(Long bno);
}
