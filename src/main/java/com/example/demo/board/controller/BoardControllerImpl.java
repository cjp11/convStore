package com.example.demo.board.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.answer.service.AnswerService;
import com.example.demo.board.model.dto.BoardDto;
import com.example.demo.board.service.BoardService;
import com.example.demo.member.model.dto.MemberDetailsDto;

@Controller
public class BoardControllerImpl implements BoardController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private AnswerService answerService;
	
	@Autowired
	private BoardService boardService;
	
	// 게시판 리스트
	@Override
	@RequestMapping(value = "BoardList.do")
	public String BoardList(Model model, @RequestParam("pageNo") int pageNo) {
			
		Map<String, Integer> map = boardService.pageSize(pageNo);
		model.addAttribute("list", boardService.selectAll(pageNo));
		
		model.addAttribute("total", map.get("total"));
		model.addAttribute("start", map.get("start"));
		model.addAttribute("end", map.get("end"));
		model.addAttribute("pageNum", map.get("pageNum"));
		model.addAttribute("pageBlock", map.get("pageBlock"));
					
		return "board/boardList";
	}
			
	// 게시판 입력 폼
	@RequestMapping(value = "BoardInsertForm.do")
	public String BoardWriteForm() {
		return "board/boardInsert";
	}
			
	// 게시판 입력후
	@RequestMapping(value = "BoardInsert.do")
	public String BoardWrite(Model model, @ModelAttribute BoardDto boarddto) {
		// 게시판 추가부분
		int res = boardService.insert(boarddto);
					
		if(res > 0) {
			model.addAttribute("list", boardService.selectAll(1));
			return "redirect:BoardList.do?pageNo=1";
						
		}else {
			return "board/boardInsert";
		}
					
	}
			
	// 게시판 상세보기
	@RequestMapping(value = "BoardDetail.do")
	public String BoardDetail(Model model, @RequestParam("b_no") int b_no) {
		boardService.boardCount(b_no);
		model.addAttribute("detail", boardService.selectOne(b_no));
		
		return "board/boardDetail";
	}
	
	// 게시판 게시글 삭제
	@RequestMapping(value = "BoardDelete.do")
	public String BoardDelete(Model model, @RequestParam("b_no") int b_no) {
		int res = boardService.delete(b_no);
				
		if(res > 0) {
			model.addAttribute("list", boardService.selectAll(1));
			return "redirect:BoardList.do?pageNo=1";
		}else {
			model.addAttribute("list", boardService.selectAll(1));
			
			return "redirect:BoardList.do?pageNo=1";
		}
				
	}
		
	// 게시판 게시글 수정 폼
	@RequestMapping(value = "BoardUpdateForm.do")
	public String BoardUpdateForm(Model model, @RequestParam("b_no") int b_no) {
		model.addAttribute("detail",boardService.selectOne(b_no));
		
		return "board/boardUpdateForm";
	}
		
	// 게시판 게시글 수정 후
	@RequestMapping(value = "BoardUpdate.do")
	public String BoardUpdate(Model model, @ModelAttribute BoardDto boarddto, @RequestParam("b_no") int b_no) {
		boardService.update(boarddto);
		model.addAttribute("detail", boardService.selectOne(boarddto.getB_no()));
		model.addAttribute("AnswerList", answerService.selectAll(b_no));
				
		return "redirect:BoardDetail.do?b_no=" + boarddto.getB_no();
	}
		
	// 게시판 검색결과 매핑
	@RequestMapping(value = "BoardSearch.do")
	public String BoardSearch(Model model, @RequestParam("option") String option, @RequestParam("input")String input, @RequestParam("pageNo")int pageNo) {
		Map<String, Object> map = boardService.searchPageSize(pageNo, option, input);
		
		model.addAttribute("total", map.get("total"));
		model.addAttribute("start", map.get("start"));
		model.addAttribute("end", map.get("end"));		
		model.addAttribute("list", boardService.search(option, input, pageNo));
				
		return "board/boardList";
	}
		
	// 관리자 게시판 리스트에서 삭제
	@RequestMapping(value = "BoardMulDel.do")
	public String BoardMulDel(@RequestParam("chk") String[] b_no) {
		boardService.boardMulDel(b_no);
			
		return "redirect:BoardList.do?pageNo=1";
	}
	
}
