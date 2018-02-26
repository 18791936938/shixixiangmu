package com.bky.service;

import java.util.List;

import com.bky.dto.AjaxResultDto;
import com.bky.model.User;

public interface UserService {
	
	public AjaxResultDto addUser(User user);
	
	public User queryUser(String username);
	
	public User queryUserById(String userId);
	
	public void deleteUser(String name);

	public List<User> queryAllUser();

	public AjaxResultDto updateUser(User user);
	
	public int updatePwd(User user);
	
	public int updatePersonalInfo(User user);
}
