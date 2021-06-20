package com.example.demo.crawling.statics.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.phantomjs.PhantomJSDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.springframework.stereotype.Component;

/*
 * phantomjs를 사용한 크롤링
 * phantomjs v2.1.1을 지정한 폴더에 설치한다.
 * pom.xml에서 관련 라이브러리와 사설 저장소를 등록해줘야 한다.
 * */

@Component
public class HeadlessCrawler {
  private WebDriver driver;
  protected static DesiredCapabilities dCaps;
//public HeadlessCrawler() {
//  
//  System.setProperty("phantomjs.binary.path", "C:\\dev\\phantomjs-2.1.1-windows\\bin\\phantomjs.exe");
//  dCaps = new DesiredCapabilities();
//  dCaps.setJavascriptEnabled(true);
//  dCaps.setCapability("takesScreenshot", false);
//  
//  driver = new PhantomJSDriver(dCaps);
//  driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
//}
//
//
//public List<Map<String,String>> getEventInfo(String url) {
//  	List<Map<String,String>> list = new ArrayList<>();
//    driver.get(url);
//    
//    //이벤트정보가 담기 table의 클래스명 tbl_ltype1으로 조회함. 
//    WebElement eventTable = driver.findElement(By.className("tbl_ltype1"));
//    WebElement tbody = eventTable.findElement(By.tagName("tbody"));
//    List<WebElement> trs = tbody.findElements(By.tagName("tr"));
//    
//    System.out.println("trs.size() = "+trs.size());
//    
//    for(int i = 0; i<trs.size();i++){
//    	//tr>td>a+img
//    	WebElement tr = trs.get(i);
//    	WebElement a = tr.findElement(By.cssSelector("td p.tit a"));
//    	WebElement img = tr.findElement(By.cssSelector("td img"));
//    	WebElement p = tr.findElement(By.cssSelector("td p.period"));
//    	Map<String, String> map = new HashMap<>();
//    	
//    	map.put("a.href", a.getAttribute("href"));//링크
//    	map.put("eventTitle", a.getText());//이벤트명
//    	map.put("img.src", img.getAttribute("src"));//이미지
//    	map.put("period",  p.getText());
//    	list.add(map);
//    }
//    
//    System.out.println(list);
//    return  list;
//}




}