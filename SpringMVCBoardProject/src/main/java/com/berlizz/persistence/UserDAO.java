package com.berlizz.persistence;

import java.util.Date;

import com.berlizz.domain.UserVO;
import com.berlizz.dto.LoginDTO;

public interface UserDAO {

	public UserVO login(LoginDTO dto) throws Exception;
	
	public void keepLogin(String userid, String sessionKey, Date next);
	
	public UserVO checkUserWithSessionKey(String sessionKey);
}
