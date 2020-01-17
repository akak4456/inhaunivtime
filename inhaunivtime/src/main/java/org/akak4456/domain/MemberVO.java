package org.akak4456.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String userid;
	private String userpw;
	private String username;
	private String email;
	private boolean enabled;
	
	private Date regDate;
	private Date updatedate;
	private List<AuthVO> authList;
}
