package com.example.demo.manager.model.dao;

import java.util.List;
import java.util.Map;

import com.example.demo.member.model.dto.MemberDto;
import com.example.demo.member.model.dto.QuestionDto;
import com.example.demo.member.model.dto.QuestionFileDto;

public interface ManagerDao {

	List<Map<String, String>> selectListMember(int cPage, int numPerPage);

	int selectManagerTotalMember();

	MemberDto selectOneMember(String member_id);

	List<Map<String, String>> selectListDeletedMember(int cPage, int numPerPage);

	int selectManagerTotalDeletedMember();

	List<QuestionDto> selectQuestionList(int cPage, int numPerPage);

	int selectQuestionListCount();

	QuestionDto selectQuestion(int no);

	int insertBoard(QuestionDto questiondto);

	int insertFile(QuestionFileDto fbf);

	int deleteQuestion(String question_no);

}
