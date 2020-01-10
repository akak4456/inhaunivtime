package org.akak4456.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class FreeBoardVO {
	private Long bno;
	private String title;
	private String content;
	private String writername;
	private Long replycnt;
	private Long recommendcnt;
	private Date regdate;
	private Date updatedate;
	
	private List<AttachVO> attachList;
}
