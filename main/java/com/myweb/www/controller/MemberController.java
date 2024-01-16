package com.myweb.www.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.PagingHandler;
import com.myweb.www.security.MemberVO;
import com.myweb.www.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/member/*")
@Controller
@RequiredArgsConstructor
public class MemberController {

	private final MemberService msv;
	private final BCryptPasswordEncoder bcEncoder;
	
	@GetMapping("/register")
	public void register() {}	
	
	@PostMapping("/register")
	public String register(MemberVO mvo) {
		
		mvo.setPwd(bcEncoder.encode(mvo.getPwd()));
		log.info(">>>> mvo >>> {} ",mvo);
		int isOk = msv.register(mvo);
		
		return "index";
	}
	
	@GetMapping("/login")
	public void login() {}
	
	@PostMapping("/login")
	public String loginPost(HttpServletRequest request, RedirectAttributes re) {
		//로그인 실패시 다시 로그인 페이지로 돌아와 오류 메세지 전송
		//다시 로그인 유도
		re.addAttribute("email", request.getAttribute("email"));
		re.addAttribute("errMsg", request.getAttribute("errMsg"));
		
		return "redirect:/member/login";
		
	}
	
	// @RequestParam("email")String email : 쿼리스트링 (파라미터 받기) 
	@GetMapping("/modify")
	public void modify(Principal p, Model m) {
		log.info(">>>> Principal >> email >"+p.getName());
		String email = p.getName();
		m.addAttribute("mvo", msv.detail(email));
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam("email")String email, Model m) {
		m.addAttribute("mvo", msv.detail(email));
		return "/member/modify";
	}
	
	
	@PostMapping("/modify")
	public String modify(MemberVO mvo, HttpServletRequest request, HttpServletResponse response) {
		int isOk = 2;
		if(mvo.getPwd().isEmpty()) {
			//비번 없는 업데이트 진행
			isOk = msv.modifyPwdEmpty(mvo);
		}else {
			//비번을 다시 인코딩 하여 업데이트 진행
			mvo.setPwd(bcEncoder.encode(mvo.getPwd()));
			isOk = msv.modify(mvo);
		}
		//로그아웃 진행
		Authentication authentication = SecurityContextHolder
				.getContext().getAuthentication();
		new SecurityContextLogoutHandler().logout(request, response, authentication);
		
		return "/member/login";
	}
	
	@GetMapping("/list")
	public void list(MemberVO mvo, Model m) {
		log.info(">>> memberVO >> {} ", mvo);
		
		//페이징 처리
		List<MemberVO> list = msv.getList();
		
		m.addAttribute("list", list);
	}
	
	public String removeMember(@RequestParam("email")String email, HttpServletRequest request, HttpServletResponse response) {
		msv.remove(email);
		logout(request, response);
		return "redirect:/";
		
	}
	
	public void logout(HttpServletRequest req, HttpServletResponse res) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		new SecurityContextLogoutHandler().logout(req, res, authentication);
	}
}
