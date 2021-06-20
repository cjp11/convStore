package com.example.demo.board.model.dto;

import java.util.Date;

public class BoardDto {

	private int b_no;
	private String member_id;
	private String b_title;
	private String b_content;
	private Date b_date;
	private int b_hits;
	private int total;
	private String member_grade;
	
	public BoardDto() {
		super();
	}
	
	public BoardDto(int b_no, String member_id, String b_title, String b_content, Date b_date, int b_hits, int total,
			String member_grade) {
		super();
		this.b_no = b_no;
		this.member_id = member_id;
		this.b_title = b_title;
		this.b_content = b_content;
		this.b_date = b_date;
		this.b_hits = b_hits;
		this.total = total;
		this.member_grade = member_grade;
	}

	public int getB_no() {
		return b_no;
	}

	public void setB_no(int b_no) {
		this.b_no = b_no;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getB_title() {
		return b_title;
	}

	public void setB_title(String b_title) {
		this.b_title = b_title;
	}

	public String getB_content() {
		return b_content;
	}

	public void setB_content(String b_content) {
		this.b_content = b_content;
	}

	public Date getB_date() {
		return b_date;
	}

	public void setB_date(Date b_date) {
		this.b_date = b_date;
	}

	public int getB_hits() {
		return b_hits;
	}

	public void setB_hits(int b_hits) {
		this.b_hits = b_hits;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getMember_grade() {
		return member_grade;
	}

	public void setMember_grade(String member_grade) {
		this.member_grade = member_grade;
	}
	
}
