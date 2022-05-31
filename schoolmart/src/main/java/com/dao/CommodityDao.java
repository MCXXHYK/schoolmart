package com.dao;

import com.pojo.Commodity;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("commodityDao")
@Mapper
public interface CommodityDao {

    List<Commodity> selectAllCommoditys();

    int insertCommodity(Commodity commodity);

    int deleteCommodity(Commodity commodity);

    List<Commodity> selectCommodityByName(Commodity commodity);

    Commodity selectCommodityById(Integer bid);

    void updateCommodity(Commodity commodity);

    List<String> selectCommodityType();

    List<Commodity> selectCommodityByType(String btype);

    List<Commodity> selectHotGoods();

    List pageGoods(Commodity commodity);

    int pageGoodsTotal(Commodity bcommodityook);
}
