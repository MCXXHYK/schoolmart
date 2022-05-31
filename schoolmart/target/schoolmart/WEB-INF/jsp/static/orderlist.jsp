<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的订单</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<style>
    th {
        vertical-align: middle !important;
    }

    td {
        vertical-align: middle !important;
    }
</style>
<body>
<jsp:include page="../header.jsp">
    <jsp:param name="flag" value="4"></jsp:param>
</jsp:include>
<h3 class="text-center">我的订单</h3>
<div id="con" class="container">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table-bordered table-striped" style="font-size: x-small">
                <thead>
                <tr>
                    <th class="text-center">订单号</th>
                    <th class="text-center">商品名</th>
                    <th class="text-center">购买用户</th>
                    <th class="text-center">手机号</th>
                    <th class="text-center">收货地址</th>
                    <th class="text-center">购买数量</th>
                    <th class="text-center">总计</th>
                    <th class="text-center">购买时间</th>
                    <th class="text-center">订单状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.p.list}" var="order">
                    <tr>
                        <td class="text-center">${order.oid}</td>
                        <td class="text-center">${order.bname}</td>
                        <input type="hidden" id="bname" value="${order.bname}"/>
                        <input type="hidden" id="uemail" value="${order.uemail}"/>
                        <td class="text-center">${order.uemail}</td>
                        <td class="text-center">${order.telnum}</td>
                        <td class="text-center">${order.address}</td>
                        <td class="text-center">${order.oamount}</td>
                        <td class="text-center">￥${order.ototal}</td>
                        <td class="text-center">${order.odate}</td>
                        <td class="text-center">${order.ostatus}</td>
                        <td class="text-center" style="width: 50px">


                            <a href="#"
                               class="btn btn-primary btn-sm <c:if test="${order.ostatus !='未付款'}">disabled</c:if>"
                               onclick="ensurePay(${order.oid})" data-toggle="modal" data-target="#myModal">确认支付</a>
                            <a href="#"
                               class="btn btn-success btn-sm <c:if test="${order.ostatus !='已发货'}">disabled</c:if>"
                               onclick="makesure(${order.oid})">确认收货</a>
                            <a href="javascript:;" onclick="delOrder(${order.oid});"
                               class="btn btn-danger btn-sm <c:if test="${order.ostatus !='未付款'}">disabled</c:if>">取消订单</a>
                            <a href="javascript:;" onclick="delOrder(${order.oid});"
                               class="btn btn-danger btn-sm">删除订单</a>
                            <a class="btn btn-primary btn-xs <c:if test="${order.ostatus !='已确认收货'}">disabled</c:if>"
                               href="javascript:;"
                               onclick="comment_sub('${order.bname}')" <%--data-toggle="modal" data-target="#commentModal"--%>>评价</a>
                        </td>
                        <script>
                            function delOrder(oid) {
                                console.log(oid);
                                //发送异步请求
                                $.get("${pageContext.request.contextPath}/order/delorder", {oid: oid}, function (res) {
                                    console.log(res);
                                    if (res.status) {
                                        $("#MsgS").show(1000);
                                        setTimeout(function () {
                                            $("#MsgS").hide(1000);
                                            window.location.href = "${pageContext.request.contextPath}/order/findOrderList";
                                        }, 2000);
                                    } else {
                                        $("#MsgF").show(3000);
                                    }
                                })
                            }

                            function ensurePay(oid) {
                                console.log(oid);
                                $.get("${pageContext.request.contextPath}/order/findOrderById", {oid: oid}, function (res) {
                                    console.log(res);
                                    $("#bidp").text(res.bname)
                                    $("#uidp").text(res.uid)
                                    $("#tid").val(res.bname)
                                    $("#oid").val(oid)
                                    $("#yid").val(res.uid)
                                    $("#bi").val(res.uemail)
                                    $("#bn").val(res.telnum)
                                    $("#bp").val(res.address)
                                    $("#oamounts").val(res.oamount)
                                }, "JSON")
                            }


                            function makesure(oid) {
                                $.post("${pageContext.request.contextPath}/order/makesure", {oid: oid}, function (res) {

                                    if (res.status) {

                                        alert(res.msg);
                                        window.location.href = "${pageContext.request.contextPath}/order/findOrderList";
                                        /*toastr.success(res.msg);*/

                                        /*window.location.href会屏蔽掉toastr的效果！*/
                                    } else {
                                        alert(res.msg);
                                        /*toastr.error(res.msg);*/
                                    }
                                })
                            }

                            function comment_sub(name1) {
                                $("#name").val(name1);
                                console.log(name1)
                                $("#commentModal").modal('show');
                            }
                        </script>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
    <div id="MsgS" class="alert alert-success alert-dismissible" style="display: none" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                aria-hidden="true">&times;</span></button>
        <strong>删除成功！</strong>该订单已被删除
    </div>
    <div id="MsgF" class="alert alert-danger alert-dismissible" style="display: none" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                aria-hidden="true">&times;</span></button>
        <strong>删除失败</strong>数据异常：
    </div>

    <jsp:include page="../indexpage.jsp">
        <jsp:param value="${pageContext.request.contextPath}/order/pageOrders?uid=${requestScope.p.uid}" name="url"/>
    </jsp:include>
    <jsp:include page="footer.jsp"/>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-info" id="myModalLabel"><span class="glyphicon glyphicon-user"></span>确认您的信息
                </h5>
            </div>
            <form id="userIF" action="${pageContext.request.contextPath}/order/alipay">
                <div class="modal-body">

                    <div class="form-group">
                        <label for="tid">商品名称</label>
                        <p class="form-control-static" id="bidp">10</p>
                        <input type="hidden" class="form-control" id="tid" name="bname">
                        <input type="hidden" class="form-control" id="oid" name="oid">
                    </div>
                    <div class="form-group">
                        <label for="yid">用户编号</label>
                        <p class="form-control-static" id="uidp">10</p>
                        <input type="hidden" class="form-control" id="yid" name="uid">
                    </div>
                    <div class="form-group">
                        <label for="bi">邮箱</label>
                        <input type="text" class="form-control" id="bi" name="uemail" placeholder="请输入用户邮箱">
                    </div>
                    <div class="form-group">
                        <label for="bn">手机号</label>
                        <input type="number" class="form-control" id="bn" name="telnum" placeholder="请确认你的邮箱">
                    </div>
                    <div class="form-group">
                        <label for="bp">收货地址</label>
                        <input type="text" class="form-control" id="bp" name="address" placeholder="请输入收货地址">
                    </div>
                    <div class="form-group">
                        <label for="bp">购买数量</label>
                        <input type="text" class="form-control" name="oamount" id="oamounts" placeholder="请输入购买数量">
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-info" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-success">支付</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal" tabindex="-1" role="dialog" id="commentModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-title">请填写评价信息</span>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-horizontal">
                    <input type="hidden" id="uid" value="${sessionScope.user.uid}"/>
                    <input type="hidden" id="name" name="bname"/>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">评价内容</label>
                        <div class="col-sm-7">
                                <textarea type="text" class="form-control" id="content" name="content"
                                          placeholder="请输入评价内容"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="commentSubmit()">提交</button>
            </div>
            <script>
                function commentSubmit() {
                    var bname = $("#name").val();
                    var uid = $("#uid").val();
                    var content = $("#content").val();
                    var uemail = $("#uemail").val();
                    console.log(bname, uid, content);
                    $.post("${pageContext.request.contextPath}/comment/addComment",
                        {
                            bname: bname,
                            uid: uid,
                            content: content,
                            uemail: uemail
                        },
                        function (res) {
                            if (res.status) {
                                /*alert(res.msg);*/
                                toastr.info(res.msg);
                                $("#commentModal").modal('hide');
                            } else {
                                /*alert(res.msg)*/
                                toastr.info(res.msg);
                            }
                        }, "JSON")
                }
            </script>
        </div>
    </div>
</div>
</body>
</html>