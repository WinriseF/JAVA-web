<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- 引入 JSTL 核心标签库 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户注册</title>
<style>
    body { font-family: sans-serif; }
    .container { width: 300px; margin: 50px auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
    label { display: block; margin-bottom: 5px; }
    input[type="text"], input[type="password"] { width: 95%; padding: 8px; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 3px; }
    button { padding: 10px 15px; background-color: #007bff; color: white; border: none; border-radius: 3px; cursor: pointer; }
    button:hover { background-color: #0056b3; }
    .error { color: red; margin-bottom: 10px; font-size: 0.9em; }
    .login-link { margin-top: 15px; text-align: center; font-size: 0.9em; }
    .login-link a { color: #007bff; text-decoration: none; }
</style>
</head>
<body>
    <div class="container">
        <h2>用户注册</h2>
        <c:if test="${not empty errorMessage}">
            <p class="error">${errorMessage}</p>
        </c:if>
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div>
                <label for="username">用户名:</label>
                <input type="text" id="username" name="username" value="${not empty usernameValue ? usernameValue : ''}" required>
            </div>
            <div>
                <label for="password">密码:</label>
                <input type="password" id="password" name="password" required>
            </div>
             <div>
                <label for="confirmPassword">确认密码:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <div>
                <button type="submit">注册</button>
            </div>
        </form>
        <div class="login-link">
            已有账号? <a href="${pageContext.request.contextPath}/login.jsp">立即登录</a>
        </div>
    </div>
</body>
</html>