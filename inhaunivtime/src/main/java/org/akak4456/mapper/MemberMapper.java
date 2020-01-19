package org.akak4456.mapper;

import org.akak4456.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String userid);
	
	public int countForId(String userid);
	
	public int countForEmail(String email);
	
	public int insert(MemberVO vo);
}
