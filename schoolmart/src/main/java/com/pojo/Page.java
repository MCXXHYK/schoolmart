package com.pojo;

import java.util.List;

public class Page {

    private Integer start = 0;
    private Integer pageNumber;
    private Integer pageSize = 10;
    private Integer totalCount;
    private Integer totalPage;
    private List<Object> list;

    public List<Object> getList() {
        return list;
    }

    public void setList(List<Object> list) {
        this.list = list;
    }

    public Integer getStart() {
        if (pageNumber == null) {
            pageNumber = 1;
        }
        if (pageSize == null) {
            pageSize = 10;
        }
        return (pageNumber - 1) * pageSize;
    }

    public void setStart(Integer start) {
        this.start = start;
    }

    public Integer getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(Integer pageNumber) {
        this.pageNumber = pageNumber;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

    public Integer getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }

    public void SetPageSizeAndTotalCount(int totalCount) {
        this.totalCount = totalCount;
        totalPage = (int) Math.ceil((double) totalCount / pageSize);
    }
}
