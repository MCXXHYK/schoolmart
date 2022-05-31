<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ZEROMan
  Date: 2020/12/6
  Time: 19:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    function getGoodsContidion() {
        var gname = $('#exampleInputEmail2').val();
        $('#content').load('${pageContext.request.contextPath}/commodity/pageGoods?bname=' + gname);
    }
</script>

<script>
    function editSure() {
        console.log($("#editCommodityForm").serialize()); //表单序列化 获取表单数据
        $.post("${pageContext.request.contextPath}/commodity/updateCommodity", $("#editCommodityForm").serialize(), function (res) {
            if (res.status) {
                /*alert(res.msg+"，点击确定关闭当前对话框！");*/
                toastr.info(res.msg);
                //此处有Bug 更新数据成功后 页面刷新时页面整体变成灰色 无法操作
                $('#myModal').modal('hide');
                $('.modal-backdrop').remove();
                getGoodsContidion();
            } else {
                toastr.error(res.msg);
            }
        }, "JSON")
    }
</script>
<div class="col-sm-10">
    <!--中心内容-->


    <div class="page-header" style="margin-top: -22px;margin-bottom: 5px">
        <h1>商品管理</h1>
    </div>
    <!-- 创建标签页-->
    <div>
        <ul class="nav nav-tabs">
            <!--标签选项卡-->
            <li><a href="#profile" data-toggle="tab" class="active">商品列表</a></li>
            <li><a href="#insertcommodity" data-toggle="tab" class="active">添加商品</a></li>
            <!--datatoggle用来绑定切换面板的时间-->
        </ul>

        <!--选项卡面板-->
        <div class="tab-content ">
            <!---->
            <div class="tab-pane active" id="profile">

                <div class="panel panel-default">
                    <div class="panel-body">
                        <form class="form-inline text-center" action="">
                            <div class="form-group">
                                <label for="exampleInputEmail2">商品名称</label>
                                <input type="text" name="bname" class="form-control" id="exampleInputEmail2"
                                       placeholder="请输入商品名称">
                            </div>
                            <button type="button" class="btn btn-primary" onclick="getGoodsContidion()">根据商品名查询查询
                            </button>
                        </form>
                    </div>
                    <!--    用户表格-->
                    <table class="table table-hover table-bordered table-striped">
                        <thead>
                        <tr>
                            <th class="text-center">编号</th>
                            <th class="text-center">商品名</th>
                            <th class="text-center">价格</th>

                            <th class="text-center">类型</th>
                            <th class="text-center">商品描述</th>
                            <th class="text-center">库存</th>
                            <th class="text-center">是否热销</th>
                            <th class="text-center">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.p.list}" var="comment">
                            <tr>
                                <td class="text-center">${comment.bid}</td>
                                <td class="text-center">${comment.bname}</td>
                                <td class="text-center">${comment.bprice}</td>

                                <td class="text-center">${comment.btype}</td>
                                <td class="text-center">${comment.bdetail}</td>
                                <td class="text-center">${comment.bstock}</td>
                                <td class="text-center">
                                    <c:if test="${comment.bisHot}">
                                        畅销
                                    </c:if>
                                    <c:if test="${!comment.bisHot}">
                                        不畅销
                                    </c:if>
                                </td>
                                <td class="text-center"><a href="javascript:;"
                                                           onclick="delCommodityRow(${comment.bid});" id="del"
                                                           class="btn btn-danger btn-sm" <%--data-toggle="modal" data-target="#deleteusermodal"--%>>删除</a>
                                    <a onclick="editCommodityRow(${comment.bid})" class="btn btn-primary btn-sm"
                                       data-toggle="modal" data-target="#myModal">
                                        修改
                                    </a>
                                </td>
                                <script>
                                    function delCommodityRow(bid) {
                                        console.log(bid);
                                        //发送异步请求
                                        $.get("${pageContext.request.contextPath}/commodity/deleteCommodity", {bid: bid}, function (res) {
                                            console.log(res);
                                            if (res.status) {
                                                $("#MsgS").show(1000);
                                                setTimeout(function () {
                                                    $("#MsgS").hide(1000);
                                                    getGoodsContidion();
                                                }, 2000);
                                            } else {
                                                $("#MsgF").show(1000);
                                            }
                                        });
                                    }

                                    function editCommodityRow(bid) {
                                        console.log(bid);
                                        $.get("${pageContext.request.contextPath}/commodity/findOne", {bid: bid}, function (res) {
                                            console.log(res);
                                            $("#bidp").text(res.bid)
                                            $("#bi").val(res.bid)
                                            $("#bn").val(res.bname)
                                            $("#bp").val(res.bprice)

                                            $("#bt").val(res.btype)

                                            $("#bd").val(res.bdetail)
                                            $("#bs").val(res.bstock)

                                            $('#hot').value = res.bisHot;
                                        }, "JSON")
                                    }
                                </script>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <jsp:include page="../page.jsp">
                        <jsp:param
                                value="javascript:$('#content').load('${pageContext.request.contextPath}/commodity/pageGoods?bname=${requestScope.p.bname}"
                                name="url"/>
                        <jsp:param value="${pageContext.request.contextPath}/commodity/pageGoods?" name="url1"/>
                    </jsp:include>
                </div>

                <div id="MsgS" class="alert alert-success alert-dismissible" style="display: none" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <strong>删除成功！</strong>该商品已被删除！
                </div>
                <div id="MsgF" class="alert alert-danger alert-dismissible" style="display: none" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <strong>删除失败</strong>数据异常：
                </div>
            </div>
            <div class="tab-pane disabled" id="insertcommodity">

                <div class="panel panel-default">
                    <div class="panel-body">
                        <form class="text-center" enctype="multipart/form-data" id="Form">
                            <div class="form-group">
                                <label for="exampleInputEmail2">商品名称</label>
                                <input type="text" id="bname" name="bname" class="form-control" placeholder="请输入商品名称">
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail2">商品价格</label>
                                <input type="text" id="bprice" name="bprice" class="form-control" placeholder="请输入商品价格">
                            </div>

                            <div class="form-group">
                                <label for="exampleInputEmail2">商品类型</label>

                                <select class="form-control" name="btype" id="btype">
                                    <option>休闲零食</option>
                                    <option>面包糕点</option>
                                    <option>饼干</option>
                                    <option>饮料</option>
                                    <option>膨化薯片</option>
                                    <option>日用百货</option>
                                    <option>卫生用品</option>
                                    <option>洗护用品</option>
                                    <option>牙膏牙刷</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="exampleInputEmail2">商品库存</label>
                                <input type="text" id="bstock" name="bstock" class="form-control" placeholder="请输入商品库存">
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail2">商品详情描述</label>
                                <input type="text" id="bdetail" name="bdetail" class="form-control"
                                       placeholder="请输入商品詳情">
                            </div>
                            <div class="form-group">
                                <label>是否畅销</label>
                                <select class="form-control" name="bisHot" id="chot">
                                    <option value="true">畅销</option>
                                    <option value="false">
                                        不畅销
                                    </option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="bimg">添加图片</label>
                                <input type="file" id="bimg" name="bimg">
                                <p class="help-block">请上传200k以下的图片</p>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> 确定
                                </label>
                            </div>

                            <input type="button" value="添加商品" class="btn btn-success" onclick="insCommodity()">
                            <script>
                                function insCommodity() {

                                    $.ajax({
                                        url: "${pageContext.request.contextPath}/commodity/insertcommodity",
                                        type: "post",
                                        cache: false,
                                        data: new FormData($("#Form")[0]),
                                        dataType: "json",
                                        processData: false,
                                        contentType: false,
                                        success: function (res) {
                                            if (res.status) {
                                                /*alert(res.msg);*/
                                                toastr.success(res.msg);
                                                $("#bname").val("");
                                                $("#bprice").val("");
                                                // $("#bpublish").val("");
                                                $("#btype").val("");
                                                // $("#bauthor").val("");
                                                $("#bstock").val("");
                                                $("#chot").val("");
                                                $("#bdetail").val("");
                                                $("#bimg").val("");
                                            } else {
                                                toastr.error(res.msg);
                                            }
                                        }
                                    })
                                }
                            </script>
                        </form>
                    </div>


                </div>
            </div>
        </div>


        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-info" id="myModalLabel"><span
                                class="glyphicon glyphicon-user"></span>修改商品信息</h5>
                    </div>
                    <div class="modal-body">
                        <form id="editCommodityForm" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="bi">bid</label>
                                <p class="form-control-static" id="bidp">10</p>
                                <input type="hidden" class="form-control" id="bi" name="bid">
                            </div>
                            <div class="form-group">
                                <label for="bn">商品名称</label>
                                <input type="text" class="form-control" id="bn" name="bname" placeholder="请输入商品名称">
                            </div>
                            <div class="form-group">
                                <label for="bp">商品价格</label>
                                <input type="number" class="form-control" id="bp" name="bprice"
                                       placeholder="商品价格只能输入数字哦">
                            </div>

                            <div class="form-group">
                                <label for="bt">商品类型</label>
                                <select class="form-control" name="btype" id="bt">
                                    <option>休闲零食</option>
                                    <option>面包糕点</option>
                                    <option>饼干</option>
                                    <option>饮料</option>
                                    <option>膨化薯片</option>
                                    <option>日用百货</option>
                                    <option>卫生用品</option>
                                    <option>洗护用品</option>
                                    <option>牙膏牙刷</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail2">商品详情描述</label>
                                <input type="text" id="bd" name="bdetail" class="form-control" placeholder="请输入商品詳情">
                            </div>
                            <div class="form-group">
                                <label for="bs">商品库存</label>
                                <input type="number" class="form-control" id="bs" name="bstock" placeholder="请输入库存量">
                            </div>
                            <div class="form-group">
                                <label>是否畅销</label>
                                <select class="form-control" name="bisHot" id="hot">
                                    <option value="true">畅销</option>
                                    <option value="false">
                                        不畅销
                                    </option>
                                </select>
                            </div>


                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-info" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-success" onclick="editSure()">确认修改</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
