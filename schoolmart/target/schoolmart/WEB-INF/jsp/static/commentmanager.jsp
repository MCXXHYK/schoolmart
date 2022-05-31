<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: YK_ZERO
  Date: 2021/4/25
  Time: 17:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    function getcommentContidion() {
        var uemail = $('#exampleInputEmail2').val();
        $('#content').load('${pageContext.request.contextPath}/comment/managePageEvaluation?uemail=' + uemail);
    }
</script>

<div class="col-sm-10">
    <!--中心内容-->


    <div class="page-header" style="margin-top: -22px;margin-bottom: 5px">
        <h1>评论管理</h1>
    </div>
    <!-- 创建标签页-->
    <div>
        <ul class="nav nav-tabs">
            <!--标签选项卡-->
            <li><a href="#profile" data-toggle="tab" class="active">评论列表</a></li>
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
                                <label for="exampleInputEmail2">Email</label>
                                <input type="text" name="uemail" class="form-control" id="exampleInputEmail2"
                                       placeholder="请输入用户名查询评论" value="${requestScope.p.uemail}">
                            </div>
                            <button type="button" class="btn btn-primary" onclick="getcommentContidion()">查询</button>
                        </form>
                    </div>
                    <!--    用户表格-->

                    <table class="table table-hover table-bordered table-striped">

                        <tr>
                            <th class="col-3 text-center">评论编号</th>
                            <th class="col-3 text-center">商品名</th>
                            <th class="col-3 text-center">评论用户</th>
                            <th class="col-3 text-center">用户ID</th>
                            <th class="col-3 text-center">评论内容</th>
                            <th class="col-3 text-center">评论时间</th>
                            <th class="col-3 text-center">操作</th>
                        </tr>


                        <c:forEach items="${requestScope.p.list}" var="comment">
                            <tr>
                                <td class="col-3 text-center">${comment.comment_id}</td>
                                <td class="col-3 text-center">${comment.bname}</td>
                                <td class="col-3 text-center">${comment.uemail}</td>
                                <td class="col-3 text-center">${comment.uid}</td>
                                <td class="col-3 text-center">${comment.content}</td>
                                <td class="col-3 text-center">${comment.createTime}</td>

                                <td class="col-3 text-center"><a href="javascript:;"
                                                                 onclick="delMyComment(${comment.comment_id},${comment.uid});"
                                                                 id="del"
                                                                 class="btn btn-danger btn-sm">删除</a>

                                </td>
                                <script>
                                    function delMyComment(comment_id, uid) {
                                        console.log(comment_id);
                                        //发送异步请求
                                        $.get("${pageContext.request.contextPath}/comment/deleteComment", {comment_id: comment_id}, function (res) {
                                            console.log(res);
                                            if (res.status) {
                                                $("#succMsg").show(1000);
                                                setTimeout(function () {
                                                    $("#succMsg").hide(1000);
                                                    getcommentContidion();
                                                }, 2000);
                                            } else {
                                                $("#errMsg").show(1000);
                                            }
                                        });
                                    }
                                </script>
                            </tr>
                        </c:forEach>

                    </table>
                    <jsp:include page="../page.jsp">
                        <jsp:param
                                value="javascript:$('#content').load('${pageContext.request.contextPath}/comment/managePageEvaluation?uid=${requestScope.p.uid}"
                                name="url"/>
                        <jsp:param value="${pageContext.request.contextPath}/comment/managePageEvaluation?"
                                   name="url1"/>
                    </jsp:include>
                </div>
                <div id="succMsg" class="alert alert-success alert-dismissible" style="display: none" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <strong>删除成功！</strong>该评论已被删除
                </div>
                <div id="errMsg" class="alert alert-danger alert-dismissible" style="display: none" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <strong>删除失败</strong>数据异常！
                </div>
            </div>
        </div>
    </div>
</div>
