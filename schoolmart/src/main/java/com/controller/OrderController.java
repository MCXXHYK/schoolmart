package com.controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.domain.AlipayTradePayModel;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.dao.CommodityDao;
import com.dao.OrderDao;
import com.pojo.Commodity;
import com.pojo.Order;
import com.pojo.User;
import com.service.OrderService;
import com.utils.AlipayConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;


@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderDao orderDao;
    @Autowired
    private CommodityDao commodityDao;
    @Autowired
    private OrderService orderService;


    public static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


    /**
     * 查询我的订单
     *
     * @param session
     * @param model
     * @return
     */
    @RequestMapping("/findOrderList")
    public String findOrderList(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        Order order = new Order();
        order.setUid(user.getUid());
        List orderList = orderDao.pageOrder(order);
        order.setList(orderList);
        int total = orderDao.pageOrderTotal(order);
        order.SetPageSizeAndTotalCount(total);
        model.addAttribute("p", order);
        List<String> commodityType = commodityDao.selectCommodityType();
        model.addAttribute("btypes", commodityType);
        return "static/orderlist";
    }

    /**
     * 分页查询所有订单
     *
     * @param model
     * @param order
     * @param session
     * @return
     */
    @RequestMapping("/pageOrders")
    public String pageOrders(Model model, Order order, HttpSession session) {
        User user = (User) session.getAttribute("user");
        List orders = orderDao.pageOrder(order);
        order.setList(orders);
        int total = orderDao.pageOrderTotal(order);
        order.SetPageSizeAndTotalCount(total);
        model.addAttribute("p", order);
        if (user.getType() == 1) {
            return "static/ManageOrderList";
        } else {
            List<String> commodityType = commodityDao.selectCommodityType();
            model.addAttribute("btypes", commodityType);
            return "static/orderlist";
        }
    }

    /**
     * 直接购买商品
     *
     * @param order
     * @param bid
     * @return
     */
    @RequestMapping("/buycommodity")
    @ResponseBody
    public Map<String, Object> buycommodity(Order order, @RequestParam("bid") Integer bid) {
        Map<String, Object> hashmap = new HashMap<>();
        Commodity commodity = commodityDao.selectCommodityById(bid);
        Double bprice = commodity.bprice;
        Integer amount = order.getOamount();
        Integer bstock = commodity.bstock;
        Double ototal = bprice * amount;
        String bname = commodity.bname;
        order.setOtotal(ototal);
        order.setOdate(sdf.format(new Date()));
        order.setBname(bname);
        order.setBid(bid);
        order.setOstatus("未付款");
        if (amount <= bstock && bstock > 0) {
            orderDao.buycommodity(order);
            hashmap.put("status", true);
            hashmap.put("msg", "总计：" + ototal + "请付款");
        } else {
            hashmap.put("status", false);
            hashmap.put("msg", "库存不足，现有库存" + bstock);
        }
        return hashmap;
    }

    /**
     * 删除订单
     *
     * @param oid
     * @return
     */
    @RequestMapping("/delorder")
    @ResponseBody
    public Map<String, Object> delorder(Integer oid) {
        Map<String, Object> map = new HashMap<>();
        try {
            orderDao.delOrder(oid);
            map.put("status", true);
        } catch (Exception e) {
            map.put("status", false);
        }
        return map;
    }

    /**
     * 支付时订单信息回显,修改订单时订单信息回显
     *
     * @param oid
     * @return
     */
    @RequestMapping("/findOrderById")
    @ResponseBody
    public Order findOrderById(Integer oid) {
        return orderDao.findOrderById(oid);
    }


    /**
     * 支付宝支付
     *
     * @param order
     * @param response
     * @throws Exception
     */
    @RequestMapping("/alipay")
    @ResponseBody
    public void alipay(Order order, HttpServletResponse response) throws Exception {
        //
        Order order1 = orderDao.findOrderById(order.getOid());
        Integer bid = order1.getBid();
        Commodity commodity = commodityDao.selectCommodityById(bid);
        Double bprice = commodity.getBprice();
        Integer amount = order.getOamount();
        Double ototal = bprice * amount;
        order1.setAddress(order.getAddress());
        order1.setOamount(order.getOamount());
        order1.setTelnum(order.getTelnum());
        order1.setUemail(order.getUemail());
        order1.setOtotal(ototal);
        orderDao.payfor(order1);
        AlipayTradePayModel payModel = new AlipayTradePayModel();
        //商户订单号，商户网站订单系统中唯一订单号，必填
        payModel.setOutTradeNo(String.valueOf(order1.getOid()));
        payModel.setProductCode("FAST_INSTANT_TRADE_PAY");
        //付款金额，必填
        payModel.setTotalAmount(String.valueOf(order1.getOtotal()));
        //订单名称，必填
        payModel.setSubject(order1.getBname());
        //商品描述，可空
        payModel.setBody("支付宝支付，共" + order1.getOtotal() + "元");
        // 该笔订单允许的最晚付款时间，逾期将关闭交易。取值范围：1m～15d。m-分钟，h-小时，d-天，1c-当天（1c-当天的情况下，无论交易何时创建，都在0点关闭）。 该参数数值不接受小数点， 如 1.5h，可转换为 90m。
        payModel.setTimeoutExpress("10m");

        //获得初始化的AlipayClient
        AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);

        //设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(AlipayConfig.return_url);
        alipayRequest.setNotifyUrl(AlipayConfig.notify_url);

        alipayRequest.setBizModel(payModel);
        //请求
        String form = "";
        try {
            //form 支付页面
            form = alipayClient.pageExecute(alipayRequest).getBody(); //调用SDK生成表单
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        response.setContentType("text/html;charset=" + AlipayConfig.charset);
        response.getWriter().write(form);//直接将完整的表单html输出到页面
        response.getWriter().flush();
        response.getWriter().close();
    }

    /**
     * 支付宝回调同步跳转商户更新库存以及订单信息
     *
     * @param out_trade_no
     * @param total_amount
     * @param session
     * @param model
     * @return
     */
    @RequestMapping("/alipayReturnNotice")
    public String alipayReturnNotice(String out_trade_no, String total_amount, HttpSession session, Model model) {
        Order order1 = orderDao.findOrderById(Integer.valueOf(out_trade_no));
        Integer bid = order1.getBid();
        Commodity commodity = commodityDao.selectCommodityById(bid);
        Integer amount = order1.getOamount();
        Integer bstock = commodity.getBstock();
        order1.setOtotal(Double.valueOf(total_amount));
        order1.setOstatus("待发货");
        try {
            orderDao.payfor(order1);
            commodity.setBstock(bstock - amount);
            commodityDao.updateCommodity(commodity);
        } catch (Exception e) {
            e.printStackTrace();
        }
        User user = (User) session.getAttribute("user");
        Order order = new Order();
        order.setUid(user.getUid());
        List orderList = orderDao.pageOrder(order);
        order.setList(orderList);
        int total = orderDao.pageOrderTotal(order);
        order.SetPageSizeAndTotalCount(total);
        model.addAttribute("p", order);
        List<String> commodityType = commodityDao.selectCommodityType();
        model.addAttribute("btypes", commodityType);
        return "static/orderlist";
    }

    /**
     * 修改订单信息
     *
     * @param order
     * @return
     */
    @RequestMapping("/updateOrder")
    @ResponseBody
    public Map<String, Object> updateOrder(Order order) {
        Map<String, Object> hashmap = new HashMap<>();
        //
        Order order1 = orderDao.findOrderById(order.getOid());
        Integer bid = order1.getBid();
        Commodity commodity = commodityDao.selectCommodityById(bid);
        Double bprice = commodity.getBprice();
        Integer amount = order.getOamount();
        Integer amount1 = order1.getOamount();
        Integer bstock = commodity.getBstock();
        Double ototal = bprice * amount;
        Integer num = amount - amount1;
        order1.setOamount(amount);
        order.setAddress(order.getAddress());
        order1.setTelnum(order.getTelnum());
        order1.setUemail(order.getUemail());
        commodity.setBstock(bstock - num);
        order1.setOtotal(ototal);
        order1.setOstatus(order.getOstatus());
        try {
            if (commodity.getBstock() >= 0) {
                orderDao.payfor(order1);
                commodityDao.updateCommodity(commodity);
                hashmap.put("status", true);
                hashmap.put("msg", "修改成功");
            } else {
                hashmap.put("msg", "库存不足!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            hashmap.put("status", false);
            hashmap.put("msg", "修改失败");
        }
        return hashmap;
    }

    /**
     * 确认收货
     *
     * @param oid
     * @return
     */
    @RequestMapping("/makesure")
    @ResponseBody
    public Map<String, Object> makesure(Integer oid) {
        Map<String, Object> map = new HashMap<>();
        try {
            orderDao.makesure(oid);
            map.put("status", true);
            map.put("msg", "已确认收货");
        } catch (Exception e) {
            map.put("status", false);
            map.put("msg", "确认收货失败");
        }
        return map;
    }

    /**
     * 跳转购物车
     */
    @RequestMapping("/mycart")
    public String mycart(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        List<String> commodityType = commodityDao.selectCommodityType();
        model.addAttribute("btypes", commodityType);
        return "static/mycart";
    }

    /**
     * echart柱状图
     *
     * @return
     */
    @RequestMapping("/echart")
    @ResponseBody
    public Map<String, Object> echart() {
        Map<String, Object> res = new HashMap<>();
        List<Map<String, Object>> list = orderDao.groupOrder();
        List<String> titleList = new ArrayList<>();
        List<BigDecimal> dataList = new ArrayList<>();
        for (Map<String, Object> dataMap : list) {
            titleList.add((String) dataMap.get("btype"));
            dataList.add((BigDecimal) dataMap.get("oamount"));

        }
        res.put("titleList", titleList);
        res.put("dataList1", dataList);
        return res;
    }

    /**
     * echart 饼状图
     *
     * @return
     */
    @RequestMapping("/pie")
    @ResponseBody
    public Map<String, Object> pie() {
        Map<String, Object> res = new HashMap<>();
        List<Map<String, Object>> list = orderDao.sortOtotal();
        List<String> titleList = new ArrayList<>();
        List<Double> dataList = new ArrayList<>();
        for (Map<String, Object> dataMap : list) {
            titleList.add((String) dataMap.get("btype"));
            dataList.add((Double) dataMap.get("ototal"));

        }
        res.put("titleList", titleList);
        res.put("dataList2", dataList);
        return res;
    }

}