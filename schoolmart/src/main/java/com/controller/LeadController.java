package com.controller;

import com.dao.CommentDao;
import com.dao.CommodityDao;
import com.dao.OrderDao;
import com.dao.UserDao;
import com.pojo.Comment_info;
import com.pojo.Commodity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/lead")
public class LeadController {

    @Autowired
    private UserDao userDao;
    @Autowired
    private CommodityDao commodityDao;
    @Autowired
    private CommentDao commentDao;
    @Autowired
    private OrderDao orderDao;


    /**
     * 返回首页
     *
     * @param model
     * @return
     */
    @RequestMapping("/index")
    public String index(Model model) {
        List<String> commodityType = commodityDao.selectCommodityType();
        model.addAttribute("btypes", commodityType);
        List<Commodity> commodityList = commodityDao.selectHotGoods();
        model.addAttribute("scrollCommodity1", commodityList.get(0));
        model.addAttribute("scrollCommodity2", commodityList.get(1));
        model.addAttribute("scrollCommodity3", commodityList.get(2));
        model.addAttribute("commodityList", commodityList);
        return "index";
    }


    /**
     * 商品详情
     *
     * @param bid
     * @param model
     * @return
     */
    @RequestMapping("/detail")
    public String detail(Integer bid, Model model) {
        List<String> commodityType = commodityDao.selectCommodityType();
        model.addAttribute("btypes", commodityType);
        Commodity goods = commodityDao.selectCommodityById(bid);
        List<Comment_info> commentInfoList = commentDao.queryComment(goods.bname);
        model.addAttribute("goods", goods);
        model.addAttribute("commentList", commentInfoList);
        return "detail";
    }

    /**
     * 跳转管理员页面首页
     *
     * @param model
     * @return
     */
    @RequestMapping("/manage")
    public String manage(Model model) {
        //获取用户总数
        Integer totalUser = userDao.count() == null ? 0 : userDao.count();
        //获取评论总数
        Integer totalComment = commentDao.count() == null ? 0 : commentDao.count();
        //获取总销售额
        Double totPrice = orderDao.totalPrice() == null ? 0 : orderDao.totalPrice();
        //获取总销量
        Integer totalShopping = orderDao.totalShopping() == null ? 0 : orderDao.totalShopping();
        model.addAttribute("totalUser", totalUser);
        model.addAttribute("totalComment", totalComment);
        model.addAttribute("totPrice", totPrice);
        model.addAttribute("totalShopping", totalShopping);
        return "manager";
    }
}
