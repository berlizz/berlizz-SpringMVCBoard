package com.berlizz.service;

import java.util.Date;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.berlizz.domain.UserVO;
import com.berlizz.dto.LoginDTO;
import com.berlizz.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO dao;
	
	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return dao.login(dto);
	}
	
	@Override
	public void keepLogin(String userid, String sessionKey, Date next) throws Exception {
		dao.keepLogin(userid, sessionKey, next);
	}
	
	@Override
	public UserVO checkLoginBefore(String sessionKey) {
		return dao.checkUserWithSessionKey(sessionKey);
	}

}
