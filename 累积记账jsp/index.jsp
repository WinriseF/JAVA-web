<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.List, java.util.Date, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>累积记账</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <h1>简单记账小程序</h1>
        <form method="post" action="">
            <div class="input-sty">
                <label for="type">收支类型:</label>
                <select id="type" name="type">
                    <option value="in">收入</option>
                    <option value="out">支出</option>
                </select>
            </div>
            <div class="input-sty">
                <label for="jine">金额:</label>
                <input type="number" id="jine" name="jine" placeholder="请输入金额">
            </div>
            <button id="submit-but" type="submit">提交</button>
        </form>
    </div>
    <h2>记录</h2>
    <div id="jilu">
        <%
            List<String> records = (List<String>) session.getAttribute("records");
            if (records == null || records.isEmpty()) {
        %>
            <p>暂无记录</p>
        <%
            } else {
                for (String record : records) {
        %>
            <p><%= record %></p>
        <%
                }
            }
        %>
    </div>
    <h3>总金额:<span id="total-doller"><%= session.getAttribute("total") == null ? 0 : session.getAttribute("total") %></span></h3>

    <%
        // 处理表单提交
        String type = request.getParameter("type");
        String jineStr = request.getParameter("jine");

        if (type != null && jineStr != null && !jineStr.isEmpty()) {
            try {
                double amount = Double.parseDouble(jineStr);
                double currentTotal = (session.getAttribute("total") == null) ? 0 : (Double) session.getAttribute("total");
                List<String> currentRecords = (session.getAttribute("records") == null) ? new ArrayList<>() : (List<String>) session.getAttribute("records");

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String dateTimeString = sdf.format(new Date());

                String recordText = (type.equals("in") ? "收入" : "支出") + ": " + amount + " (记录时间: " + dateTimeString + ")";
                currentRecords.add(recordText);
                session.setAttribute("records", currentRecords);

                if (type.equals("in")) {
                    currentTotal += amount;
                } else if (type.equals("out")) {
                    currentTotal -= amount;
                }
                session.setAttribute("total", currentTotal);

                if (currentTotal < 0) {
    %>
                    <script>
                        window.open('https://www.xjietiao.com/','_blank');
                        window.open('https://www.duxiaoman.com/','_blank');
                        window.open('https://m.pingan.com/c3/puihuitouliu/loan_page1.html?channel=PAGW&sourceType=PChome','_blank');
                    </script>
    <%
                }

                // 重定向以避免重复提交
                response.sendRedirect(request.getRequestURI());

            } catch (NumberFormatException e) {
                out.println("<script>alert('请输入有效的金额');</script>");
            }
        }
    %>
</body>
</html>