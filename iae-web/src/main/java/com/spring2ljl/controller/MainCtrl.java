package com.spring2ljl.controller;

import com.spring2ljl.IpUtil;
import com.spring2ljl.UserContext;
import com.spring2ljl.pojo.User;
import com.spring2ljl.service.UserService;
import com.spring2ljl.service.WorkService;
import com.spring2ljl.utils.Md5Util;
import com.spring2ljl.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.jws.WebParam;
import javax.servlet.http.HttpServletRequest;

@Controller
public class MainCtrl {
    @Autowired
    private UserService userService;
    @Autowired
    private WorkService workService;
    @RequestMapping("")
    public String index(){
        return "index";
    }
    @RequestMapping("auth")
    @ResponseBody
    public String auth(User user){
        String stirng = StringUtil.randomStirng(32);
        String md5 = Md5Util.string2MD5(user.getPassword() + stirng);
        User auth = userService.auth(user);
        if (auth!=null){
            UserContext.setUserContext(auth);
            return "1";
        }else{
            return "0";
        }
    }
    @RequestMapping("home")
    public String home(){
        return "home";
    }
    @RequestMapping("charts")
    public String charts(){
        return "charts";
    }
    @RequestMapping("logout")
    public String logout(){
        UserContext.removeUser();
        return "redirect:/";
    }
    @RequestMapping("work")
    public String work(){
        return "work";
    }
    @RequestMapping("workstastics")
    public String workstastics(Model mode){
        workService.getMap(mode);
        return "workstastics";
    }
    @RequestMapping("all")
    public String all(){
        return "all";
    }
    @RequestMapping("info")
    public String info(Model model, HttpServletRequest request) {
        model.addAttribute("ip", IpUtil.getIpAddr(request));
        return "info";
    }
    @RequestMapping("infoUpdate")
    @ResponseBody
    public String infoUpdate(User user,String code){
        User user1 = UserContext.getUser();
        user.setId(user1.getId());
        if(!"Spring-2019".equals(code)){
            return "0";
        }
        userService.update(user);
        return "1";
    }
}
