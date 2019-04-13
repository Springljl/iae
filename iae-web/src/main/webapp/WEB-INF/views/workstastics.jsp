<%--
  Created by IntelliJ IDEA.
  User: Towar
  Date: 2019/4/6
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>table</title>
    <link rel="stylesheet" href="../../layui/css/layui.css"/>
    <script type="text/javascript" src="../../layui/layui.js"></script>
</head>
<body>
<span>
    本月工作天数：<span class="layui-badge layui-bg-green">${monthday}</span>
    本年工作天数：<span class="layui-badge layui-bg-green">${yearday}</span>
    总的工作天数：<span class="layui-badge layui-bg-green">${allday}</span>
</span>
</body>
</html>
