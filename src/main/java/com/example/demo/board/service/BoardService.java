package com.example.demo.board.service;

import java.util.List;
import java.util.Map;

import com.example.demo.board.model.dto.BoardDto;

public interface BoardService {
	
	public List<BoardDto> selectAll(int pageNo);
	
	public BoardDto selectOne(int b_no);
	
	public int insert(BoardDto dto);
	
	public int update(BoardDto dto);
	
	public int delete(int b_no);
	
	public List<BoardDto> search(String option, String input, int pageNo);
	
	public int totalPage();
	
	public int searchTotalPage(String option, String input);
	
	public Map<String, Integer> pageSize(int pageNo);
	
	public Map<String, Object> searchPageSize(int pageNo, String option, String input);
	
	public int boardCount(int b_no);
	
	public int boardMulDel(String[] b_no);
}
