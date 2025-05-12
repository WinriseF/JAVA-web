package com.javaweb.servlet;
import com.javaweb.model.Comment;
import com.javaweb.model.CommentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/comment")
public class CommentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CommentDAO commentDAO;
    private static final int DEFAULT_PAGE_SIZE = 10; // 每页评论数

    public CommentServlet() {
        super();
        commentDAO = new CommentDAO(); // 初始化 DAO 对象
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int articleId = 1;
        try {
            String articleIdParam = request.getParameter("articleId");
            if (articleIdParam != null && !articleIdParam.isEmpty()) {
                articleId = Integer.parseInt(articleIdParam);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            articleId = 1;
        }

        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) {
                    currentPage = 1;
                }
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        int offset = (currentPage - 1) * DEFAULT_PAGE_SIZE;
        int limit = DEFAULT_PAGE_SIZE;

        List<Comment> comments = commentDAO.getCommentsByArticleId(articleId, offset, limit);

        int totalComments = commentDAO.getCommentCountByArticleId(articleId);

        request.setAttribute("comments", comments);
        request.setAttribute("totalComments", totalComments);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("pageSize", DEFAULT_PAGE_SIZE);

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int articleId = 1;
        try {
            String articleIdParam = request.getParameter("articleId");
            if (articleIdParam != null && !articleIdParam.isEmpty()) {
                articleId = Integer.parseInt(articleIdParam);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/comment?articleId=1&error=invalid_article_id"); // 重定向回默认文章页
            return;
        }


        Integer commenterId = null;
        String commenterIdParam = request.getParameter("commenterId");
        if (commenterIdParam != null && !commenterIdParam.isEmpty()) {
            try {
                commenterId = Integer.parseInt(commenterIdParam);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        String commentContent = request.getParameter("commentContent");

        if (commentContent == null || commentContent.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/comment?articleId=" + articleId + "&error=content_empty");
            return;
        }

        Comment newComment = new Comment(articleId, commenterId, commentContent.trim());

        boolean success = commentDAO.addComment(newComment);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/comment?articleId=" + articleId + "&page=1");
        } else {
            response.sendRedirect(request.getContextPath() + "/comment?articleId=" + articleId + "&error=db_insert_failed");
        }
    }
}