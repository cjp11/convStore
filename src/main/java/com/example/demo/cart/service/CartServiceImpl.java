package com.example.demo.cart.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.cart.model.dao.CartDAO;
import com.example.demo.cart.model.dto.CartVO;

//@Service("cartService")
@Service
public class CartServiceImpl implements CartService{
	@Autowired
	private CartDAO cartDAO;
	
	
	public List<CartVO> myCartList(CartVO cartVO) throws Exception{
		
		List<CartVO> myCartList=cartDAO.selectCartList(cartVO);
		if(myCartList.size()==0){ //카트에 저장된 상품이없는 경우
			System.out.println("myCartList.size() == 0");
			return null;
		}
		return myCartList;
	}
	
	
	public void addInCart(ArrayList<CartVO> selectedList) throws Exception{
		cartDAO.insertInCart(selectedList);
	}
	public void removeCartItem(int cart_id) throws Exception{
		cartDAO.deleteCartItem(cart_id);
	}
}
