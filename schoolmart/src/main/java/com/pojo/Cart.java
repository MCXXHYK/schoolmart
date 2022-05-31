package com.pojo;

import java.util.HashMap;


//购物车类
public class Cart {

    //购买商品的集合
    private HashMap<Commodity, Integer> goods;

    //购物车的总金额
    private double totalPrice;

    //构造方法
    public Cart() {
        goods = new HashMap<Commodity, Integer>();
        totalPrice = 0.0;
    }

    public Cart(HashMap<Commodity, Integer> goods, double totalPrice) {
        super();
        this.goods = goods;
        this.totalPrice = totalPrice;
    }

    public HashMap<Commodity, Integer> getGoods() {
        return goods;
    }

    public void setGoods(HashMap<Commodity, Integer> goods) {
        this.goods = goods;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

}
