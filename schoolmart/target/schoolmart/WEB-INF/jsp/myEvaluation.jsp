<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">

<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<html>
<head>
    <title>Title</title>
</head>
<style>
    th {
        vertical-align: middle !important;
    }

    td {
        vertical-align: middle !important;
    }
</style>
<body>
<jsp:include page="header.jsp">
    <jsp:param name="flag" value="16"/>
</jsp:include>
<h3 class="text-center">我的评价</h3>
<div class="container" id="content">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table-bordered table-striped" style="font-size: x-small">

                <tr>
                    <th class="text-center">评论编号</th>
                    <th class="text-center">商品名</th>
                    <th class="text-center">评论内容</th>
                    <th class="text-center">评论时间</th>
                    <th class="text-center">操作</th>
                </tr>


                <c:forEach items="${requestScope.p.list}" var="comment">
                    <tr>
                        <input id="exampleInputEmail2" type="hidden" value="${comment.uid}"/>
                        <td class="text-center">${comment.comment_id}</td>
                        <td class="text-center">${comment.bname}</td>
                        <td class="text-center">${comment.content}</td>
                        <td class="text-center">${comment.createTime}</td>

                        <td class="text-center"><a href="javascript:;"
                                                   onclick="delMyComment(${comment.comment_id},${comment.uid});"
                                                   id="del" class="btn btn-danger btn-sm">删除</a>

                        </td>
                        <script>
                            function delMyComment(comment_id, uid) {
                                console.log(comment_id);
                                //发送异步请求
                                $.get("${pageContext.request.contextPath}/comment/deleteComment", {comment_id: comment_id}, function (res) {
                                    console.log(res);
                                    if (res.status) {
                                        $("#MsgS").show(1000);
                                        setTimeout(function () {
                                            $("#MsgS").hide(1000);
                                            window.location.href = "${pageContext.request.contextPath}/comment/PageEvaluation?uid" + uid;
                                        }, 2000);
                                    } else {
                                        $("#MsgF").show(1000);
                                    }
                                });
                            }
                        </script>
                    </tr>
                </c:forEach>

            </table>
        </div>
    </div>
</div>
<div id="MsgS" class="alert alert-success alert-dismissible" style="display: none" role="alert">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span>
    </button>
    <strong>删除成功！</strong>该评论已被删除
</div>
<div id="MsgF" class="alert alert-danger alert-dismissible" style="display: none" role="alert">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span>
    </button>
    <strong>删除失败</strong>数据异常：
</div>
<jsp:include page="indexpage.jsp">
    <jsp:param value="${pageContext.request.contextPath}/comment/PageEvaluation?uid=${requestScope.p.uid}" name="url"/>
</jsp:include>
</body>
</html>
