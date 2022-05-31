<%--
  Created by IntelliJ IDEA.
  User: ZEROMan
  Date: 2020/12/9
  Time: 19:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.validate-1.13.1.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<body>
<jsp:include page="../header.jsp">
    <jsp:param name="flag" value="7"></jsp:param>
</jsp:include>
<div class="container">
    <div class="row" style="margin-top: 80px">
        <div class="col-sm-6 col-sm-offset-3">
            <h1 style="color: #2aabd2">SweetLove校园超市 <small>用户密码修改</small></h1>

            <form id="Form" class="text-center">
                <input type="hidden" class="text" name="uid" id="uid" value="${sessionScope.user.uid }"/>
                <label>旧&ensp;密&ensp;码:</label><input class="form-control" id="password" name="password"
                                                      placeholder="请输入您的旧密码" readonly
                                                      onfocus="this.removeAttribute('readonly');"/>
                <br/>
                <br/>
                <label>新&ensp;密&ensp;码:</label><input class="form-control" type="password" id="newPassword"
                                                      name="newPassword" placeholder="请设置您的新密码(不少于8位)" readonly
                                                      onfocus="this.removeAttribute('readonly');"/>
                <br/>
                <br/>
                <label>确认密码:</label><input class="form-control" type="password" name="rePassword"
                                           placeholder="请再次确认您的新密码" readonly
                                           onfocus="this.removeAttribute('readonly');"/>
                <br/>
                <br/>
                <input class="btn btn-info btn-block" type="button" name="submit" id="submit" value="更新"/>
            </form>
        </div>
    </div>
</div>


<script>
    var validator;
    $(document).ready(function () {
        $.validator.setDefaults({});

        validator = $("#Form").validate({
            rules: {
                password: {
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
                password: {
                    required: "必须填写旧密码",
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
    $(document).ready(function () {
        $("#submit").click(function () {
            $.post("${pageContext.request.contextPath}/user/updateupwd", {
                    uid: $("#uid").val(),
                    password: $("#password").val(),
                    newPassword: $("#newPassword").val()
                },
                function (data) {
                    if (data == 'success') {
                        alert("修改密码成功,请重新登录");
                        window.location.href = "${pageContext.request.contextPath}/user/logout";
                    }
                    if (data == 'false') {
                        /*alert("旧密码输入有误");*/
                        toastr.warning("旧密码输入有误!");
                    }
                    if (data == 'pwdEmpty') {
                        /*alert("密码不能为空");*/
                        toastr.warning("密码不能为空!");
                    }
                    if (data == 'newEmpty') {
                        /*alert("确认密码不能为空");*/
                        toastr.warning("确认密码不能为空!");
                    }
                });
        });
    });
</script>
</body>
</html>
