package com.javaweb.model;
import java.util.Date;

public class Comment {

    private int id;
    private int articleId;
    private Integer commenterId;
    private Date commentTime;
    private String commentContent;

    public Comment() {
    }

    // 带参数构造函数 (方便创建对象)
    public Comment(int articleId, Integer commenterId, String commentContent) {
        this.articleId = articleId;
        this.commenterId = commenterId;
        this.commentContent = commentContent;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getArticleId() {
        return articleId;
    }

    public void setArticleId(int articleId) {
        this.articleId = articleId;
    }

    public Integer getCommenterId() {
        return commenterId;
    }

    public void setCommenterId(Integer commenterId) {
        this.commenterId = commenterId;
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", articleId=" + articleId +
                ", commenterId=" + commenterId +
                ", commentTime=" + commentTime +
                ", commentContent='" + commentContent + '\'' +
                '}';
    }
}