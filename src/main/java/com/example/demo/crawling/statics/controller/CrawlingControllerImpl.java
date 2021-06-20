package com.example.demo.crawling.statics.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.crawling.statics.model.JavaWebCrawler;

@Controller
public class CrawlingControllerImpl implements CrawlingController {
	
	@Autowired
	JavaWebCrawler javaWebCrawler;
	
//	@Autowired
//	HeadlessCrawler headlessCrawler;
	
	@RequestMapping(value = "/crawling/7-eleven")
	public void crawlerFor7Eleven(Model model){
		List<Map<String, String>> data = null;
		try {
			
			data = javaWebCrawler.get7eleven("http://www.7-eleven.co.kr/event/eventList.asp");
		
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("data", data); // ModelAndView로 타입을 정하지 않고 void로 할 경우 파라미터명을 data로 하지않으면 jsp를 찾지 못한다.
	}

	@RequestMapping(value = "/crawlingEmart")
	public ModelAndView crawlerEmart() {
		ModelAndView mav = new ModelAndView();
		List<Map<String, String>> data = null;
		
		try {
			data = javaWebCrawler.getEmart("https://www.emart24.co.kr/service/event.asp");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		mav.addObject("emartCrawlingList", data);
		mav.setViewName("crawling/crawlingEmart");
		
		return mav;
	}

//	@RequestMapping(value = "gs25.do")
//	public ModelAndView crawlerForGS25() {
//		ModelAndView mav = new ModelAndView();
//		List<Map<String, String>> data = null;
//		
//		data = headlessCrawler.getEventInfo("http://gs25.gsretail.com/gscvs/ko/customer-engagement/event/current-events");
//		
//		mav.addObject("gs25CrawlingList", data);
//		mav.setViewName("crawling/gs25");
//		
//		return mav;
//	}
	
	@RequestMapping(value = "/crawling/gs25")
	public ModelAndView crawlerForGS25() {
		ModelAndView mav = new ModelAndView();
		List<Map<String, String>> data = null;
	
		try {
			data = javaWebCrawler.getGS25("http://gs25.gsretail.com/gscvs/ko/customer-engagement/event/current-events");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		mav.addObject("gs25CrawlingList", data);
		mav.setViewName("crawling/gs25");
		
		return mav;
	}

	@RequestMapping(value = "/crawling/ministop")
	public ModelAndView crawlerForMinistop() {
		ModelAndView mav = new ModelAndView();
		List<Map<String, String>> data = null;
		
		try {
			data = javaWebCrawler.getMinistop("https://www.ministop.co.kr/MiniStopHomePage/page/event/eventlist.do");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		mav.addObject("ministopCrawlingList", data);
		mav.setViewName("crawling/ministop");
		
		return mav;
	}

//	@RequestMapping(value = "cu.do")
//	public ModelAndView crawlerForCKU() {
//		ModelAndView mav = new ModelAndView();
//		List<Map<String, String>> data = null;
//		
//		try {
//			data = javaWebCrawler.getCu("http://membership.bgfretail.com/pc/eventList");
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		
//		mav.addObject("cuCrawlingList", data);
//		mav.setViewName("crawling/cu");
//		
//		return mav;
//	}
	
	@RequestMapping(value = "/crawling/cu")
	public void crawlerForCKU(Model model) {
		List<Map<String, String>> data = null;
		
		try {
			data = javaWebCrawler.getCu("http://membership.bgfretail.com/pc/eventList");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("data", data); // ModelAndView로 타입을 정하지 않고 void로 할 경우 파라미터명을 data로 하지않으면 jsp를 찾지 못한다.
	}
	
}
