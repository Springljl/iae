package com.spring2ljl.utils;

import java.util.ArrayList;
import java.util.List;

public class Page<T> {
    private Integer pageNo;
    private Integer pageSize;
    private Integer totalCount;
    private Integer totalPage;
    private List<T> data = new ArrayList<>();

    public Page(Integer pageNo, Integer pageSize, Integer totalCount) {
        this.totalCount = totalCount;
        this.pageSize = pageSize;
        this.totalPage = (int) Math.ceil((double) totalCount / pageSize);
        this.pageNo = pageNo;
        if (pageNo <= 1) {
            this.pageNo = 1;
        } else if (pageNo >= totalPage) {
            this.pageNo = totalPage;
        }
    }

    public Integer getPageNo() {
        return pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
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

    public List<T> getData() {
        return data;
    }

    public void setData(List<T> data) {
        this.data = data;
    }
}