package com.bky.controller;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bky.dto.AjaxResultDto;
import com.bky.model.Comment;
import com.bky.model.UploadFile;
import com.bky.model.User;
import com.bky.model.UserViewCollect;
import com.bky.service.CommentService;
import com.bky.service.UploadFileService;
import com.bky.service.UserService;

@Controller
public class CommentController extends BaseController{
	
	@Autowired
	public CommentService commentService;
	
	@Autowired
	public UserService userService;
	
	@Autowired
	public UploadFileService uploadFileService;
	/**
	 * 对文件进行评论
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("addComment")
	public ModelAndView addComment(HttpServletRequest request, HttpServletResponse response) throws Exception{
		//1获取参数
		String fileId = request.getParameter("fileId");//文件ID
		String userId = request.getParameter("userId");//评论人
		String text = request.getParameter("text");//评论内容
		//2封装
		Comment comment = new Comment();
		comment.setCommentId(UUID.randomUUID().toString());
		comment.setUserId(userId);
		comment.setFileId(fileId);
		comment.setText(text);
		comment.setDate(new Timestamp(System.currentTimeMillis()));
		
		User user = userService.queryUserById(userId);
		String userName = "";
		if (null != user){
			userName = user.getUserName();
		}
		comment.setUserName(userName);
		//3添加评论
		AjaxResultDto dto = new AjaxResultDto();
        try {
        	commentService.addCommet(comment);
		} catch (Exception e) {
			e.printStackTrace();
			dto.setIsError(true);
			dto.setMessage("评论失败！");
		}
	        
        //4、返回
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
	 * 对文件进行评论
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="addLike",method=RequestMethod.POST)
	@ResponseBody
	public String addLike(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String fileId = request.getParameter("fileId");//文件ID
		UploadFile file = uploadFileService.queryUploadFileById(fileId);
		String currentUserID = getCurrentUserID(request);
		
		UserViewCollect userViewCollect = new UserViewCollect();
		userViewCollect.setUserId(currentUserID);
		int count = uploadFileService.getTimesUserCount(userViewCollect);
		boolean isCollect = false;
		if (count != 0) {
			UserViewCollect uv = uploadFileService.getTimesUser(userViewCollect);
			if(StringUtils.isBlank(uv.getCollectId()))
			{
				uv.setCollectId(fileId);
				file.setCollectTimes(file.getCollectTimes()+1);
				uploadFileService.updateUserCollect(uv);
				isCollect = false;
			}else{
				isCollect = true;
			}
			
		}else{
			userViewCollect.setCollectId(fileId);
			uploadFileService.insertTimesUser(userViewCollect);
			file.setCollectTimes(file.getCollectTimes()+1);
		}
		
		int i = uploadFileService.updateFileCollectTimes(file);
		
		file = uploadFileService.queryUploadFileById(fileId);
		
		//3添加评论
		AjaxResultDto dto = new AjaxResultDto();
		if(i>0){
			dto.setMessage("收藏成功！");
			dto.setStatus("10010");
		}else{
			dto.setMessage("收藏失败！");
			dto.setStatus("10011");
		}
		dto.setData(file.getCollectTimes());
		dto.setIsError(isCollect);
		JSONObject obj = (JSONObject) JSONObject.toJSON(dto);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
		out.flush();
		out.close();
		return null;
	}
	
	
	/**
	 * 获取文件历史评论记录
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("queryHistoryComment")
	public ModelAndView queryHistoryComment(HttpServletRequest request, HttpServletResponse response) throws Exception{
		//1.获取参数
		String fileId = request.getParameter("fileId");
		JSONArray result = new JSONArray();
		//2.查询
		List<Comment> list = commentService.queryHistoryComment(fileId);
		result = (JSONArray) JSONArray.toJSON(list);
		//3、返回
        response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain; charset=utf-8");
        PrintWriter out = response.getWriter();
	    out.print(result); 
	    out.flush();
	    out.close();
        return null;
	}
}
