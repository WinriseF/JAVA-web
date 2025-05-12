<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户登录</title>
 <style>
    body { font-family: sans-serif; }
    .container { width: 300px; margin: 50px auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
    label { display: block; margin-bottom: 5px; }
    input[type="text"], input[type="password"] { width: 95%; padding: 8px; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 3px; }
    button { padding: 10px 15px; background-color: #28a745; color: white; border: none; border-radius: 3px; cursor: pointer; }
    button:hover { background-color: #218838; }
    .error { color: red; margin-bottom: 10px; font-size: 0.9em; }
    .success { color: green; margin-bottom: 10px; font-size: 0.9em; }
    .register-link { margin-top: 15px; text-align: center; font-size: 0.9em; }
    .register-link a { color: #007bff; text-decoration: none; }
</style>
</head>
<body>
    <div class="container">
        <h2>用户登录</h2>
        <c:if test="${not empty errorMessage}">
            <p class="error">${errorMessage}</p>
        </c:if>

        <c:if test="${param.registration == 'success'}">
             <p class="success">注册成功，请登录！</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div>
                <label for="username">用户名:</label>
                <input type="text" id="username" name="username" value="${not empty usernameValue ? usernameValue : ''}" required>
            </div>
            <div>
                <label for="password">密码:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div>
                <button type="submit">登录</button>
            </div>
        </form>
         <div class="register-link">
            还没有账号? <a href="${pageContext.request.contextPath}/register.jsp">立即注册</a>
        </div>
    </div>
</body>
</html>