package com.service;


import com.pojo.Order;

import java.util.List;

public interface OrderService {

    int buycommodity(Order order);

    List<Order> selectAllOrders(Integer uid);
}
