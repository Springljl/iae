<%--
Created by IntelliJ IDEA.
User: Towar
Date: 2019/4/5
Time: 21:10
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <link rel="icon" href="../../img/c16.ico">
    <link rel="stylesheet" href="../../layui/css/layui.css" />
    <script type="text/javascript" src="../../layui/layui.js"></script>
    <script type="text/javascript" src="../../js/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/raphael.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.classyled.min.js"></script>
</head>
<body style="min-width: 800px">
<ul class="layui-nav layui-bg-blue">
    <li class="layui-nav-item layui-this"><a href="/charts" target="iframe">图形分析</a></li>
    <li class="layui-nav-item"><a href="/table" target="iframe">所有记录</a></li>
    <li class="layui-nav-item"><a href="/info/month" target="iframe">每月详情</a></li>
    <li class="layui-nav-item"><a href="/info" target="iframe">修改信息</a></li>
    <li class="layui-nav-item" style="float: right"><a href="javascript:;" onclick="logout()">退出</a></li>
    <li class="layui-nav-item" style="float: right">欢迎${user.userName}</li>
</ul>
<iframe id="iframe" name="iframe" width="100%" src="/charts" frameborder="0"></iframe>
<hr style="margin: 0">
<div class="led" style="text-align: center"></div>
</body>
<script>
    $(function () {
        $(".led").ClassyLED({
            type:'time',
            format:'hh:mm:ss',
            backgroundColor:'#ffffff',
            color:'green',
            fontType:2,
            rounded:200,
            size:5
        });
    })
    layui.use('element', function(){
        var element = layui.element;
    });
    layui.use('layer', function(){
        var layer = layui.layer;
    });
    setInterval(function () {
        document.getElementById("iframe").style.height=document.body.clientHeight-102;
    },10)
    function logout() {
        layer.confirm("确认退出登录？",
            function(index, layero){
                window.location.href="/logout"
            },
            function(index){}
            );
    }
</script>
</html>