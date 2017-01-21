package com.berlizz.persistence;

import java.util.List;

import com.berlizz.domain.BoardVO;
import com.berlizz.domain.SearchCriteria;

public interface BoardDAO {

	public void create(BoardVO vo) throws Exception;
	
	public BoardVO read(Integer bno) throws Exception;
	
	public void update(BoardVO vo) throws Exception;
	
	public void delete(Integer bno) throws Exception;
	
	public List<BoardVO> listCriteria(SearchCriteria cri) throws Exception;
	
	public int countPaging(SearchCriteria cri) throws Exception;
	
	public void updateReplyCnt(Integer bno, int amount) throws Exception;
	
	public void updateViewCnt(Integer bno) throws Exception; 
}
