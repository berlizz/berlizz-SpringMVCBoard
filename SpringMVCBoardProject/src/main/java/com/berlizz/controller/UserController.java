package com.berlizz.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.berlizz.domain.UserVO;
import com.berlizz.dto.LoginDTO;
import com.berlizz.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Inject
	private UserService service;
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login() throws Exception {
		logger.info("login()");
	}
	
	@RequestMapping(value ="/loginPost", method = RequestMethod.POST)
	public void loginPOST(LoginDTO dto, Model model) throws Exception {
		logger.info("loginPOST()");
		
		UserVO vo = service.login(dto);
		if(vo == null) {
			return;
		}

		model.addAttribute("userVO", vo);
	}
	
	
}
