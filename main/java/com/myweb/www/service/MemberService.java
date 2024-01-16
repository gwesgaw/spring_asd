package com.myweb.www.service;

import java.util.List;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.security.MemberVO;

public interface MemberService {

	int register(MemberVO mvo);

	boolean updateLastLogin(String authEmail);

	MemberVO detail(String email);

	List<MemberVO> getList();

	int modifyPwdEmpty(MemberVO mvo);

	int modify(MemberVO mvo);

	void remove(String email);

}
