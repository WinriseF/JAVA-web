<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Object user = session.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>欢迎</title>
<style>
    body { font-family: sans-serif; padding: 20px; }
    .logout-link a { color: #dc3545; text-decoration: none; }
</style>
</head>
<body>
    <h2>欢迎您, <c:out value="${sessionScope.loggedInUser}" />!</h2>

    <p>您已成功登录系统。</p>

    <p class="logout-link">
        <a href="${pageContext.request.contextPath}/logout">退出登录</a>
    </p>

</body>
</html>