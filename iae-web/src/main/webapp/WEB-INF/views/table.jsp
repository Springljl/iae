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
    <script type="text/javascript" src="../../js/DateFormat.js"></script>
    <script type="text/javascript" src="../../js/jquery.min.js"></script>
    <style>
       table{
           margin-top: -20px;
       }
    </style>
</head>
<body>
<table id="data" lay-filter="test"></table>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
        <button class="layui-btn layui-btn-sm" lay-event="mod">编辑</button>
        <button class="layui-btn layui-btn-sm" lay-event="del">删除</button>
    </div>
</script>
<div style="display: none;margin-top: 10px" id="form">
    <form class="layui-form" method="post" action="/info/update">
        <input type="hidden" name="id">
        <div class="layui-form-item">
            <label class="layui-form-label">金额</label>
            <div class="layui-input-block">
                <input type="number" name="amount" min="1" required  lay-verify="required" placeholder="请输入金额" autocomplete="off" class="layui-input" style="width: 100px">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">方式</label>
            <div class="layui-input-block">
                <input type="radio" name="type" value="0" title="支出">
                <input type="radio" name="type" value="1" title="收入" checked>
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">描述(200字以内)</label>
            <div class="layui-input-block">
                <textarea name="description" placeholder="请输入内容" maxlength="200" style="resize: none;width: 350px" class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
            </div>
        </div>
    </form>
</div>
</body>
<script>
    var form
    layui.use('form', function(){
        form = layui.form;
        form.on('submit(formDemo)', function(data){
            return true;
        });
    });
    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#data'
            ,id:'table-data'
            , height: '530'
            , url: '/info/page' //数据接口
            , page: true //开启分页
            , limits: [10]
            , toolbar: '#toolbarDemo'
            , defaultToolbar: ['print', 'exports']
            , even: true
            , cols: [[ //表头
                {title: '选择', type: 'checkbox'}
                , {title: '序号', type: 'numbers'}
                , {field: 'id', hide: true, title: 'id', width: 130, unresize: true, align: 'center'}
                , {
                    field: 'type', title: '类型', width: 80, unresize: true, align: 'center', templet: function (d) {
                        if (d.type === 1) {
                            return '<span class="layui-badge layui-bg-blue" style="font-size: 16px">收入</span>'
                        } else {
                            return '<span class="layui-badge layui-bg-black" style="font-size: 16px">支出</span>'
                        }
                    }
                }
                , {
                    field: 'amount', title: '金额', width: 130, unresize: true, align: 'center', templet: function (d) {
                        if (d.type === 0) {
                            return '<span class="layui-badge layui-bg-black" style="font-size: 16px">-' + d.amount + '元</span>'
                        } else {
                            return '<span class="layui-badge layui-bg-blue" style="font-size: 16px">+' + d.amount + '元</span>'
                        }
                    }
                }
                , {
                    field: 'time', title: '时间', width: 140, unresize: true, align: 'center', templet: function (d) {
                        return formatYMD(d.time)
                    }
                }
                , {field: 'description', title: '描述', align: 'center'}
            ]]
        });
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'add':
                    add(table)
                    break;
                case 'del':
                    del(checkStatus.data,table)
                    break;
                case 'mod':
                    mod(checkStatus.data,form)
                    break;
            }
            ;
        });
    });
    add=function(table){
        layer.open({
            type:1,
            title:"添加",
            content:$("#form"),
            area: ['500px', '330px']
        })
        $("input[name='id']").val("")
        $("input[name='amount']").val("")
        $("textarea[name='description']").val("")
        $("input[value=1]").prop("checked",true)
    }
    mod=function(val,form){
        if(val.length!=1){
            layer.alert("请选择一条要编辑的数据")
        }else{
            layer.open({
                type:1,
                title:"编辑",
                content:$("#form"),
                area: ['500px', '330px']
            })
            $("input[name='id']").val(val[0].id)
            $("input[name='amount']").val(val[0].amount)
            $("textarea[name='description']").val(val[0].description)
            $("input[value="+val[0].type+"]").prop("checked",true)
            form.render('radio');
        }
    }
    del=function (val,table) {
        if(val.length===0){
            layer.alert("请选择要删除的选项")
        }else{
           layer.confirm("确认要删除选中的"+val.length+"条记录",function () {
               var ids=[];
               for (var i=0;i<val.length;i++){
                   ids.push(val[i].id)
               }
               $.ajax({
                   url:"/info/delete",
                   data:{
                       ids:ids
                   },
                   success:function (resp) {
                       if(resp==="1"){
                           layer.msg("删除成功");
                           table.reload('table-data');
                       }
                   }
               })
           })
        }
    }
</script>
</html>
