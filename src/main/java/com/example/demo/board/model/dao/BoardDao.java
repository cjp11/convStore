package com.example.demo.board.model.dao;

import java.util.List;
import java.util.Map;

import com.example.demo.board.model.dto.BoardDto;

public interface BoardDao {
	
	public List<BoardDto> selectAll(int pageNo);
	
	public BoardDto selectOne(int b_no);
	
	public int insert(BoardDto boarddto);
	
	public int update(BoardDto boarddto);
	
	public int delete(int b_no);
	
	public int searchTotalPage(Map map);
	
	public List<BoardDto> search(Map map);
	
	public int totalPage();
	
	public int boardCount(int b_no);
	
	public int boardMulDel(Map map);
}
