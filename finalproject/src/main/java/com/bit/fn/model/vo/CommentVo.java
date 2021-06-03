package com.bit.fn.model.vo;

import java.sql.*;

public class CommentVo {
	private int commentNum, num, writerNum;
	private String commentWriter,commentContent;
	private Date commentDate;
	
	public CommentVo() {}

	public CommentVo(int commentNum, int num, int writerNum, String commentWriter, String commentContent,
			Date commentDate) {
		super();
		this.commentNum = commentNum;
		this.num = num;
		this.writerNum = writerNum;
		this.commentWriter = commentWriter;
		this.commentContent = commentContent;
		this.commentDate = commentDate;
	}

	public int getCommentNum() {
		return commentNum;
	}

	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getWriterNum() {
		return writerNum;
	}

	public void setWriterNum(int writerNum) {
		this.writerNum = writerNum;
	}

	public String getCommentWriter() {
		return commentWriter;
	}

	public void setCommentWriter(String commentWriter) {
		this.commentWriter = commentWriter;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public Date getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((commentContent == null) ? 0 : commentContent.hashCode());
		result = prime * result + ((commentDate == null) ? 0 : commentDate.hashCode());
		result = prime * result + commentNum;
		result = prime * result + ((commentWriter == null) ? 0 : commentWriter.hashCode());
		result = prime * result + num;
		result = prime * result + writerNum;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CommentVo other = (CommentVo) obj;
		if (commentContent == null) {
			if (other.commentContent != null)
				return false;
		} else if (!commentContent.equals(other.commentContent))
			return false;
		if (commentDate == null) {
			if (other.commentDate != null)
				return false;
		} else if (!commentDate.equals(other.commentDate))
			return false;
		if (commentNum != other.commentNum)
			return false;
		if (commentWriter == null) {
			if (other.commentWriter != null)
				return false;
		} else if (!commentWriter.equals(other.commentWriter))
			return false;
		if (num != other.num)
			return false;
		if (writerNum != other.writerNum)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "CommentVo [commentNum=" + commentNum + ", num=" + num + ", writerNum=" + writerNum + ", commentWriter="
				+ commentWriter + ", commentContent=" + commentContent + ", commentDate=" + commentDate + "]";
	}

}
