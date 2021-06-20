package com.example.demo.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.member.model.dto.AddressDto;
import com.example.demo.member.model.dto.MemberDetailsDto;
import com.example.demo.member.model.dto.MemberDto;
import com.example.demo.member.model.dto.MembershipDto;
import com.example.demo.member.model.dto.QuestionDto;
import com.example.demo.member.model.dto.QuestionFileDto;

@Repository
public class MemberDaoImpl implements MemberDao {

	private String nameSpace = "member.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertMember(MemberDto memberdto) {
		return sqlSession.insert(nameSpace + "insertMember", memberdto);
	}
	
	@Override
	public MemberDto selectOneMember(String member_id) {
		return sqlSession.selectOne(nameSpace + "selectOneMember", member_id);
	}
	
	@Override
	public int checkIdDuplicate(String member_id) {
		return sqlSession.selectOne(nameSpace + "checkIdDuplicate", member_id);
	}
	
	@Override
	public int updateMember(MemberDto memberdto) {
		return sqlSession.update(nameSpace + "updateMember", memberdto);
	}
	
	@Override
	public int connectMember(MemberDto memberdto) {
		return sqlSession.insert(nameSpace + "connectMember", memberdto);
	}
	
	@Override
	public int selectMember(String member_id) {
		return sqlSession.selectOne(nameSpace + "selectMember", member_id);
	}
	
	@Override
	public int totalMember() {
		return sqlSession.selectOne(nameSpace + "totalMember");
	}
	
	@Override
	public int deleteConnect(String member_id) {
		return sqlSession.delete(nameSpace + "deleteConnect", member_id);
	}
	
	@Override
	public int insertAddress(Map<String, Object> map) {
		return sqlSession.insert(nameSpace + "insertAddress", map);
	}
	
	@Override
	public Map<String, Object> selectConnectMember(String user_name) {
		Map<String, Object> map = sqlSession.selectOne(nameSpace + "selectConnectMember", user_name);
		System.out.println("map@DAOImpl = " + map);
		return map;
	}
	
	@Override
	public int updateAddress(Map<String, Object> map) {
		return sqlSession.update(nameSpace + "updateAddress", map);
	}

	@Override
	public MembershipDto selectMembership(String memberId) {
		return sqlSession.selectOne(nameSpace + "selectMembership", memberId);
	}
	
	@Override
	public int updateMembership(Map<String, Object> map) {
		return sqlSession.update(nameSpace + "updateMembership", map);
	}

	@Override
	public int deleteMember(String member_id) {
		return sqlSession.delete(nameSpace + "deleteMember", member_id);
	}
	
//	@Override
//	public List<QuestionDto> selectQuestionList(int cPage, int numPerPage) {
//		RowBounds rowBounds = new RowBounds((cPage - 1) * numPerPage, numPerPage);
//		return sqlSession.selectList(nameSpace + "selectQuestionList", null, rowBounds);
//	}
//	
//	@Override
//	public int selectQuestionListCount(String member_id) {
//		return sqlSession.selectOne(nameSpace + "selectQuestionListCount", member_id);
//	}
//	
//	@Override
//	public int insertBoard(QuestionDto questiondto) {
//		return sqlSession.insert(nameSpace + "insertQuestion", questiondto);
//	}
//	
//	@Override
//	public int insertFile(QuestionFileDto fbf) {
//		return sqlSession.insert(nameSpace + "insertFile", fbf);
//	}
//	
//	@Override
//	public QuestionDto selectQuestion(int no) {
//		return sqlSession.selectOne(nameSpace + "selectQuestion", no);
//	}

	@Override
	public List<AddressDto> selectAddrList(String member_id) {
		return sqlSession.selectList(nameSpace + "selectAddrList", member_id);
	}
	
	@Override
	public int deleteMemberAddress(int address_no) {
		return sqlSession.delete(nameSpace + "deleteMemberAddress", address_no);
	}
	
	@Override
	public int updateAddressLevel(Map<String, Object> map) {
		return sqlSession.update(nameSpace + "updateAddressLevel", map);
	}
	
	@Override
	public int updateAddressLevelByAddrNo(int address_no) {
		return sqlSession.update(nameSpace + "updateAddressLevelByAddrNo", address_no);
	}
	
	@Override
	public int selectAddrLevel(String member_id) {
		return sqlSession.selectOne(nameSpace + "selectAddrLevel", member_id);
	}
	
}
