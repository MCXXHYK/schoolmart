package com.dao;


import com.pojo.Order;
import com.pojo.TopThree;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("orderDao")
@Mapper
public interface OrderDao {

    int buycommodity(Order order);

    List<Order> selectAllOrders(Integer uid);

    int delOrder(Integer oid);

    Order findOrderById(Integer oid);

    int payfor(Order order);

    List<Order> selectAll();

    List<Order> selectOrderByEmail(String uemail);

    int makesure(Integer oid);

    List pageOrder(Order order);

    int pageOrderTotal(Order order);

    Double totalPrice();

    Integer totalShopping();

    List<Map<String, Object>> groupOrder();

    List<Map<String, Object>> sortOtotal();

    List<TopThree> topThree();
}
