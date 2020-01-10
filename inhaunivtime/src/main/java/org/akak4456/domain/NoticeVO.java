package org.akak4456.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	private Long bno;
	private String title;
	private String content;
	private Date regdate;
	private Date updatedate;
}
