<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<%--
  Created by IntelliJ IDEA.
  User: ZEROMan
  Date: 2020/12/13
  Time: 14:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户信息更改</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<body>
<jsp:include page="../header.jsp">
    <jsp:param name="flag" value="5"></jsp:param>
</jsp:include>
<div class="container-fluid">
    <div class="row" style="margin-top: 80px">
        <div class="col-md-4 col-md-offset-4">
            <h1 style="color: #2aabd2">SweetLove校园超市平台<small>用户信息修改</small></h1>
        </div>
    </div>
    <div class="row text-center">
        <div class="col-sm-6 col-sm-offset-3">
            <form id="indexmyinfo">
                <div class="form-group">
                    <label class="pull-left">账户邮箱</label>
                    <input type="text" class="form-control" name="uemail" value="${user0.uemail}" style="height: 40px">
                </div>
                <div class="form-group">
                    <label class="pull-left">手机号</label>
                    <input type="text" class="form-control" name="telnum" value="${user0.telnum}" style="height: 40px">
                </div>
                <div class="form-group">
                    <label class="pull-left">收货地址</label>
                    <input type="text" class="form-control" name="address" value="${user0.address}"
                           style="height: 40px">
                </div>
                <div class="form-group">
                    <label class="pull-left">性别</label>
                    <%--<input type="text" class="form-control" name="usex"  value="${user0.usex}" style="height: 40px">--%>
                    <input type="hidden" name="uid" value="${user0.uid}"/>
                    <select class="form-control" name="usex">
                        <option id="sex1">${user0.usex}</option>
                        <option>
                            <c:if test="${user0.usex=='男'}">女</c:if>
                            <c:if test="${user0.usex=='女'}">男</c:if>
                        </option>
                    </select>
                </div>
                <button type="button" onclick="upinfo()" class="btn btn-danger btn-block" style="margin-top: 10px">确定
                </button>
                <script>
                    function upinfo() {
                        $.post("${pageContext.request.contextPath}/user/updateUserInfo", $("#indexmyinfo").serialize(), function (res) {
                            console.log(res);
                            if (res.status) {
                                alert(res.msg + "即将返回主页");
                                window.location.href = "${pageContext.request.contextPath}/lead/index";
                            } else {
                                alert(res.msg);
                            }
                        }, "JSON")
                    }
                </script>
            </form>
        </div>
    </div>
</div>
</body>
</html>
