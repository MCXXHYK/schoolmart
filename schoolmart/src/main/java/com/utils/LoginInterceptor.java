package com.utils;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String url = request.getRequestURI();
        if (url.indexOf("/user/tologin") >= 0 || url.indexOf("/user/forgetupwd") >= 0 || url.indexOf("/user/login") >= 0 || url.indexOf("/order/alipayReturnNotice") >= 0 || url.indexOf("/user/toregister") >= 0 || url.indexOf("/user/register") >= 0) {
            return true;
        }
        HttpSession session = request.getSession();
        Object o = session.getAttribute("user");
        if (o != null)
            return true;
        request.setAttribute("msg", "亲！请先登录哦！");
        request.getRequestDispatcher("/WEB-INF/jsp/logintest.jsp").forward(request, response);
        return false;
    }
}