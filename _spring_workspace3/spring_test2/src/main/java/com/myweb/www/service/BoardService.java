package com.myweb.www.service;

import java.util.List;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.PagingVO;

public interface BoardService {

	void register(BoardVO bvo);

	List<BoardVO> getList(PagingVO pgvo);

	Object getdetail(int bno);

	void modify(BoardVO bvo);

	int delete(int bno);

	int gettotalCount(PagingVO pgvo);

}
