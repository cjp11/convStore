package com.example.demo.board.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.board.model.dto.BoardDto;

@Repository
public class BoardDaoImpl implements BoardDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	// 네임스페이스 설정
	private String nameSpace = "board.";

	@Override
	public int totalPage() {
		int res = sqlSession.selectOne(nameSpace + "boardtotal");
		return res;
	}

	@Override
	public List<BoardDto> selectAll(int pageNo) {
		List<BoardDto> list = new ArrayList<BoardDto>();
		list = sqlSession.selectList(nameSpace + "boardList", pageNo);
		return list;
	}

	@Override
	public BoardDto selectOne(int b_no) {
		BoardDto detail = sqlSession.selectOne(nameSpace + "boardDetail", b_no);
		return detail;
	}

	@Override
	public int insert(BoardDto boarddto) {
		int res = sqlSession.insert(nameSpace + "boardInsert", boarddto);
		return res;
	}

	@Override
	public int update(BoardDto boarddto) {
		int res = sqlSession.update(nameSpace + "boardUpdate", boarddto);
		return res;
	}

	@Override
	public int delete(int b_no) {
		int res = sqlSession.delete(nameSpace + "boardDelete", b_no);
		return res;
	}

	@Override
	public List<BoardDto> search(Map map) {
		List<BoardDto> search = new ArrayList<BoardDto>();
		search = sqlSession.selectList(nameSpace + "boardSearch", map);
		return search;
	}

	@Override
	public int searchTotalPage(Map map) {
		int res = sqlSession.selectOne(nameSpace + "boardSearchTotal", map);
		return res;
	}

	@Override
	public int boardCount(int b_no) {
		int res = sqlSession.update(nameSpace + "boardCount", b_no);
		return res;
	}

	@Override
	public int boardMulDel(Map map) {
		int res = sqlSession.delete(nameSpace + "boardMulDel", map);
		return res;
	}
	
}
