package com.bky.controller;

import javax.servlet.http.HttpServletRequest;

import com.bky.model.User;

public class BaseController {
	protected User getCurrentUser(HttpServletRequest request) {
		if (null == request) {
			return null;
		}
		return (User) request.getSession().getAttribute("user");
	}

	protected String getCurrentUserID(HttpServletRequest request) {
		return getCurrentUser(request).getUserId();
	}
}
