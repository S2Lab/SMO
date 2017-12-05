<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,game.main.*,servlet.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
if(!Utils.get(session,"permission").equals("admin"))
{
	response.sendRedirect("Login.jsp"); // 不是管理员的话 直接跳转到登陆页面
	return;
}
%>
<%
// 这里的都是页面用来处理更改用到的动作
Connection conn=DatabaseConnectionManager.getConnection("管理员页面",false);

/*
能执行的动作:
	给予一个玩家物品;
	删除一个玩家的某个物品;
	删除一个玩家的所有物品;
	修改一个玩家的属性;
	删除玩家的账号;
	
	修改公告信息;
	删除公告信息;
	新增公告信息;
*/
Statement stmt_act=conn.createStatement();

String act=Utils.get(request,"act");

// 直接操作表格时可能用到的变量
String table=Utils.get(request,"table");
String col=Utils.get(request,"col");

// 物品操作时可能用到的变量
String username=Utils.get(request,"username");
String id_item=Utils.get(request,"id_item");
String amount=Utils.get(request,"amount");
String order=Utils.get(request,"order");

// 操作玩家属性时可能用到的变量
String attr=Utils.get(request,"attr");
String value=Utils.get(request,"value");
boolean is_num=Utils.get(request,"is_num").equals("true");
value= is_num?(value):('\''+value+'\''); // 是个数字的话就不加单引号

// 操作告示牌信息时可能用到的变量
String id_msg=Utils.get(request,"id_msg");
String id_sign=Utils.get(request,"id_sign");

if(!act.equals("")) // 有要执行的动作
{
	try
	{
		switch(act)
		{
		case "edit":
			stmt_act.execute("update "+table+" set "+col+"="+value+" where username");
			break;
		
		case "give":
			System.out.println("username='"+username+"'");
			DBAPI.Inventory_Edit(username, Integer.valueOf(id_item), Integer.valueOf(order), Integer.valueOf(amount));
			
			response.sendRedirect("AdminPage.jsp?page=inv&username="+username);
			break;
			
		case "drop":
			stmt_act.executeUpdate("delete from inventory where username='"+username+"' and id_item="+id_item+" and inventory.order="+order);
			
			response.sendRedirect("AdminPage.jsp?page=inv");
			break;
			
		case "drop_all":
			stmt_act.executeUpdate("select from inventory where username='"+username+"'");
			
			response.sendRedirect("AdminPage.jsp?page=inv");
			break;
			
		case "edit_attr":
			stmt_act.executeUpdate("update player set "+attr+"="+value+" where username='"+username+"'");
			break;
			
		case "delete_acco":
			// 删除玩家账号的话
			// 删除玩家信息
			// 删除last_action里的信息
			// 删除物品栏信息
			stmt_act.executeUpdate("delete from last_action where username='"+username+"'");
			stmt_act.executeUpdate("delete from inventory where username='"+username+"'");
			stmt_act.executeUpdate("delete from player where username='"+username+"'");
			stmt_act.executeUpdate("delete from accounts where username='"+username+"'");
			break;
			
		case "edit_sign":
			break;
			
		case "new_sign":
			break;
			
		case "remove_sign":
			break;
			
		case "restart_smo": // 重启主程序
			SMOMain.stop();
			new SMOMain();
			response.sendRedirect("AdminPage.jsp?page=index");
			
			break;
			
		default:
			break;
		}
	}
	catch(Exception e)
	{
		System.out.println("管理员页面执行动作时发生错误");
		e.printStackTrace();
	}
	
}

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理员页面 SMO v <%=game.main.SMOMain.version %></title>

<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />

<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>

<style>
body{margin:0;padding:0;width:100%;font-family:merriweather,Georgia,Times New Roman,Microsoft Yahei Light}
h1{text-align:center}
table{width:100%;text-align:center}

.item_table{margin-right:20px;text-decoration:none}
.item_table:hover{text-decoration:none;background-color:lightblue}
.item_table:visited{text-decoration:none}
</style>

