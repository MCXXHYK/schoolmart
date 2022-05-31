<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/toastr.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/toastr.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>


</head>
<style>
    .main-box {
        text-align: center;
        padding: 20px;
        border-radius: 5px;
        -moz-border-radius: 5px;
        -webkit-border-radius: 5px;
        margin-bottom: 40px;
    }

    th {
        vertical-align: middle !important;
    }

    td {
        vertical-align: middle !important;
    }
</style>
<body>
<!--导航条-->
<nav class="navbar navbar-inverse">
    <!--屏幕不留白-->
    <div class="container-fluid">
        <!--屏幕自适应-->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand"
               href="${pageContext.request.contextPath}/lead/manage">SweetLove校园超市后台管理系统<small>v1.0</small></a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">欢迎：<span class="text-danger">${user.uemail}</span></a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                       aria-expanded="false">个人中心 <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="javascript:$('#content').load('${pageContext.request.contextPath}/user/userinfo');">我的信息</a>
                        </li>
                        <li role="separator" class="divider"></li>
                        <li>
                            <a href="javascript:$('#content').load('${pageContext.request.contextPath}/user/toupdateadminupwd')">修改密码</a>
                        </li>
                        <li role="separator" class="divider"></li>
                        <li><a href="${pageContext.request.contextPath}/user/logout">退出登录</a></li>
                    </ul>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<!--页面中心内容-->
