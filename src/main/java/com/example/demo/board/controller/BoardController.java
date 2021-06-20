package com.example.demo.board.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.board.model.dto.BoardDto;

public interface BoardController {

	public String BoardList(Model model, int pageNo);

	// 게시판 입력 폼
	public String BoardWriteForm();

	// 게시판 입력후
	public String BoardWrite(Model model, BoardDto boarddto);

	// 게시판 상세보기
	public String BoardDetail(Model model, int b_no);
	
	// 게시판 게시글 삭제
	public String BoardDelete(Model model, int b_no);
		
	// 게시판 게시글 수정 폼
	public String BoardUpdateForm(Model model, int b_no);
		
	// 게시판 게시글 수정 후
	public String BoardUpdate(Model model, BoardDto boarddto, int b_no);
		
	// 게시판 검색결과 매핑
	public String BoardSearch(Model model, String option, String input, int pageNo);
		
	// 관리자 게시판 리스트에서 삭제
	public String BoardMulDel(String[] b_no);
	
}
