<%@page import="game.main.*,servlet.*,java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	System.out.println("收到一次请求");

	new SMOMain();

	String username=servlet.Utils.get(request,"username");
	String act=servlet.Utils.get(request,"act");
	
	String result="default";
	
	
	try
	{
		switch(act)
		{
		case MSG.T_Aping: // 唤醒
			SMOActHandler.F_Aping(username,Utils.get(request,"loc_x"),Utils.get(request,"loc_y"));
			result="success";
			break;
			
		case MSG.T_SQinv:
			break;
		case MSG.T_OQinv:
			break;
			
		case MSG.T_SQequi:
			break;
		case MSG.T_OQequi:
			break;
			
		case MSG.T_SAuseitem:
			break;
		case MSG.T_SAuseequi:
			break;
			
		case MSG.T_SQinfo:
			break;
		case MSG.T_OQinfo:
			break;
			
		case MSG.T_Qsigninfo:
			break;
			
		case MSG.T_SQsurrs:
			break;
		case MSG.T_Qentityfunclist:
			break;
		case MSG.T_Aentityfunc:
			break;
			
		default:
		}
	}
	catch(Exception e)
	{
		System.out.println("发生错误");
		e.printStackTrace(System.out);
		result="exception";
	}
	
	/*
	if(act.equals(servlet.MSG.T_Aping))
	{
		try{
			System.out.println("username=="+servlet.Utils.get(request,"username"));
			System.out.println("username=="+servlet.Utils.get(request,"loc_x"));
			System.out.println("username=="+servlet.Utils.get(request,"loc_y"));
			SMOMain.update_user_last_action(servlet.Utils.get(request,"username"), servlet.Utils.get(request,"loc_x"), servlet.Utils.get(request,"loc_y"));
		}
		catch(Exception e)
		{
			out.print(e.getStackTrace());
			out.print("<br>发生错误<br>");
		}
	}*/
%>

<div id="username"><%=servlet.Utils.get(session,"username") %></div>

<div id="result"><%=result %></div>



