package com.controller;


import com.pojo.Commodity;
import com.pojo.Cart;
import com.pojo.User;
import com.service.CommodityService;
import com.service.CartService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;


@Controller
@RequestMapping("/cart")
public class CartController {

    @Resource
    private CommodityService commodityService;
    @Resource
    private CartService cartService;

    /**
     * 将商品添加至购物车（"默认初始数量为 1"）
     *
     * @param bid
     * @param number
     * @param session
     * @return
     */
    @RequestMapping("/addGoodsInCart")
    public String addGoodsInCart(Integer bid, Integer number, HttpSession session) {
        Commodity commodity = commodityService.selectCommodityById(bid);
        Cart cart = null;
        if (session.getAttribute("cart") != null) {
            cart = (Cart) session.getAttribute("cart");
        } else {
            cart = new Cart();
        }
        cart = cartService.addGoodsInCart(commodity, number, cart);
        session.setAttribute("cart", cart);
        return "redirect:/order/mycart";
    }

    /**
     * 购物车删除功能，更新购物车中商品
     *
     * @param bid
     * @param session
     * @return
     */
    @RequestMapping("/removeGoodsFromCart")
    public String removeGoodsFromCart(Integer bid, HttpSession session) {
        Commodity commodity = commodityService.selectCommodityById(bid);
        Cart cart = (Cart) session.getAttribute("cart");
        cart = cartService.removeGoodsFromCart(commodity, cart);
        session.setAttribute("cart", cart);
        return "redirect:/order/mycart";
    }

    /**
     * 清空购物车，并跳转至购物车页面
     *
     * @param session
     * @return
     */
    @RequestMapping("/cleanCart")
    public String cleanCart(HttpSession session) {
        Cart cart = null;
        session.setAttribute("cart", cart);
        return "redirect:/order/mycart";
    }


    /**
     * 结算购物车，跳转至订单页面
     *
     * @param session
     * @return
     */
    @RequestMapping("/accountCart")
    public String accountCart(HttpSession session) {

        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");
        cartService.accountCart(cart, user);
        cart = null;
        session.setAttribute("cart", cart);

        return "redirect:/order/findOrderList";
    }
  /*  @ResponseBody
    @RequestMapping(value = "/checkStore",produces={"text/html;charset=UTF-8;","application/json;"})
    public String checkStore(HttpSession session){
        Cart cart =(Cart)session.getAttribute("cart");
        Map<Book, Integer> map=cart.getGoods();
        Iterator<Map.Entry<Book, Integer>> iter = map.entrySet().iterator();
        while (iter.hasNext()) {
            Map.Entry<Book, Integer> entry =  iter.next();
            Book book = entry.getKey();
            Integer number = entry.getValue();
            if (!bookService.checkStore(book.getBid(),number)){
                return "《"+book.getBname()+"》库存不足,库存剩余:"+book.getStore();
            }
        }
        return "success";
    }*/
}
