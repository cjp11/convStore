package com.example.demo.cart.model.dto;

public class CartVO {
	private String member_id;
	private int cart_id;
	private String image_url;
	private String product_name;
	private int product_stock;
	private int product_price;
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getCart_id() {
		return cart_id;
	}
	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getImage_url() {
		return image_url;
	}
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	
	public int getProduct_stock() {
		return product_stock;
	}
	public void setProduct_stock(int product_stock) {
		this.product_stock = product_stock;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	@Override
	public String toString() {
		return "CartVO [member_id=" + member_id + ", cart_id=" + cart_id + ", product_name=" + product_name
				+ ", image_url=" + image_url + ", product_stock=" + product_stock + ", product_price=" + product_price
				+ "]";
	}
	
	
	

}
