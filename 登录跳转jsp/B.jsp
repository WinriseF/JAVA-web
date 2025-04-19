<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>页面 B</title>
</head>
<body>

    <%-- (1) 使用 include 指令包含登录表单/逻辑 --%>
    <%@ include file="loginForm.jsp" %>

    <h1>这里是页面 B 的主要内容</h1>

    <p><a href="A.jsp">去页面 A</a></p>
    <%
        // 检查是否已登录
        if (loggedInUser != null) {
    %>
    <p><a href="logout.jsp">登出</a></p>
    <%  }else { %>
    <p>请登录以访问此页面。</p>
    <% } %>
</body>
</html>