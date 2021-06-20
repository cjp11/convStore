package com.example.demo.utill.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UtillControllerImpl implements UtillController{

	@RequestMapping(value = "imageUpload.do", method = RequestMethod.POST)
	public void communityImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) {
		 
	    OutputStream out = null;
	    PrintWriter printWriter = null;
	    response.setCharacterEncoding("utf-8");
	    response.setContentType("text/html;charset=utf-8");
	
//	    String resourcePath = "C:\\board\\article_image"; // 윈도우
	    String resourcePath = "/var/lib/tomcat9/webapps/boardImg"; // 리눅스
	
	    Date date = new Date();
	    date.getTime();
	    
	    try{
	
	        String fileName = upload.getOriginalFilename();
	        String[] fileNameArr = fileName.split("\\."); // 윈도우
//	        String[] fileNameArr = fileName.split("/."); // 리눅스
	        System.out.println(Arrays.toString(fileNameArr));
	        String storeFileName = fileNameArr[0] + date.getTime() + "." + fileNameArr[1];
	        System.out.println("저장경로 : " + resourcePath + storeFileName);
	        byte[] bytes = upload.getBytes();
	        String uploadPath = resourcePath + storeFileName;//저장경로
	
	        out = new FileOutputStream(new File(uploadPath));
	        out.write(bytes);
	        String callback = request.getParameter("CKEditorFuncNum");
	
	        String filePath = "resources/boardImg/" + storeFileName;
	        
	        printWriter = response.getWriter();
	
	        printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
	                + callback
	                + ",'"
	                + filePath
	                + "','이미지를 업로드 하였습니다.'"
	                + ")</script>");
	        printWriter.flush();
	
	    }catch(IOException e){
	        e.printStackTrace();
	    } finally {
	        try {
	            if (out != null) {
	                out.close();
	            }
	            if (printWriter != null) {
	                printWriter.close();
	            }
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	
	    return;
	}
	
}
