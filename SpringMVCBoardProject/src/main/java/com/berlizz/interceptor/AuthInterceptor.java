package com.berlizz.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	private static final String LOGIN = "login";
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//logger.info("preHandle()");
		System.out.println("AuthInterceptor : preHandle()");
		
		HttpSession session = request.getSession();
		if(session.getAttribute(LOGIN) == null) {
			saveDestination(request);
			
			response.sendRedirect("/user/login");
			
			return false;
		}
		
		return true;
	}
	
	private void saveDestination(HttpServletRequest request) {
		//logger.info("saveDestination()");
		System.out.println("AuthInterceptor : preHandle()");
		
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
