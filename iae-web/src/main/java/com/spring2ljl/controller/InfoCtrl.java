package com.spring2ljl.controller;

import com.spring2ljl.Vo;
import com.spring2ljl.pojo.Info;
import com.spring2ljl.service.InfoService;
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
@RequestMapping("info")
public class InfoCtrl {
    @Autowired
    private InfoService infoService;
    @RequestMapping("page")
    @ResponseBody
    public Vo page(@RequestParam(value ="page",defaultValue = "1") Integer page,@RequestParam(value ="limit",defaultValue = "10") Integer limit){
        Page<Info> infoPage = infoService.page(page, limit);
        return Vo.ret(infoPage.getData(),infoPage.getTotalCount());
    }
    @RequestMapping("delete")
    @ResponseBody
    public String delete(@RequestParam("ids[]")Integer[] ids){
        infoService.deleteByIds(Arrays.asList(ids));
        return "1";
    }
    @RequestMapping("update")
    public String update(Info info){
        infoService.update(info);
        return "table";
    }
    @RequestMapping("month")
    public String month(){
        return "month";
    }
    @RequestMapping("time")
    @ResponseBody
    public Map month(@RequestParam(value = "v",defaultValue = "") String v){
        if ("".equals(v)){
            v= DateUtil.format(new Date());
        }
        Map data=infoService.all(v);
        return data;
    }
    @RequestMapping("charts")
    @ResponseBody
    public Map charts(){
        Map map=infoService.charts();
        return map;
    }
}
