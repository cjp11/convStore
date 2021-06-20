package com.example.demo.answer.model.dao;

import java.util.List;

import com.example.demo.answer.model.dto.AnswerDto;

public interface AnswerDao {
	
	public List<AnswerDto> selectAll(int b_no);
	
	public int insert(AnswerDto answerdto);
	
	public int update(AnswerDto answerdto);
	
	public int delete(int a_no);
	
	public int reinsert(AnswerDto answerdto);
	
	public int answerCount(int a_no);
	
	public int answerUpDel(int a_no);
}
