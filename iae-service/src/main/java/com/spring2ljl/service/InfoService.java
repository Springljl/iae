package com.spring2ljl.service;

import com.spring2ljl.pojo.Info;
import com.spring2ljl.utils.Page;

import java.util.List;
import java.util.Map;

public interface InfoService {
    Page<Info> page(Integer page, Integer limit);

    void deleteByIds(List<Integer> ids);

    void update(Info info);

    Map all(String v);

    Map charts();
}
