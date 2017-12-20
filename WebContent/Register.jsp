<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@page import="servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	new game.main.SMOMain();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<title>创建新账户</title>
<style>
body
{
	font-family:Microsoft Yahei;
	font-size:16px;
	background-color:#1b94da;
	text-align:center;
	margin:0;
	padding:0;
}
tr
{
	border:5px solid lightblue;
}

table
{
background-color:#87cefa;
}
</style>

<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>

<script>
</script>
</head>
<body>

    <div>
    <form action="RegisterDirect.jsp" method="get">
    	<table style="width:90%;margin:5%;">
    		<tr>
    			<td>用户名</td>
    			<td><input type="text" name="username" value="<%=Utils.get(request,"username") %>" id="username" onchange="checkUsername()"></td>
    		</tr>
    		<tr>
    			<td>密码</td>
    			<td><input type="password" name="password" value="<%=Utils.get(request,"password") %>" id="passwd1"></td>
    		</tr>
    		<tr>
    			<td>确认密码</td>
    			<td><input type="password" name="" value="<%=Utils.get(request,"username") %>" id="passwd2" onchange="checkPassword()"></td>
    		</tr>
    		<tr>
    			<td></td>
    			<td style="font-size:80%">若需申请管理员权限<br>请联系QQ351768593</td>
    		</tr>
    		<tr>
    			<td>职业选择</td>
    			<td>剑士<input type="radio" name="class_in" value="sword" id="radio_sword" checked ></td>
    		</tr>
    		<tr>
    			<td> </td>
    			<td>魔法师<input type="radio" name="class_in" value="magic" id="radio_magic"></td>
    		</tr>
    		<tr>
    			<td> </td>
    			<td>刺客<input type="radio" name="class_in" value="acc" id="radio_acc"></td>
    		</tr>
    		<tr style="height:100px">
    			<td>介绍</td>
    			<td id="out_info_class">...</td>
    		</tr>
    		<tr style="height:100px">
    			<td>属性</td>
    			<td id="out_info_attr">...</td>
    		</tr>
    		<tr>
    			<td></td>
    			<td><input type="button" value="创建账户!" onclick="btn_test_create_new()"></td>
    		</tr>
    	</table>
    	<input type="submit" style="display:none" id="btn_submit">
    </form>
    </div>

</body>
<script>
//检查密码可用性
function checkPassword()
{
	if($("#passwd1").val()==$("#passwd2").val() && $("#passwd1").val().length<=25)
	{
		$("#passwd1").css("background-color","green");
		$("#passwd2").css("background-color","green");
	}
	else
	{
		$("#passwd1").css("background-color","red");
		$("#passwd2").css("background-color","red");
	}
}
// 检查用户名可用性
function checkUsername()
{
	let in_username=$("#username").val();
	if(in_username.trim().length==0 || in_username.trim().length>25)
	{
		$("#username").css("background-color","red");
	}
	else
	{
	    let str_get=$.get("AJAX_Handler.jsp?act=checkUsernameExistence&username="+$("#username").val(),function(){
	    	console.log(str_get);
	    	let json_get=JSON.parse(str_get.responseText);
	    	if(json_get.result==false)
	    		$("#username").css("background-color","green");
	    	else
	    		$("#username").css("background-color","red");
	    });
	}
}
// 测试创建用户按钮
function btn_test_create_new()
{
	if($("#passwd1").css("background-color")=="rgb(0, 128, 0)" && $("#username").css("background-color")=="rgb(0, 128, 0)")
		$("#btn_submit").click();
}

// 显示职业信息
function show_info_class(id_classIn)
{
    let result="";
    let result2="";
    switch(id_classIn)
    {
    case "sword":
        result="剑士,物理类职业<br>拥有相对平均的属性";
        result2="物理属性A<br>魔法属性C<br>敏捷属性B";
        break;
    case "acc":
        result="刺客,物理类职业<br>强化敏捷类属性";
        result2="物理属性B<br>魔法属性C<br>敏捷属性A";
        break;
    case "magic":
        result="魔法师,魔法类职业<br>拥有相对平均的属性";
        result2="物理属性C<br>魔法属性A<br>敏捷属性B";
        break;
    case "牧师":
        result="牧师,魔法类职业<br>强化生命恢复";
        break;
    default:
        break;
    }
    document.getElementById("out_info_class").innerHTML=result;
    document.getElementById("out_info_attr").innerHTML=result2;
}
$("#radio_sword").click(function(){
	show_info_class("sword");
});
$("#radio_acc").click(function(){
	show_info_class("acc");
});
$("#radio_magic").click(function(){
	show_info_class("magic");
});
$("#radio_sword").click();
</script>
</html>