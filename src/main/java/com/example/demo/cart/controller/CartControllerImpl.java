package com.example.demo.cart.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.cart.model.dto.CartVO;
import com.example.demo.cart.service.CartService;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
public class CartControllerImpl implements CartController {
	@Autowired
	private CartService cartService;
	
	// 장바구니 목록 보여주기
	@RequestMapping(value = "cart/myCartList.do", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public ModelAndView myCartMain(@RequestParam String member_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		CartVO cartVO = new CartVO();
		cartVO.setMember_id(member_id);
		System.out.println("vo에 set된 member_id:" + cartVO.getMember_id());
		ModelAndView mav = new ModelAndView();
		mav.setViewName("cart/myCartList");
		
		List<CartVO> myCartList = cartService.myCartList(cartVO);
		mav.addObject("myCartList", myCartList);
		System.out.println("myCartMain 끝");
		return mav;
	}
	
	// 장바구니 담기
	@RequestMapping(value = "addInCart.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String addInCart(@RequestBody ArrayList<CartVO> checkedList, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("checkedList :: " + checkedList);

		ArrayList<CartVO> selectedList = new ArrayList<CartVO>();

		CartVO cartVO;

		for (int i = 0; i < checkedList.size(); i++) {
			cartVO = new CartVO();
			cartVO.setMember_id(checkedList.get(i).getMember_id());
			cartVO.setImage_url(checkedList.get(i).getImage_url());
			cartVO.setProduct_name(checkedList.get(i).getProduct_name());
			cartVO.setProduct_stock(checkedList.get(i).getProduct_stock());
			cartVO.setProduct_price(checkedList.get(i).getProduct_price());
			selectedList.add(cartVO);
		}
		cartService.addInCart(selectedList);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString("장바구니 담기 성공");

		return json;
	}
	
	// 장바구니에서 삭제
	@RequestMapping(value="cart/removeCartItem.do" ,method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String removeCartItem(@RequestParam("cart_id") int cart_id,
			                          HttpServletRequest request, HttpServletResponse response)  throws Exception{
		System.out.println("removeCart controller 접근");
		//ModelAndView mav=new ModelAndView();
		cartService.removeCartItem(cart_id);
		System.out.println("삭제 완료");
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString("장바구니 삭제 성공");
		//mav.setViewName("redirect:cart/myCartList.do");
		return json;
	}


}
