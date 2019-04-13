package com.spring2ljl.controller;

import com.spring2ljl.Vo;
import com.spring2ljl.pojo.Info;
import com.spring2ljl.pojo.Work;
import com.spring2ljl.service.InfoService;
import com.spring2ljl.service.WorkService;
import com.spring2ljl.utils.DateUtil;
import com.spring2ljl.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;
import java.util.Date;
import java.util.Map;

@Controller
@RequestMapping("work")
public class WorkCtrl {
    @Autowired
    private WorkService workService;
    @RequestMapping("page")
    @ResponseBody
    public Vo page(@RequestParam(value ="page",defaultValue = "1") Integer page,@RequestParam(value ="limit",defaultValue = "10") Integer limit){
        Page<Work> workPage = workService.page(page, limit);
        return Vo.ret(workPage.getData(),workPage.getTotalCount());
    }
    @RequestMapping("delete")
    @ResponseBody
    public String delete(@RequestParam("ids[]")Integer[] ids){
        workService.deleteByIds(Arrays.asList(ids));
        return "1";
    }
    @RequestMapping("update")
    public String update(Work work){
        workService.update(work);
        return "work";
    }

}
