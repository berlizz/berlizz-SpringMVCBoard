package com.berlizz.service;

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

}
