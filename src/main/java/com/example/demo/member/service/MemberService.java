package com.example.demo.member.service;

import java.util.List;
import java.util.Map;

import com.example.demo.member.model.dto.AddressDto;
import com.example.demo.member.model.dto.MemberDetailsDto;
import com.example.demo.member.model.dto.MemberDto;
import com.example.demo.member.model.dto.MembershipDto;
import com.example.demo.member.model.dto.QuestionDto;
import com.example.demo.member.model.dto.QuestionFileDto;

public interface MemberService {
	
	// 스프링 시큐리티 관련 클래스

	int insertMember(MemberDto memberdto);

	MemberDto selectOneMember(String member_id);

	int checkIdDuplicate(String member_id);

	int updateMember(MemberDto memberdto);

	int connectMember(MemberDto memberdto);

	int selectMember(String member_id);

	int totalMember();

	int deleteConnect(String member_id);

	int insertAddress(Map<String, Object> map);

	int updateAddress(Map<String, Object> map);

	MembershipDto selectMembership(String memberId);

	int updateMembership(Map<String, Object> map);

	int deleteMember(String member_id);

//	List<QuestionDto> selectQuestionList(int cPage, int numPerPage);
//
//	int selectQuestionListCount(String member_id);
//
//	int insertBoard(QuestionDto questiondto);
//
//	int insertFile(QuestionFileDto fbf);
//
//	QuestionDto selectQuestion(int no);

	List<AddressDto> selectAddrList(String member_id);

	int deleteMemberAddress(int address_no);

	int updateAddressLevel(Map<String, Object> map);

	int updateAddressLevelByAddrNo(int address_no);

	int selectAddrLevel(String member_id);

}
