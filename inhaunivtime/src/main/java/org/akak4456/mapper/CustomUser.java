package org.akak4456.mapper;

import java.util.Collection;
import java.util.stream.Collectors;

import org.akak4456.domain.MemberVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class CustomUser extends User {
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
		// TODO Auto-generated constructor stub
	}

	private static final long serialVersionUID = 1L;
	
	private MemberVO member;
	
	public CustomUser(MemberVO vo) {
		super(vo.getUserid(),vo.getUserpw(),vo.getAuthList().stream()
				.map(auth->new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		this.member = vo;
	}
	

}
