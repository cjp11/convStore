package com.example.demo.crawling.statics.model;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.client.ClientProtocolException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Component;

@Component
public class JavaWebCrawler {

	public List<Map<String, String>> get7eleven(String url) throws ClientProtocolException, IOException {
		String result = "";
		// Jsoup라이브러리 사용
	    Document doc = Jsoup.connect(url).get();
	    result = doc.data();
	    
	    // 특정엘레먼트 찾기
	    Elements elems = doc.select("ul#listUl li");
//	    System.out.println("elems="+elems);
//	    System.out.println("elems="+elems.size());
	    List<Map<String, String>> eventList = new ArrayList<>();
	    
	    // elems의 마지막요소는 +(More) 버튼이라 -1을 해 준다.
	    for(int i = 0; i < elems.size() - 1; i++){
	    	Element e = elems.get(i);
	    	Element a = e.select("a").get(0);
	    	//System.out.println("a="+a);
	    	Element dl = e.select("div.event_over").get(0).select("dl").get(0);
	    	//System.out.println("div="+div);
	    	
	    	Map<String, String> map = new HashMap<>();
	    	map.put("a.href", a.attr("href"));
	    	map.put("img.src", a.select("img").get(0).attr("src"));
	    	map.put("dt", dl.select("dt").get(0).text());
	    	map.put("dd", dl.select("dd.date").get(0).text());
	    	eventList.add(map);
	    }
	    System.out.println("eventList = " + eventList);

	    return eventList;
	}
	
	public List<Map<String, String>> getEmart(String url) throws IOException {
		String result = "";
		// Jsoup라이브러리 사용
	    Document doc = Jsoup.connect(url).get();
	    result = doc.data();
	    
	    // 특정엘레먼트 찾기
	    Elements elems = doc.select("table.listTable tbody tr");
//	    System.out.println("elems="+elems);
//	    System.out.println("elems="+elems.size());
	    List<Map<String, String>> eventList = new ArrayList<>();
	    
	    // elems의 마지막요소는 +(More)버튼이라 -1을 해 준다.
	    for(int i = 0; i < elems.size() - 1; i++){
	    	Element e = elems.get(i);
	    	Element a = e.select("a").get(0);
	    	Elements td = e.select("td");
	    	
	    	System.out.println("td =" + td);
	    	String title = td.get(2).select("a").html();
	    	String date = td.get(3).html();
	    	System.out.println("title =" + title);
	    	System.out.println("date" + date);
	    	
	    	String href = a.attr("href");
	    	
	    	System.out.println(href.substring(1));
	    	
//	    	Element dl = e.select("div.event_over").get(0).select("dl").get(0);
	    	//System.out.println("div="+div);
	    	
	    	Map<String, String> map = new HashMap<>();
	    	map.put("date", date);
	    	map.put("title", title);
	    	map.put("href", href.substring(1));
	    	map.put("img.src", a.select("img").get(0).attr("src"));
//	    	map.put("dt", dl.select("dt").get(0).text());
//	    	map.put("dd", dl.select("dd.date").get(0).text());
	    	eventList.add(map);
	    }
	    System.out.println("eventList=" + eventList);

	    return eventList;
	}

	public List<Map<String, String>> getCu(String url) throws IOException {
		String result = "";
		// Jsoup라이브러리 사용
	    Document doc = Jsoup.connect(url).get();
	    result = doc.data();
	    
	    // 특정엘레먼트 찾기
	    Elements elems = doc.select("div.list_box ul li");
	    System.out.println("elems=" + elems);
//	    System.out.println("elems="+elems.size());
	    List<Map<String, String>> eventList = new ArrayList<>();
	    
	    for(int i = 0; i < elems.size() -1; i++) {
	    	Element li = elems.get(i);
//	    	System.out.println("li:" + li);
	    	Element imgsrc = li.select("div").get(0).select("img").get(0);
//	    	Element href = li.select("div").get(1);
	    	
//	    	System.out.println("imgsrc : " + imgsrc.attr("src"));
	    	
	    	Element title = li.select("h4").get(0);
//	    	System.out.println("title:" + title.html());
	    	
	    	Element date = li.select("span").get(0);
//	    	System.out.println("date:" + date.html());
	    	
//	    	System.out.println("href:" + href.attr("href"));
	    	
	    	Map<String, String> map = new HashMap<>();
	    	
	    	map.put("imgsrc", imgsrc.attr("src"));
	    	map.put("title", title.html());
	    	map.put("date", date.html());
//	    	map.put("href", href.attr("href"));
	    	
	    	eventList.add(map);
	    	
	    }

	    System.out.println("eventList = " + eventList);
	    return eventList;
	}
	
