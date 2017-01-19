package com.berlizz.test;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.berlizz.domain.ReplyVO;
import com.berlizz.persistence.ReplyDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/Webapp/WEB-INF/spring/**/root-context.xml")
public class ReplyDAOTest {
	
	@Inject
	private ReplyDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyDAOTest.class);
	
	
	@Test
	public void createTest() throws Exception {
		ReplyVO vo = new ReplyVO();
		vo.setBno(251);
		vo.setReplyer("테스터");
		vo.setReplytext("테스트 리플라이22");
		
		dao.create(vo);
	}
	
	@Test 
	public void listTest() throws Exception {
		List<ReplyVO> list = dao.list(251);
		
		for(ReplyVO vo : list) {
			logger.info(vo.toString());
		}
	}
}
