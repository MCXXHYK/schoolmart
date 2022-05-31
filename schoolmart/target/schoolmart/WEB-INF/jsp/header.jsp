<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ZEROMan
  Date: 2020/12/11
  Time: 12:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/toastr.min.css">
<script src="${pageContext.request.contextPath}/js/toastr.min.js"></script>
<script>
    toastr.options = {

        "closeButton": false, //是否显示关闭按钮

        "debug": false, //是否使用debug模式

        "positionClass": "toast-center-center",//弹出窗的位置

        "showDuration": "300",//显示的动画时间

        "hideDuration": "500",//消失的动画时间

        "timeOut": "2000", //展现时间

        "extendedTimeOut": "500",//加长展示时间

        "showEasing": "swing",//显示时的动画缓冲方式

        "hideEasing": "linear",//消失时的动画缓冲方式

        "showMethod": "fadeIn",//显示时的动画方式

        "hideMethod": "fadeOut" //消失时的动画方式
    };
</script>
<nav class="navbar navbar-default">
    <!--屏幕不留白-->
    <div class="container">
        <div class="col-md-12 col-md-offset-1">
            <!--屏幕自适应-->
            <div class="navbar-header" style="height: 80px;margin-top: 25px;">

                <a class="navbar-brand" href="#">SweetLove校园超市<small><small>dirt-cheap</small></small></a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="#" onclick="backindex()" class=<c:if test="${param.flag ==1}">"active"</c:if> >首页</a>
                    </li>
                    <script>
                        function backindex() {
                            window.location.href = "${pageContext.request.contextPath}/lead/index";
                        }
                    </script>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                           aria-expanded="false">商品分类<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <c:forEach items="${btypes}" var="btypes">
                                <li>
                                    <a href="${pageContext.request.contextPath}/commodity/selectbytype?btype=${btypes}">${btypes}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </li>
                </ul>
                <form class="navbar-form" action="${pageContext.request.contextPath}/commodity/selectbyname">
                    <div class="form-group" style="width: 320px">
                        <input type="text" style="width: 320px" name="bname" class="form-control" placeholder="搜搜你的喜欢">

                    </div>
                    <button type="submit" class="btn btn-default">搜！</button>
                </form>
                <ul class="nav navbar-nav">
                    <li><a href="#">欢迎：<span class="text-danger">${user.uemail}</span></a></li>
                    <li><a href="${pageContext.request.contextPath}/order/mycart">我的购物车</a></li>
                    <li><a href="${pageContext.request.contextPath}/order/findOrderList">我的订单</a></li>
                    <li>
                        <a href="${pageContext.request.contextPath}/comment/PageEvaluation?uid=${sessionScope.user.uid}">我的评价</a>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                           aria-expanded="false">个人中心 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="${pageContext.request.contextPath}/user/indexuserinfo">我的信息</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="${pageContext.request.contextPath}/user/toupdateupwd">修改密码</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="${pageContext.request.contextPath}/user/logout">退出登录</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>

