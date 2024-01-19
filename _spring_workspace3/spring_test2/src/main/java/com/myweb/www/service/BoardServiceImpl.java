package com.myweb.www.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.repository.BoardDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j // log를 사용하기위해
@RequiredArgsConstructor // final 등록시 생성자 사용
@Service // 서비스로 사용하겠다

public class BoardServiceImpl implements BoardService{

	private final BoardDAO bdao;

	@Override
	public void register(BoardVO bvo) {
		bdao.register(bvo);
		
	}

	@Override
	public BoardVO getdetail(int bno) {
		log.info(" >>>>> bno 들어오는지 확인하자 >>>>> {}" , bno);
		bdao.updateCount(bno);
		return bdao.detail(bno);
	}

	@Override
	public void modify(BoardVO bvo) {
		log.info(" >>>>> bvo 들어오는지 확인하자 >>>>> {}" , bvo);
		bdao.modify(bvo);
	}

	@Override
	public int delete(int bno) {
		log.info(" >>>>> bno 들어오는지 확인하자 >>>>> {}" , bno);
		int isOk = bdao.delete(bno);
		return isOk;
	}

	@Override
	public List<BoardVO> getList(PagingVO pgvo) {
		return bdao.selectList(pgvo);
	}

	@Override
	public int gettotalCount(PagingVO pgvo) {
		return bdao.totalCount(pgvo);
	}
	
}