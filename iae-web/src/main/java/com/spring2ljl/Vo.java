package com.spring2ljl;

import lombok.Data;

@Data
public class Vo<T> {
    private String code;
    private Integer count;
    private T data;

    private Vo(){}
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public static<T> Vo ret(T data,Integer count){
        Vo<Object> vo = new Vo<>();
        vo.setCode("0");
        vo.setCount(count);
        vo.setData(data);
        return vo;
    }
}
