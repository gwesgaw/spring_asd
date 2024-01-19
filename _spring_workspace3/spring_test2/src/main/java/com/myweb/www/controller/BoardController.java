package com.myweb.www.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.PagingHandler;
import com.myweb.www.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Slf4j // log를 사용하기 위해
@RequestMapping("/board/*") // board로 시작되는 모든 요청을 여기서 처리하겠다
@RequiredArgsConstructor // final로 매개변수를 하면 생성자를 생성해준다
@Controller // 해당 클래스는 controller로 등록이된다.

public class BoardController {

	private final BoardService bsv;
	
		@GetMapping("/register")
		public void register() {}
		

		@PostMapping("/register")
		public String register(BoardVO bvo) {
			log.info(">>>>> bvo 들어온지 확인하자 >>>>> {} " , bvo);
			
			bsv.register(bvo);
			
			return "index";
		}
		
		@GetMapping("/list")
		public void list (Model m , PagingVO pgvo) {
			log.info(">>>>> pgvo 들어온지 확인하자 >>>>> {}" , pgvo);
			
			//페이징처리
			List<BoardVO> list = bsv.getList(pgvo);
			
			//totalCount 구하기
			int totalCount = bsv.gettotalCount(pgvo);
			PagingHandler ph = new PagingHandler(pgvo, totalCount);
			
			m.addAttribute("list", list);
			m.addAttribute("ph", ph);
		}
		
		@GetMapping({"/detail" , "/modify"})
		public void detail(Model m , @RequestParam("bno") int bno) {
			log.info(">>>>> bno 들어온지 확인하자 >>>>> {}" , bno);
			m.addAttribute("bvo" , bsv.getdetail(bno));
		}
		
		@PostMapping("/modify")
		public String modify(BoardVO bvo , Model m) {
			log.info(">>>>> bvo 들어온지 확인하자 >>>>> {} " , bvo);
			bsv.modify(bvo);
			m.addAttribute("bvo",bvo.getBno());
			return "index";
		}
		
		@GetMapping("/delete")
		public String delete(@RequestParam("bno") int bno) {
			int isOk = bsv.delete(bno);
			return "index";
		}
	
}