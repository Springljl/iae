<%--
  Created by IntelliJ IDEA.
  User: Towar
  Date: 2019/4/6
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html ng-app="app">
<head>
    <title>修改信息</title>
    <link rel="stylesheet" href="../../layui/css/layui.css" />
    <script type="text/javascript" src="../../layui/layui.js"></script>
    <script type="text/javascript" src="../../js/angular.js"></script>
    <script type="text/javascript" src="../../js/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/raphael.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.classyled.min.js"></script>
    <style>
        span{
            color: red;
        }
    </style>
</head>
<body ng-controller="MainCtrl as ctrl">
<marquee scrollAmount="10" behavior="scroll" width="100%" style="margin-left: -100px"><div class="led" style="text-align: center"></div></marquee>
<input type="hidden" name="ip" required  lay-verify="required" value="${ip.replace('.',':')}" readonly autocomplete="off" class="layui-input" style="text-align: center">
<form class="layui-form" name="form" ng-submit="ctrl.submit()">
    <div class="layui-form-item">
        <div class="layui-input-block">
            <input oninput="this.value = this.value.replace(/[\u4e00-\u9fa5]/g, '');" type="text" name="userName" required  ng-model="ctrl.userName" ng-minlength="4" ng-maxlength="10" placeholder="请输入用户名" autocomplete="off" class="layui-input" style="width: 190px;margin-top: 20px;display: inline-block">
            <span ng-show="form.userName.$error.required">请输入账号</span>
            <span ng-show="form.userName.$error.minlength">长度应大于等于4</span>
            <span ng-show="form.userName.$error.maxlength">长度应小于等于10</span>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <input type="password" name="password" required ng-model="ctrl.password" ng-minlength="6" ng-maxlength="16" placeholder="请输入密码" autocomplete="off" class="layui-input" style="width: 190px;display: inline-block">
            <span ng-show="form.password.$error.required">请输入密码</span>
            <span ng-show="form.password.$error.minlength">长度应大于等于6</span>
            <span ng-show="form.password.$error.maxlength">长度应小于等于16</span>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <input  type="text" name="code" required placeholder="请输入通行证" ng-model="ctrl.code"  ng-maxlength="11"  autocomplete="off" class="layui-input" style="width: 190px;margin-top: 20px;display: inline-block">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <input type="submit" class="layui-btn" ng-disabled="form.$invalid" value="提交">
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<script>
    $(function () {
        $(".led").ClassyLED({
            type:'number',
            value:$("input[name='ip']").val(),
            format:'hh:mm:ss',
            backgroundColor:'#ffffff',
            color:'red',
            fontType:1,
            rounded:20,
            size:3
        });
    })
    layui.use('form', function(){
        var form = layui.form;
        form.on('submit(formDemo)', function(data){
            return false;
        });
    });
    angular.module("app",[]).controller("MainCtrl",[function () {
        var self=this;
        self.submit=function () {
            layer.confirm("确认修改？",function () {
                var i=layer.load(1);
                $.ajax({
                    url:'/infoUpdate',
                    data:{
                        userName:self.userName,
                        password:self.password,
                        code:self.code
                    },
                    success:function (resp) {
                       if (resp==="1"){
                           layer.alert("修改成功，下次登录生效");
                       } else{
                           layer.alert("不好意思，通行证错误，不能修改信息")
                       }
                        layer.close(i)
                    }
                })
            })
        }
    }]);
</script>
</body>
</html>
