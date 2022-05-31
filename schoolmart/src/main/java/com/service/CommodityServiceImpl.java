package com.service;

import com.dao.CommodityDao;
import com.pojo.Commodity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("commodityService")
@Transactional
public class CommodityServiceImpl implements CommodityService {

    @Autowired
    private CommodityDao commodityDao;

    @Override
    public List<Commodity> selectAllCommoditys() {
        return commodityDao.selectAllCommoditys();
    }

    @Override
    public int insertCommodity(Commodity commodity) {
        return commodityDao.insertCommodity(commodity);
    }

    @Override
    public int deleteCommodity(Commodity commodity) {
        return commodityDao.deleteCommodity(commodity);
    }

    @Override
    public List<Commodity> selectCommodityByName(Commodity commodity) {
        return commodityDao.selectCommodityByName(commodity);
    }

    @Override
    public Commodity selectCommodityById(Integer bid) {
        return commodityDao.selectCommodityById(bid);
    }
}
