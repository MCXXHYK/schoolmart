<!DOCTYPE html>
<html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <!-- 引入 jquery、Bootstrap -->
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/toastr.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/toastr.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.cookie.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.validate-1.13.1.js"></script>
</head>

<body>
<!-- 登录表单 -->
<div class="login-form">
    <center><span>校园超市平台系统</span></center>
    <center><span style="color: red;font-size: x-small">${message}</span></center>
    <form id="loginForm" action="${pageContext.request.contextPath}/user/login" method="post">
        <div class="form-group">
            <label for="uemail">用户名</label>
            <input type="text" class="form-control" name="uemail" id="uemail" placeholder="请输入您的邮箱" readonly
                   onfocus="this.removeAttribute('readonly');">
        </div>
        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" class="form-control" name="upwd" id="password" placeholder="请输入您的密码" readonly
                   onfocus="this.removeAttribute('readonly');"><br>
            <label><input id="remember" type="checkbox" checked="checked">记住密码</label>
        </div>
        <div class="c3-1">
            <center>
                <button id="login" type="submit" onclick="setCookie()" class="btn btn-primary">登录</button>
                <script>
                    function setCookie() {
                        //把信息设置进去Cookie里面去
                        var userName = $('#uemail').val();
                        var passWord = $('#password').val();
                        var aa = $("input[id='remember']").is(":checked");//获取是否选中
                        if (aa === true) {//如果选中-->记住密码登录
                            $.cookie("uemail", userName.trim(), {expires: 7});//有效时间7天，也可以设置为永久，把时间去掉就好
                            $.cookie("upwd", passWord.trim(), {expires: 7});
                        } else {//如果没选中-->不记住密码登录
                            $.cookie("uemail", "");
                            $.cookie("upwd", "");
                            /*alert("没有记住密码")*/
                            toastr.error("没有记住密码！")
                        }

                    }

                    $(document).ready(function () {
                        //获取cookie
                        var userName = $.cookie("uemail"); //获取cookie中的用户名
                        var pwd = $.cookie("upwd"); //获取cookie中的登陆密码
                        if (pwd) {//密码存在的话把“记住用户名和密码”复选框勾选住
                            $("[id='rememenber']").attr("checked", "true");
                        }
                        if (userName != "") {//用户名存在的话把用户名填充到用户名文本框
                            $("#uemail").val(userName);
                        } else {
                            $("#uemail").val("");
                        }
                        if (pwd != "") {//密码存在的话把密码填充到密码文本框
                            $("#password").val(pwd);
                        } else {
                            $("#password").val("");
                        }
                    })
                </script>
            </center>
            <br/>
            <a href="#" id="searchPwd" data-toggle="modal" data-target="#searchPwd-window">忘记密码</a>
            <a href="#" id="toRegister" data-toggle="modal" data-target="#register-window">立即注册</a>
        </div>
    </form>
</div>
<!-- 注册框 -->

