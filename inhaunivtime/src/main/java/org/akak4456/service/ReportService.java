package org.akak4456.service;

import java.util.List;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.ReportVO;

public interface ReportService {
	public List<ReportVO> getList(Criteria cri);
	
	public int getTotal();
	
	public Long findByRno(Long rno);
}
