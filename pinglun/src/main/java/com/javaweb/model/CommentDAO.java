package com.javaweb.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    // 数据库连接信息 - 请根据你的数据库修改
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/user_auth_db?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "123456";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to load JDBC driver.", e);
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }


    public boolean addComment(Comment comment) {
        String sql = "INSERT INTO comments (article_id, commenter_id, comment_content) VALUES (?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, comment.getArticleId());
            if (comment.getCommenterId() == null) {
                pstmt.setNull(2, Types.INTEGER);
            } else {
                pstmt.setInt(2, comment.getCommenterId());
            }
            pstmt.setString(3, comment.getCommentContent());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Comment> getCommentsByArticleId(int articleId, int offset, int limit) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT id, article_id, commenter_id, comment_time, comment_content " +
                "FROM comments " +
                "WHERE article_id = ? " +
                "ORDER BY comment_time DESC " +
                "LIMIT ?, ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, articleId);
            pstmt.setInt(2, offset);
            pstmt.setInt(3, limit);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Comment comment = new Comment();
                    comment.setId(rs.getInt("id"));
                    comment.setArticleId(rs.getInt("article_id"));
                    int commenterId = rs.getInt("commenter_id");
                    if (rs.wasNull()) {
                        comment.setCommenterId(null);
                    } else {
                        comment.setCommenterId(commenterId);
                    }
                    comment.setCommentTime(rs.getTimestamp("comment_time"));
                    comment.setCommentContent(rs.getString("comment_content"));
                    comments.add(comment);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }

    public int getCommentCountByArticleId(int articleId) {
        String sql = "SELECT COUNT(*) FROM comments WHERE article_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, articleId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}