<div class="modal fade" id="register-window" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-center" id="myModalLabel1">注册</h4>
            </div>
            <form class="form-inline"
                  id="login_form" <%--action="${pageContext.request.contextPath}/user/register" method="post"--%>>
                <div class="modal-body text-center">

                    <label>用&ensp;户&ensp;名:</label><input class="form-control" id="email" name="uemail"
                                                          placeholder="请设置您的用户名" readonly
                                                          onfocus="this.removeAttribute('readonly');"/>
                    <br/>
                    <br/>
                    <label>密&emsp;&emsp;码:</label><input class="form-control" type="password" name="upwd"
                                                         placeholder="请设置您的密码(不少于8位)" readonly
                                                         onfocus="this.removeAttribute('readonly');"/>
                    <br/>
                    <br/>
                    <label>手&ensp;机&ensp;号:</label><input class="form-control" name="telnum" placeholder="请输入您的手机号"
                                                          readonly onfocus="this.removeAttribute('readonly');"/>
                    <br/>
                    <br/>
                    <label>地&emsp;&emsp;址:</label><input class="form-control" name="address" placeholder="请输入收货地址"
                                                         readonly onfocus="this.removeAttribute('readonly');"/>
                    <input type="hidden" name="type" value="0"/>
                    <br/>
                    <br/>
                    <label>性&emsp;&emsp;别:</label>
                    <select class="form-control" name="usex">
                        <option>请选择</option>
                        <option>男</option>
                        <option>女</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" id="register" class="btn btn-primary">注册</button>
                </div>
            </form>
            <script>
                toastr.options = {

                    "closeButton": false, //是否显示关闭按钮

                    "debug": false, //是否使用debug模式

                    "positionClass": "toast-center-center",//弹出窗的位置

                    "showDuration": "1500",//显示的动画时间

                    "hideDuration": "1000",//消失的动画时间

                    "timeOut": "2000", //展现时间

                    "extendedTimeOut": "1000",//加长展示时间

                    "showEasing": "swing",//显示时的动画缓冲方式

                    "hideEasing": "linear",//消失时的动画缓冲方式

                    "showMethod": "fadeIn",//显示时的动画方式

                    "hideMethod": "fadeOut" //消失时的动画方式
                };
                $('#register').click(function () {
                    $.post('${pageContext.request.contextPath}/user/register', $('#login_form').serialize(), function (res) {
                        if (res.status === true) {
                            /*alert(res.msg);*/
                            toastr.success(res.msg);
                            $("#register-window").modal('hide');
                            var ipts = $(":input");
                            console.log(ipts.length);
                            for (var i = 0; i < ipts.length; i++) {
                                if (ipts[i].type == "text") {
                                    ipts[i].value = "";
                                }
                            }
                        } else if (res.status === false) {
                            /*alert(res.msg);*/
                            toastr.success(res.msg);
                        } else {
                            /*alert(res.msg);*/
                            toastr.error(res.msg);
                            $("#email").val("");
                        }
                    }, "JSON")
                });

                function resetPwdF() {
                    $.post("${pageContext.request.contextPath}/user/forgetupwd", {
                            uid: $("#uid").val(),
                            newPassword: $("#newPassword").val()
                        },
                        function (data) {
                            /*alert(data);*/
                            if (data == 'success') {
                                /*alert("密码重置成功,请登录！");*/
                                toastr.success("密码重置成功,请登录！");
                                $("#searchPwd-window").modal("hide");
                            }
                            if (data == 'false') {
                                /*alert("旧密码输入有误");*/
                                toastr.error("旧密码输入有误!");

                            }
                            if (data == 'uidEmpty') {
                                /*alert("用户ID不能为空");*/
                                toastr.warning("用户ID不能为空!");
                            }
                            if (data == 'newEmpty') {
                                /*alert("确认密码不能为空");*/
                                toastr.warning("确认密码不能为空!");
                            }
                        });
                }


                var validator;
                $(document).ready(function () {


                    $.validator.setDefaults({});

                    validator = $("#Form").validate({
                        rules: {
                            uid: {
                                required: true,
                            },
                            newPassword: {
                                required: true,
                            },
                            rePassword: {
                                required: true,
                                equalTo: "#newPassword"
                            }
                        },
                        messages: {
                            uid: {
                                required: "必须填写用户ID",
                            },
                            newPassword: {
                                required: "必须填写密码",
                            },
                            rePassword: {
                                required: "必须填写确认密码",
                                equalTo: "两次输入的密码不一致"
                            }
                        }
                    });
                });
            </script>
        </div>
    </div>
</div>
<!-- 找回密码框 -->
<div class="modal fade" id="searchPwd-window" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">重置密码</h4>
            </div>
            <div class="modal-body">
                <form class="form-inline" id="Form" role="form">
                    <label>I&emsp;&emsp;D：</label><input class="form-control" id="uid" name="uid"
                                                         placeholder="请输入您的用户ID" readonly
                                                         onfocus="this.removeAttribute('readonly');"/>
                    <br/>
                    <br/>
                    <label>新&ensp;密&ensp;码:</label><input class="form-control" type="password" id="newPassword"
                                                          name="upwd" placeholder="请设置您的新密码(不少于8位)" readonly
                                                          onfocus="this.removeAttribute('readonly');"/>
                    <br/>
                    <br/>
                    <label>确认密码:</label><input class="form-control" type="password" id="rePassword"
                                               placeholder="请再次确认您的新密码" readonly
                                               onfocus="this.removeAttribute('readonly');"/>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="resetPwd" onclick="resetPwdF()" class="btn btn-primary">重置密码</button>
            </div>
        </div>
    </div>
</div>
</body>
<style type="text/css">
    html body {
        background: url('${pageContext.request.contextPath}/upload/school_bg.jpg') no-repeat;
        background-size: cover;
    }

    span {
        font-family: "微软雅黑";
        font-size: 30px;

    }

    .login-form {
        width: 30%;
        margin: auto;
        margin-top: 15%;
        color: #4cf6ff;
    }

    #toRegister {
        float: right;
    }

    a {
        color: #37f9d5;
        font-weight: bold;
    }
</style>
</html>
