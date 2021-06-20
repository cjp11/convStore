package com.example.demo.crawling.dynamic.model.dto;

public class GSVO {
	private String productName;
	private int productPrice;
	private int productStock;
	private String imageUrl;

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public int getProductStock() {
		return productStock;
	}
	public void setProductStock(int productStock) {
		this.productStock = productStock;
	}
	@Override
	public String toString() {
		return "GSVO [productName=" + productName + ", productPrice=" + productPrice + ", productStock=" + productStock
				+ "]";
	}
	
}
