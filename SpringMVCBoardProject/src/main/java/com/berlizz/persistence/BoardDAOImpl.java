package com.berlizz.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.berlizz.domain.BoardVO;
import com.berlizz.domain.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject 
	private SqlSession session;
	
	private static final String namespace = "com.berlizz.mapper.BoardMapper";
	
	
	@Override
	public void create(BoardVO vo) throws Exception {
		session.insert(namespace + ".create", vo);
	}

	@Override
	public BoardVO read(Integer bno) throws Exception {
		return session.selectOne(namespace + ".read", bno);
	}

	@Override
	public void update(BoardVO vo) throws Exception {
		session.update(namespace + ".update", vo);
	}

	@Override
	public void delete(Integer bno) throws Exception {
		session.delete(namespace + ".delete", bno);
	}
	
	@Override
	public List<BoardVO> listCriteria(SearchCriteria cri) throws Exception {
		return session.selectList(namespace + ".listCriteria", cri);
	}
	
	@Override
	public int countPaging(SearchCriteria cri) throws Exception {
		return session.selectOne(namespace + ".countPaging", cri);
	}
	
	@Override
	public void updateReplyCnt(Integer bno, int amount) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("bno", bno);
		map.put("amount", amount);
		
		session.update(namespace + ".updateReplyCnt", map);
	}
	
	@Override
	public void updateViewCnt(Integer bno) throws Exception {
		session.update(namespace + ".updateViewCnt", bno);
	}

}
