package com.example.demo.answer.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.answer.model.dao.AnswerDao;
import com.example.demo.answer.model.dto.AnswerDto;

@Service
public class AnswerServiceImpl implements AnswerService {

	@Autowired
	private AnswerDao dao;
	
	@Override
	public List<AnswerDto> selectAll(int b_no) {
		return dao.selectAll(b_no);
	}

	@Override
	public int insert(AnswerDto answerdto) {
		return dao.insert(answerdto);
	}

	@Override
	public int update(AnswerDto answerdto) {
		return dao.update(answerdto);
	}
	
	@Override
	public int delete(int a_no) {
	
		return dao.delete(a_no);
	}
	
	@Override
	public int reinsert(AnswerDto answerdto) {
		return dao.reinsert(answerdto);
	}
	
	@Override
	public int answerCount(int a_no) {
		return dao.answerCount(a_no);
	}
	
	@Override
	public int answerUpDel(int a_no) {
		return dao.answerUpDel(a_no);
	}

}
