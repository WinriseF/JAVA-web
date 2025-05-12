package com.javaweb.dao;

import com.javaweb.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {

    public boolean isUserExists(String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } finally {
            DBUtil.close(rs, pstmt, conn);
        }
        return false;
    }

    public boolean addUser(String username, String passwordHash) throws SQLException {
        String sql = "INSERT INTO users (username, password_hash) VALUES (?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            if (isUserExists(username)) {
                return false; // 用户已存在
            }
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, passwordHash);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } finally {
            DBUtil.close(pstmt, conn);
        }
    }

    public String getUserPasswordHash(String username) throws SQLException {
        String sql = "SELECT password_hash FROM users WHERE username = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String passwordHash = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                passwordHash = rs.getString("password_hash");
            }
        } finally {
            DBUtil.close(rs, pstmt, conn);
        }
        return passwordHash;
    }
}