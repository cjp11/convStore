package com.example.demo.member.model.dto;

public class MembershipDto {
	
   private String member_id;
   private int point;
   private int used_point;
   
   public MembershipDto() {
      super();
   }
   
   public MembershipDto(String member_id, int point, int used_point) {
      super();
      this.member_id = member_id;
      this.point = point;
      this.used_point = used_point;
   }

   public String getMember_id() {
      return member_id;
   }

   public void setMember_id(String member_id) {
      this.member_id = member_id;
   }

   public int getPoint() {
      return point;
   }

   public void setPoint(int point) {
      this.point = point;
   }

   public int getUsed_point() {
      return used_point;
   }

   public void setUsed_point(int used_point) {
      this.used_point = used_point;
   }

   @Override
   public String toString() {
      return "Membership [member_id=" + member_id + ", point=" + point + ", used_point=" + used_point + "]";
   }
   
}