</head>
<body>

	<div style="width:100%;float:left;border:1px solid black;margin-bottom:40px">
		<a href="AdminPage.jsp?page=index" class="item_table">控制台首页</a>
		<a href="AdminPage.jsp?page=acco" class="item_table">账户信息</a>
		<a href="AdminPage.jsp?page=inv" class="item_table">背包信息</a>
		<a href="AdminPage.jsp?page=sign" class="item_table">公告信息</a>
		
		<a href="DataPage.jsp" class="item_table" target="_blank">数据清单</a>
		
		<a href="Login.jsp" class="item_table" style="margin-left:50px;color:darkred">登出</a>
		
		<span style="margin-left:100px">刷新时间 : <%=new java.sql.Date(System.currentTimeMillis()).toLocaleString() %></span>
	</div>
	
	<div style="width:100%;float:left;border:1px solid lightblue">
	<%
	switch(Utils.get(request,"page"))
	{
	case "":
	case "index":
		%>
			<div style="font-size:300%;width:auto;text-align:center;margin:40px">Sword Magic Online<br>后台管理面板</div>
			
			
			<div class="container-fluid">
				<div class="row">
					<div class="col-sm-12 col-md-4">
					<%
					Statement stmt_now=conn.createStatement();
					stmt_now.executeQuery("select * from last_action where now()-last_time<30");
					ResultSet rs=stmt_now.getResultSet();
					int count=0;
					while(rs.next()) count++;
					rs.beforeFirst();
					%>
					
					<h1>实时状态</h1>
					<table style="font-size:100%">
						<tr><td>在线玩家</td><td><%=count%></td></tr>
						
						<%while(rs.next()) {%>
						<tr style="border-bottom:1px solid black"><td><%=rs.getString("username") %><br><%=rs.getString("ipaddr") %></td>
						<td><%=rs.getString("last_time") %><br><%=rs.getString("loc_x") %>,<%=rs.getString("loc_y") %></td></tr>
						<%} %>
					
					</table>
					</div>
				
					<div class="col-sm-12 col-md-4">
					
					<h1>连接器状态</h1>
					<table>
					<%
					for(String key:DatabaseConnectionManager.conns.keySet())
					{
						try
						{
							DatabaseConnectionManager.conns.get(key).createStatement()
							.executeQuery("show tables").getStatement().close();
							
							%>
							<tr><td style="color:purple"><%=key%></td><td style="color:green">正常</td></tr>
							<%
						}
						catch(Exception e)
						{
							%>
							<tr><td style="color:purple"><%=key%></td><td style="color:red">断开</td></tr>
							<%
						}
					}
					%>
					
					</table>
					</div>
					
					
					<div class="col-sm-12 col-md-4">
					
					<h1>SMO主程序</h1>
					
					<a href="AdminPage.jsp?act=restart_smo"><button class="btn btn-danger" style="height:50%;width:50%;margin-left:25%;">重启主程序</button></a>
					
					</div>
				</div>
			</div>
		<%
		break;
	
	case "inv":
		%>
		<div style="width:100%;text-align:center">
		<form action="AdminPage.jsp">
		检索特定玩家<input type="text" name="username" value=""><input type="submit" value="检索">
		<input type="hidden" name="page" value="inv"> </form>
		</div>
		
		
		<table> 
		<caption>背包列表</caption>
		<tr>
			<td style="width:100px">用户名</td>
			<td style="width:100px">物品</td>
			<td style="width:100px">序列码</td>
			<td style="width:100px">数量</td>
			<td style="width:50px">物品栏位置</td>
			<td><!-- 丢弃按钮 --></td>
		</tr>
		<tr>
		<form action="AdminPage.jsp">
			<td><input type="text" value="" name="username"></td>
			<td><input type="number" step="1" name="id_item" value="0"></td>
			<td><input type="number" step="1" name="order" value="0"></td>
			<td><input type="number" step="1" name="amount" value="0"></td>
			<td> - <input type="hidden" name="act" value="give"></td>
			<td><input type="submit" value="编辑物品"></td>
		</form>
		</tr>
		<%
		Statement stmt_inv=conn.createStatement();
		if(!username.equals(""))
		{
			stmt_inv.executeQuery("select * from inventory where username='"+username+"'");
		}
		else
		{
			stmt_inv.executeQuery("select * from inventory");
		}
		ResultSet rs_inv=stmt_inv.getResultSet();
		while(rs_inv.next())
		{
			%>
			<tr>
				<td><%=rs_inv.getString("username")%></td>
				<td><%=rs_inv.getInt("id_item")%></td>
				<td><%=rs_inv.getInt("order")%></td>
				<td><%=rs_inv.getInt("amount")%></td>
				<td><%=rs_inv.getInt("slot")%></td>
				<td><a href="AdminPage.jsp?act=drop&id_item=<%=rs_inv.getInt("id_item")%>&order=<%=rs_inv.getInt("order")%>&slot=<%=rs_inv.getInt("slot")%>&username=<%=rs_inv.getString("username")%>"><button>全部丢弃</button></a></td>
			</tr>
			<%
		}
		
		%></table><%
		
		break;
	
	case "sign":
		break;
		
	case "acco":
	default:
		break;
	}
	%>
	
	
	</div>
	
	<span class="btns" data-toggle="modal" data-target="#modal_input" onclick="btn_click_info()" style="display:none">修改信息</span>
	
	<form action="Admin.jsp">
		<input type="hidden" name="username" value="">
		<input type="hidden" name="table" value="">
		<input type="hidden" name="col" value="">
		<input type="hidden" name="is_num" value="">
	</form>
	
	<!-- 模态框 输入栏 -->
	<div class="modal fade" id="modal_input">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
			
			<!-- 模态框头部 -->
			<div class="modal-header">
				<h4 class="modal-title">要修改成?</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<!-- 模态框主体 -->
			<div class="modal-body" id="modal_input_body">
				<input type="text" id="input_value" value="" style="wdith:100%">
			</div>
			
			<!-- 模态框底部 -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">提交</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
			</div>
			
			</div>
		</div>
	</div>

</body>
</html>