package com.controller;


import com.dao.CommentDao;
import com.dao.CommodityDao;
import com.dao.UserDao;
import com.pojo.Comment_info;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private UserDao userDao;
    @Autowired
    private CommodityDao commodityDao;
    @Autowired
    private CommentDao commentDao;

    public static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    /**
     * 添加评论
     *
     * @param comment
     * @return
     */
    @RequestMapping("/addComment")
    @ResponseBody
    public Map<String, Object> addComment(Comment_info comment) {
        Map<String, Object> map = new HashMap<>();
        comment.setCreateTime(DATE_FORMAT.format(new Date()));
        try {
            commentDao.InsertIntoComment(comment);
            map.put("status", true);
            map.put("msg", "评价成功！！！");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("status", false);
            map.put("msg", "评价失败");
        }
        return map;
    }

    /**
     * 分页显示我的商品评价
     *
     * @param model
     * @param comment
     * @return
     */
    @RequestMapping("/PageEvaluation")
    public String PageEvaluation(Model model, Comment_info comment) {
        List comments = commentDao.pageComments(comment);
        comment.setList(comments);

        int total = commentDao.pageCommentsTotal(comment);
        comment.SetPageSizeAndTotalCount(total);
        model.addAttribute("p", comment);
        List<String> commodityType = commodityDao.selectCommodityType();
        model.addAttribute("btypes", commodityType);
        return "myEvaluation";
    }

    /**
     * 分页显示所有商品评价
     *
     * @param model
     * @param comment
     * @return
     */
    @RequestMapping("/managePageEvaluation")
    public String myPageEvaluation(Model model, Comment_info comment) {
        List comments = commentDao.pageComments(comment);
        comment.setList(comments);
        int total = commentDao.pageCommentsTotal(comment);
        comment.SetPageSizeAndTotalCount(total);
        model.addAttribute("p", comment);
        return "static/commentmanager";
    }

    /**
     * 删除评价
     *
     * @param comment_info
     * @return
     */
    @RequestMapping("/deleteComment")
    @ResponseBody
    public Map<String, Object> deleteComment(Comment_info comment_info) {
        Map<String, Object> map = new HashMap<>();
        try {
            commentDao.deleteComment(comment_info);
            map.put("status", true);
            map.put("msg", "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("status", false);
            map.put("msg", "删除失败");

        }
        return map;
    }

}
