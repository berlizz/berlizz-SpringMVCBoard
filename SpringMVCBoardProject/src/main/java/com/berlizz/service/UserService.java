package com.berlizz.service;

import java.util.Date;

import com.berlizz.domain.UserVO;
import com.berlizz.dto.LoginDTO;

public interface UserService {

	public UserVO login(LoginDTO dto) throws Exception;
	
	public void keepLogin(String userid, String sessionKey, Date next) throws Exception;
	
	public UserVO checkLoginBefore(String sessionKey);
}
