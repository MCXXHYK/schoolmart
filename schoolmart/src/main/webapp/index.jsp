
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>欢迎</title>
</head>
<body>
<%
    response.sendRedirect(request.getContextPath() + "/user/tologin");
%>
</body>
</html>
