package com.example.demo.member.model.dto;

public class QuestionDto {

	private int question_no;
	private String member_id;
	private String question_comment;
	private String question_reg_date;
	private String question_title;
	private String admin_id;
	
	public QuestionDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public QuestionDto(int question_no, String member_id, String question_comment, String question_reg_date,
			String question_title,String admin_id) {
		super();
		this.question_no = question_no;
		this.member_id = member_id;
		this.question_comment = question_comment;
		this.question_reg_date = question_reg_date;
		this.question_title = question_title;
		this.admin_id= admin_id;
	}
	
	public int getQuestion_no() {
		return question_no;
	}
	
	public void setQuestion_no(int question_no) {
		this.question_no = question_no;
	}
	
	public String getMember_id() {
		return member_id;
	}
	
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	public String getQuestion_comment() {
		return question_comment;
	}
	
	public void setQuestion_comment(String question_comment) {
		this.question_comment = question_comment;
	}
	
	public String getQuestion_reg_date() {
		return question_reg_date;
	}
	
	public void setQuestion_reg_date(String question_reg_date) {
		this.question_reg_date = question_reg_date;
	}
	
	public String getQuestion_title() {
		return question_title;
	}
	
	public void setQuestion_title(String question_title) {
		this.question_title = question_title;
	}
	
	public String getAdmin_id() {
		return admin_id;
	}
	
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	
	@Override
	public String toString() {
		return "Question [question_no=" + question_no + ", member_id=" + member_id + ", question_comment="
				+ question_comment + ", question_reg_date=" + question_reg_date + ", quetstion_title=" + question_title
				+ "]";
	}
	
}
