package com.example.demo.crawling.dynamic.controller;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;

import com.example.demo.crawling.dynamic.model.dto.AddressVO;

public class FailPage {
	public boolean isServiceStore(WebDriver driver, AddressVO vo, int startIndex) {
		int idx = 1;
		while (true) {
			try {
				String placeName = driver.findElement(By.cssSelector("#content > div > div:nth-child(" + startIndex
						+ ") > div > div.restaurant-list" + " > div:nth-child(" + idx + ")"
						+ "> div > table > tbody > tr > td:nth-child(2) > div > div.restaurant-name.ng-binding"))
						.getText();
				System.out.println(placeName);
				placeName = placeName.trim();
				if (placeName.equals(vo.getPlaceName())) {

					/*
					 * ***********스크롤 처리하기 전의 편의점은 클릭 처리가 안됨. ********************
					 * sendKeys(Keys.END); 를 수행하면 페이지 스크롤 끝까지 되는데 이 후에 driver.findElement()를 수행할 때,
					 * 편의점의 모든 리스트 요소에 접근할 것이라고 생각. 하지만, NoSuchElementException 발생. 해당 요소를 찾을 수 없다고
					 * 나옴. 해결: 스크롤 하여 해당 요소 위치에 접근해야 클릭 처리를 할 수 있음.
					 **************************************************************/

					WebElement ele = driver.findElement(By.cssSelector("#content > div > div:nth-child(" + startIndex
							+ ") > div > div.restaurant-list > div:nth-child(" + idx + ")"));
					Actions actions = new Actions(driver);
					actions.moveToElement(ele);
					actions.perform();

					driver.findElement(By.cssSelector("#content > div > div:nth-child(" + startIndex
							+ ") > div > div.restaurant-list > div:nth-child(" + idx + ")")).click();
					Thread.sleep(3000);
					System.out.println("목적 편의점 지점까지 도달");
					return true;
				}
				idx++;

			} catch (Exception e) {
				//e.printStackTrace();
				System.out.println("해당지점 서비스 제공 X 경우임!");
				return false;
			}
		}

	}
}
