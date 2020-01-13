package org.akak4456.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReportVO {
	private Long caseno;
	private Long targetno;
	private char casekind;
	private Date regdate;
}
