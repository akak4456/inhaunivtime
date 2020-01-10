package org.akak4456.domain;

import lombok.Data;

@Data
public class CourseRateVO {
	private Long rateno;
	private String coursenumber;
	private String username;
	private double score;
	private String content;
}
