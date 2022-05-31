package com.service;

import com.dao.OrderDao;
import com.pojo.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("orderService")
@Transactional
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderDao orderDao;

    @Override
    public int buycommodity(Order order) {
        return orderDao.buycommodity(order);
    }

    @Override
    public List<Order> selectAllOrders(Integer uid) {
        return orderDao.selectAllOrders(uid);
    }
}
