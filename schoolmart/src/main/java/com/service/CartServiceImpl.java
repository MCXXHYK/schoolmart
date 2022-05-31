package com.service;


import com.dao.CommodityDao;
import com.dao.OrderDao;
import com.pojo.Commodity;
import com.pojo.Cart;
import com.pojo.Order;
import com.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;


@Service
@Transactional(rollbackFor = Exception.class)
public class CartServiceImpl implements CartService {

    @Autowired
    private OrderDao orderDao;
    @Autowired
    private CommodityDao commodityDao;

    public static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


    /**
     * 结算购物车生成订单
     *
     * @param cart
     * @param user
     */
    public void accountCart(Cart cart, User user) {
        HashMap<Commodity, Integer> goods = cart.getGoods();
        for (Commodity commodity : goods.keySet()) {
            int amount = goods.getOrDefault(commodity, 0);
            if (amount > 0) {
                Commodity commodityNow = commodityDao.selectCommodityById(commodity.getBid());
                Order order = new Order();
                Double bprice = commodity.bprice;
                Integer bstock = commodityNow.bstock;
                Double ototal = bprice * amount;
                String bname = commodity.bname;
                order.setOtotal(ototal);
                order.setOamount(amount);
                order.setOdate(DATE_FORMAT.format(new Date()));
                order.setUid(user.getUid());
                order.setUemail(user.getUemail());
                order.setAddress(user.getAddress());
                order.setTelnum(user.getTelnum());
                order.setBname(bname);
                order.setBid(commodity.getBid());
                order.setOstatus("未付款");
                if (amount <= bstock && bstock > 0) {
                    orderDao.buycommodity(order);
                } else {
                    throw new RuntimeException(commodity.getBname() + "库存不足，当前库存为：" + bstock);
                }
            }
        }
    }

    /**
     * 购物车商品数量添加
     *
     * @param commodity
     * @param number
     * @param cart
     * @return
     */
    @Override
    public Cart addGoodsInCart(Commodity commodity, int number, Cart cart) {

        HashMap<Commodity, Integer> goods = cart.getGoods();
        if (goods.containsKey(commodity)) {
            goods.put(commodity, goods.get(commodity) + number);
        } else {
            goods.put(commodity, number);
        }
        //重新计算购物车的总金额
        return calTotalPrice(cart);
    }

    /**
     * 删除购物车商品
     *
     * @param commodity
     * @param cart
     * @return
     */
    @Override
    public Cart removeGoodsFromCart(Commodity commodity, Cart cart) {

        HashMap<Commodity, Integer> goods = cart.getGoods();
        goods.remove(commodity);
        cart.setGoods(goods);
        //重新计算购物车的总金额
        return calTotalPrice(cart);
    }

    /**
     * 计算购物车总金额
     *
     * @param cart
     * @return
     */
    @Override
    public Cart calTotalPrice(Cart cart) {
        HashMap<Commodity, Integer> goods = cart.getGoods();
        double sum = 0.0;
        Set<Commodity> keys = goods.keySet(); //获得键的集合
        Iterator<Commodity> it = keys.iterator(); //获得迭代器对象
        while (it.hasNext()) {
            Commodity i = it.next();
            sum += i.getBprice() * goods.get(i);
        }
        cart.setTotalPrice(sum);
        return cart;
    }
}
