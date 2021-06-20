package com.example.demo.crawling.dynamic.controller;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.springframework.ui.Model;

import com.example.demo.crawling.dynamic.model.dto.GSVO;

public class SelectCategory {

	ArrayList<GSVO> list = new ArrayList<GSVO>();

	public void extractProductInfo(WebDriver driver, Model model) {
		// 2부터 카테고리 시작
		int categoryIdx = 2;
		// k = 19번 부터는 요기요에서 막아 놓은 것 같다. 개별로 19이상의 인덱스에 접근은 가능한데....
		while(true) {
			try {
			/*
			 * 출처: https://stackoverrun.com/ko/q/13064334 driver.findElement() will not
			 * return null if no element is found so your condition that checks that is not
			 * necessary. If no element is found, an exception is thrown which you are
			 * catching. You can avoid all the try/catches by using .findElements() (note
			 * the plural). If the element is not found, an empty list will be returned. You
			 * can then check for an empty list and avoid all the exceptions.
			 */
			
			List<WebElement> el = driver
					.findElements(By.cssSelector("#menu > div > div:nth-child(" + categoryIdx + ") > div.panel-heading > h4"));
			String plusText = driver.findElement(By.cssSelector("#menu > div > div:nth-child("+categoryIdx+") > div.panel-heading > h4 > a > span")).getText();
			//System.out.println(plusText);
			if (!el.isEmpty() && plusText.contains("＋")) {
				System.out.println("진입");
				
				el.get(0).click();
				int innerCategoryIdx = 1;
				while (true) {
					
					List<WebElement> innerEl = driver.findElements(By.cssSelector("#menu > div > div:nth-child(" + categoryIdx
							+ ") > " + "div.panel-collapse.collapse.in.btn-scroll-container > div > ul > li:nth-child("
							+ innerCategoryIdx + ")"));
					
					
					// <재고 있는 상품만 데이터 저장>
					// 상품 재고가 없는 상품의 재고를 출력해보면 빈 문자열로 나오고, 길이도 0이지만,
					// isStock != null 문장으로 조건에 추가하면 상품 재고 없는 상품도 출력됨.
					// 즉, 모든 상품이 출력됨
					if (!innerEl.isEmpty()) {

						// 이 문장을 if 위로 뺐을 경우, innerEl이 null인 상황으로 가정하면
						// NoSuchElementException 발생
						String isStock = driver.findElement(By.cssSelector("#menu > div > div:nth-child(" + categoryIdx
								+ ") > div.panel-collapse.collapse.in.btn-scroll-container > div > ul > li:nth-child("
								+ innerCategoryIdx
								+ ") > table > tbody > tr > td.menu-text > div.menu-stock.ng-binding")).getText();
						// 반드시 재고(String)값이 0이상인 데이터만 접근
						// 요기요에서 품절 상태인 경우 재고 표시란이 없어짐(length == 0)
						if (isStock.length() != 0) {
							GSVO gsVO = new GSVO();
							String url = driver.findElement(By.cssSelector("#menu > div > div:nth-child(" + categoryIdx
									+ ") > div.panel-collapse.collapse.in.btn-scroll-container > div > ul > li:nth-child("
									+ innerCategoryIdx + ") > table > tbody > tr > td.photo-area > div"))
									.getAttribute("style");
							int start = url.indexOf("https://");
							int last = url.indexOf("?");
							if (last != -1) {
								String ok = url.substring(start, last);
								gsVO.setImageUrl(ok);
							}
							// 이름 
							gsVO.setProductName(driver.findElement(By.cssSelector("#menu > div > div:nth-child(" + categoryIdx
									+ ") > "
									+ "div.panel-collapse.collapse.in.btn-scroll-container > div > ul > li:nth-child("
									+ innerCategoryIdx + ") > "
									+ "table > tbody > tr > td.menu-text > div.menu-name.ng-binding")).getText());
							
							// 단가  String -> int 변환
							String strPrice = driver.findElement(By.cssSelector("#menu > div > div:nth-child(" + categoryIdx
									+ ") > " + "div.panel-collapse.collapse.in.btn-scroll-container > div > ul > "
									+ "li:nth-child(" + innerCategoryIdx
									+ ") > table > tbody > tr > td.menu-text > div.menu-price > "
									+ "span:nth-child(1)")).getText();
							strPrice = strPrice.trim();
							strPrice = strPrice.replace("원","");
							strPrice = strPrice.replace(",", "");
							
							int price = Integer.parseInt(strPrice);
							gsVO.setProductPrice(price);
							
							// 재고 String -> int 변환
							String strStock = driver.findElement(By.cssSelector("#menu > div > div:nth-child(" + categoryIdx
									+ ") > div.panel-collapse.collapse.in.btn-scroll-container > div > ul > li:nth-child("
									+ innerCategoryIdx
									+ ") > table > tbody > tr > td.menu-text > div.menu-stock.ng-binding")).getText();
							strStock = strStock.trim();
							strStock = strStock.replace("(", "");
							strStock = strStock.replace("개 남음)", "");
							
							int stock = Integer.parseInt(strStock);
							gsVO.setProductStock(stock);
							// list에 vo 담기 
							list.add(gsVO);
							innerCategoryIdx++;
						} else {
							break;
						}
					}
					// innerEl 이 존재하지 않는 경우
					else {
						
						break;
					}
				}
			}	//카테고리 존재 & 클릭하고 리스트에 제품 데이터 add 완료. if절 완료.
			categoryIdx++;
			}
			catch(Exception e) {
				System.out.println("없는 카테고리(마지막 다음)에 접근하는 경우");
				break;
			}
		}

		model.addAttribute("list", list);

	}
}
