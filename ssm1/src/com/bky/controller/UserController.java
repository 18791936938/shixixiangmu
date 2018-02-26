package com.bky.controller;

import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bky.dto.AjaxResultDto;
import com.bky.model.User;
import com.bky.service.UserService;

@Controller
public class UserController extends BaseController {
	@Autowired
	public UserService userService;

	/**
	 * 首页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("index")
	public ModelAndView index(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		String userName = request.getParameter("username");
		if (null != userName && !userName.equals("")) {
			User user = userService.queryUser(userName);
			/*mv.addObject("userId", user.getUserId());*/
			mv.addObject("userName", userName);
		}
		mv.setViewName("index");
		return mv;
	}

	/**
	 * 首页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("logout")
	public ModelAndView logout(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		request.getSession().removeAttribute("username");
		request.getSession().removeAttribute("userId");
		mv.setViewName("login");
		return mv;
	}

	/**
	 * 登陆
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("login")
	public String login(HttpServletRequest request) {
		return "login";
	}

	/**
	 * 登陆
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "logins", method = RequestMethod.GET)
	public String logins(HttpServletRequest request) {
		return "login";
	}

	/**
	 * 注册页面跳转
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("regist")
	public String regist(HttpServletRequest request) {
		return "regist";
	}
	@RequestMapping("manual")
	public String manual(HttpServletRequest request) {
		return "manual";
	}

	/**
	 * 注册
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("goRegist")
	public ModelAndView goRegist(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		// 1.获取参数
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String useremail = request.getParameter("useremail");
		// 2.查询是否有该用户
		User user1 = userService.queryUser(username);
		if (null == user1) {
		User user = new User();
		user.setUserId(UUID.randomUUID().toString());
		user.setUserName(username);
		user.setPassWord(password);
		user.setUserEmail(useremail);
		user.setStatus("0");
		// 3.添加
		AjaxResultDto dto = userService.addUser(user);
		JSONObject obj = (JSONObject) JSONObject.toJSON(dto);
		PrintWriter out = response.getWriter();
		out.print(obj);
		out.flush();
		out.close();
		return null;
	} else{
	AjaxResultDto dto =new AjaxResultDto();
	dto.setIsError(true);
	dto.setMessage("已存在该用户");
	JSONObject obj = (JSONObject) JSONObject.toJSON(dto);
	PrintWriter out = response.getWriter();
	out.print(obj);
	out.flush();
	out.close();
	return null;
	}
	}
	
	/**
	 * 修改密码
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("editAccount")
	public String editAccount(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String currentPwd = request.getParameter("currentPwd");
		String newPwd = request.getParameter("newPwd");
		String confirmPwd = request.getParameter("confirmPwd");
		String resultStr = "";
		String resultStatus = "";
		User user = getCurrentUser(request);

		if (StringUtils.isBlank(currentPwd) || StringUtils.isBlank(newPwd)
				|| StringUtils.isBlank(confirmPwd)) {
			resultStr = "操作错误！";
			resultStatus = "10001";
		} else {
			if (StringUtils.equals(currentPwd, user.getPassWord())) {
				if (StringUtils.equals(newPwd, confirmPwd)) {
					user.setUserId(user.getUserId());
					user.setPassWord(newPwd);
					if (userService.updatePwd(user) > 0) {
						resultStr = "密码修改成功";
						resultStatus = "10000";
					} else {
						resultStr = "密码修改失败";
						resultStatus = "10001";
					}
				} else {
					resultStr = "新密码与确认密码不一致";
					resultStatus = "10001";
				}
			} else {
				resultStr = "当前密码输入错误";
				resultStatus = "10001";
			}
		}

		//
		AjaxResultDto dto = new AjaxResultDto();
		dto.setMessage(resultStr);
		dto.setStatus(resultStatus);
		JSONObject obj = (JSONObject) JSONObject.toJSON(dto);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
		out.flush();
		out.close();
		return null;
	}
	/**
	 * 修改个人资料
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("editPersonalInfo")
	public String editPersonalInfo(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String nickName = request.getParameter("nickName");
		String sex = request.getParameter("sex");
		String birthday = request.getParameter("birthday");
		String hobby = request.getParameter("hobby");
		String occupation = request.getParameter("occupation");
		String resultStr = "";
		String resultStatus = "";
		User user = getCurrentUser(request);
		
		
		if (StringUtils.isBlank(nickName) || StringUtils.isBlank(sex)
				|| StringUtils.isBlank(hobby) || StringUtils.isBlank(birthday) || StringUtils.isBlank(occupation)) {
			resultStr = "操作错误！";
			resultStatus = "10011";
		} else {
			if(null == user){
				resultStr = "操作错误！";
				resultStatus = "10011";
			}else{
				user.setNickName(nickName);
				user.setSex(sex);
				user.setBirthday(birthday);
				user.setHobby(hobby);
				user.setOccupation(occupation);
				
				if (userService.updatePersonalInfo(user) > 0) {
					resultStr = "个人信息修改成功！";
					resultStatus = "10000";
				} else {
					resultStr = "个人信息修改失败";
					resultStatus = "10001";
				}
			}
			
		}
		//
		AjaxResultDto dto = new AjaxResultDto();
		dto.setMessage(resultStr);
		dto.setStatus(resultStatus);
		dto.setData(user);
		JSONObject obj = (JSONObject) JSONObject.toJSON(dto);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
		out.flush();
		out.close();
		return null;
	}

	@RequestMapping("viewAccount")
	public ModelAndView viewAccount(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		String userId = request.getParameter("userId");
		mv.addObject("userId", userId);
		mv.setViewName("account");
		return mv;

	}

	/**
	 * 登陆
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("goLogin")
	public ModelAndView goLogin(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 1.获取参数
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		// 2.查询是否有该用户
		User user = userService.queryUser(username);
		// 3.判断密码是否正确
		AjaxResultDto dto = new AjaxResultDto();
		if (null == user) {
			dto.setIsError(true);
			dto.setMessage("不存在该用户");
		} else {
			
			if(StringUtils.equals("1", user.getStatus()))
			{
				dto.setIsError(true);
				dto.setMessage("此用户被禁用，请联系管理员！");
			}else{
				
				if (!user.getPassWord().equals(password)) {
					dto.setIsError(true);
					dto.setMessage("密码错误");
				}

				HttpSession session = request.getSession();
				session.setAttribute("userId", user.getUserId());
				session.setAttribute("username", username);
				session.setAttribute("user", user);
			}
		}

		JSONObject obj = (JSONObject) JSONObject.toJSON(dto);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 获取用户列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getUserList")
	public ModelAndView getUserList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<User> list = userService.queryAllUser();
		JSONArray arr = (JSONArray) JSONArray.toJSON(list);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(arr.toJSONString());
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 禁用用户
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("forbidUser")
	public ModelAndView forbidUser(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String userId = request.getParameter("userId");
		User user = new User();
		user.setUserId(userId);
		user.setStatus("1");
		AjaxResultDto dto = userService.updateUser(user);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(JSONObject.toJSONString(dto));
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 启用用户
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("activeUser")
	public ModelAndView activeUser(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String userId = request.getParameter("userId");
		User user = new User();
		user.setUserId(userId);
		user.setStatus("0");
		AjaxResultDto dto = userService.updateUser(user);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(JSONObject.toJSONString(dto));
		out.flush();
		out.close();
		return null;
	}
}
