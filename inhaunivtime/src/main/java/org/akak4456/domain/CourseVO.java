package org.akak4456.domain;

import lombok.Data;

@Data
public class CourseVO {
	private String coursenumber;
	private String title;
	private double point;
	private String kind;
	private String timeandplace;
	private String professor;
	private String evaluationmethod;
}
