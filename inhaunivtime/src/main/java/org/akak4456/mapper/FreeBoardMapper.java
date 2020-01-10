package org.akak4456.mapper;

import java.util.List;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.FreeBoardVO;
import org.apache.ibatis.annotations.Param;

public interface FreeBoardMapper {
	public List<FreeBoardVO> getList();
	
	public List<FreeBoardVO> getListWithPaging(Criteria cri);
	
	public List<FreeBoardVO> getHotBoard(int amount);
	
	public int insertSelectKey(FreeBoardVO freeboard);
	
	public FreeBoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(FreeBoardVO freeboard);
	
	public int updateReplyCnt(@Param("bno")Long bno, @Param("amount") int amount);
	
	public int updateRecommendCnt(@Param("bno")Long bno, @Param("amount") int amount);
	
	public int getTotalCount(Criteria cri);
}
