package com.example.demo.cart.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.example.demo.cart.model.dto.CartVO;

public interface CartService {
	public List<CartVO> myCartList(CartVO cartVO) throws Exception;
	public void addInCart(ArrayList<CartVO> selectedList) throws Exception;
	public void removeCartItem(int cart_id) throws Exception;
}
