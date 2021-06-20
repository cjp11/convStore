package com.example.demo.utill.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

public interface UtillController {
	public void communityImageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile upload);
}
