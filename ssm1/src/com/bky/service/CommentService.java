package com.bky.service;


import java.util.List;

import com.bky.model.Comment;

public interface CommentService {
	public void addCommet(Comment comment);
	public List<Comment> queryHistoryComment(String fileId);
}
