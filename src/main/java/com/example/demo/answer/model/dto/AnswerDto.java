package com.example.demo.answer.model.dto;

import java.util.Date;

public class AnswerDto {
	
	private int a_no;
	private int b_no;
	private String member_id;
	private String a_content;
	private String a_date;
	private String a_en;
	private int a_pno;
	private int lv;
	private String pno_id;
	
	public AnswerDto() {
		super();
	}

	public AnswerDto(int a_no, int b_no, String member_id, String a_content, String a_date, String a_en, int a_pno, int lv,
			String pno_id) {
		super();
		this.a_no = a_no;
		this.b_no = b_no;
		this.member_id = member_id;
		this.a_content = a_content;
		this.a_date = a_date;
		this.a_en = a_en;
		this.a_pno = a_pno;
		this.lv = lv;
		this.pno_id = pno_id;
	}

	public String getPno_id() {
		return pno_id;
	}

	public void setPno_id(String pno_id) {
		this.pno_id = pno_id;
	}

	public int getLv() {
		return lv;
	}

	public void setLv(int lv) {
		this.lv = lv;
	}
	
	public int getA_no() {
		return a_no;
	}
	
	public void setA_no(int a_no) {
		this.a_no = a_no;
	}
	
	public int getB_no() {
		return b_no;
	}
	
	public void setB_no(int b_no) {
		this.b_no = b_no;
	}
	
	public String getmember_id() {
		return member_id;
	}
	
	public void setmember_id(String member_id) {
		this.member_id = member_id;
	}
	
	public String getA_content() {
		return a_content;
	}
	
	public void setA_content(String a_content) {
		this.a_content = a_content;
	}
	
	public String getA_date() {
		return a_date;
	}

	public void setA_date(String a_date) {
		this.a_date = a_date;
	}

	public String getA_en() {
		return a_en;
	}

	public void setA_en(String a_en) {
		this.a_en = a_en;
	}

	public int getA_pno() {
		return a_pno;
	}

	public void setA_pno(int a_pno) {
		this.a_pno = a_pno;
	}
	
}
