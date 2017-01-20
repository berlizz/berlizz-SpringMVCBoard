package com.berlizz.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.berlizz.domain.Criteria;
import com.berlizz.domain.PageMaker;
import com.berlizz.domain.ReplyVO;
import com.berlizz.service.ReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {

	@Inject
	private ReplyService service;
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ReplyVO vo) {
		logger.info("register()");
		
		ResponseEntity<String> entity = null;
		try {
			service.addReply(vo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/all/{bno}", method = RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> list(@PathVariable("bno") Integer bno) {
		logger.info("list()");
		
		ResponseEntity<List<ReplyVO>> entity = null;
		try {
			entity = new ResponseEntity<>(service.listReply(bno), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/{rno}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> modify(@PathVariable("rno") Integer rno, @RequestBody ReplyVO vo) {
		logger.info("modify()");
		
		ResponseEntity<String> entity = null;
		try {
			vo.setRno(rno);
			service.modifyReply(vo);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/{rno}", method = RequestMethod.DELETE)
	public ResponseEntity<String> delete(@PathVariable("rno") Integer rno) {
		logger.info("delete()");
		
		ResponseEntity<String> entity = null;
		try {
			service.removeReply(rno);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/{bno}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPage(@PathVariable("bno") Integer bno, @PathVariable("page") Integer page) {
		logger.info("listPage()");
		
		ResponseEntity<Map<String, Object>> entity = null;
		try {
			Criteria cri = new Criteria();
			cri.setPage(page);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			
			List<ReplyVO> list = service.listReplyPage(bno, cri);
			Map<String, Object> map = new HashMap<>();
			map.put("list", list);
			
			int replyCount = service.count(bno);
			pageMaker.setTotalCount(replyCount);
			map.put("pageMaker", pageMaker);
			
			entity = new ResponseEntity<>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
