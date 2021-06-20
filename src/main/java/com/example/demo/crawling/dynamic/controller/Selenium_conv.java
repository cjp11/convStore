/*

 * 요기요 등록 음식점 이하의 리스트들에 접근
 */
package com.example.demo.crawling.dynamic.controller;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.demo.crawling.dynamic.model.dto.AddressVO;

// jsp 파일에 input 값을 입력하지 않아도 자동적으로 크롤링 페이지를 띄워줌
// 로그인 회원가입 형태로 실행해보면 될지도 모름. 
@Controller
public class Selenium_conv {
	// WebDriver
		private WebDriver driver;
		// Properties
		public static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
		public static final String WEB_DRIVER_PATH = "C:/Crawler/Selenium/chromedriver_win32/chromedriver.exe";
		//private CrawlThread mCrawlThread;
		// 크롤링 할 URL
		private String base_url;

	@RequestMapping(value = "/start.do", method = RequestMethod.GET)
	public String start(AddressVO addr, Model model) throws InterruptedException {
		
		System.out.println("start() 실행");

		System.out.println("placeName: " + addr.getPlaceName());
		System.out.println("addr: " + addr.getAddr());
		
		
		Selenium_conv selTest = new Selenium_conv();
		boolean selPage = selTest.crawl(addr,model);

		

		if(!selPage) {
			return "crawling/fail";
		}else return "crawling/outputList";


	}
	
	

	

	public Selenium_conv() {
		super();

		// System Property SetUp
		System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
		
		ChromeOptions options = new ChromeOptions(); // 리눅스 구동하기 위한 추가사항
		options.addArguments("--headless");		
		options.addArguments("--no-sandbox");
		options.addArguments("--disable-dev-shm-usage");
		options.addArguments("--window-size=1920x1080");
	
		driver = new ChromeDriver(options);
		
		// Driver SetUp
		//driver = new ChromeDriver();
		base_url = "https://www.yogiyo.co.kr/mobile/#/";
		// base_url = "https://www.naver.com/";

	}

	public boolean crawl(AddressVO vo, Model model) throws InterruptedException {

		
			long startTime = System.currentTimeMillis();
			String add = vo.getAddr();
			
			
			

			// get page (= 브라우저에서 url을 주소창에 넣은 후 request 한 것과 같다)
			driver.get(base_url);
			Thread.sleep(2200);
			//driver.manage().timeouts().pageLoadTimeout(3, TimeUnit.SECONDS);
			// 요기요 검색 창 접근, 창 비우기, 창에 주소 넣기. 엔터키 입력(검색 클릭과 같은 동작)
			WebElement address = driver.findElement(By.cssSelector("#search > div > form > input"));
			address.clear();
			address.sendKeys(add);
			address.sendKeys("\n"); // address.submit()이 동작하지 않음.
			Thread.sleep(1200);

			// '편의점/마트' 카테고리 클릭
			driver.findElement(By.cssSelector("#category > ul > li:nth-child(14)")).click();
			Thread.sleep(1800);	// 1.3초도 예외 코드 뜸

			/*
			 * driver.findElement(By.cssSelector(
			 * "img[src='image/category-convenience-store.png']")).click();
			 */

			// 경로: #content > div 이면 출력값: css selector: #content > div
			// 우리 동네 플러스, 슈퍼레드위크 추천, 요기요 등록 음식점 -> 세 영역으로 나뉨(2~4 index로 접근,
			// div:nth-child(2~4) 그런데 prodsCount.size() 값이 왜 7이 나오지?
			List<WebElement> prodsCount = driver.findElements(By.cssSelector("#content > div > div"));
			// System.out.println("Total number of products are " + prodsCount.size());
			// System.out.println(j +"번째 출력 내용" + prodsCount.get(j++).getText());

			// '요기요 등록 음식점' 아래에 있는 편의점 지점 리스트들에 접근 위한 인덱스. 추출 작업.
			int startIndex = -1;

			// 끝 index 설정 이슈 -> 대강 10으로 두기 vs prodsCount.size() 값으로 두기
			for (int j = 2; j <= prodsCount.size(); j++) { // ****** 시작 인덱스 = 2 (1 아님) *******
				String startName = driver
						.findElement(By.cssSelector(
								"#content > div > div:nth-child(" + j + ") > div > div.ranking-guide.ng-scope > p"))
						.getText();
				// System.out.println(startName + "문자열 길이: " + startName.length());
				// if절 진입 못하는 문제 발생. 왜 ? 문자열의 길이를 구해보면 길이의 뒤로 공백문자열이 들어가 있는 경우가 존재.
				// trim() 함수 이용. 앞 뒤 공백 문자열 제거해줌.
				startName = startName.trim();
				if (startName.equals("요기요 등록 음식점")) {
					System.out.println(startName);
					startIndex = j;
					break;

				}
			}

		

			// #content > div > div:nth-child(4) > div // 요기요 등록 음식점 이하 div

			// 무한 스크롤(확인)
			WebElement element = driver.findElement(By.cssSelector("body"));
			element.sendKeys(Keys.END);
			//driver.manage().timeouts().pageLoadTimeout(3, TimeUnit.SECONDS);	
			Thread.sleep(2500);		// 이 문장이 없으면 아래에서 편의점 리스트들 중 일부를 인식하지 못해
									// NoSuchElementException 발생

			

			// jsp에서 전달한 편의점 지점명과 지점명이 같은 편의점을 검색해 클릭하는 행위
			// 전달한 편의점 지점명에 해당하는 편의점이 없다면 요기요 서비스 제공 지점이 아님
			// 서비스 제공 업체가 아니다 (현재 재고 서비스 지원하지 않음), 끝 편의점 요소 까지 접근했는데 해당 편의점이 검색되지 않을 시(재고 서비스를 지원하지 않는 편의점이다) -> fail.jsp 페이지로 return 시키기
			FailPage failPage = new FailPage();
			boolean isExist = failPage.isServiceStore(driver, vo, startIndex);
			if(!isExist) {
				return false;
			}
			// 해당 편의점 접근처리 완료된 상태, 카테고리 순회하면서 상품정보 가져오기
			SelectCategory selCategory = new SelectCategory();
			selCategory.extractProductInfo(driver, model);
			model.addAttribute("place", vo);
			
			long endTime = System.currentTimeMillis();
			//System.out.println((endTime - startTime)/1000 + "초");
		
			
			driver.close();
			return true;
			
			

			/*
			 * [문제1] 서울 서초구 서초동 1303-33 현위치 주소가 이렇게 떴는데 요기요에서 이 주소값으로 검색 버튼이 눌러지지 않음. 요기요에서
			 * 인식하는 주소가 아닌듯.
			 * 
			 * 예) 서울 서초구 서초동 1337-17 으로 검색하면 서울 서초구 서초동 1337-17 보원빌딩으로 바뀌어서 검색됨 -> 요기요는 현위치를
			 * 근처 빌딩 또는 건물 위치까지 검색해야 나오는 듯. -> 현 주소 + 건물명까지 붙혀서 주소값을 보강해주세요
			 * 
			 * 
			 * [문제2] GS25-서초점 -> 요기요 상에 등록되어 있는데 검색 버튼 안눌림. 즉, 편의점 지점 명으로 검색시 주소로 변환되어 검색되는데
			 * 되는게 있고 않되는 게 있음.
			 */

	
		
	}

}