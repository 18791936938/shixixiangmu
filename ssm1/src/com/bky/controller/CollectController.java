package com.bky.controller;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bky.dto.AjaxResultDto;
import com.bky.model.Collect;
import com.bky.model.UploadFile;
import com.bky.model.User;
import com.bky.service.CollectService;
import com.bky.service.UploadFileService;
import com.bky.service.UserService;

@Controller
public class CollectController {
	
	@Autowired
	public CollectService collectService;
	
	@Autowired
	public UploadFileService uploadFileService;
	
	@Autowired
	public UserService userService;
	
	/**
	 * 收藏文件
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("addCollect")
	public ModelAndView addCollect(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileId = request.getParameter("fileId");
		String userId = request.getParameter("userId");
		Date coll_time = new Timestamp(System.currentTimeMillis());
		
		Collect collect = new Collect();
		collect.setFileId(fileId);
		collect.setUserId(userId);
		collect.setColl_time(coll_time);
		
		AjaxResultDto dto = new AjaxResultDto();
		try {
			collectService.addCollect(collect);
		} catch (Exception e) {
			dto.setIsError(true);
			dto.setMessage("收藏失败!");
		}
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain; charset=utf-8");
        JSONObject obj = (JSONObject) JSONObject.toJSON(dto);
        PrintWriter out = response.getWriter();
	    out.print(obj);
	    out.flush();
	    out.close();
        return null;
	}

	/**
	 * 个人中心
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("personalCenter")
	public ModelAndView personalCenter(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView();
		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		mv.addObject("userId", userId);
		mv.addObject("userName", userName);
		mv.setViewName("personalcenter");
		return mv;
	}
	
	/**
	 * 根据userId查询当前用户收藏的文件
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("queryCollectByUserId")
	public ModelAndView queryCollectByUserId(HttpServletRequest request, HttpServletResponse response) throws Exception{
		//1.获取参数
		String userId = request.getParameter("userId");
		//2.查询
		//2.1查询所有收藏
		List<Collect> list = collectService.queryCollectByUserId(userId);
		//2.2根据fileId查询文件
		JSONArray arr = new JSONArray();
		for (int i = 0; i < list.size(); i++) {
 			String fileId = list.get(i).getFileId();
			UploadFile uploadFile = uploadFileService.queryUploadFileById(fileId);
			
			if(uploadFile!=null){
			String uId = uploadFile.getUserId();
			User user = userService.queryUserById(uId);
			String userName = "";
			if (null != user){ 
				userName = user.getUserName();
			}
			JSONObject obj = new JSONObject();
			obj.put("id", uploadFile.getFileId());
			obj.put("path", uploadFile.getDownloadLink());
			obj.put("name", uploadFile.getFileName());
			obj.put("desc", uploadFile.getTag());
			obj.put("userName", userName);
			arr.add(obj);
			}
		}
		//3.返回
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain; charset=utf-8");
	    PrintWriter out = response.getWriter();
	    out.print(arr);
	    out.flush();
	    out.close();
		return null;
	}
	
	
	/**
	 * 根据文件Id删除收藏文件
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("deleteCollectByFileId")
	public ModelAndView deleteCollectByFileId(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileId = request.getParameter("id");
		AjaxResultDto dto = collectService.deleteCollectByFileId(fileId);
        response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain; charset=utf-8");
        JSONObject obj = (JSONObject) JSONObject.toJSON(dto);
        PrintWriter out = response.getWriter();
	    out.print(obj);
	    out.flush();
	    out.close();
        return null;
	}
	
	
	/**
	 * 权限管理
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("privilege")
	public ModelAndView privilege(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView();
		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		mv.addObject("userId", userId);
		mv.addObject("userName", userName);
		mv.setViewName("privilege");
		return mv;
	}
}
