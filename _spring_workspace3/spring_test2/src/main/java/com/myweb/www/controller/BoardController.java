package com.myweb.www.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.FileVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.BoardDTO;
import com.myweb.www.handler.FileHandler;
import com.myweb.www.handler.PagingHandler;
import com.myweb.www.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/board/*")
@Controller
public class BoardController {
	
	@Inject
	private BoardService bsv;
	
	@Inject
	private FileHandler fh;
	
	@GetMapping("/register")
	public void register() {}

	@PostMapping("/register")
	public String insert(BoardVO bvo, @RequestParam(name="files", required = false)MultipartFile[] files) {
		log.info(">>> bvo >>> {}", bvo);
		List<FileVO> flist=null;
		
		//FileHandler
		if(files[0].getSize() > 0) {
			flist = fh.uploadFile(files);
		}
		
		int isOk =  bsv.insert(new BoardDTO(bvo, flist));
		return "index";
	}
	
	
	@GetMapping("/list")
	public void list(Model m, PagingVO pgvo) {
		log.info(">>> pagingVO >> {} ", pgvo);
		
		//페이징 처리
		List<BoardVO> list = bsv.getList(pgvo);
		//totalCount 구하기
		int totalCount = bsv.getTotalCount(pgvo);
		PagingHandler ph = new PagingHandler(pgvo, totalCount);
		
		m.addAttribute("list", list);
		m.addAttribute("ph", ph);
		
	}
	
	@GetMapping({"/detail", "/modify"})
	public void detail(Model m, @RequestParam("bno") int bno) {
		m.addAttribute("bdto", bsv.getDetail(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO bvo, @RequestParam(name="files", required = false)MultipartFile[] files) {
		log.info(">>> bno >>{} ", bvo);
		List<FileVO> flist = null;
		if(files[0].getSize()>0) {
			flist = fh.uploadFile(files);
		}
		BoardDTO boardDTO = new BoardDTO(bvo, flist);
		//update
		bsv.modify(boardDTO);
		
		//m.addAttribute("bno", bvo.getBno());
		return "redirect:/board/detail?bno="+bvo.getBno();
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("bno")long bno) {
		int isOk = bsv.remove(bno);

		return "redirect:/board/list";
	}
	
	@DeleteMapping(value = "/file/{uuid}")
	public ResponseEntity<String> removeFile(@PathVariable("uuid")String uuid){
		log.info(">>> uuid >> {} " + uuid);
		
		int isOk = bsv.delete(uuid);
		
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) :
			new ResponseEntity<String>("0",HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
