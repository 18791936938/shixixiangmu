package com.bky.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bky.dao.UserMapper;
import com.bky.dto.AjaxResultDto;
import com.bky.model.User;
import com.bky.service.UserService;
@Service("userService")
public class UserServiceImpl implements UserService{
	@Resource
	private UserMapper userDao;
	
	/* (non-Javadoc)
	 * ����û�
	 * @see com.bky.service.UserService#addUser(com.bky.model.User)
	 */
	@Transactional
	@Override
	public AjaxResultDto addUser(User user) {
		AjaxResultDto dto = new AjaxResultDto();
		try {
			userDao.addUser(user);
		} catch (Exception e) {
			e.printStackTrace();
			dto.setIsError(true);
			dto.setMessage("ע���û�ʧ�ܣ�");
		}
		return dto;
	}
	
	/* (non-Javadoc)
	 * �����û�����ѯ�û�
	 * @see com.bky.service.UserService#queryUser(java.lang.String)
	 */
	@Override
	public User queryUser(String username) {
		return userDao.queryUser(username);
	}
	
	@Override
	public void deleteUser(String uname) {
		userDao.deleteUser(uname);
	}

	@Override
	public User queryUserById(String userId) {
		return userDao.queryUserById(userId);
	}

	@Override
	public List<User> queryAllUser() {
		return userDao.queryAllUser();
	}

	@Override
	public AjaxResultDto updateUser(User user) {
		AjaxResultDto dto = new AjaxResultDto();
		try {
			userDao.updateUser(user);
		} catch (Exception e) {
			dto.setIsError(true);
			dto.setMessage("�����û�ʧ�ܣ�");
		}
		return dto;
	}

	@Override
	public int updatePwd(User user) {
		return userDao.updatePwd(user);
	}

	@Override
	public int updatePersonalInfo(User user) {
		return userDao.updatePersonalInfo(user);
	}
	
}
