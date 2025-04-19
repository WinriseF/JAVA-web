<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 从 session 中获取已登录的用户名
    String username = (String) session.getAttribute("loggedInUser");

    // 简单的安全检查，如果未登录用户意外访问此页面
    if (username == null) {
        // 可以重定向回登录页面或显示错误
        // response.sendRedirect("A.jsp"); // 或者 B.jsp，或者一个专门的登录页
        out.println("请先登录!");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>欢迎</title>
</head>
<body>
    <hr>
    <h2>欢迎您, <%= username %>!</h2>
    <p>您已成功登录。</p>
    <p><a href="A.jsp">访问 A 页面</a></p>
    <p><a href="B.jsp">访问 B 页面</a></p>
    <hr>
</body>
</html>