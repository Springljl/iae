<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <meta charset="UTF-8">
    <title>登录</title>
    <link rel="icon" href="../../img/c16.ico">
    <!--必要样式-->
    <link href="../../css/styles.css" rel="stylesheet" type="text/css" />
    <link href="../../css/demo.css" rel="stylesheet" type="text/css" />
    <link href="../../css/loaders.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class='login'>
    <div class='login_title'>
        <span>admin</span>
    </div>
    <div class='login_fields'>
        <div class='login_fields__user'>
            <div class='icon'>
                <img alt="" src='../../img/user_icon_copy.png'>
            </div>
            <input name="userName" placeholder='用户名' maxlength="16" type='text' autocomplete="off" />
        </div>
        <div class='login_fields__password'>
            <div class='icon'>
                <img alt="" src='../../img/lock_icon_copy.png'>
            </div>
            <input name="password" placeholder='密码' maxlength="16" type='text' autocomplete="off">
        </div>
        <div class='login_fields__submit'>
            <input type='button' value='登录'>
        </div>
    </div>
    <div class='success'>
    </div>
</div>
<div class='authent'>
    <div class="loader" style="height: 44px;width: 44px;margin-left: 28px;">
        <div class="loader-inner ball-clip-rotate-multiple">
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>
    <p>认证中...</p>
</div>
<link href="../../layui/css/layui.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.min.js"></script>
<script type="text/javascript" src='../../js/stopExecutionOnTimeout.js?t=1'></script>
<script type="text/javascript" src="../../layui/layui.js"></script>
<script type="text/javascript" src="../../js/Particleground.js"></script>
<script type="text/javascript" src="../../js/Treatment.js"></script>
<script type="text/javascript" src="../../js/jquery.mockjax.js"></script>
<script type="text/javascript">
    $(document).keypress(function (e) {
        // 回车键事件
        if (e.which == 13) {
            $('input[type="button"]').click();
        }
    });
    //粒子背景特效
    $('body').particleground({
        dotColor: '#E8DFE8',
        lineColor: '#133b88'
    });
    $('input[name="password"]').focus(function () {
        $(this).attr('type', 'password');
    });
    $('input[type="text"]').focus(function () {
        $(this).prev().animate({ 'opacity': '1' }, 200);
    });
    $('input[type="text"],input[type="password"]').blur(function () {
        $(this).prev().animate({ 'opacity': '.5' }, 200);
    });
    $('input[name="userName"],input[name="password"]').keyup(function () {
        var Len = $(this).val().length;
        if (!$(this).val() == '' && Len >= 5) {
            $(this).next().animate({
                'opacity': '1',
                'right': '30'
            }, 200);
        } else {
            $(this).next().animate({
                'opacity': '0',
                'right': '20'
            }, 200);
        }
    });
    var open = 0;
    layui.use('layer', function () {
        //非空验证
        $('input[type="button"]').click(function () {
            var login = $('input[name="userName"]').val();
            var password = $('input[name="password"]').val();
            if (login == '') {
                ErroAlert('请输入您的账号');
            } else if (password == '') {
                ErroAlert('请输入密码');
            } else {
                //认证中..
                $('.login').addClass('test'); //倾斜特效
                setTimeout(function () {
                    $('.login').addClass('testtwo'); //平移特效
                }, 300);
                setTimeout(function () {
                    $('.authent').show().animate({ right: -320 }, {
                        easing: 'easeOutQuint',
                        duration: 600,
                        queue: false
                    });
                    $('.authent').animate({ opacity: 1 }, {
                        duration: 200,
                        queue: false
                    }).addClass('visible');
                }, 500);
                $.ajax({
                    url:"/auth",
                    data:{
                        userName:login,
                        password:password,
                    },
                    success:function (resp) {
                        setTimeout(function () {
                            $('.authent').show().animate({ right: 90 }, {
                                easing: 'easeOutQuint',
                                duration: 600,
                                queue: false
                            });
                            $('.authent').animate({ opacity: 0 }, {
                                duration: 200,
                                queue: false
                            }).addClass('visible');
                            $('.login').removeClass('testtwo'); //平移特效
                        }, 2000);
                        setTimeout(function () {
                            $('.authent').hide();
                            $('.login').removeClass('test');
                            if (resp==="1") {
                                //登录成功
                                window.location.href="/home"
                            } else {
                                ErroAlert("登录失败")
                            }
                        }, 2400);
                    }
                })
            }
        })
    })
</script>

</body>
</html>
