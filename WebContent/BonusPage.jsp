<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SMO Bonus Page</title>
<style>
body
{
text-align:center;
}
input
{
width:100%;
}
table
{
width:100%;
border:1px gray solid;
}
#out_bonus_content table tr td
{
border:1px solid black;
}
</style>
</head>
<body>

在这里兑换Bonus Key

<table>
	<tr>
		<td>用户名</td>
		<td><input type="text" value="" name="in_username" id="in_username"></td>
	</tr>
	<tr>
		<td>Bonus Key</td>
		<td><input type="text" value="" name="in_id_key" id="in_id_key"></td>
	</tr>
</table>

<div id="out_bonus_content" style="border:1px gray solid">
	<table>
		<tr>
			<td>物品名</td>
			<td>数量</td>
		</tr>
	</table>
	
	<button>领取</button>
</div>

</body>
</html>