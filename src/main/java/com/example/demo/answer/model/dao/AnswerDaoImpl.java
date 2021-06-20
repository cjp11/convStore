package com.example.demo.answer.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.answer.model.dto.AnswerDto;

@Repository
public class AnswerDaoImpl implements AnswerDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 네임스페이스 설정
	private String nameSpace = "answer.";
	
	@Override
	public List<AnswerDto> selectAll(int b_no) {
		List<AnswerDto> list = new ArrayList<AnswerDto>();
		list = sqlSession.selectList(nameSpace + "answerList", b_no);
		return list;
	}

	@Override
	public int insert(AnswerDto answerdto) {
		int res = sqlSession.insert(nameSpace + "answerInsert", answerdto);
		return res;
	}

	@Override
	public int update(AnswerDto answerdto) {
		int res = sqlSession.update(nameSpace + "answerUpdate", answerdto);
		return res;
	}

	@Override
	public int delete(int a_no) {
		int res = sqlSession.delete(nameSpace + "answerDelete", a_no);
		return res;
	}

	@Override
	public int reinsert(AnswerDto answerdto) {
		int res = sqlSession.insert(nameSpace + "answerInsertRe", answerdto);
		return res;
	}

	@Override
	public int answerCount(int a_no) {
		int res = sqlSession.selectOne(nameSpace + "answerCount", a_no);
		return res;
	}

	@Override
	public int answerUpDel(int a_no) {
		int res = sqlSession.update(nameSpace + "answerUpDel", a_no);
		return res;
	}

}
