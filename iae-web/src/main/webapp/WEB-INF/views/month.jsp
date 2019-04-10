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
    <title>month</title>
    <link rel="stylesheet" href="../../layui/css/layui.css"/>
    <script type="text/javascript" src="../../layui/layui.js"></script>
    <script type="text/javascript" src="../../js/DateFormat.js"></script>
    <script type="text/javascript" src="../../js/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/vue.min.js"></script>
    <script type="text/javascript" src="../../js/raphael.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.classyled.min.js"></script>
    <style>
        th{
            background-color: #8D8D8D;
            color: white;
        }
        p{
            font-family: Consolas;
        }
        td{
            font-family: Consolas;
            font-size: 18px !important;
        }
        table:hover{
            position: relative;
            top: -10px;
            box-shadow: 0 10px 50px blue;
        }
    </style>
</head>
<body>
<div id="data" style="margin:10px auto;text-align: center;width: 800px">
    <div class="layui-inline" style="width: 375px;">
            <input  type="text" readonly class="layui-input"  id="test1" style="display: inline-block;width: 275px">
            <button class="layui-btn layui-btn-danger" @click="getData" style="margin-top: -2px">查询</button>

    </div>
    <table class="layui-table" style="margin-top: 100px;width: 800px;height: 100px;">
        <caption ><p id="title" style="font-size: 28px"></p></caption>
        <tr>
            <th>月收入</th><td>{{m_in}}元</td>
            <th>年收入</th><td>{{y_in}}元</td>
        </tr>
        <tr>
            <th>月支出</th><td>{{m_out}}元</td>
            <th>年支出</th><td>{{y_out}}元</td>
        </tr>
        <tr>
            <th>月总计</th><td>{{m_all<0?"支出："+(0-m_all):"收入："+m_all}}元</td>
            <th>年总计</th><td>{{y_all<0?"支出："+(0-y_all):"收入："+y_all}}元</td>
        </tr>
        <tr>
        <th>平均月收入(收入)</th><td>{{(y_in/12).toFixed(2)}}元</td>
        <th>平均月收入(收入-支出)</th><td>{{(y_all/12).toFixed(2)}}元</td>
        </tr>
        <tr>
            <th>平均月支出</th>
            <td colspan="3">{{(y_out/12).toFixed(2)}}元</td>
        </tr>
    </table>
</div>
</body>
<script>
   $(function () {
       layui.use('laydate', function(){
           var laydate = layui.laydate;
           laydate.render({
               elem: '#test1', //指定元素
               type:'month',
               btns: ['confirm'],
               value:new Date()
           });
       });
       var vue=new Vue({
           el:"#data",
           data:{
               m_in:0,
               m_out:0,
               m_all:0,
               y_in:0,
               y_out:0,
               y_all:0,
           },
           created:function(){
               this.getData();
           },
           methods:{
               getData:function () {
                   $("#title").html($("#test1").val()==""?formatYM(new Date().getTime())+"收支情况":$("#test1").val()+"收支情况")
                   $.ajax({
                       url:"/info/time?v="+$("#test1").val(),
                       type:'get',
                       success:function (resp) {
                           vue.m_in=resp.m_in;
                           vue.m_out=resp.m_out;
                           vue.m_all=resp.m_all;
                           vue.y_in=resp.y_in;
                           vue.y_out=resp.y_out;
                           vue.y_all=resp.y_all;
                       }
                   })
               }
           }
       })
   })
</script>
</html>
