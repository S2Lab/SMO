<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="game.main.*,servlet.*,java.sql.*,net.sf.json.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商城</title>

<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />

<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>

<style>
body
{
	background-color:lightblue;
	text-align:center;
}
table
{
	width:100%;
}
td
{
	border:1px solid darkred;
}
.td_coin_need
{
	width:100px;
}
</style>

<script>
function sendTrade(id_tradeIn)
{
	$.get("AJAX_Handler.jsp?act=Ashopbuy&id_shop=0&id_trade="+id_tradeIn,function(){
		;
	});
}
</script>

</head>
<body>
<%
boolean passed=Utils.get(session,"passed").equals("true");
%>

<div id="out_player_coins">
<%if(passed)
{%>
随便买点啥吧?<br>
<a href="GamePage.jsp">返回游戏</a>

<% 
}
else
{%>
你还没有登陆..

<%
}%>
</div>


<table>
<tr>
	<td>名称</td>
	<td>物品</td>
	<td>数量</td>
	<td> </td>
	<td class="td_coin_need">金币</td>
	<td class="td_coin_need">银币</td>
	<td class="td_coin_need">铜币</td>
	<td class="td_coin_need">伊瑞希亚币</td>
	<td style="width:60px"> </td>
</tr>
<%
new SMOMain();
//获取交易列表
JSONObject list=game.main.ShopHandler.getShopList("0");

if(list.getInt("amounts")==1)
{
%>
<tr>
	<td><%=list.getString("name") %></td>
	<td><%=ItemUseHandler.getItemName(Integer.valueOf(list.getInt("id_item_sold"))) %></td>
	<td><%=list.getInt("amount_sold") %></td>
	<td><%=list.getString("des") %></td>
	<td><%=list.getInt("gold_need") %></td>
	<td><%=list.getInt("silver_need") %></td>
	<td><%=list.getInt("copper_need") %></td>
	<td><%=list.getInt("irisia_need") %></td>
	<td><%=passed?"<button onclick=\"sendTrade("+list.getInt("id_trade")+")\">购买</button>":"" %></td>
</tr>
<%
}
else
{
	
	for(int step=0;step<list.getInt("amounts");step++)
	{
%>
<tr>
	<td><%=list.getJSONArray("name").getString(step) %></td>
	<td><%=ItemUseHandler.getItemName(Integer.valueOf(list.getJSONArray("id_item_sold").getInt(step)))  %></td>
	<td><%=list.getJSONArray("amount_sold").getInt(step) %></td>
	<td><%=list.getJSONArray("des").getString(step) %></td>
	<td><%=list.getJSONArray("gold_need").getInt(step) %></td>
	<td><%=list.getJSONArray("silver_need").getInt(step) %></td>
	<td><%=list.getJSONArray("copper_need").getInt(step) %></td>
	<td><%=list.getJSONArray("irisia_need").getInt(step) %></td>
	<td><%=passed?"<button onclick=\"sendTrade("+list.getJSONArray("id_trade").getInt(step)+")\">购买</button>":"" %></td>
</tr>
<%
	}
}
%>
</table>



<script></script>


</body>
</html>