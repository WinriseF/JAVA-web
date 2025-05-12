<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%-- 启用 Session 对象 --%>
<%@ page session="true" %>

<%
    session.invalidate();

    // 清除相关的 Cookie (记住密码和自动登录的 Cookie)
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            String cookieName = cookie.getName();
            // 检查 Cookie 名称是否是我们设置的记住密码或自动登录的 Cookie
            if ("remember_username".equals(cookieName) || "remember_password".equals(cookieName) || "auto_login_user".equals(cookieName)) {
                Cookie expiredCookie = new Cookie(cookieName, ""); // 值为空
                expiredCookie.setMaxAge(0); // 设置有效期为0
                expiredCookie.setPath("/"); 
                response.addCookie(expiredCookie);
            }
        }
    }

    // 重定向回登录页面，完成登出流程
    response.sendRedirect("login.jsp");
    return;
%>