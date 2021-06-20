package com.example.demo.answer.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.answer.model.dto.AnswerDto;
import com.example.demo.answer.service.AnswerService;

@Controller
public class AnswerControllerImpl implements AnswerController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private AnswerService answerService;
	
	@RequestMapping(value = "AnswerList.do")
	@ResponseBody
	public List<AnswerDto> AnswerList(Model model, @RequestParam("b_no") int b_no) {
		return answerService.selectAll(b_no);
	}
	
	// 댓글 입력
	@RequestMapping(value = "AnswerInsert.do")
	@ResponseBody
	public int AnswerInsert(@ModelAttribute AnswerDto answerdto) {
		return answerService.insert(answerdto);
	}
	
	// 댓글 추가입력
	@RequestMapping(value = "AnswerInsertRe.do")
	@ResponseBody
	public int AnswerInsertRe(@ModelAttribute AnswerDto answerdto) {
		return answerService.reinsert(answerdto);
	}
	
	@RequestMapping(value = "AnswerDelete.do")
	@ResponseBody
	public int AnswerDelete(@RequestParam("a_no") int a_no) {
		int count =answerService.answerCount(a_no);
		
		if(count == 0) {
			return answerService.delete(a_no);
		}else {
			return answerService.answerUpDel(a_no);
		}
		
	}
	
	@RequestMapping(value = "AnswerUpdate.do")
	@ResponseBody
	public int AnswerUpdate(@ModelAttribute AnswerDto answerdto) {
		return answerService.update(answerdto);
	}
}
