package org.akak4456.security;

import org.akak4456.domain.MemberVO;
import org.akak4456.mapper.CustomUser;
import org.akak4456.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		log.warn("Load User By UserName: "+username);
		MemberVO vo = memberMapper.read(username);
		log.info("userVO: "+vo);
		return vo == null ? null:new CustomUser(vo);
	}

}
