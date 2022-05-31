<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    function getOrdersContidion() {
        var uemail = $('#exampleInputEmail2').val();
        $('#content').load('${pageContext.request.contextPath}/order/pageOrders?uemail=' + uemail);
    }
</script>
<div class="col-sm-10">
    <div class="page-header" style="margin-top: -22px;margin-bottom: 5px">
        <h1>订单管理</h1>
    </div>
    <div class="page-right" style="float: right;width: 100px;height: 50px;">

    </div>
    <script>
        //下载
        function downAll() {
            window.location.href = "${pageContext.request.contextPath}/Excel/exportOrderAllList";
        }

        function downTopthree() {
            window.location.href = "${pageContext.request.contextPath}/Excel/exportTopThreeList";
        }
    </script>
    <div>
        <ul class="nav nav-tabs">
            <!--标签选项卡-->
            <!--datatoggle用来绑定切换面板的时间-->
            <li><a href="#profile" data-toggle="tab" class="active">订单列表</a></li>
            <li><a href="javascript:downAll();">导出所有订单数据</a></li>
            <li><a href="javascript:downTopthree();">导出销量前三商品</a></li>
        </ul>

        <!--选项卡面板-->
        <div class="tab-content ">
            <!---->
            <div class="tab-pane active" id="profile">

                <div class="panel panel-default">
                    <div class="panel-body">
                        <form class="form-inline text-center" action="#">
                            <div class="form-group">
                                <label for="exampleInputEmail2">Email</label>
                                <input type="text" name="uemail" class="form-control" id="exampleInputEmail2"
                                       placeholder="请输入用户邮箱查询订单">
                            </div>
                            <button type="button" class="btn btn-primary" onclick="getOrdersContidion()">查询</button>
                        </form>
                        <table class="table table-hover table-bordered table-striped">
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
                                    <td class="text-center">${order.uemail}</td>
                                    <td class="text-center">${order.telnum}</td>
                                    <td class="text-center">${order.address}</td>
                                    <td class="text-center">${order.oamount}</td>
                                    <td class="text-center">￥${order.ototal}</td>
                                    <td class="text-center">${order.odate}</td>
                                    <td class="text-center">${order.ostatus}</td>
                                    <td class="text-center"><a href="javascript:;" onclick="delOrder(${order.oid});"
                                                               class="btn btn-danger btn-sm">删除订单</a>
                                        <a href="#" class="btn btn-primary btn-sm" onclick="modifyOrders(${order.oid})"
                                           data-toggle="modal" data-target="#myModal">修改订单</a>
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
                                                        getOrdersContidion();
                                                    }, 2000);

                                                } else {
                                                    $("#MsgF").show(1000);
                                                }
                                            })
                                        }

                                        function modifyOrders(oid) {
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
                                                $("#ostatus").val(res.ostatus)
                                            }, "JSON")
                                        }
                                    </script>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <jsp:include page="../page.jsp">
                            <jsp:param
                                    value="javascript:$('#content').load('${pageContext.request.contextPath}/order/pageOrders?uemail=${requestScope.p.uemail}"
                                    name="url"/>
                            <jsp:param value="${pageContext.request.contextPath}/order/pageOrders?" name="url1"/>
                        </jsp:include>
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
                    <strong>删除失败</strong>数据异常!
                </div>
            </div>
        </div>

        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-info" id="myModalLabel"><span
                                class="glyphicon glyphicon-pencil"></span>订单修改</h5>
                    </div>
                    <div class="modal-body">
                        <form id="userIF">
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
                                <input type="text" class="form-control" name="oamount" id="oamounts"
                                       placeholder="请输入购买数量">
                            </div>
                            <div class="form-group">
                                <label for="bp">订单状态</label>
                                <%--<input type="text" class="form-control" name="ostatus" id="ostatus" placeholder="请输入订单状态">--%>
                                <select class="form-control" name="ostatus" id="ostatus">
                                    <option>未付款</option>
                                    <option>已付款</option>
                                    <option>待发货</option>
                                    <option>已发货</option>
                                    <option>已确认收货</option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-info" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-success" onclick="sure()">确认</button>
                        <script>
                            function sure() {
                                console.log($("#userIF").serialize()); //表单序列化 获取表单数据
                                $.post("${pageContext.request.contextPath}/order/updateOrder", $("#userIF").serialize(), function (res) {
                                    if (res.status) {
                                        toastr.info(res.msg);
                                        $("#myModal").modal('hide');
                                        $('.modal-backdrop').remove();
                                        getOrdersContidion();
                                        //此处有Bug 更新数据成功后 页面刷新时页面整体变成灰色 无法操作
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
    </div>
</div>