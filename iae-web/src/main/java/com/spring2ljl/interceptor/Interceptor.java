package com.spring2ljl.interceptor;

import com.spring2ljl.UserContext;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Interceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if(UserContext.getUser()!=null){
            return true;
        }
        response.sendRedirect("/");
        return false;
    }
}
