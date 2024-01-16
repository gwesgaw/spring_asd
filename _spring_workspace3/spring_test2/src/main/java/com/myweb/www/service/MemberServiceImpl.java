package com.myweb.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.repository.MemberDAO;
import com.myweb.www.security.MemberVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberServiceImpl implements MemberService{

	
	private final MemberDAO mdao;

	@Override
	public int register(MemberVO mvo) {
		// TODO Auto-generated method stub
		int isOk = mdao.insert(mvo);
		return mdao.insertAuthInit(mvo.getEmail());
	}

	@Override
	public boolean updateLastLogin(String authEmail) {
		
		return mdao.updateLastLogin(authEmail) > 0 ? true : false;
	}

	@Override
	public MemberVO detail(String email) {
		MemberVO mvo = mdao.selectEmail(email);
		mvo.setAuthList(mdao.selectAuths(email));
		return mvo;
	}

	@Override
	public List<MemberVO> getList() {
		// TODO Auto-generated method stub
		List<MemberVO> list = mdao.getList();
		
		for (MemberVO mvo : list) {
			mvo.setAuthList(mdao.selectAuths(mvo.getEmail()));
		}
		
		return list;
	}

	@Override
	public int modifyPwdEmpty(MemberVO mvo) {
		// TODO Auto-generated method stub
		return mdao.modifyPwdEmpty(mvo);
	}

	@Override
	public int modify(MemberVO mvo) {
		// TODO Auto-generated method stub
		return mdao.modify(mvo);
	}

	@Override
	public void remove(String email) {
		// TODO Auto-generated method stub
		mdao.adelete(email);
		mdao.delete(email);
		
	}
}
