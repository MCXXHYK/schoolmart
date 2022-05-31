package com.service;


import com.pojo.Commodity;
import com.pojo.Cart;
import com.pojo.User;

public interface CartService {

    Cart addGoodsInCart(Commodity commodity, int number, Cart cart);

    Cart removeGoodsFromCart(Commodity commodity, Cart cart);

    Cart calTotalPrice(Cart cart);

    void accountCart(Cart cart, User user);

}
