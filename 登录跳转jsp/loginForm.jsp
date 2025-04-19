<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 检查是否是登录表单提交请求
    String usernameSubmit = request.getParameter("username");
    String passwordSubmit = request.getParameter("password");
    String errorMessage = null;
    boolean loginAttempt = request.getMethod().equalsIgnoreCase("POST") && usernameSubmit != null; // 检查是否为POST请求且有用户名参数

    // 检查会话中是否已有登录用户
    String loggedInUser = (String) session.getAttribute("loggedInUser");

    // 如果是登录尝试 (POST请求) 且用户当前未登录
    if (loginAttempt && loggedInUser == null) {
        // 身份验证逻辑：用户名和密码相同则成功
        if (usernameSubmit != null && !usernameSubmit.isEmpty() && usernameSubmit.equals(passwordSubmit)) {
            // 登录成功
            session.setAttribute("loggedInUser", usernameSubmit); // 将用户名存入 session
            loggedInUser = usernameSubmit; // 更新当前状态的loggedInUser变量

            //使用 forward 指令跳转到 welcome.jsp
            pageContext.forward("welcome.jsp");

        } else {
            // 登录失败
            errorMessage = "用户名或密码错误！";
        }
    }

    // 根据登录状态决定显示内容
    if (loggedInUser != null) {
        // 用户已登录，显示欢迎信息
    } else {
        // 用户未登录，显示登录表单
%>
    <hr>
    <h3>用户登录</h3>
    <% if (errorMessage != null) { %>
        <p style="color:red;"><%= errorMessage %></p>
    <% } %>
    <form method="post" action="<%= request.getRequestURI() %>">
        用户名: <input type="text" name="username"><br>
        密码: <input type="password" name="password"><br>
        <input type="submit" value="登录">
    </form>
    <hr>
<%
    }
%>