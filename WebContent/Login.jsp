<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	session.invalidate();
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆到SMO网络</title>
<style>
	body
	{
		text-align:center;
	}
</style>
</head>
<body>

<div style="margin:0 auto">
<form action="LoginRedirect.jsp">

<table>
<caption>登陆到SMO网络</caption>
	<tr>
		<td>用户名</td>
		<td><input type="text" name="username"></td>
	</tr>
	<tr>
		<td>密码</td>
		<td><input type="password" name="password"></td>
	</tr>
	<tr>
		<td>管理员登陆</td>
		<td><input type="checkbox" name="as-admin"></td>
	</tr>
	<tr>
		<td> </td>
		<td><input type="submit" value="登陆"></td>
	</tr>
</table>


</form>

</div>

</body>
</html>