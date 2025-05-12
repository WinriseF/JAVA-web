package com.javaweb.servlet;

import com.javaweb.dao.UserDao;
import com.javaweb.util.MD5Util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register") // Servlet 映射路径
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        String errorMessage = null;
        boolean registrationSuccess = false;

        if (username == null || username.trim().isEmpty() || password == null || password.isEmpty()) {
            errorMessage = "用户名和密码不能为空!";
        } else if (!password.equals(confirmPassword)) {
            errorMessage = "两次输入的密码不一致!";
        } else {
            try {
                username = username.trim();
                if (userDao.isUserExists(username)) {
                    errorMessage = "该用户已存在";
                } else {
                    String hashedPassword = MD5Util.hash(password);
                    if (hashedPassword == null) {
                        errorMessage = "密码加密失败，请稍后重试。";
                    } else {
                        boolean added = userDao.addUser(username, hashedPassword);
                        if (added) {
                            registrationSuccess = true;
                            response.sendRedirect(request.getContextPath() + "/login.jsp?registration=success");
                            return; // 重定向后必须返回
                        } else {
                            errorMessage = "注册过程中发生错误，请稍后重试。";
                        }
                    }
                }
            } catch (SQLException e) {
                errorMessage = "数据库操作失败：" + e.getMessage();
                e.printStackTrace();
            } catch (Exception e) {
                errorMessage = "发生未知错误。";
                e.printStackTrace();
            }
        }

        if (!registrationSuccess) {
            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("usernameValue", username);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/register.jsp");
    }
}