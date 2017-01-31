package com.berlizz.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.berlizz.domain.UserVO;
import com.berlizz.service.UserService;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Inject
	private UserService service;
	
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	private static final String LOGIN = "login";
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("preHandle()");
		
		HttpSession session = request.getSession();
		if(session.getAttribute(LOGIN) == null) {
			saveDestination(request);
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if(loginCookie != null) {
				UserVO userVO = service.checkLoginBefore(loginCookie.getValue());
				
				if(userVO != null) {
					session.setAttribute(LOGIN, userVO);
					return true;
				}
			}
			
			response.sendRedirect("/user/login");
			
			return false;
		}
		
		return true;
	}
	
	private void saveDestination(HttpServletRequest request) {
		logger.info("saveDestination()");
		
		String uri = request.getRequestURI();
		String query = request.getQueryString();
		
		if(query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}
		
		if(request.getMethod().equals("GET")) {
			request.getSession().setAttribute("destination", uri + query);
		}
	}
}
