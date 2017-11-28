<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	new game.main.SMOMain();
	session.invalidate();
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<title>登陆到SMO网络</title>
<style>
	body
	{
		text-align:center;
		vertical-align:center;
		margin:0;
		padding:0;
		max-width:100%;
		max-height:100%;
		background-color:#bababa
	}
	input
	{
		width:200px;
	}

	
</style>



</head>
<body>

<div style="width:300px;height:200px;position:absolute;top:50%;left:50%;margin:-100px 0 0 -150px;text-align:center;">

<form action="LoginRedirect.jsp">

<table>
<caption>登陆到SMO网络<br><span style="font-size:80%">Be aware of your surroundings.</span><br></caption>
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
	<tr>
		<td> </td>
		<td><a href="Register.jsp"><input type="button" value="创建新账户"></a></td>
	</tr>
</table>

</form>
	
</div>

<div style="position:fixed;bottom:0px;left:0px;font-size:75%"><a href="computer.html">跳转到战斗计算器</a><br>Sword Magic Online v 0.1.2 by S2Lab.Firok</div>

</body>
</html>