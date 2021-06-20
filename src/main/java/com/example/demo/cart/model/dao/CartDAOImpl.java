package com.example.demo.cart.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.example.demo.cart.model.dto.CartVO;

//@Repository("cartDAO")
@Repository
public class CartDAOImpl implements CartDAO{

	//private String nameSpace = "cart."; 
	
	@Autowired
	private SqlSession sqlSession;
	public void insertInCart(ArrayList<CartVO> selectedList) throws DataAccessException{
		for(int i=0; i<selectedList.size(); i++) {
			System.out.println("insertInCart 접근 후 " + i);
			int cart_id=selectMaxCartId();
			System.out.println("cart_id: " + cart_id);
			selectedList.get(i).setCart_id(cart_id);
			System.out.println("vo : " + selectedList.get(i));
			sqlSession.insert("cart.insertItemsInCart",selectedList.get(i));
		}
	}
	@Override
	public int selectMaxCartId() throws DataAccessException{
		System.out.println("selectMaxCartId 접근");
		int cart_id = sqlSession.selectOne("cart.selectMaxCartId");
		return cart_id;
	}
	
	// 리스트 전체 뽑기(해당 member_id와 일치하는) 
	@Override
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException {
		System.out.println("selectCartList 접근");
		List<CartVO> myCartList;
		myCartList = sqlSession.selectList("cart.selectCartList",cartVO);
		System.out.println("db cart 목록 사이즈: " + myCartList.size());
		//System.out.println(myCartList.get(3).getMember_id());
		//System.out.println(myCartList.get(3).getCart_id());
		//System.out.println(myCartList.get(3).getProduct_name());
		
		return myCartList;
	}
	
	public void deleteCartItem(int cart_id) throws DataAccessException{
		System.out.println("deleteCartItem DAO 접근");
		sqlSession.delete("cart.deleteCartItem",cart_id);
	}
	
	
}
