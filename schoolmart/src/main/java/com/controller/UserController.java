package com.controller;

import com.dao.CommentDao;
import com.dao.CommodityDao;
import com.dao.OrderDao;
import com.dao.UserDao;
import com.pojo.Commodity;
import com.pojo.User;
import com.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserDao userDao;
    @Autowired
    private CommodityDao commodityDao;
    @Autowired
    private CommentDao commentDao;
    @Autowired
    private OrderDao orderDao;
    @Autowired
    private UserService userService;


    @RequestMapping("/tologin")
    public String tologin() {
        return "logintest";
    }

    /**
     * 用户登录
     *
     * @param user
     * @param model
     * @param session
     * @return
     */
    @RequestMapping("/login")
    public String login(User user, Model model, HttpSession session) {
        User user1 = userDao.login(user);
        if (user1 == null || user1.equals("")) {
            model.addAttribute("message", "用户名和密码错误");
            return "logintest";
        }
        if (user1.getType() == 1) {
            //获取用户总数
            Integer totalUser = userDao.count() == null ? 0 : userDao.count();
            //获取评论总数
            Integer totalComment = commentDao.count() == null ? 0 : commentDao.count();
            //获取总销售额
            Double totPrice = orderDao.totalPrice() == null ? 0 : orderDao.totalPrice();
            //获取总销量
            Integer totalShopping = orderDao.totalShopping() == null ? 0 : orderDao.totalShopping();
            List<String> commodityType = commodityDao.selectCommodityType();
            model.addAttribute("btypes", commodityType);
            session.setAttribute("user", user1);
            model.addAttribute("totalUser", totalUser);
            model.addAttribute("totalComment", totalComment);
            model.addAttribute("totPrice", totPrice);
            model.addAttribute("totalShopping", totalShopping);
            return "manager";
        } else if(user1.getType() == 0){
            List<String> commodityType = commodityDao.selectCommodityType();
            model.addAttribute("btypes", commodityType);
            List<Commodity> commodityList = commodityDao.selectHotGoods();
            model.addAttribute("commodityList", commodityList);
            model.addAttribute("scrollCommodity1", commodityList.get(0));
            model.addAttribute("scrollCommodity2", commodityList.get(1));
            model.addAttribute("scrollCommodity3", commodityList.get(2));
            session.setAttribute("user", user1);
            return "index";
        }else {
            model.addAttribute("message", "用户类型有误！");
            return "logintest";
        }
    }

    /**
     * 用户注册
     *
     * @param user
     * @return
     */
    @RequestMapping("/register")
    @ResponseBody
    public Map<String, Object> register(User user) {
        Map<String, Object> map = new HashMap<>();
        User users = userDao.selectUserByEmail(user.getUemail());
        if (users != null) {
            map .put("status", "same");
            map.put("msg", "用户名相同，请更换您的用户名重新注册！");
        } else {
            try {
                userDao.registeruser(user);
                map.put("status", true);
                map.put("msg", "注册成功！请登录！");
            } catch (Exception e) {
                map.put("status", false);
                map.put("msg", "注册失败！");
            }
        }
        return map;
    }

    /**
     * 返回管理员界面
     *
     * @return
     */
    @RequestMapping("/manager")
    public String toManager() {
        return "manager";
    }

    /**
     * 退出登录
     *
     * @param session
     * @return
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "logintest";
    }

    /**
     * 跳转普通用户修改密码界面
     *
     * @return
     */
    @RequestMapping("/toupdateupwd")
    public String updatePwd() {
        return "static/updatepwd";
    }

    /**
     * 跳转管理员修改密码界面
     *
     * @return
     */
    @RequestMapping("/toupdateadminupwd")
    public String updateadminPwd() {
        return "updateadminpwd";
    }

    /**
     * 修改用户密码
     *
     * @param uid
     * @param password
     * @param newPassword
     * @return
     */
    @RequestMapping("/updateupwd")
    @ResponseBody
    public String updatePwd(Integer uid, String password, String newPassword) {
        if (password == null || password.equals("")) {
            return "pwdEmpty";
        }

        if (newPassword == null || newPassword.equals("")) {
            return "newEmpty";
        }
        boolean flag = userService.UpdatePassword(uid, password, newPassword);
        if (flag) {
            return "success";
        }
        return "false";
    }

    /**
     * 忘记密码
     *
     * @return
     */
    @PostMapping("/forgetupwd")
    @ResponseBody
    public String forgetupwd(Integer uid, String newPassword) {
        if (uid == null || uid.equals("")) {
            return "uidEmpty";
        }

        if (newPassword == null || newPassword.equals("")) {
            return "newEmpty";
        }
        boolean flag = userDao.forgetupwd(uid, newPassword);
        if (flag) {
            return "success";
        }
        return "false";
    }

    /**
     * 管理员修改个人信息
     *
     * @param model
     * @param session
     * @return
     */
    @RequestMapping("/userinfo")
    public String userinfo(Model model, HttpSession session) {
        User user1 = (User) session.getAttribute("user");
        User user0 = userDao.selectUserInfo(user1.getUid());
        model.addAttribute("user0", user0);
        return "static/myinfo";
    }

    /**
     * 普通用户修改个人信息
     *
     * @param model
     * @param session
     * @return
     */
    @RequestMapping("/indexuserinfo")
    public String indexuserinfo(Model model, HttpSession session) {
        List<String> commodityType = commodityDao.selectCommodityType();
        model.addAttribute("btypes", commodityType);
        User user1 = (User) session.getAttribute("user");
        User user0 = userDao.selectUserInfo(user1.getUid());
        model.addAttribute("user0", user0);
        return "static/indexmyinfo";
    }

    /**
     * 购买商品时用户信息回显
     *
     * @param uid
     * @return
     */
    @RequestMapping("/findUserById")
    @ResponseBody
    public User findUserById(Integer uid) {
        return userDao.selectUserInfo(uid);
    }

    /**
     * 分页查询用户数据
     *
     * @param model
     * @param user
     * @return
     */
    @RequestMapping("/pageUser")
    public String pageUser(Model model, User user) {
        List users = userDao.pageUser(user);
        user.setList(users);
        int total = userDao.pageUserTotal(user);
        user.SetPageSizeAndTotalCount(total);
        model.addAttribute("p", user);
        return "static/usercontent";
    }

    /**
     * 更新用户信息
     *
     * @param user
     * @return
     */
    @RequestMapping("/updateUserInfo")
    @ResponseBody
    public Map<String, Object> updateadmin(User user) {
        Map<String, Object> map = new HashMap<>();
        try {
            userDao.updateadmin(user);
            map.put("status", true);
            map.put("msg", "修改信息成功");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("status", false);
            map.put("msg", "修改信息失败");
        }
        return map;
    }

    /**
     * 删除用户
     *
     * @param uid
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody//将控制器方法返回值转为json 并响应给对应请求
    public Map<String, Object> delete(Integer uid) {
        Map<String, Object> map = new HashMap<>();
        try {
            userDao.delete(uid);
            map.put("status", true);
            map.put("msg", "删除用户信息成功！");

        } catch (Exception e) {
            e.printStackTrace();
            map.put("status", false);
            map.put("msg", "删除用户信息失败！");
        }
        return map;
    }


}