<div class="row">
    <div class="col-sm-2">
        <!--菜单组件-->
        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingOne">
                    <h4 class="panel-title">
                        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne"
                           aria-expanded="true" aria-controls="collapseOne">
                            用户管理
                        </a>
                    </h4>
                </div>
                <div id="collapseOne" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOne">
                    <div class="panel-body">
                        <ul class="list-group">
                            <li class="list-group-item"><a
                                    href="javascript:$('#content').load('${pageContext.request.contextPath}/user/pageUser');">用户列表</a>
                            </li>
                            <%--<script>--%>
                            <%--    $(function () {--%>
                            <%--        $("#btnuser").click(function () {--%>
                            <%--            //动态更换中心内容 load将远程url对应的页面源码包含到指定选择器中--%>

                            <%--        })--%>
                            <%--    })--%>
                            <%--</script>--%>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingTwo">
                    <h4 class="panel-title">
                        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo"
                           aria-expanded="true" aria-controls="collapseOne">
                            商品管理
                        </a>
                    </h4>
                </div>
                <div id="collapseTwo" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOne">
                    <div class="panel-body">
                        <ul class="list-group">
                            <li class="list-group-item"><a
                                    href="javascript:$('#content').load('${pageContext.request.contextPath}/commodity/pageGoods');">全部商品</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingThr">
                    <h4 class="panel-title">
                        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThr"
                           aria-expanded="true" aria-controls="collapseOne">
                            订单管理
                        </a>
                    </h4>
                </div>
                <div id="collapseThr" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOne">
                    <div class="panel-body">
                        <ul class="list-group">
                            <li class="list-group-item"><a
                                    href="javascript:$('#content').load('${pageContext.request.contextPath}/order/pageOrders');">全部订单</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingFour">
                    <h4 class="panel-title">
                        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour"
                           aria-expanded="true" aria-controls="collapseOne">
                            评论管理
                        </a>
                    </h4>
                </div>
                <div id="collapseFour" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOne">
                    <div class="panel-body">
                        <ul class="list-group">
                            <li class="list-group-item"><a
                                    href="javascript:$('#content').load('${pageContext.request.contextPath}/comment/managePageEvaluation');">全部评论</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="content">
        <div class="col-md-10" id="page-id" style="background-color: #e6e6e6">
            <div id="page-wrapper">
                <div id="page-inner">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="main-box" style="background-color: chocolate">
                                <i class="fa fa-user"></i><span style="margin-left: 20px;">用户总数：${totalUser}</span>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="main-box" style="background-color: darkseagreen">
                                <i class="fa fa-comment"></i><span
                                    style="margin-left: 20px;">评论总数：${totalComment}</span>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="main-box" style="background-color: burlywood">
                                <i class="fa fa-rmb"></i><span style="margin-left: 20px;">总交易额：${totPrice}</span>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="main-box" style="background-color: cadetblue">
                                <i class="fa fa-shopping-cart"></i><span
                                    style="margin-left: 20px;">总销量：${totalShopping}</span>
                            </div>
                        </div>


                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    <select onchange="selec(this.options[this.options.selectedIndex].value)">
                                        <option value="bar">柱状图</option>
                                        <option value="pie">饼图</option>
                                    </select>
                                </div>
                                <div class="panel-body">
                                    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
                                    <div id="main">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div id="left" style="width: 100%;height:400px;"></div>
                                            </div>
                                            <div class="col-md-6">
                                                <div id="right" style="width: 100%;height:400px;"></div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        toastr.options = {

            "closeButton": false, //是否显示关闭按钮

            "debug": false, //是否使用debug模式

            "positionClass": "toast-center-center",//弹出窗的位置

            "showDuration": "1000",//显示的动画时间

            "hideDuration": "1500",//消失的动画时间

            "timeOut": "1000", //展现时间

            "extendedTimeOut": "1000",//加长展示时间

            "showEasing": "swing",//显示时的动画缓冲方式

            "hideEasing": "linear",//消失时的动画缓冲方式

            "showMethod": "fadeIn",//显示时的动画方式

            "hideMethod": "fadeOut" //消失时的动画方式
        };
        //页面加载时从后台获取数据
        window.onload = function () {
            selec('bar');
        }

        function jahdjad() {
            var chartDom1 = document.getElementById('left');
            var chartDom2 = document.getElementById('right');
            var myChart1 = echarts.init(chartDom1);
            var myChart2 = echarts.init(chartDom2);
            $.post("${pageContext.request.contextPath}/order/echart", function (res) {
                var sorts = res.titleList;
                var num = res.dataList1;
                var json = [];
                var array = {};
                for (var i = 0; i < sorts.length; i++) {
                    array['value'] = num[i];
                    array['name'] = sorts[i];
                    json.push(array)
                    array = {};
                }
                var json_arrays = JSON.parse(JSON.stringify(json));
                console.log(json_arrays)

                var option3;

                option3 = {
                    title: {
                        text: '分类总销量',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'item'
                    },
                    legend: {
                        data: json_arrays,
                        orient: 'vertical',
                        left: 'right',
                    },
                    series: [
                        {
                            name: '分类销量',
                            type: 'pie',
                            radius: '50%',
                            data: json_arrays,
                            emphasis: {
                                itemStyle: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }
                    ]
                };
                option3 && myChart1.setOption(option3);
            });

            $.post("${pageContext.request.contextPath}/order/pie", function (res) {
                var sorts = res.titleList;
                var num = res.dataList2;
                var json = [];
                var array = {};
                for (var i = 0; i < sorts.length; i++) {
                    array['value'] = num[i];
                    array['name'] = sorts[i];
                    json.push(array)
                    array = {};
                }
                var json_arrays = JSON.parse(JSON.stringify(json));
                console.log(json_arrays)

                var option4;

                option4 = {
                    title: {
                        text: '分类总销售额',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'item'
                    },
                    legend: {
                        data: json_arrays,
                        orient: 'vertical',
                        left: 'right',
                    },
                    series: [
                        {
                            name: '分类销售额',
                            type: 'pie',
                            radius: '50%',
                            data: json_arrays,
                            emphasis: {
                                itemStyle: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }
                    ]
                };
                option4 && myChart2.setOption(option4);
            });
        }


        function selec(ty) {
            if (ty == 'pie') {
                jahdjad();

            } else if (ty == 'bar') {
                var myChart1 = echarts.init(document.getElementById('left'));
                var myChart2 = echarts.init(document.getElementById('right'));
                $.post("${pageContext.request.contextPath}/order/echart", function (res) {
                    // 基于准备好的dom，初始化echarts实例
                    // 指定图表的配置项和数据
                    var option1 = {
                        title: {
                            text: '分类总销量'
                        },
                        tooltip: {},
                        legend: {
                            data: ['分类总销量']
                        },
                        xAxis: {
                            data: res.titleList
                        },
                        yAxis: {},
                        series: [{
                            name: '分类总销量',
                            type: 'bar',
                            data: res.dataList1
                        }]
                    }
                    myChart1.setOption(option1);
                });

                $.post("${pageContext.request.contextPath}/order/pie", function (res) {
                    var option2 = {
                        title: {
                            text: '分类总销售额'
                        },
                        tooltip: {},
                        legend: {
                            data: ['分类总销售额']
                        },
                        xAxis: {
                            data: res.titleList
                        },
                        yAxis: {},
                        series: [{
                            name: '分类总销售额',
                            type: 'bar',
                            data: res.dataList2
                        }]
                    };
                    myChart2.setOption(option2);
                    // 使用刚指定的配置项和数据显示图表。
                });
            }
        }

    </script>
</div>
</body>
</html>
