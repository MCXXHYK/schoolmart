package com.pojo;

import com.utils.ExcelTitle;

public class Order extends Page {

    @ExcelTitle(title = "订单号")
    private Integer oid;
    @ExcelTitle(title = "订单总金额")
    private Double ototal;
    @ExcelTitle(title = "购买数量")
    private Integer oamount;
    @ExcelTitle(title = "订单状态")
    private String ostatus;
    @ExcelTitle(title = "用户ID")
    private Integer uid;
    @ExcelTitle(title = "用户邮箱")
    private String uemail;
    @ExcelTitle(title = "用户电话号码")
    private String telnum;
    @ExcelTitle(title = "用户收货地址")
    private String address;
    @ExcelTitle(title = "订单生成时间")
    private String odate;
    @ExcelTitle(title = "商品名称")
    private String bname;
    @ExcelTitle(title = "商品ID")
    private Integer bid;

    public Integer getBid() {
        return bid;
    }

    public void setBid(Integer bid) {
        this.bid = bid;
    }

    public String getBname() {
        return bname;
    }

    public void setBname(String bname) {
        this.bname = bname;
    }

    public Integer getOid() {
        return oid;
    }

    public void setOid(Integer oid) {
        this.oid = oid;
    }

    public Double getOtotal() {
        return ototal;
    }

    public void setOtotal(Double ototal) {
        this.ototal = ototal;
    }

    public Integer getOamount() {
        return oamount;
    }

    public void setOamount(Integer oamount) {
        this.oamount = oamount;
    }

    public String getOstatus() {
        return ostatus;
    }

    public void setOstatus(String ostatus) {
        this.ostatus = ostatus;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getUemail() {
        return uemail;
    }

    public void setUemail(String uemail) {
        this.uemail = uemail;
    }

    public String getTelnum() {
        return telnum;
    }

    public void setTelnum(String telnum) {
        this.telnum = telnum;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getOdate() {
        return odate;
    }

    public void setOdate(String odate) {
        this.odate = odate;
    }
}
