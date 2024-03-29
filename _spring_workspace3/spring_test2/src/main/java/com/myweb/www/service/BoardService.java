package com.myweb.www.service;

import java.util.List;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.BoardDTO;

public interface BoardService {

	int insert(BoardDTO bdto);

	List<BoardVO> getList(PagingVO pgvo);

	BoardDTO getDetail(long bno);

	void modify(BoardDTO boardDTO);

	int remove(long bno);

	int getTotalCount(PagingVO pgvo);

	int delete(String uuid);


}
