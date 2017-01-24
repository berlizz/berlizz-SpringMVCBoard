package com.berlizz.persistence;

import com.berlizz.domain.UserVO;
import com.berlizz.dto.LoginDTO;

public interface UserDAO {

	public UserVO login(LoginDTO dto) throws Exception;
}
