<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.javaweb.model.Comment" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>文章评论页</title>
    <style type="text/css">
        .comment { border: 1px solid #eee; margin-bottom: 10px; padding: 10px; }
        .comment p { margin: 5px 0; }
        .comment .info { font-size: 0.9em; color: #666; }
        .pagination a { margin-right: 5px; }
        .pagination .current { font-weight: bold; color: blue; }
    </style>
</head>
<body>

<h1>文章标题</h1>
<p>这是一篇文章的内容...</p>
<% int articleId = 1; %>

<h2>评论区</h2>

<div class="comment-form">
    <h3>发表评论</h3>
    <form action="comment" method="post">
        <input type="hidden" name="articleId" value="<%= articleId %>">
        <input type="hidden" name="commenterId" value="999">

        <textarea name="commentContent" rows="4" cols="50" placeholder="请输入评论内容..." required></textarea><br>
        <button type="submit">提交评论</button>
    </form>
</div>

<hr>

<div class="comment-list">
    <h3>最新评论</h3>
    <%
        List<Comment> comments = (List<Comment>) request.getAttribute("comments");
        Integer totalComments = (Integer) request.getAttribute("totalComments");
        Integer currentPage = (Integer) request.getAttribute("currentPage");
        Integer pageSize = (Integer) request.getAttribute("pageSize"); // 每页显示数量
        String servletUrl = request.getContextPath() + "/comment?articleId=" + articleId; // Servlet URL for pagination

        if (comments != null && !comments.isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            for (Comment comment : comments) {
    %>
    <div class="comment">
        <p><%= comment.getCommentContent() %></p>
        <p class="info">
            评论人ID: <%= comment.getCommenterId() != null ? comment.getCommenterId() : "匿名" %>
            | 时间: <%= sdf.format(comment.getCommentTime()) %>
        </p>
    </div>
    <%
        }
    } else {
    %>
    <p>暂无评论。</p>
    <%
        }
    %>
</div>

<%-- 分页链接 --%>
<div class="pagination">
    <%
        if (totalComments != null && totalComments > 0 && pageSize != null && pageSize > 0) {
            int totalPages = (int) Math.ceil((double) totalComments / pageSize);

            if (totalPages > 1) {
                for (int i = 1; i <= totalPages; i++) {
                    if (i == currentPage) {
    %>
    <span class="current"><%= i %></span>
    <%
    } else {
    %>
    <a href="<%= servletUrl %>&page=<%= i %>"><%= i %></a>
    <%
                    }
                }
            }
        }
    %>
</div>

</body>
</html>