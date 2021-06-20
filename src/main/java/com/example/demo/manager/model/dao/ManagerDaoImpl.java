package com.example.demo.manager.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.member.model.dto.MemberDto;
import com.example.demo.member.model.dto.QuestionDto;
import com.example.demo.member.model.dto.QuestionFileDto;

@Repository
public class ManagerDaoImpl implements ManagerDao {

	private String nameSpace = "manager."; 
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<Map<String, String>> selectListMember(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage - 1) * numPerPage, numPerPage);
		return sqlSession.selectList("manager.selectListMember", null, rowBounds);
	}

	@Override
	public int selectManagerTotalMember() {
		
		return sqlSession.selectOne(nameSpace + "selectManagerTotalMember");
	}

	@Override
	public MemberDto selectOneMember(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(nameSpace + "selectOneMember", member_id);
	}

	@Override
	public List<Map<String, String>> selectListDeletedMember(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage - 1) * numPerPage, numPerPage);
		return sqlSession.selectList(nameSpace + "selectListDeletedMember", null, rowBounds);
	}

	@Override
	public int selectManagerTotalDeletedMember() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(nameSpace + "selectManagerTotalDeletedMember");
	}

	@Override
	public List<QuestionDto> selectQuestionList(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		RowBounds rowBounds = new RowBounds((cPage - 1) * numPerPage, numPerPage);
		return sqlSession.selectList(nameSpace + "selectQuestionList", null, rowBounds);
	}

	@Override
	public int selectQuestionListCount() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(nameSpace + "selectQuestionListCount");
	}

	@Override
	public QuestionDto selectQuestion(int no) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(nameSpace + "selectQuestion", no);
	}

	@Override
	public int insertBoard(QuestionDto question) {
		// TODO Auto-generated method stub
		return sqlSession.insert(nameSpace + "insertQuestion", question);
	}

	@Override
	public int insertFile(QuestionFileDto fbf) {
		// TODO Auto-generated method stub
		return sqlSession.insert(nameSpace + "insertFile",fbf);
	}

	@Override
	public int deleteQuestion(String question_no) {
		// TODO Auto-generated method stub
		return sqlSession.delete(nameSpace + "deleteQuestion", question_no);
	}

}
