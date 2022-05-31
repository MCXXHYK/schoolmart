package com.controller;

import com.dao.CommodityDao;
import com.pojo.Commodity;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/commodity")
public class CommodityController {

    @Autowired
    private CommodityDao commodityDao;

    /**
     * 分页查询商品
     *
     * @param model
     * @param commodity
     * @return
     */
    @RequestMapping("/pageGoods")
    public String pageUser(Model model, Commodity commodity) {
        List goods = commodityDao.pageGoods(commodity);
        commodity.setList(goods);
        int total = commodityDao.pageGoodsTotal(commodity);
        commodity.SetPageSizeAndTotalCount(total);
        model.addAttribute("p", commodity);
        return "static/commoditylist";
    }


    /**
     * 添加商品
     *
     * @param commodity
     * @param bimg
     * @param session
     * @return
     */
    @RequestMapping("/insertcommodity")
    @ResponseBody
    public Map<String, Object> insertcommodity(Commodity commodity, @RequestParam("bimg") MultipartFile bimg, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        try {
            //获取upload的绝对路径
            String path = session.getServletContext().getRealPath("upload");
            System.out.println(path);
            //创建路径为path的目标文件名为商品的原始名称，并把图片放进去
            File targetFile = new File(path, bimg.getOriginalFilename());
            bimg.transferTo(targetFile);
            //把图片bcover更改为上传图片名，保存商品信息到数据库
            commodity.setBcover(bimg.getOriginalFilename());
            commodityDao.insertCommodity(commodity);
            map.put("status", true);
            map.put("msg", "添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("status", false);
            map.put("msg", "添加失败");
        }
        return map;
    }

    /**
     * 删除商品
     *
     * @param commodity
     * @return
     */
    @RequestMapping("/deleteCommodity")
    @ResponseBody
    public Map<String, Object> deletecommodity(Commodity commodity) {
        Map<String, Object> map = new HashMap<>();
        try {
            commodityDao.deleteCommodity(commodity);
            map.put("status", true);
            map.put("msg", "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("status", false);
            map.put("msg", "删除失败");

        }
        return map;
    }

    /**
     * 前台根据商品名模糊查找商品
     *
     * @param commodity
     * @param model
     * @param session
     * @return
     */
    @RequestMapping("/selectbyname")
    public String selectbyname(Commodity commodity, Model model, HttpSession session) {
        List<Commodity> commodity1 = commodityDao.selectCommodityByName(commodity);
        model.addAttribute("commodity1", commodity1);
        List<String> commodityType = commodityDao.selectCommodityType();
        model.addAttribute("btypes", commodityType);
        return "commodityindexselect";
    }

    /**
     * 商品信息回显
     *
     * @param bid
     * @return
     */
    @RequestMapping("/findOne")
    @ResponseBody
    public Commodity findOne(Integer bid) {
        return commodityDao.selectCommodityById(bid);
    }

    /**
     * 修改商品信息
     *
     * @param commodity
     * @return
     */
    @RequestMapping("/updateCommodity")
    @ResponseBody
    public Map<String, Object> updatecommodity(Commodity commodity) {
        Map<String, Object> map = new HashMap<>();
        try {
            commodityDao.updateCommodity(commodity);
            map.put("status", true);
            map.put("msg", "更新商品信息成功");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("status", false);
            map.put("msg", "更新失败");

        }
        return map;
    }

    /**
     * 分类查询商品
     *
     * @param btype
     * @param model
     * @return
     */
    @RequestMapping("/selectbytype")
    public String selectCommoditybytype(String btype, Model model) {
        List<Commodity> commoditycol = commodityDao.selectCommodityByType(btype);
        model.addAttribute("commoditycol", commoditycol);
        List<String> commodityType = commodityDao.selectCommodityType();
        model.addAttribute("btypes", commodityType);
        return "commoditytypelist";
    }
}
