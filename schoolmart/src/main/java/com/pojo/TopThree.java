package com.pojo;

import com.utils.ExcelTitle;

public class TopThree {

    @ExcelTitle(title = "商品类型")
    private String btype;

    @ExcelTitle(title = "（前三）销售总金额")
    private double ototal;

    public String getBtype() {
        return btype;
    }

    public void setBtype(String btype) {
        this.btype = btype;
    }

    public double getOtotal() {
        return ototal;
    }

    public void setOtotal(double ototal) {
        this.ototal = ototal;
    }
}
