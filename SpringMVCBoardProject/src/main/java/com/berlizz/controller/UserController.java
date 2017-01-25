package com.berlizz.controller;

import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.WebUtils;

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
	public void loginPOST(LoginDTO dto, Model model, HttpSession session) throws Exception {
		logger.info("loginPOST()");
		
		UserVO vo = service.login(dto);
		if(vo == null) {
			return;
		}
		
		model.addAttribute("userVO", vo);
		
		if(dto.isUseCookie()) {
			int amount = 60 * 60 * 24 * 7;
			Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));
			
			service.keepLogin(vo.getUserid(), session.getId(), sessionLimit);
		}
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("logout()");
		
		Object obj = session.getAttribute("login");
		if(obj != null) {
			UserVO userVO = (UserVO)obj;
			session.removeAttribute("login");
			session.invalidate();
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if(loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				
				service.keepLogin(userVO.getUserid(), session.getId(), new Date());
			}
		}
		
		return "redirect:/";
	}
	
	
}
