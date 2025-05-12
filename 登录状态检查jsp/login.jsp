<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%-- 启用 Session 对象，如果没有则创建一个 --%>
<%@ page session="true" %>

<%
    String validUsername = "admin";
    String validPassword = "admin123";
    String errorMessage = "";

    String rememberedUsername = "";
    String rememberedPassword = "";


    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("auto_login_user".equals(cookie.getName())) {
                String autoLoginUsername = cookie.getValue();

                if (validUsername.equals(autoLoginUsername)) {
                    // 自动登录成功，建立 Session
                    session.setAttribute("loggedInUser", autoLoginUsername); 
                    response.sendRedirect("welcome.jsp");
                    // 终止当前 JSP 的处理，防止在重定向后继续渲染页面内容
                    return;
                }
            }
        }
    }


    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // 获取用户提交的用户名和密码
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean rememberMe = "on".equals(request.getParameter("remember_me"));
        boolean autoLogin = "on".equals(request.getParameter("auto_login"));

        // 身份验证
        if (validUsername.equals(username) && validPassword.equals(password)) {
            // 身份验证成功
            // 建立 Session，标记用户已登录
            session.setAttribute("loggedInUser", username);
            session.setAttribute("loginTime", System.currentTimeMillis()); // 可以记录登录时间

            // 处理“记住密码” Cookie
            if (rememberMe) {
                // 创建并设置记住密码的 Cookie，有效期例如 30 天
                Cookie userCookie = new Cookie("remember_username", username);
                userCookie.setMaxAge(30 * 24 * 60 * 60);
                userCookie.setPath("/");
                response.addCookie(userCookie);

                Cookie passCookie = new Cookie("remember_password", password);
                passCookie.setMaxAge(30 * 24 * 60 * 60);
                passCookie.setPath("/");
                response.addCookie(passCookie);
            } else {
                 Cookie userCookie = new Cookie("remember_username", "");
                 userCookie.setMaxAge(0); userCookie.setPath("/"); response.addCookie(userCookie);
                 Cookie passCookie = new Cookie("remember_password", "");
                 passCookie.setMaxAge(0); passCookie.setPath("/"); response.addCookie(passCookie);
            }

             if (autoLogin) {
                 Cookie autoLoginCookie = new Cookie("auto_login_user", username);
                 autoLoginCookie.setMaxAge(60 * 24 * 60 * 60); 
                 autoLoginCookie.setPath("/");
                 response.addCookie(autoLoginCookie);
             } else {
                 Cookie autoLoginCookie = new Cookie("auto_login_user", "");
                 autoLoginCookie.setMaxAge(0); autoLoginCookie.setPath("/"); response.addCookie(autoLoginCookie);
             }

            // 重定向到欢迎页面 (完成登录操作)
            response.sendRedirect("welcome.jsp");
            // 终止当前 JSP 的处理
            return;

        } else {
            // 身份验证失败
            errorMessage = "用户名或密码错误！";
        }
    }

    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                // 查找名为 'remember_username' 的 Cookie 并获取其值
                if ("remember_username".equals(cookie.getName())) {
                    rememberedUsername = cookie.getValue();
                }
                // 查找名为 'remember_password' 的 Cookie 并获取其值
                if ("remember_password".equals(cookie.getName())) {
                    rememberedPassword = cookie.getValue();
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户登录</title>
<style>
    .error { color: red; }
</style>
</head>
<body>
    <h2>用户登录</h2>

    <%-- 显示错误消息 --%>
    <% if (!errorMessage.isEmpty()) { %>
        <p class="error"><%= errorMessage %></p>
    <% } %>

    <form action="login.jsp" method="post">
        <label for="username">用户名:</label><br>
        <%-- 使用记住密码的变量填充输入框 --%>
        <input type="text" id="username" name="username" value="<%= rememberedUsername %>"><br><br>

        <label for="password">密码:</label><br>
         <%-- 使用记住密码的变量填充输入框 --%>
        <input type="password" id="password" name="password" value="<%= rememberedPassword %>"><br><br>

        <%-- “是否记住密码”选项 --%>
        <input type="checkbox" id="remember_me" name="remember_me" value="on">
        <label for="remember_me">是否记住密码</label><br><br>

        <%-- “是否自动登录”选项 --%>
        <input type="checkbox" id="auto_login" name="auto_login" value="on">
        <label for="auto_login">是否自动登录</label><br><br>

        <input type="submit" value="登录">
    </form>
</body>
</html>