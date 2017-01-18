package com.berlizz.test;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.berlizz.domain.BoardVO;
import com.berlizz.domain.Criteria;
import com.berlizz.persistence.BoardDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class BoardDAOTest {

	@Inject
	private BoardDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
	
	/*@Test
	public void testCreate() throws Exception {
		BoardVO vo = new BoardVO();
		vo.setTitle("test title");
		vo.setContent("test content");
		vo.setWriter("test writer");
		
		dao.create(vo);
	}*/
	
	/*@Test
	public void testUpdate() throws Exception {
		BoardVO vo = new BoardVO();
		vo.setBno(1);
		vo.setTitle("test update");
		vo.setContent("test update");
		dao.update(vo);
	}*/
	
	/*@Test
	public void testDelete() throws Exception {
		dao.delete(1);
	}*/
	
	/*@Test
	public void testListPage() throws Exception {
		int page = 3;
		List<BoardVO> list = dao.listPage(page);
		
		for(BoardVO vo : list) {
			logger.info(vo.getBno() + " : " + vo.getTitle());
		}
	}*/
	
	@Test
	public void testListCriteria() throws Exception {
		Criteria cri = new Criteria();
		cri.setPage(3);
		cri.setPerPageNum(20);
		
		List<BoardVO> list = dao.listCriteria(cri);
		for(BoardVO vo : list) {
			logger.info(vo.getBno() + " : " + vo.getTitle());
		}
	}
}
