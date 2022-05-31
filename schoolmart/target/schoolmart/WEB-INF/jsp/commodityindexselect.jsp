<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ZEROMan
  Date: 2020/12/12
  Time: 12:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<body>
<jsp:include page="header.jsp">
    <jsp:param name="flag" value="3"></jsp:param>
</jsp:include>
<div class="container" id="booklib">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="alert alert-danger">你的搜索结果</div>
            <c:forEach items="${commodity1}" var="commoditycol">
                <div class="col-md-3">
                    <div class="thumbnail">
                        <a href="${pageContext.request.contextPath}/lead/detail?bid=${commoditycol.bid}"><img
                                src="${pageContext.request.contextPath}/upload/${commoditycol.bcover}"
                                style="width: 240px;height: 280px"></a>
                        <div class="caption text-center">
                            <h3>￥${commoditycol.bprice}</h3>
                            <p style="font-size: xx-small">${commoditycol.bname}</p>
                            <p><a href="#" onclick="addCart(${commoditycol.bid})" class="btn btn-info"
                                  role="button">购物车</a> <a href="#" class="btn btn-default" role="button"
                                                           onclick="buycommodity(${sessionScope.user.uid},${commoditycol.bid})"
                                                           data-toggle="modal" data-target="#myModal">立即购买</a></p>
                            <script>
                                function buycommodity(uid, bid) {
                                    console.log(uid);
                                    $.get("${pageContext.request.contextPath}/user/findUserById", {uid: uid}, function (res) {
                                        console.log(res);
                                        $("#bidp").text(bid)
                                        $("#uidp").text(res.uid)
                                        $("#tid").val(bid)
                                        $("#yid").val(res.uid)
                                        $("#bi").val(res.uemail)
                                        $("#bn").val(res.telnum)
                                        $("#bp").val(res.address)
                                    }, "JSON")
                                }

                                function addCart(gid) {
                                    $.post("${pageContext.request.contextPath}/cart/addGoodsInCart", {
                                        "number": 1,
                                        "bid": gid
                                    }, function () {
                                        /*alert("添加购物车成功！");*/
                                        toastr.info("添加购物车成功!");
                                    });
                                }
                            </script>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<jsp:include page="static/footer.jsp"/>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-info" id="myModalLabel"><span class="glyphicon glyphicon-user"></span>确认您的信息
                </h5>
            </div>
            <div class="modal-body">
                <form id="userIF">
                    <div class="form-group">
                        <label for="tid">商品编号</label>
                        <p class="form-control-static" id="bidp">10</p>
                        <input type="hidden" class="form-control" id="tid" name="bid">
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
                        <input type="text" class="form-control" name="oamount" placeholder="请输入购买数量">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-success" onclick="sure()">确认购买</button>
                <script>
                    function sure() {
                        console.log($("#userIF").serialize()); //表单序列化 获取表单数据
                        $.post("${pageContext.request.contextPath}/order/buycommodity", $("#userIF").serialize(), function (res) {
                            if (res.status) {
                                /*alert(res.msg);*/
                                toastr.success(res.msg);
                                $("#myModal").modal('hide');
                            } else {
                                toastr.error(res.msg);
                                $("#myModal").modal('hide');
                            }
                        }, "JSON")
                    }
                </script>
            </div>
        </div>
    </div>
</div>
</body>
</html>
