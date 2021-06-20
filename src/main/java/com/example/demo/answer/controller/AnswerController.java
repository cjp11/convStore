package com.example.demo.answer.controller;

import java.util.List;

import org.springframework.ui.Model;

import com.example.demo.answer.model.dto.AnswerDto;

public interface AnswerController {
	
	public List<AnswerDto> AnswerList(Model model, int b_no);
	
	// 댓글 입력
	public int AnswerInsert(AnswerDto answerdto);
	
	// 댓글 추가입력
	public int AnswerInsertRe(AnswerDto answerdto);
	
	public int AnswerDelete(int a_no);
	
	public int AnswerUpdate(AnswerDto answerdto);
	
}
