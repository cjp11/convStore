package com.example.demo.crawling.statics.controller;

import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

public interface CrawlingController {
	
	public void crawlerFor7Eleven(Model model);
	
	public ModelAndView crawlerEmart();
	
	public ModelAndView crawlerForGS25();
	
	public ModelAndView crawlerForMinistop();
	
	public void crawlerForCKU(Model model);
}