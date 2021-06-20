package com.example.demo.chatting.model.dto;

public class ChattingDto {

	private int chat_no;
	private String member_id;
	private String chat_content;
	private String chat_date;
	
	public ChattingDto() {
		super();
	}

	public ChattingDto(int chat_no,String member_id, String chat_content, String chat_date) {
		super();
		this.chat_no = chat_no;
		this.member_id = member_id;
		this.chat_content = chat_content;
		this.chat_date = chat_date;
	}

	
	public ChattingDto(String member_id, String chat_content) {
		super();
		this.member_id = member_id;
		this.chat_content = chat_content;
	}

	@Override
	public String toString() {
		return "Chatting ["+chat_no+", member_id=" + member_id + ", chat_content=" + chat_content + ", chat_date=" + chat_date + "]";
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getChat_content() {
		return chat_content;
	}

	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}

	public String getChat_date() {
		return chat_date;
	}

	public void setChat_date(String chat_date) {
		this.chat_date = chat_date;
	}

	public int getChat_no() {
		return chat_no;
	}

	public void setChat_no(int chat_no) {
		this.chat_no = chat_no;
	}
	
	

}
