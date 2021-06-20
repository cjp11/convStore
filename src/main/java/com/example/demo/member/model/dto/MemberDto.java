package com.example.demo.member.model.dto;

import java.sql.Date;

public class MemberDto implements java.io.Serializable{

   private static final long serialVersionUID = 1L;
   
   private String member_id;
   private String member_password;
   private String member_name;
   private String member_gender;
   private Date member_birthday;
   private String member_phone;
   private String member_email;
   private Date member_enrollDate;
   private String member_grade;

   private boolean enabled;
   private String authority;
   
   public MemberDto() {}

   public MemberDto(String member_id, String member_password, String member_name, String member_gender,
         Date member_birthday, String member_phone, String member_email, Date member_enrollDate,
         String member_grade) {
	   
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
   }

   
   public MemberDto(String member_id, String member_password, String member_name, String member_gender, Date member_birthday,
		String member_phone, String member_email) {
	   
	super();
	this.member_id = member_id;
	this.member_password = member_password;
	this.member_name = member_name;
	this.member_gender = member_gender;
	this.member_birthday = member_birthday;
	this.member_phone = member_phone;
	this.member_email = member_email;
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

   public static long getSerialversionuid() {
      return serialVersionUID;
   }
   
   public boolean isEnabled() {
	return enabled;
   }

   public void setEnabled(boolean enabled) {
	   this.enabled = enabled;
   }
	
   public String getAuthority() {
	   return authority;
   }
	
   public void setAuthority(String authority) {
	   this.authority = authority;
   }
	
   @Override
   public String toString() {
	   return "Member [member_id=" + member_id + ", member_password=" + member_password + ", member_name="
	            + member_name + ", member_gender=" + member_gender + ", member_birthday=" + member_birthday
	            + ", member_phone=" + member_phone + ", member_email=" + member_email + ", member_enrollDate="
	            + member_enrollDate + ", member_grade=" + member_grade + "]";
   }
   
}
