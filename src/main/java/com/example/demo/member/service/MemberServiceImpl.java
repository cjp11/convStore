package com.example.demo.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.member.model.dao.MemberDao;
import com.example.demo.member.model.dto.AddressDto;
import com.example.demo.member.model.dto.MemberDetailsDto;
import com.example.demo.member.model.dto.MemberDto;
import com.example.demo.member.model.dto.MembershipDto;
import com.example.demo.member.model.dto.QuestionDto;
import com.example.demo.member.model.dto.QuestionFileDto;

@Service
public class MemberServiceImpl implements MemberService {
	
	// 스프링 시큐리티 관련 클래스
	
	@Autowired
	private MemberDao memberDao;

	@Override
	public int insertMember(MemberDto memberdto) {
		return memberDao.insertMember(memberdto);
	}

	@Override
	public MemberDto selectOneMember(String member_id) {
		return memberDao.selectOneMember(member_id);
	}

	@Override
	public int checkIdDuplicate(String member_id) {
		return memberDao.checkIdDuplicate(member_id);
	}

	@Override
	public int updateMember(MemberDto memberdto) {
		return memberDao.updateMember(memberdto);
	}

	@Override
	public int connectMember(MemberDto memberdto) {
		return memberDao.connectMember(memberdto);
	}

	@Override
	public int selectMember(String member_id) {
		return memberDao.selectMember(member_id);
	}
	
	@Override
	public int totalMember() {
		return memberDao.totalMember();
	}

	@Override
	public int deleteConnect(String member_id) {
		return memberDao.deleteConnect(member_id);
	}

	@Override
	public int insertAddress(Map<String, Object> map) {
		return memberDao.insertAddress(map);
	}
	
	@Override
	public MembershipDto selectMembership(String memberId) {
		return memberDao.selectMembership(memberId);
	}

	@Override
	public int updateAddress(Map<String, Object> map) {
		return memberDao.updateAddress(map);
	}

	@Override
	public int updateMembership(Map<String, Object> map) {
		return memberDao.updateMembership(map);
	}

	@Override
	public int deleteMember(String member_id) {
		return memberDao.deleteMember(member_id);
	}

//	@Override
//	public List<QuestionDto> selectQuestionList(int cPage, int numPerPage) {
//		return memberDao.selectQuestionList(cPage,numPerPage);
//	}
//
//	@Override
//	public int selectQuestionListCount(String member_id) {
//		return memberDao.selectQuestionListCount(member_id);
//	}
//
//	@Override
//	public int insertBoard(QuestionDto questiondto) {		
//		return memberDao.insertBoard(questiondto);
//	}
//
//	@Override
//	public int insertFile(QuestionFileDto fbf) {
//		return memberDao.insertFile(fbf);
//	}
//
//	@Override
//	public QuestionDto selectQuestion(int no) {
//		return memberDao.selectQuestion(no);
//	}
	
	@Override
	public List<AddressDto> selectAddrList(String member_id) {
		return memberDao.selectAddrList(member_id);

	}

	@Override
	public int deleteMemberAddress(int address_no) {
		return memberDao.deleteMemberAddress(address_no);
	}

	@Override
	public int updateAddressLevel(Map<String, Object> map) {
		return memberDao.updateAddressLevel(map);
	}

	@Override
	public int updateAddressLevelByAddrNo(int address_no) {
		return memberDao.updateAddressLevelByAddrNo(address_no);
	}

	@Override
	public int selectAddrLevel(String member_id) {
		return memberDao.selectAddrLevel(member_id);
	}

}
