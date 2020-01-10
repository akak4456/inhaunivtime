package org.akak4456.mapper;

import java.util.List;

import org.akak4456.domain.CourseVO;
import org.akak4456.domain.Criteria;

public interface CourseMapper {
	public List<CourseVO> getList();
	
	public List<CourseVO> getListWithPaging(Criteria cri);
	
	public CourseVO read(String coursenumber);
}
