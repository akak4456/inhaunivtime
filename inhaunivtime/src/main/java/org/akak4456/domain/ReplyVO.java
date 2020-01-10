package org.akak4456.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private Long rno;
	private Long bno;
	private Long replyto;
	private String reply;
	private String repliername;
	private Date replydate;
	private Date updatedate;
	private char isdelete;
}
