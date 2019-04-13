package com.spring2ljl.service;

import com.spring2ljl.pojo.Work;
import com.spring2ljl.utils.Page;
import org.springframework.ui.Model;

import java.util.List;

public interface WorkService {
    Page<Work> page(Integer page, Integer limit);
    void deleteByIds(List<Integer> ids);

    void update(Work work);

    void getMap(Model model);
}
