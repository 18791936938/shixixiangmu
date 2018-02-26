package com.bky.dao;

import java.util.List;
import java.util.Map;

import com.bky.model.User;

public interface UserMapper {
	
	public void addUser(User user);
	
	public User queryUser(String username);
	
	public User queryUserEmail(String useremail);
	
	public User queryUserById(String userId);
	
	public void deleteUser(String uname);

	public List<User> queryAllUser();

	public void updateUser(User user);
	
	public int updatePwd(User user);
	
	public int updatePersonalInfo(User user);
}
