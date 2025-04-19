<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 使当前用户的 session 失效
    session.invalidate();

    // 重定向用户到 A.jsp 页面
    // 用户将被导向 A.jsp，此时因为 session 已失效，loginForm.jsp 会显示登录表单
    response.sendRedirect("A.jsp");

    // 在调用 sendRedirect 后最好不要再输出任何内容，
    // 也可以加上 return; 确保后续代码（如果有的话）不执行
%>
<%-- 下面的 HTML 内容通常不会显示，因为重定向前页面就结束了 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>退出登录</title>
</head>
<body>
    <p>正在退出登录...</p>
</body>
</html>