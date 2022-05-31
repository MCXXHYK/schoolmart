package com.service;

import com.pojo.Commodity;

import java.util.List;

public interface CommodityService {

    List<Commodity> selectAllCommoditys();

    int insertCommodity(Commodity commodity);

    int deleteCommodity(Commodity commodity);

    List<Commodity> selectCommodityByName(Commodity commodity);

    Commodity selectCommodityById(Integer bid);

}
