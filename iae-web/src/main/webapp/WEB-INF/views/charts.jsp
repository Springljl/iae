<%--
  Created by IntelliJ IDEA.
  User: Towar
  Date: 2019/4/6
  Time: 15:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>charts</title>
    <link rel="stylesheet" href="../../layui/css/layui.css"/>
    <script type="text/javascript" src="../../layui/layui.js"></script>
    <script type="text/javascript" src="../../js/DateFormat.js"></script>
    <script type="text/javascript" src="../../js/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/vue.min.js"></script>
    <script type="text/javascript" src="../../js/echarts.min.js"></script>
</head>
<body>
<div id="echarts" style="width: 100%;height:100%"></div>
</body>
<script type="text/javascript">
    var layer;
    var l;
    layui.use('layer', function(){
        layer = layui.layer;
        l=layer.load(0);
    });

    var myChart ;
    var vue=new Vue({
        el:"#echarts",
        created:function () {
            $.ajax({
                url:"/info/charts",
                type:'get',
                success:function (resp) {
                    layer.close(l)
                    myChart= echarts.init(document.getElementById('echarts'));
                    var option=option = {
                        title: {
                            text: new Date().getFullYear()+'年收入支出统计'
                        },
                        tooltip: {
                            trigger: 'axis'
                        },
                        legend: {
                            data:['支出','收入']
                        },
                        grid: {
                            left: '3%',
                            right: '4%',
                            bottom: '3%',
                            containLabel: true
                        },
                        toolbox: {
                            feature: {
                                saveAsImage: {}
                            }
                        },
                        xAxis: {
                            type: 'category',
                            name:'月份',
                            boundaryGap: false,
                            data: resp.years
                        },
                        yAxis: {
                            type: 'value',
                            name:'金额',
                        },
                        series: [
                            {
                                name:'支出',
                                type:'line',
                                data:resp.out
                            },
                            {
                                name:'收入',
                                type:'line',
                                data:resp.in
                            }
                        ]
                    };
                    myChart.setOption(option);
                }
            })
        }
    })
    window.onresize = function () {
        myChart.resize();
    };
</script>
</html>
