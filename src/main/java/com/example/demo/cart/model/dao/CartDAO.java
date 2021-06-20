package com.example.demo.cart.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.example.demo.cart.model.dto.CartVO;

public interface CartDAO {
	public void insertInCart(ArrayList<CartVO> selectedList) throws DataAccessException;
	public int selectMaxCartId() throws DataAccessException;
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException;
	public void deleteCartItem(int cart_id) throws DataAccessException;
}
