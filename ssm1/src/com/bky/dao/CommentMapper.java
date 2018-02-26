package com.bky.dao;

import java.util.List;

import com.bky.model.Comment;

public interface CommentMapper {
	public void addComment(Comment comment); 
	public List<Comment> queryHistoryComment(String fileId);
}
