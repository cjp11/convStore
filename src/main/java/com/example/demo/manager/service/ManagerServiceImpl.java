package com.example.demo.manager.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.manager.model.dao.ManagerDao;
import com.example.demo.manager.model.dao.ManagerDaoImpl;
import com.example.demo.member.model.dto.MemberDto;
import com.example.demo.member.model.dto.QuestionDto;
import com.example.demo.member.model.dto.QuestionFileDto;

@Service
public class ManagerServiceImpl implements ManagerService {

	@Autowired
	private ManagerDao managerDao = new ManagerDaoImpl();
	
	@Override
	public List<Map<String, String>> selectListMember(int cPage, int numPerPage) {
		return managerDao.selectListMember(cPage, numPerPage);
	}

	@Override
	public int selectManagerTotalMember() {
		return managerDao.selectManagerTotalMember();
	}

	@Override
	public MemberDto selectOneMember(String member_id) {
		// TODO Auto-generated method stub
		return managerDao.selectOneMember(member_id);
	}

	@Override
	public List<Map<String, String>> selectDeletedListMember(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return managerDao.selectListDeletedMember(cPage, numPerPage);
	}

	@Override
	public int selectManagerTotalDeletedMember() {
		// TODO Auto-generated method stub
		return managerDao.selectManagerTotalMember();
	}

	@Override
	public List<QuestionDto> selectQuestionList(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return managerDao.selectQuestionList(cPage, numPerPage);
	}

	@Override
	public int selectQuestionListCount() {
		// TODO Auto-generated method stub
		return managerDao.selectQuestionListCount();
	}

	@Override
	public QuestionDto selectQuestion(int no) {
		// TODO Auto-generated method stub
		return managerDao.selectQuestion(no);
	}

	@Override
	public int insertBoard(QuestionDto questiondto) {
		// TODO Auto-generated method stub
		return managerDao.insertBoard(questiondto);
	}

	@Override
	public int insertFile(QuestionFileDto fbf) {
		// TODO Auto-generated method stub
		return managerDao.insertFile(fbf);
	}

	@Override
	public int deleteQuestion(String question_no) {
		// TODO Auto-generated method stub
		return managerDao.deleteQuestion(question_no);
	}

}
