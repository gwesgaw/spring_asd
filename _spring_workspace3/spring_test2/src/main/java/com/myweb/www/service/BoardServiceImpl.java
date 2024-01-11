package com.myweb.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.FileVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.BoardDTO;
import com.myweb.www.repository.BoardDAO;
import com.myweb.www.repository.FileDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	private BoardDAO bdao;
	
	@Inject
	private FileDAO fdao;

	@Override
	public int insert(BoardDTO bdto) {
		log.info("insert service in");
		int isOk = bdao.insert(bdto.getBvo());
		
		if(bdto.getFlist()==null) {
			return isOk;
		}
		
		//bvo insert 후 파일도 있다면...
		if(isOk > 0 && bdto.getFlist().size() > 0) {
			long bno = bdao.selectOneBno();
			for(FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bno);
				isOk *= fdao.insertFile(fvo);
			}
		}
		
		return isOk;
	}

	@Override
	public List<BoardVO> getList(PagingVO pgvo) {
		// TODO Auto-generated method stub
		bdao.updateCommentCount();
		bdao.updateFileCount();
		
		return bdao.getList(pgvo);
	}

	@Transactional
	@Override
	public BoardDTO getDetail(long bno) {
		// TODO Auto-generated method stub
		BoardVO bvo = bdao.selectDetail(bno);
		bdao.updateReadCount(bno);
		List<FileVO>flist = fdao.getFileList(bno);
		BoardDTO bdto = new BoardDTO(bvo, flist);
		return bdto;
	}

	@Override
	public void modify(BoardDTO bdto) {
		// TODO Auto-generated method stub
		int isOk = bdao.update(bdto.getBvo());
		if(bdto.getFlist() == null) {
			isOk *= 1;
		}else {
			if(isOk > 0 && bdto.getFlist().size() > 0) {
				long bno = bdto.getBvo().getBno();
				for(FileVO fvo : bdto.getFlist()) {
					fvo.setBno(bno);
					isOk *= fdao.insertFile(fvo);
				}
			}
		}
	}

	@Override
	public int remove(long bno) {
		// TODO Auto-generated method stub
		return bdao.remove(bno);
	}

	@Override
	public int getTotalCount(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return bdao.getTotalCount(pgvo);
	}

	@Override
	public int delete(String uuid) {
		// TODO Auto-generated method stub
		return fdao.deleteFile(uuid);
	}

}
