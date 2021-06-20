package com.example.demo.cart.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.cart.model.dto.CartVO;

public interface CartController {
	public ModelAndView myCartMain(@RequestParam String member_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception;
	public @ResponseBody String addInCart(@RequestBody ArrayList<CartVO> checkedList, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public @ResponseBody String removeCartItem(@RequestParam("cart_id") int cart_id,
            HttpServletRequest request, HttpServletResponse response)  throws Exception;
}
