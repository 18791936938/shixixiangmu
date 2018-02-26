package com.bky.util;

import java.io.BufferedInputStream;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class CommonUtil {
	/**
	 * @Title: upload
	 * @Description: 上传文件
	 * @param @param mutipartFile
	 * @param @param ctxPath
	 * @param @return
	 * @return String
	 * @throws
	 */
	public static String upload(MultipartFile mutipartFile, String ctxPath) {
		// 上传文件名
		MultipartFile mf = mutipartFile;
		String fileName = mf.getOriginalFilename();
		String newFileName = UUID.randomUUID().toString().replace("-", "") + "_" + fileName;
		File uploadFile = new File(ctxPath + "/" + newFileName);
		try {
			// 上传
			FileCopyUtils.copy(mf.getBytes(), uploadFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newFileName;
	}
	
	
	/**    
	 * @Title: download    
	 * @Description: 下载  
	 * @param @param request        
	 * @return void      
	 * @throws     
	 */ 
	public static void download(HttpServletRequest request, HttpServletResponse response, String storeName, String contentType, String realName, String ctxPath) throws Exception {  
		response.setContentType("text/html;charset=UTF-8");  
		request.setCharacterEncoding("UTF-8");
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;

		String downLoadPath = ctxPath + storeName;
		long fileLength = new File(downLoadPath).length();

		response.setContentType(contentType);
		String header = request.getHeader("User-Agent");
		if(header.toLowerCase().indexOf("msie") >= 0){
			response.setHeader("Content-disposition", "attachment; filename=" + java.net.URLEncoder.encode(realName,"utf-8"));
		} else {
			response.setHeader("Content-disposition", "attachment; filename=\"" + new String(realName.getBytes("utf-8"), "ISO-8859-1") + "\"");
		}
		response.setHeader("Content-Length", String.valueOf(fileLength));
		bis = new BufferedInputStream(new FileInputStream(downLoadPath));
		bos = new BufferedOutputStream(response.getOutputStream());
		byte[] buff = new byte[2048];
		int bytesRead;
		while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
			bos.write(buff, 0, bytesRead);
		}
		bis.close();
		bos.close();
    }  
	
	
}
