package org.akak4456.mapper;

import java.util.List;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.ReportVO;

public interface ReportMapper {
	public List<ReportVO> getList();
	
	public List<ReportVO> getListWithPaging(Criteria cri);
	
	public ReportVO read(Long caseno);
	
	public int insertSelectKey(ReportVO vo);
	
	public int delete(Long caseno);
}
