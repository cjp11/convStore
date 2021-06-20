package com.example.demo.chatting.controller;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.chatting.model.dto.ChattingDto;
import com.example.demo.chatting.service.ChattingService;
import com.example.demo.chatting.service.ChattingServiceImpl;
import com.example.demo.member.model.dto.MemberDetailsDto;

@Controller
public class ChattingController {

	@Autowired
	private ChattingService chattingService = new ChattingServiceImpl();
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/chatting/showChat.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String,Object> showChat() {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<ChattingDto> list = chattingService.selectChattingList();
		int connectCount = chattingService.connectCount(); 
		
		map.put("list", list);
		map.put("connectCount", connectCount);
		
		logger.debug("map = " + map);
		
		return map;	
	}
	
	@RequestMapping(value = "/chatting/insertChat.do", method = RequestMethod.GET, produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> insertChat(@RequestParam(value = "member_id")String member_id,
						   @RequestParam(value = "chat_content")String chat_content) {
		
		ChattingDto chatting = new ChattingDto(0, member_id, chat_content, null);
		
		int insertChat = chattingService.insertChat(chatting);
		
		Map<String, Object> map = new HashMap<String, Object>();
		int connectCount = chattingService.connectCount();
		map.put("connectCount", connectCount);
		return map;	
	}
	
	@RequestMapping(value = "/chatting/chatUpload.do", method = RequestMethod.POST)
	@ResponseBody
	public String uploadPhoto(HttpServletRequest request) {
		
		// 파일정보
		StringBuffer sb = new StringBuffer();
		try{
			// 원본파일 명
			String originalFileName = request.getHeader("file-name");
			// 파일저장 경로
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/chatting/");
			String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
			int rndNum = (int)(Math.random() * 1000);
			String renamedFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + rndNum + "." + ext;
			
			InputStream is = request.getInputStream();
			OutputStream os = new FileOutputStream(saveDirectory+renamedFileName);
			byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
			int numRead;
			while((numRead = is.read(b,0,b.length)) != -1) {
				os.write(b, 0, numRead);
			}
			os.flush();
			os.close();
			
			// 정보 출력
			sb = new StringBuffer();
			sb.append("&NewLine=true")
			  .append("&sFileName=").append(originalFileName)
//			  .append("&sFileURL=").append("http://localhost:9090/demo/resources/upload/chatting/") // 로컬
			  .append("&sFileURL=").append("https://allpyon.com/demo/resources/upload/chatting/") // AWS
			  .append(renamedFileName);
			
			// 유저의 인증세션 값 가져오기
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
			MemberDetailsDto memberDetailsdto = (MemberDetailsDto) authentication.getPrincipal();
			
			// 실시간 업로드되는 이미지 관리 위해 디비에 넣기
			Map<String, String> map = new HashMap<>();
			map.put("member_id", memberDetailsdto.getUsername());
			map.put("renamedFilename", renamedFileName);
			
			int result = chattingService.chatUpload(map);
						
		}catch(Exception e){
			e.printStackTrace();
		}
		return sb.toString();
	}
	
}
