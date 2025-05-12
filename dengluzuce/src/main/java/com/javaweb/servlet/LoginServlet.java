package com.javaweb.servlet;

import com.javaweb.dao.UserDao;
import com.javaweb.util.MD5Util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login") // Servlet 映射路径
public class LoginServlet extends HttpServlet {
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
        String errorMessage = null;

        if (username == null || username.trim().isEmpty() || password == null || password.isEmpty()) {
            errorMessage = "用户名和密码不能为空!";
        } else {
            try {
                username = username.trim();
                String storedHash = userDao.getUserPasswordHash(username);

                if (storedHash == null) {
                    errorMessage = "用户名或密码错误"; // 用户不存在
                } else {
                    String inputHash = MD5Util.hash(password);
                    if (inputHash != null && inputHash.equals(storedHash)) {
                        // 登录成功
                        HttpSession session = request.getSession(true); // 获取或创建 Session
                        session.setAttribute("loggedInUser", username); // 存储登录状态
                        response.sendRedirect(request.getContextPath() + "/welcome.jsp"); // 重定向到欢迎页
                        return; // 重定向后必须返回
                    } else {
                        errorMessage = "用户名或密码错误"; // 密码不匹配
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

        // 登录失败
        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("usernameValue", username); // 保留用户名输入
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // GET 请求直接导向登录页面
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}