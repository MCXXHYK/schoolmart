<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: YK_ZERO
  Date: 2021/4/12
  Time: 8:21
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
    <jsp:param name="flag" value="5"></jsp:param>
</jsp:include>


<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="thumbnail">
                <a href="${pageContext.request.contextPath}/lead/detail?bid=${goods.bid}"><img
                        src="${pageContext.request.contextPath}/upload/${goods.bcover}"
                        style="width: 240px;height: 280px"></a>
                <div class="caption text-center">
                    <input id="gid" type="hidden" value="${goods.bid}">
                    <h3>￥${goods.bprice}</h3>
                    <h3>${goods.bname}</h3>
                    <%--<span class="count-group">
                            <button onclick="changeCount('-')">-</button><span id="count-id" style="margin: 0 5px">1</span><button
                            onclick="changeCount('+')">+</button></span>--%>
                    <p>购买数量：<span id="sub" onclick="subNum();"><span class="glyphicon glyphicon-minus"
                                                                     aria-hidden="true"></span></span>&nbsp;
                        <input style="height: 25px; width:25px;" id="number" name="number" value="1" size="2" readonly/>&nbsp;
                        <span id="add" onclick="addNum();"><span class="glyphicon glyphicon-plus"
                                                                 aria-hidden="true"></span></span></p>
                    <span style="margin-left: 15px; color: #666;">库存<span id="store-id">${goods.bstock}</span>件</span>
                    <p><a href="#" onclick="addCart()" class="btn btn-info" role="button">加入购物车</a> <a href="#"
                                                                                                       class="btn btn-default"
                                                                                                       role="button"
                                                                                                       onclick="buycommodity(${sessionScope.user.uid},${goods.bid})"
                                                                                                       data-toggle="modal"
                                                                                                       data-target="#myModal">立即购买</a>
                    </p>
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

                        function changeCount(type) {
                            let $count = $('#count-id');
                            let $store = $('#store-id');
                            let count = parseInt($count.text());
                            let store = parseInt($store.text());
                            if (type === '+') {
                                count = count === store ? store : count + 1;
                            } else {
                                count = count === 1 ? 1 : count - 1;
                            }
                            $count.text(count)
                        }

                        function addNum() {
                            var num = parseInt(document.getElementById("number").value);
                            if (num < 100) {
                                document.getElementById("number").value = ++num;
                            }
                        }

                        function subNum() {
                            var num = parseInt(document.getElementById("number").value);
                            if (num > 1) {
                                document.getElementById("number").value = --num;
                            }
                        }

                        function addCart() {
                            var number = $('#number').val();
                            var gid = $('#gid').val();
                            $.post("${pageContext.request.contextPath}/cart/addGoodsInCart", {
                                "number": number,
                                "bid": gid
                            }, function () {
                                alert("添加购物车成功！");
                            });
                        }
                    </script>
                </div>
            </div>
        </div>
        <div class="col-md-10 col-md-offset-1">
            <p>
                <span class="glyphicon glyphicon-tag label label-success"> 分类 : ${goods.btype}</span>
            </p>
            <p>
            <span class="glyphicon glyphicon-record label label-danger">
                商品描述：${goods.bdetail}
            </span>
            </p>
        </div>
    </div>
    <div class="container" style="margin-top: 20px">

        <div class="row">
            <div style="background-color: white; min-height: 300px">
                <div style="background-color: #ddd; height: 29px;" class="col-md-10 col-md-offset-1">
                    <span class="glyphicon glyphicon-tags label label-default"
                          style="font-weight: bold; margin-left: -15px; font-size: 19px"> 商品评价(${commentList.size()})</span>
                </div>
                <div id="comment-content">
                    <c:forEach items="${commentList}" var="commentList">
                        <div class="row">
                            <div class="col-md-10 col-md-offset-1">
                                <div class="row" style="padding: 0 40px ;margin-top: 29px;">
                                    <div class="col-md-12" id="emaildiv"
                                         style="text-align: left ;display: inline-block;margin-top: -5px;"><span
                                            class="glyphicon glyphicon-user label label-primary"> 用户:</span> ${commentList.uemail}
                                    </div>
                                    <div class="col-md-12"
                                         style="text-align: justify;display: inline-block;margin-top: 20px;"><span
                                            class="glyphicon glyphicon-comment label label-success"> 评价内容:</span>：${commentList.content}
                                    </div>
                                    <div class="col-md-12" style="text-align: right; margin-top: 10px">
                                        <span style="color: #888888">${commentList.createTime}</span>
                                        <hr>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <jsp:include page="static/footer.jsp"/>
    </div>
</div>
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
                                alert(res.msg);
                                $("#myModal").modal('hide');
                            } else {
                                alert(res.msg);
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
