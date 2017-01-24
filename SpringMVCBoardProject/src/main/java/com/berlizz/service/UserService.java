package com.berlizz.service;

import com.berlizz.domain.UserVO;
import com.berlizz.dto.LoginDTO;

public interface UserService {

	public UserVO login(LoginDTO dto) throws Exception;
}
