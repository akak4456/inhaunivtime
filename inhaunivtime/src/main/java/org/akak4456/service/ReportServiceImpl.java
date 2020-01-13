package org.akak4456.service;

import java.util.List;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.ReportVO;
import org.akak4456.mapper.ReplyMapper;
import org.akak4456.mapper.ReportMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
@Service
public class ReportServiceImpl implements ReportService {
	@Setter(onMethod_ = @Autowired)
	private ReportMapper reportMapper;
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;
	@Override
	public List<ReportVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return reportMapper.getListWithPaging(cri);
	}
	@Override
	public int getTotal() {
		// TODO Auto-generated method stub
		return reportMapper.getTotal();
	}
	@Override
	public Long findByRno(Long rno) {
		// TODO Auto-generated method stub
		return replyMapper.read(rno).getBno();
	}

}
