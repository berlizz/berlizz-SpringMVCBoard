package com.berlizz.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.berlizz.domain.UserVO;
import com.berlizz.dto.LoginDTO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession session;
	
	private static final String namespace = "com.berlizz.mapper.UserMapper";
	
	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return session.selectOne(namespace + ".login", dto);
	}
	
	@Override
	public void keepLogin(String userid, String sessionKey, Date next) {
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("sessionKey", sessionKey);
		map.put("next", next);
		
		session.update(namespace + ".keepLogin", map);
	}
	
	@Override
	public UserVO checkUserWithSessionKey(String sessionKey) {
		return session.selectOne(namespace + ".checkUserWithSessionKey", sessionKey);
	}
}