	public List<Map<String, String>> getGS25(String url) throws IOException {
		String result = "";
		//#2.Jsoup라이브러리 사용
	    Document doc = Jsoup.connect(url).get();
	    result = doc.data();
	    
	    // 특정엘레먼트 찾기
	    Elements elems = doc.select("table.tbl_ltype1 tbody tr");
	    // System.out.println("elems=" + elems);
	    
	    List<Map<String, String>> eventList = new ArrayList<>();
	    

	    for(int i = 0; i < elems.size(); i++) {
	    	// tr > td > a + img
//	    	Element tr = elems.get(i);
//	    	
//	    	Element a = tr.select("a").get(0);
//	    	
//	    	Elements td = tr.select("td");
//	    	
//	    	String title = td.get(2).select("p").get(1).html();
//	    	String date = td.get(2).select("p").get(2).html();
	    	
	    	Element tr = elems.get(i);
	    	Element td1 = tr.select("td").get(1);
	    	Element td2 = tr.select("td").get(2);
	    	Element p1 = td2.select("p").get(1);
	    	Element p2 = td2.select("p").get(2);
	    	
	    	Element a = td1.select("a").get(0);	
	    	
	    	String title = p1.select("a").get(0).html();
	    	String date = p2.select("").get(0).html();
	    	String href = a.attr("href");
	    	
	   
	    	Map<String, String> map = new HashMap<>();
	    	
	    	map.put("href", href.substring(1));
	    	map.put("eventTitle", title);
	    	map.put("img.src", a.select("img").get(0).attr("src"));
	    	map.put("period", date);
	    	eventList.add(map);
	    }
	    
	    
	    System.out.println("eventList = " + eventList);

	    return eventList;
	}

	public List<Map<String, String>> getMinistop(String url) throws IOException {
		String result = "";
		// Jsoup라이브러리 사용
	    Document doc = Jsoup.connect(url).get();
	    result = doc.data();
	    
	    // 특정엘레먼트 찾기
	    Elements elems = doc.select("div.eventlist_li li a");
//	    System.out.println("elems="+elems);
//	    System.out.println("elems="+elems.size());
	    List<Map<String, String>> eventList = new ArrayList<>();
	    
	    for(int i = 0; i < elems.size(); i++) {
	    	Element li = elems.get(i);
	    	System.out.println("li" + "["+ i +"]" + li);
	    	
	    	Element img = li.select("a").get(0).select("img").get(0);
	    	System.out.println("img:"+img.attr("src").substring(2));
	    	
	    	Element title = li.select("ul").get(0).select("li").get(0).select("strong").get(0);
	    	System.out.println("title:" + title.html());
	    	
	    	Element date = li.select("ul").get(0).select("li").get(1).select("li").get(0);
	    	System.out.println("date:" + date.html());
	    	
	    	Element href = li.select("a").get(0);
	    	System.out.println("href:" + href.attr("href"));
//	    	Element img = li.select("img").get(0);
//	    	Element title = li.select("ul").get(0).select("li").get(0).select("strong").get(0); 
//	    	Element date = li.select("ul").get(0).select("li").get(1).select("li").get(0); 
//	    	String imgsrc = img.attr("src");
//	    	
//	    	
//	    	System.out.println("img : "+img);
//	    	System.out.println("mini li:"+li);
//	    	System.out.println("imgsrc: "+imgsrc.substring(2));
//	    	System.out.println("title : "+title.html());
//	    	System.out.println("date:"+date.html());
//	    	
	    	Map<String,String> map = new HashMap<>();
	    	
	    	map.put("imgsrc", img.attr("src").substring(2));
	    	map.put("title", title.html());
	    	map.put("date", date.html());
	    	map.put("href", href.attr("href"));
	    	
	    	eventList.add(map);
	    	
	    }
	    System.out.println("eventList = " + eventList);

	    return eventList;
	}

}