package org.akak4456.mapper;

import java.util.List;

import org.akak4456.domain.CourseRateVO;
import org.akak4456.domain.Criteria;

public interface CourseRateMapper {
	public int insertSelectKey(CourseRateVO vo);
	
	public List<CourseRateVO> getList();
	
	public List<CourseRateVO> getListWithPaging(Criteria cri);
	
	public CourseRateVO read(Long rateno);
	
	public int update(CourseRateVO vo);
	
	public int delete(Long rateno);
}
