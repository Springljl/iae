package com.spring2ljl;

import com.spring2ljl.pojo.User;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;

@Component
public class UserContext {
    private static HttpSession session;

    public static void setUserContext(User user){
        session=((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        session.setAttribute("user",user);
    }
    public static User getUser(){
        session=((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        return (User) session.getAttribute("user");
    }
    public static Integer getUserId(){
        return getUser().getId();
    }
    public static void removeUser(){
        session=((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        session.removeAttribute("user");
    }
}
