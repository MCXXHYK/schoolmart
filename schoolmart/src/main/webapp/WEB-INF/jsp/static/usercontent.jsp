<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ZEROMan
  Date: 2020/12/6
  Time: 19:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    function getUserContidion() {
        var uemail = $('#exampleInputEmail2').val();
        $('#content').load('${pageContext.request.contextPath}/user/pageUser?uemail=' + uemail);
    }
</script>

<div class="col-sm-10">
    <!--中心内容-->
    <div class="page-header" style="margin-top: -22px;margin-bottom: 5px">
        <h1>用户管理</h1>
    </div>
    <!-- 创建标签页-->
    <div>
        <ul class="nav nav-tabs">
            <!--标签选项卡-->
            <li><a href="#profile" data-toggle="tab" class="active">用户列表</a></li>
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
                                       placeholder="请输入用户名" value="${requestScope.p.uemail}">
                            </div>
                            <button type="button" class="btn btn-primary" onclick="getUserContidion()">查询</button>
                        </form>
                    </div>
                    <!--    用户表格-->
                    <table class="table table-hover table-bordered table-striped">
                        <thead>
                        <tr>
                            <th class="text-center">编号</th>
                            <th class="text-center">邮箱</th>
                            <th class="text-center">性别</th>
                            <th class="text-center">手机号</th>
                            <th class="text-center">收货地址</th>
                            <th class="text-center">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.p.list}" var="orderLists">
                            <tr>
                                <td class="text-center">${orderLists.uid}</td>
                                <td class="text-center">${orderLists.uemail}</td>
                                <td class="text-center">${orderLists.usex}</td>
                                <td class="text-center">${orderLists.telnum}</td>
                                <td class="text-center">${orderLists.address}</td>
                                <td class="text-center"><a href="javascript:;" onclick="delUserRow(${orderLists.uid});"
                                                           id="del"
                                                           class="btn btn-danger btn-sm">删除
                                                        </a>
                                </td>
                                <script>
                                    function delUserRow(uid) {
                                        console.log(uid);
                                        //发送异步请求
                                        $.get("${pageContext.request.contextPath}/user/delete", {uid: uid}, function (res) {
                                            console.log(res);
                                            if (res.status) {
                                                toastr.success("删除成功！");
                                                getUserContidion();
                                            } else {
                                                toastr.error("删除失败！");
                                            }
                                        })
                                    }
                                </script>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <jsp:include page="../page.jsp">
                        <jsp:param
                                value="javascript:$('#content').load('${pageContext.request.contextPath}/user/pageUser?uemail=${requestScope.p.uemail}"
                                name="url"/>
                        <jsp:param value="${pageContext.request.contextPath}/user/pageUser?" name="url1"/>
                    </jsp:include>
                </div>
                <div id="succMsg" class="alert alert-success alert-dismissible" style="display: none" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <strong>删除成功！</strong>该用户已被删除
                </div>
                <div id="errMsg" class="alert alert-danger alert-dismissible" style="display: none" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <strong>删除失败</strong>数据异常：
                </div>
            </div>
        </div>
    </div>
</div>
