package com.controller;


import com.dao.CommodityDao;
import com.dao.OrderDao;
import com.pojo.Order;
import com.pojo.TopThree;
import com.pojo.User;
import com.utils.ExcelPoi;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/Excel")
public class ExcelController {

    @Autowired
    private OrderDao orderDao;
    @Autowired
    private CommodityDao commodityDao;

    /**
     * 导出
     *
     * @param response
     * @param search
     * @return
     */
    @RequestMapping(value = "/exportTopThreeList", produces = "text/html;charset=UTF-8;")
    @ResponseBody
    public String exportTopThreeAllList(HttpServletResponse response, String search) {
        try {

            List<TopThree> topThree = orderDao.topThree();
            //customService.getCustomList();
            String[] titles = {"商品类型", "（前三）销售总金额"};
            String filename = "销量前三表";

            ExcelPoi.exportObject(response, topThree, titles, filename);
        } catch (Exception e) {
            //log.error(e);
        }
        return "";
    }

    @RequestMapping(value = "/exportOrderAllList", produces = "text/html;charset=UTF-8;")
    @ResponseBody
    public String exportOrderAllList(HttpServletResponse response, String search) {
        try {

            List<Order> orders = orderDao.selectAll();
            //customService.getCustomList();
            String[] titles = {"订单号", "订单总金额", "购买数量", "", "订单状态", "用户ID", "用户邮箱", "用户电话号码", "用户收货地址", "订单生成时间", "商品名称", "商品ID"};
            String filename = "订单数据表";
            ExcelPoi.exportObject(response, orders, titles, filename);
        } catch (Exception e) {
            //log.error(e);
        }
        return "";
    }
}


