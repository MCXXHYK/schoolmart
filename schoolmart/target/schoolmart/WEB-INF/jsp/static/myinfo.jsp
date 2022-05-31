<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<%--
  Created by IntelliJ IDEA.
  User: ZEROMan
  Date: 2020/12/6
  Time: 19:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<div class="container-fluid">
    <div class="row" style="margin-top: 80px">
        <div class="col-sm-6 col-sm-offset-3">
            <h1 style="color: #2aabd2">SweetLove校园超市后台管理<small>用户信息修改</small></h1>
        </div>
    </div>
    <div class="row text-center">
        <div class="col-sm-6 col-sm-offset-4">
            <form id="indexmyinfo">
                <div class="form-group">
                    <label class="pull-left">账户邮箱</label>
                    <input type="text" class="form-control" name="uemail" value="${user0.uemail}" style="height: 40px">
                </div>

                <div class="form-group">
                    <label class="pull-left">手机号</label>
                    <input type="text" class="form-control" name="telnum" value="${user0.telnum}" style="height: 40px">
                </div>
                <div class="form-group">
                    <label class="pull-left">收货地址</label>
                    <input type="text" class="form-control" name="address" value="${user0.address}"
                           style="height: 40px">
                </div>
                <div class="form-group">
                    <label class="pull-left">性别</label>
                    <input type="hidden" name="uid" value="${user0.uid}"/>
                    <select class="form-control" name="usex">
                        <option>${user0.usex}</option>
                        <option>
                            <c:if test="${user0.usex=='男'}">女</c:if>
                            <c:if test="${user0.usex=='女'}">男</c:if>
                        </option>
                    </select>
                </div>
                <button type="button" onclick="infoup()" class="btn btn-danger btn-block" style="margin-top: 10px">确定
                </button>
                <script>
                    function infoup() {
                        $.post("${pageContext.request.contextPath}/user/updateUserInfo", $("#indexmyinfo").serialize(), function (res) {
                            console.log(res);
                            if (res.status) {
                                alert(res.msg + "即将返回系统主页");
                                window.location.href = "${pageContext.request.contextPath}/user/manager";
                            } else {
                                alert(res.msg);
                            }
                        }, "JSON")
                    }
                </script>
            </form>
        </div>
    </div>
</div>