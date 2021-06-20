package com.example.demo.member.model.dto;

import java.sql.Date;

public class MemberAddressDto {
	
	private String member_id;
	   private String member_password;
	   private String member_name;
	   private String member_gender;
	   private Date member_birthday;
	   private String member_phone;
	   private String member_email;
	   private Date member_enrollDate;
	   private String member_grade;
	   private int address_no;
	   private String address;
	   private String zip_code;
	   private int address_level;
	   
	   private boolean enabled;
	   private String autority;
	   
	public MemberAddressDto() {
		super();
	}

	public MemberAddressDto(String member_id, String member_password, String member_name, String member_gender,
			Date member_birthday, String member_phone, String member_email, Date member_enrollDate, String member_grade,
			int address_no, String address, String zip_code, int address_level) {
		
		super();
		this.member_id = member_id;
		this.member_password = member_password;
		this.member_name = member_name;
		this.member_gender = member_gender;
		this.member_birthday = member_birthday;
		this.member_phone = member_phone;
		this.member_email = member_email;
		this.member_enrollDate = member_enrollDate;
		this.member_grade = member_grade;
		this.address_no = address_no;
		this.address = address;
		this.zip_code = zip_code;
		this.address_level = address_level;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_password() {
		return member_password;
	}

	public void setMember_password(String member_password) {
		this.member_password = member_password;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_gender() {
		return member_gender;
	}

	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}

	public Date getMember_birthday() {
		return member_birthday;
	}

	public void setMember_birthday(Date member_birthday) {
		this.member_birthday = member_birthday;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}

	public Date getMember_enrollDate() {
		return member_enrollDate;
	}

	public void setMember_enrollDate(Date member_enrollDate) {
		this.member_enrollDate = member_enrollDate;
	}

	public String getMember_grade() {
		return member_grade;
	}

	public void setMember_grade(String member_grade) {
		this.member_grade = member_grade;
	}

	public int getAddress_no() {
		return address_no;
	}

	public void setAddress_no(int address_no) {
		this.address_no = address_no;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getZip_code() {
		return zip_code;
	}

	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}

	public int getAddress_level() {
		return address_level;
	}

	public void setAddress_level(int address_level) {
		this.address_level = address_level;
	}
	
	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getAutority() {
		return autority;
	}

	public void setAutority(String autority) {
		this.autority = autority;
	}

	@Override
	public String toString() {
		return "MemberAddress [member_id=" + member_id + ", member_password=" + member_password + ", member_name="
				+ member_name + ", member_gender=" + member_gender + ", member_birthday=" + member_birthday
				+ ", member_phone=" + member_phone + ", member_email=" + member_email + ", member_enrollDate="
				+ member_enrollDate + ", member_grade=" + member_grade + ", address_no=" + address_no + ", address="
				+ address + ", zip_code=" + zip_code + ", address_level=" + address_level + "]";
	}
		   
}
