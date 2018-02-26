package com.bky.controller;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
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
import com.bky.util.CommonUtil;

@Controller
public class UploadFileController extends BaseController {
	@Autowired
	public UploadFileService uploadFileService;

	@Autowired
	public UserService userService;

	@Autowired
	public CommentService commentService;

	/**
	 * 上传文件
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("upload")
	public ModelAndView upload(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 1、获取参数
		String userId = request.getParameter("userId");
		String fileName = request.getParameter("fileName");
		String fileDesc = request.getParameter("fileDesc");

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		String ctxPath = request.getSession().getServletContext()
				.getRealPath("upload" + File.separator);
		ctxPath.replace(File.separator, "/");
		// 2、创建文件夹
		File file = new File(ctxPath);
		if (!file.exists()) {
			file.mkdirs();
		}
		// 3、上传
		String fileUploadName = "";
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile multiFile = entity.getValue();
			String orName = multiFile.getOriginalFilename();
			if ("".equals(orName)) {
				throw new Exception("没有文件！");
			} else {
				fileUploadName = CommonUtil.upload(multiFile, ctxPath);
			}
		}
		// 4、项目路径
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + path;
		// 5、获取文件路径
		String fullPath = basePath + "/upload/" + fileUploadName;
		// 6、将路径存入数据库
		UploadFile uploadFile = new UploadFile();
		uploadFile.setFileId(UUID.randomUUID().toString());
		uploadFile.setUserId(userId);
		uploadFile.setFileName(fileName);
		uploadFile.setUploadTime(new Timestamp(System.currentTimeMillis()));
		uploadFile.setDownloadLink(fullPath);
		uploadFile.setTag(fileDesc);
		uploadFile.setFileRealName(fileUploadName);

		AjaxResultDto dto = new AjaxResultDto();
		try {
			uploadFileService.addFile(uploadFile);
		} catch (Exception e) {
			e.printStackTrace();
			dto.setIsError(true);
			dto.setMessage("上传失败！");
		}

		// 7、返回
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
	 * 获取图片数据
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getImgData")
	public ModelAndView getImgData(HttpServletRequest request,
			HttpServletResponse response, ModelMap map) throws Exception {
		// 1.获取数据库中所有图片路径
		String selectTime = request.getParameter("selectTime");
		String selectHot = request.getParameter("selectHot");
		String searchName = request.getParameter("searchName");
		List<UploadFile> list = null;

		if (StringUtils.isNotBlank(searchName)) {
			list = uploadFileService.queryUploadFileByFileName(searchName);
		} else {
			list = uploadFileService.queryUploadFile();
		}

		if (StringUtils.isNotBlank(selectTime)) {
			list = uploadFileService
					.queryUploadFileByFileNameAndTime(searchName);
		} else if (StringUtils.isNotBlank(selectHot)) {
			list = uploadFileService
					.queryUploadFileByFileNameAndHot(searchName);
		}
		// if(!StringUtils.isEmpty(selectHot)){
		// list = uploadFileService.queryUploadFileByFileNameAndHot(searchName);
		// }else{
		// if(StringUtils.isEmpty(searchName)){
		// list = uploadFileService.queryUploadFile();
		// }else{
		// list = uploadFileService.queryUploadFileByFileName(searchName);
		// }
		// }
		// List<UploadFile> list = uploadFileService.queryUploadFile();
		JSONArray arr = new JSONArray();
		for (UploadFile uploadFile : list) {
			String userId = uploadFile.getUserId();
			User user = userService.queryUserById(userId);
			String userName = "";
			if (null != user) {
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
		// 2.返回
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(arr);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 根据用户ID查询文件
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getImgDataByUserId")
	public ModelAndView getImgDataByUserId(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 1.获取userId
		String userId = request.getParameter("userId");
		// 2.获取数据库中所有图片路径
		List<UploadFile> list = uploadFileService.queryUploadFile();
		JSONArray arr = new JSONArray();
		for (UploadFile uploadFile : list) {
			String uId = uploadFile.getUserId();
			if (uId.equals(userId)) {
				JSONObject obj = new JSONObject();
				obj.put("id", uploadFile.getFileId());
				obj.put("path", uploadFile.getDownloadLink());
				obj.put("name", uploadFile.getFileName());
				obj.put("desc", uploadFile.getTag());
				arr.add(obj);
			}
		}
		// 2.返回
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(arr);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 预览图片页面跳转
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("detail")
	public ModelAndView detail(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String imgId = request.getParameter("imgId");
		String loginUserId = request.getParameter("loginUserId");
		UploadFile file = uploadFileService.queryUploadFileById(imgId);
		String currentUserID = getCurrentUserID(request);

		UserViewCollect userViewCollect = new UserViewCollect();
		userViewCollect.setUserId(currentUserID);
		int count = uploadFileService.getTimesUserCount(userViewCollect);

		if (count != 0) {
			UserViewCollect uv = uploadFileService.getTimesUser(userViewCollect);
			if(StringUtils.isBlank(uv.getViewId()))
			{
				uv.setViewId(imgId);
				file.setViewTimes(file.getViewTimes()+1);
				uploadFileService.updateUserView(uv);
			}
			
		}else{
			userViewCollect.setViewId(imgId);
			uploadFileService.insertTimesUser(userViewCollect);
			file.setViewTimes(file.getViewTimes()+1);
		}

		uploadFileService.updateFileViewTimes(file);

		file = uploadFileService.queryUploadFileById(imgId);

		User user = userService.queryUserById(loginUserId);
		String userName = "";
		if (null != user) {
			userName = user.getUserName();
		}

		// 格式化日期
		SimpleDateFormat formatter = new SimpleDateFormat(
				" HH:mm yyyy/MM/dd E", Locale.CHINESE);
		// E表示星期，SS表示毫秒,注意MMM,E,SS,HH大写
		String dateStr = formatter.format(file.getUploadTime());

		ModelAndView mv = new ModelAndView();
		mv.addObject("file", file);
		mv.addObject("uploadTime", dateStr);
		mv.addObject("userName", userName);
		mv.addObject("loginUserId", loginUserId);
		mv.setViewName("detail");

		List<Comment> list = commentService.queryHistoryComment(file
				.getFileId());
		mv.addObject("list", list);
		return mv;
	}

	/**
	 * 下载
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("download")
	public ModelAndView download(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String fileId = request.getParameter("fileId");
		String ctxPath = request.getSession().getServletContext()
				.getRealPath("upload" + File.separator);
		ctxPath.replace(File.separator, "/");
		UploadFile file = uploadFileService.queryUploadFileById(fileId);
		String fileRealName = "";
		if (null != file) {
			fileRealName = file.getFileRealName();
		}

		// 下载
		String contentType = "application/octet-stream";
		CommonUtil.download(request, response, "", contentType, fileRealName,
				ctxPath + File.separator + fileRealName);
		return null;
	}

	/**
	 * 获取同一个作者的不同IMG
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getMoreImg")
	public ModelAndView getMoreImg(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String userId = request.getParameter("userId");
		String fileId = request.getParameter("fileId");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fileId", fileId);
		map.put("userId", userId);
		List<UploadFile> fileList = uploadFileService.queryMoreUploadFile(map);
		JSONArray arr = new JSONArray();
		for (int i = 0; i < fileList.size(); i++) {
			if (i < 4) {
				JSONObject obj = new JSONObject();
				obj.put("path", fileList.get(i).getDownloadLink());
				arr.add(obj);
			}
		}
		// 返回
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(arr);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 获取所有文件列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getFileList")
	public ModelAndView getFileList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<UploadFile> list = uploadFileService.queryUploadFile();
		JSONArray arr = new JSONArray();
		for (int i = 0; i < list.size(); i++) {
			UploadFile file = list.get(i);
			String fileId = file.getFileId();
			String fileName = file.getFileName();
			String path = file.getDownloadLink();
			Date uploadTime = file.getUploadTime();
			// 格式化日期
			SimpleDateFormat formatter = new SimpleDateFormat(
					" yyyy-MM-dd HH:mm ", Locale.CHINESE);
			// E表示星期，SS表示毫秒,注意MMM,E,SS,HH大写
			String dateStr = formatter.format(uploadTime);
			String userId = file.getUserId();
			User user = userService.queryUserById(userId);
			String userName = "";
			if (null != user) {
				userName = user.getUserName();
			}
			JSONObject obj = new JSONObject();
			obj.put("fileId", fileId);
			obj.put("fileName", fileName);
			obj.put("userName", userName);
			obj.put("uploadTime", dateStr);
			obj.put("path", path);
			arr.add(obj);
		}
		// 返回
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(arr);
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 删除文件
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("deleteFile")
	public ModelAndView deleteFile(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String fileId = request.getParameter("fileId");
		AjaxResultDto dto = uploadFileService.deleteFileByFileId(fileId);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(JSONObject.toJSONString(dto));
		out.flush();
		out.close();
		return null;
	}
}
