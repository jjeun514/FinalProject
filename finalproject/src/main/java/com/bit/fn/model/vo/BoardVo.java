package com.bit.fn.model.vo;

import java.sql.*;

public class BoardVo {
	private int num,writer,count;
	private String title,content, memName, comName;
	private Date date;
	
	public BoardVo() {}

	public BoardVo(int num, int writer, int count, String title, String content, String memName, String comName, Date date) {
		super();
		this.num = num;
		this.writer = writer;
		this.count = count;
		this.title = title;
		this.content = content;
		this.memName = memName;
		this.comName = comName;
		this.date = date;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getWriter() {
		return writer;
	}

	public void setWriter(int writer) {
		this.writer = writer;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	
	public String getComName() {
		return comName;
	}

	public void setComName(String comName) {
		this.comName = comName;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((comName == null) ? 0 : comName.hashCode());
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + count;
		result = prime * result + ((date == null) ? 0 : date.hashCode());
		result = prime * result + ((memName == null) ? 0 : memName.hashCode());
		result = prime * result + num;
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		result = prime * result + writer;
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
		BoardVo other = (BoardVo) obj;
		if (comName == null) {
			if (other.comName != null)
				return false;
		} else if (!comName.equals(other.comName))
			return false;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (count != other.count)
			return false;
		if (date == null) {
			if (other.date != null)
				return false;
		} else if (!date.equals(other.date))
			return false;
		if (memName == null) {
			if (other.memName != null)
				return false;
		} else if (!memName.equals(other.memName))
			return false;
		if (num != other.num)
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		if (writer != other.writer)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "BoardVo [num=" + num + ", writer=" + writer + ", count=" + count + ", title=" + title + ", content="
				+ content + ", memName=" + memName + ", comName=" + comName + ", date=" + date + "]";
	}

	
}
