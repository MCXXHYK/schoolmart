<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<%--
  Created by IntelliJ IDEA.
  User: YK_ZERO
  Date: 2021/4/16
  Time: 19:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">

<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<html>
<head>
    <title>我的购物车</title>
</head>
<body>
<jsp:include page="../header.jsp">
    <jsp:param name="flag" value="6"></jsp:param>
</jsp:include>
<h1 class="text-center">我的购物车</h1>
<div class="container clearfix">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="wrap">
                <div id="shopping">
                    <c:if test="${sessionScope.cart.totalPrice!=0&&sessionScope.cart!=null}">
                        <form action="#">
                            <table class="table table-hover">
                                <tr>
                                    <th>商品名称</th>
                                    <th>单价（元）</th>
                                    <th>购买数量</th>
                                    <th>金额（元）</th>
                                    <th>操作</th>
                                </tr>
                                <c:forEach var="good" items="${sessionScope.cart.goods}">
                                    <tr id="product_id_1">
                                        <td class="thumb"><img height="80" width="80"
                                                               src="${pageContext.request.contextPath}/upload/${good.key.bcover}"/><a
                                                href="${pageContext.request.contextPath}/lead/detail?bid=${good.key.bid}">${good.key.bname}</a>
                                        </td>
                                        <td class="price" style="vertical-align: middle!important;">
                                            <span>￥${good.key.bprice}</span>
                                            <input id="price${good.key.bid}" type="hidden" value="${good.key.bprice}"/>
                                        </td>
                                        <td class="number" style="vertical-align: middle!important;">
                                            <span id="sub" onclick="sub(${good.key.bid});"><span
                                                    class="glyphicon glyphicon-minus" aria-hidden="true"></span></span>
                                            <input style="height: 25px; width:25px;" type="text"
                                                   id="number${good.key.bid}" name="number" value="${good.value}"
                                                   size="2" readonly/>
                                            <span id="add" onclick="add(${good.key.bid});"><span
                                                    class="glyphicon glyphicon-plus" aria-hidden="true"></span></span>
                                        </td>

                                        <script>
                                            function add(id) {
                                                var num = parseInt(document.getElementById("number" + id).value);
                                                var goodSum = document.getElementById("goodSum" + id);
                                                var sum = document.getElementById("sum");
                                                var hiddenSum = document.getElementById("hiddenSum");
                                                if (num < 100) {
                                                    document.getElementById("number" + id).value = ++num;
                                                    goodSum.innerHTML = document.getElementById("number" + id).value * document.getElementById("price" + id).value;
                                                    window.location.href = "${pageContext.request.contextPath}/cart/addGoodsInCart?number=1&bid=" + id;
                                                }
                                            }

                                            function sub(id) {
                                                var num = parseInt(document.getElementById("number" + id).value);
                                                var goodSum = document.getElementById("goodSum" + id);
                                                var sum = document.getElementById("sum");
                                                var hiddenSum = document.getElementById("hiddenSum");
                                                if (num > 1) {
                                                    document.getElementById("number" + id).value = --num;
                                                    goodSum.innerHTML = document.getElementById("number" + id).value * document.getElementById("price" + id).value;
                                                    hiddenSum.value = parseInt(hiddenSum.value) - parseInt(document.getElementById("price" + id).value);
                                                    window.location.href = "${pageContext.request.contextPath}/cart/addGoodsInCart?number=-1&bid=" + id;
                                                }
                                            }
                                        </script>
                                        <td class="price" style="vertical-align: middle!important;">
                                            <span>￥</span>
                                            <span id="goodSum${good.key.bid}">${good.key.bprice*good.value}</span>
                                        </td>
                                        <td class="delete" style="vertical-align: middle!important;"><a
                                                class="btn btn-danger"
                                                href="${pageContext.request.contextPath}/cart/removeGoodsFromCart?bid=${good.key.bid}">删除</a>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <tr class="warning">
                                    <td colspan="" rowspan="" headers="">合计金额</td>
                                    <td colspan="" rowspan="" headers=""></td>
                                    <td colspan="" rowspan="" headers=""></td>
                                    <td colspan="" rowspan="" headers=""></td>
                                    <td class="price" id="price_id_1">
                                        <span>￥</span>
                                        <span id="sum">${sessionScope.cart.totalPrice }</span>
                                        <input id="hiddenSum" type="hidden" value="${sessionScope.cart.totalPrice}"/>
                                    </td>
                                </tr>
                            </table>
                            <div class="button">
                                <a class="btn btn-danger" onclick="confirmClear()" href="#">清空购物车</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <c:if test="${sessionScope.user!=null}"><a href="#" class="btn btn-info"
                                                                           onclick="account()"
                                                                           style="float: right">结算</a></c:if>
                                <script>
                                    function account() {
                                        window.location.href = "${pageContext.request.contextPath}/cart/accountCart";
                                    }

                                    function confirmClear() {
                                        if ($("#myConfirm").length > 0) {
                                            $("#myConfirm").remove();
                                        }
                                        var html = "<div class='modal fade' id='myConfirm' >"
                                            + "<div class='modal-backdrop in' style='opacity:0; '></div>"
                                            + "<div class='modal-dialog' style='z-index:2901; margin-top:60px; width:400px; '>"
                                            + "<div class='modal-content'>"
                                            + "<div class='modal-header'  style='font-size:16px; '>"
                                            + "<span class='glyphicon glyphicon-envelope'>&nbsp;</span>提示信息！<button type='button' class='close' data-dismiss='modal'>"
                                            + "<span style='font-size:20px;  ' class='glyphicon glyphicon-remove'></span><tton></div>"
                                            + "<div class='modal-body text-center' id='myConfirmContent' style='font-size:18px; '>"
                                            + "是否确定要清空？"
                                            + "</div>"
                                            + "<div class='modal-footer ' style=''>"
                                            + "<button class='btn btn-danger ' id='confirmOk' >确定<tton>"
                                            + "<button class='btn btn-info ' data-dismiss='modal'>取消<tton>"
                                            + "</div>" + "</div></div></div>";
                                        $("body").append(html);

                                        $("#myConfirm").modal("show");

                                        $("#confirmOk").on("click", function () {
                                            $("#myConfirm").modal("hide");
                                            window.location.href = "${pageContext.request.contextPath}/cart/cleanCart";
                                        });
                                    }
                                </script>
                                <c:if test="${sessionScope.user==null}">
                                    <button onclick="javascript:alert('请登录后再结算！');" href="#"></button>
                                </c:if>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${sessionScope.cart.totalPrice==0||sessionScope.cart==null}">
                        <img src="${pageContext.request.contextPath}/upload/empty.jpg"/>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
