package com.pojo;

import java.util.Objects;

public class Commodity extends Page {

    public Integer bid;
    public String bname;
    public Double bprice;
    public String btype;
    private String bcover;
    public Integer bstock;

    public Boolean bisHot;
    public Boolean isNew;
    public String bdetail;


    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof Commodity) {
            Commodity i = (Commodity) obj;
            if (this.getBid().equals(i.getBid())) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        return Objects.hash(bid);
    }

    public String getBdetail() {
        return bdetail;
    }

    public void setBdetail(String bdetail) {
        this.bdetail = bdetail;
    }

    public Boolean getBisHot() {
        return bisHot;
    }

    public void setBisHot(Boolean bisHot) {
        this.bisHot = bisHot;
    }

    public Boolean getIsNew() {
        return isNew;
    }

    public void setIsNew(Boolean isNew) {
        isNew = isNew;
    }


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

    public Double getBprice() {
        return bprice;
    }

    public void setBprice(Double bprice) {
        this.bprice = bprice;
    }


    public String getBtype() {
        return btype;
    }

    public void setBtype(String btype) {
        this.btype = btype;
    }


    public String getBcover() {
        return bcover;
    }

    public void setBcover(String bcover) {
        this.bcover = bcover;
    }

    public Integer getBstock() {
        return bstock;
    }

    public void setBstock(Integer bstock) {
        this.bstock = bstock;
    }
}
