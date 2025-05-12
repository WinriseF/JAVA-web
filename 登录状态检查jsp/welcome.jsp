<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 启用 Session 对象 --%>
<%@ page session="true" %>

<%
    // 获取当前 Session 对象
    String loggedInUser = (String) session.getAttribute("loggedInUser");
    if (loggedInUser == null || loggedInUser.isEmpty()) {
        // 用户未登录，重定向到登录页面
        response.sendRedirect("login.jsp");
        // 终止当前 JSP 的处理
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>欢迎页面</title>
</head>
<body>
    <h2>欢迎, <%= loggedInUser %>!</h2>

    <p>您已成功登录。</p>

    <%-- 提供一个链接到 logout.jsp 用于登出 --%>
    <p><a href="logout.jsp">登出</a></p>

</body>
</html>