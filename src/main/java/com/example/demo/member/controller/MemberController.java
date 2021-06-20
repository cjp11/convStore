package com.example.demo.member.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.member.model.dto.AddressDto;
import com.example.demo.member.model.dto.MemberDetailsDto;
import com.example.demo.member.model.dto.MemberDto;
import com.example.demo.member.model.dto.MembershipDto;
import com.example.demo.member.model.dto.QuestionDto;
import com.example.demo.member.model.dto.QuestionFileDto;
import com.example.demo.member.service.MemberService;
import com.example.demo.utill.Urlcoding;

// 시큐리티 적용을 위해 @SessionAttributes 사용
@SessionAttributes({"memberLoggedIn"})
@Controller
public class MemberController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping(value = "/member/memberEnroll.do")
	public String MemberEnroll() {
		
		if(logger.isDebugEnabled())
			logger.debug("회원등록페이지");
		return "member/memberEnroll";
	}

	@RequestMapping(value = "/member/memberEnrollEnd.do")
	public String memberEnrollEnd( Model model,
								  @RequestParam(value = "member_id") String member_id,
								  @RequestParam(value = "member_password") String member_password,
								  @RequestParam(value = "member_name") String member_name,
								  @RequestParam(value = "member_email", required = false) String member_email,
								  @RequestParam(value = "member_phone") String member_phone,
								  @RequestParam(value = "member_birthday") String member_birthday,
								  @RequestParam(value = "member_gender", required = false) String member_gender,
								  @RequestParam(value = "sample4_postcode") String postCode,
								  @RequestParam(value = "sample4_roadAddress") String road,
								  @RequestParam(value = "sample4_jibunAddress", required = false) String jibun,
								  @RequestParam(value = "sample4_detailAddress") String detail
									) {
		Date member_birth = Date.valueOf(member_birthday);
		
		MemberDto memberdto = new MemberDto(member_id, member_password, member_name, member_gender, member_birth, member_phone, member_email);
		
		if(logger.isDebugEnabled())
			logger.debug("회원등록처리페이지");
		logger.debug(memberdto.toString());
		
		/*logger.debug(member.toString());*/
		String rawPassword = member_password;
		
		// 비밀번호 암호화
		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
		memberdto.setMember_password(encodedPassword);
		
//		member.setMember_password(member_password);
		
		System.out.println("암호화후 : " + memberdto.getMember_password());
//		System.out.println("비밀번호 : " + member.getMember_password());
		
		int result = 0;
		
		if(memberService.insertMember(memberdto) > 0) {
			// address 테이블에 주소 추가
			Map<String,Object> map = new HashMap<String, Object>();

			String address = road + "#" + jibun + "#" + detail;
			
			map.put("member_id", memberdto.getMember_id());
			map.put("address", address);
			map.put("zip_code", postCode);
			map.put("address_level", 1);
			
			result = memberService.insertAddress(map);
		}
		
		String loc = "/";
		String msg = "";
		
		if((result > 0)) { msg="회원가입성공!! 올편에 오신것을 환영합니다 !!!."; } 
		else { msg="회원가입을 실패했습니다. 다시 시도하세요"; }
		 
		model.addAttribute("loc",loc);
		model.addAttribute("msg",msg);
		
		return "common/msg";
	}
	
	
	@RequestMapping(value = "/member/memberLogin.do")
	  public ModelAndView memberLogin(HttpSession session, @RequestParam String member_id, 
			  @RequestParam String member_password) {
		
		if(logger.isDebugEnabled()) {
			logger.debug("로그인요청");
		}
	      
		// 리턴할 ModelAndView 객체생성
		ModelAndView mav = new ModelAndView();
		logger.debug(member_id);
	      
		MemberDto memberdto = memberService.selectOneMember(member_id);
	      
		logger.debug(memberdto.toString());
	      
		String msg = "";
		String loc = "/";
	      
		if(memberdto == null) { msg = "존재하지 않는 아이디입니다."; }
	      
		else {
	    	  
			if(bcryptPasswordEncoder.matches(member_password, memberdto.getMember_password())) {
				//if(member_password.equals(m.getMember_password())) {
				msg = "로그인성공!";
	    		  
				// 스프링 시큐리티 적용
				int selectMember = memberService.selectMember(memberdto.getMember_id());
	         
				if(selectMember == 1) {
					int deleteConnect = memberService.deleteConnect(memberdto.getMember_id());
				}else {
					int connectMember = memberService.connectMember(memberdto);
	    			  
				}
				mav.addObject("memberLoggedIn", memberdto);
				mav.addObject("memberLoggedIn", memberdto);
			}else { msg = "비밀번호가 틀렸습니다."; }
		}   
	      
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);

		// jsp 지정
		mav.setViewName("common/msg");
	      
		return mav;
	}
	
	@RequestMapping(value = "/member/memberLogout.do")
	   public String memberLogout(SessionStatus sessionStatus, HttpSession session) {
		
		 if(logger.isDebugEnabled()) { logger.debug("로그아웃요청"); }
		 
		 if(!sessionStatus.isComplete()) {  
			//int deleteConnect = memberService.deleteConnect(m.getMember_id());
			 sessionStatus.setComplete();
		 }
		 return "redirect:/";
	   } 
	
	@Secured("ROLE_USER")
	@RequestMapping(value = "/member/myPage.do")
	public ModelAndView memberMypage(@RequestParam(value="member_id") String member_id) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("member_id@myPage.do:" + member_id);
		
		MemberDto memberdto = memberService.selectOneMember(member_id);
		System.out.println("member@myPage:" + memberdto);
		
		mav.addObject("member", memberdto);
		mav.setViewName("member/myPageHome");

		return mav;
	}
	
	@Secured("ROLE_USER")
	@RequestMapping(value = "/member/myPageMemberView.do")
	public ModelAndView memberMypageMemberView(@RequestParam(value = "member_id") String member_id) {
		ModelAndView mav = new ModelAndView();
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
		MemberDetailsDto memberDetailsdto = (MemberDetailsDto) authentication.getPrincipal();
		
		if(member_id.equals(memberDetailsdto.getUsername())) {		
			System.out.println("member_id@myPage.do:" + member_id);
			MemberDto memberdto = memberService.selectOneMember(member_id);
			
			System.out.println("member@myPage:" + memberdto);
			
			mav.addObject("member", memberdto);
			mav.setViewName("member/myInfo");
			
		}else{ mav.setViewName("common/error"); }

		return mav;
	}
	
	@Secured("ROLE_USER")
	@RequestMapping(value = "/member/memberUpdate.do")
	public ModelAndView memberUpdate(MemberDto memberdto,
									@RequestParam(value = "sample4_postcode") String postCode,
									@RequestParam(value = "sample4_roadAddress") String road,
									@RequestParam(value = "sample4_jibunAddress") String jibun,
									@RequestParam(value = "sample4_detailAddress") String detail) {
		
		if(logger.isDebugEnabled()) { logger.debug("회원정보 수정처리페이지"); }
		
		ModelAndView mav = new ModelAndView();
		System.out.println(memberdto);
		System.out.println("memberGrade : " + memberdto.getAuthority()); // getMember_grade
		String authority = memberdto.getAuthority().equals("A") ? "ROLE_ADMIN" : "ROLE_USER"; // 삼항연산자로 getMember_grade을 getAuthority 로 대체
		System.out.println("autority : " + authority);
	
		memberdto.setAuthority(authority);
		int result = 0;
		
		String loc = "/"; 
		String msg = "";
		
		if(memberService.updateMember(memberdto) > 0) {
			// address 테이블에 주소 추가
			Map<String,Object> map = new HashMap<String, Object>();

			String address = road + "#" + jibun + "#" + detail;
			
			map.put("member_id", memberdto.getMember_id());
			map.put("address", address);
			map.put("zip_code", postCode);
			map.put("address_level", 1);
			
			result = memberService.updateAddress(map);
		}
		
		if(result > 0) { 
			msg = "회원정보 수정성공!!!";
			loc = "/member/myPageMemberView.do?member_id=" + memberdto.getMember_id();
			/*mav.addObject("memberLoggedIn", member);*/
		}
		else msg="회원정보 수정실패!!!";
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@Secured("ROLE_USER")
	@RequestMapping(value = "/member/memberDelete.do")
	public ModelAndView memberDelete(String member_id, SessionStatus sessionStatus) {
		if(logger.isDebugEnabled())
			logger.debug("회원정보 삭제 페이지");
		
		ModelAndView mav = new ModelAndView();
			
		int result = memberService.deleteMember(member_id);
		
		String loc = "/"; 
		String msg = "";
		
		if(result > 0) { 
			msg = "회원정보삭제성공!!!";
			
			if(!sessionStatus.isComplete()) {
				sessionStatus.setComplete();
			}
			
		}
		else msg="회원정보 삭제실패 !!!";
		
		mav.addObject("msg", msg);
		mav.addObject("loc", "/logout");
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping(value = "/member/loginPage.do")
	public String login(){
		return "common/login";
	}
			
	@RequestMapping(value = "/member/selectMembership.do")
	@ResponseBody
	public MembershipDto selectMembership(@RequestParam(value = "memberId") String memberId) {
		MembershipDto memberShipdto = memberService.selectMembership(memberId);

		return memberShipdto;
	}

		
	@RequestMapping(value = "member/checkIdDuplicate.do")
	@ResponseBody
	public Map<String, Object> checkIdDuplicate(@RequestParam("member_id") String member_id) {
		logger.debug("@ResponseBody-javaObj ajax : " + member_id);
		
		Map<String, Object> map = new HashMap<String, Object>();

		int count = memberService.checkIdDuplicate(member_id);
		boolean isUsable = count == 0 ? true : false;
		
		map.put("isUsable", isUsable);
		
		return map;
	}			


	@RequestMapping(value = "/member/checkConnectMember.do")
	@ResponseBody
	public Map<String, Object> checkConnectMember(@RequestParam("member_id") String member_id) {
		logger.debug("@ResponseBody-javaObj ajax : " + member_id);
		
		Map<String, Object> map = new HashMap<String, Object>();

		int count = memberService.selectMember(member_id);
		boolean isUsable = count == 0 ? true : false;
		
		map.put("isUsable", isUsable);
		
		System.out.println(map.get("isUsable"));
		
		return map;
	}			
	
	@RequestMapping(value = "/member/deleteConnectMember.do")
	@ResponseBody
	public Map<String, Object> deleteConnectMember(@RequestParam("member_id") String member_id) {
		logger.debug("@ResponseBody-javaObj ajax : " + member_id);
		
		Map<String, Object> map = new HashMap<String, Object>();

		int count = memberService.deleteConnect(member_id);
		boolean isUsable = count == 1 ? true : false;
		
		map.put("isUsable", isUsable);
		
		System.out.println(map.get("isUsable"));
		
		return map;
	}
	
//	@Secured("ROLE_USER")
//	@RequestMapping(value = "/member/myPageQuestion.do")
//	public ModelAndView mypageQuestion(
//			@RequestParam(value = "cPage", required = false, defaultValue = "1")int cPage) {
//			
//			ModelAndView mav = new ModelAndView();
//			
//			// 사용자의 인증세션 값 가져오기
//			Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
//			MemberDetailsDto memberDetailsdto = (MemberDetailsDto) authentication.getPrincipal();
//			
//			// Rowbounds 처리를 위해 offset, limit 값 필요
//			int numPerPage = 10; //=> limit
//			
//			List<QuestionDto> list = memberService.selectQuestionList(cPage, numPerPage);
//			logger.debug("list@memberController=" + list);
//			
//			// 페이지바처리를 위한 전체컨텐츠 수 구하기
//			int pcount = memberService.selectQuestionListCount(memberDetailsdto.getUsername());
//				
//			mav.addObject("count", pcount);
//			mav.addObject("numPerPage", numPerPage);
//			mav.addObject("list", list);
//			mav.setViewName("member/myQuestion");
//			return mav;
//	}
//	
//	
//	@RequestMapping(value = "/member/insertEndQuestion.do", method = RequestMethod.POST, headers = ("content-type=multipart/*"))
//	public ModelAndView insertEndQuestion(@RequestParam(value = "boardTitle")String boardTitle,
//			 @RequestParam(value = "memberId")String memberId, @RequestParam(value = "smarteditor")String boardComment, HttpServletRequest request) {
//
//			QuestionDto questiondto = new QuestionDto();
//			questiondto.setQuestion_title(boardTitle);
//			questiondto.setMember_id(memberId);
//			questiondto.setQuestion_comment(boardComment);
//			
//			
//			// upload테이블에서 유저가 등록하기 전까지 올린 이미지들 확인
//			List<Map<String,Object>> uploadList = freeboardService.uploadList(memberId);
//			
//			// 체크해서 겹치는거만 넣을 리스트
//			List<String> uploadChk = new ArrayList<>();
//			
//			String directory = request.getSession().getServletContext().getRealPath("/resources/upload/freeboard/");
//			
//			// 업로드할 comment와 테이블에서 조회한 이미지가 겹치는것 골라내기
//			
//			for(int i = 0; i<uploadList.size(); i++) {
//				
//				if(boardComment.contains((String)uploadList.get(i).get("RENAMED_FILENAME"))) {
//					uploadChk.add((String)uploadList.get(i).get("RENAMED_FILENAME"));
//					
//				}else {
//					// 겹치지 않는 파일 삭제 처리 (겹친거만 살려둬야 게시글 올라갔을 때 이미지를 볼 수 있음)
//					File file = new File(directory+uploadList.get(i).get("RENAMED_FILENAME"));
//					System.out.println(directory+uploadList.get(i).get("RENAMED_FILENAME"));
//					file.delete();
//				}
//			}
//			
//			int result = memberService.insertBoard(questiondto);
//			logger.debug("게시물 등록 성공");
//			
//			// 겹친 리스트만 free_board_file테이블에 넣음(후에 게시물삭제시 삭제하기 위한 용도)
//			for(int i = 0; i < uploadChk.size(); i++) {
//				
//				QuestionFileDto fbf = new QuestionFileDto(questiondto.getQuestion_no(), uploadChk.get(i));
//				int res = memberService.insertFile(fbf);
//			
//			}
//			
//			ModelAndView mav = new ModelAndView();
//			mav.addObject("msg", "등록 완료");
//			mav.addObject("loc", "/member/myPageQuestion.do?member_id=" + memberId);
//			mav.setViewName("common/msg");
//			
//			return mav;
//	}
//	
//	@Secured("ROLE_USER")
//	@RequestMapping(value = "/member/myPageQuestionView.do")
//	public ModelAndView myPageQuestionView(@RequestParam(value = "no") int no){
//		ModelAndView mav = new ModelAndView();
//		
//		QuestionDto questiondto = memberService.selectQuestion(no);
//		
//		mav.addObject("question",questiondto);
//		mav.setViewName("member/myQuestionView");
//		return mav;
//	}
	

		
	@Secured("ROLE_USER")
	@RequestMapping(value = "/member/selectMemberAddress.do")
	public ModelAndView selectMemberAddress(@RequestParam("member_id") String member_id) {
		ModelAndView mav = new ModelAndView();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
		MemberDetailsDto memberDetailsdto = (MemberDetailsDto) authentication.getPrincipal();
		
		if(member_id.equals(memberDetailsdto.getUsername())) {
			List<AddressDto> list = memberService.selectAddrList(member_id);
			
			mav.addObject("list", list);
			mav.setViewName("/member/memberAddress");
			
		}else{ mav.setViewName("common/error"); }
		return mav;
	}
	
	@RequestMapping(value = "/member/deleteMemberAddress.do")
	@ResponseBody
	public String deleteMemberAddress(@RequestParam("address_no") int address_no) {
		int result = memberService.deleteMemberAddress(address_no);
		String msg = "";
		
		if(result > 0) { msg = "success"; }
		else { msg = "fail"; }
		
		return msg;
	}
	
	@RequestMapping(value = "/member/updateDefaultAddress.do")
	@ResponseBody
	public String updateDefaultAddress(@RequestParam("address_no") int address_no,
			@RequestParam("address_level") int address_level,
			@RequestParam("member_id") String member_id) {
		
		// 해당 회원의 address_level이 1이었던 배송지 정보를 바꾸려는 배송지 정보의 level로 바꿔줌.
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("address_level", address_level);
		int result1 = memberService.updateAddressLevel(map);
		
		// address_no에 해당하는 배송지 정보의 level을 1로 바꿔줌
		int result2 = memberService.updateAddressLevelByAddrNo(address_no);
		String msg = "";
		
		if(result1 > 0 && result2 > 0) { msg = "success"; }
		else { msg = "fail"; }
		
		return msg;
	}

	@RequestMapping(value = "/member/insertMemberAdress.do")
	@ResponseBody
	public String insertMemberAdress(@RequestParam("address") String address,
			@RequestParam("zip_code") String zip_code,
			@RequestParam("member_id") String member_id) {
		
		// address_level 최대값 가져오기
		int address_level = memberService.selectAddrLevel(member_id);
		
		// 새로운 배송지 정보 추가하기
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("address", address);
		map.put("zip_code", zip_code);
		map.put("address_level", address_level + 1);
		
		int result = memberService.insertAddress(map);
		
		String msg = "";
		
		if(result > 0) { msg = "success"; }
		else { msg = "fail"; }
		
		return msg;
	}
	
	@RequestMapping(value = "/member/updateMemberAddress.do")
	@ResponseBody
	public String updateMemberAdress(@RequestParam("address_level") int address_level,
			@RequestParam("address") String address,
			@RequestParam("zip_code") String zip_code,
			@RequestParam("member_id") String member_id) {
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("address", address);
		map.put("zip_code", zip_code);
		map.put("address_level", address_level);
		
		int result = memberService.updateAddress(map);
		
		String msg = "";
		
		if(result > 0) { msg = "success"; }
		else { msg = "fail"; }
		
		return msg;
	}
	
	//url decode 
	@RequestMapping(value = "decode.do")
	public void decode(Model model, @RequestParam("url") String url, HttpServletResponse response) {
		Urlcoding code = new Urlcoding();
		String res = code.urlDecode(url);

		try {
			response.getWriter().print(res);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
}
