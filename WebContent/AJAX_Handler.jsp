<%@page import="game.main.*,servlet.*,java.sql.*,net.sf.json.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	new SMOMain();

	// String username=servlet.Utils.get(request,"username");
	String username=Utils.get(request.getSession(),"username");
	String act=servlet.Utils.get(request,"act");
		
	JSONObject json=new JSONObject();
	json.put("status","common");
	
	
	try
	{
		switch(act)
		{
		case MSG.T_Aping: // 唤醒
			ActHandler.F_Aping(username,Utils.get(request,"loc_x"),Utils.get(request,"loc_y"));
			json.put("status","success");
			break;
			
		case MSG.T_SQinv:
			json.put("result",ActHandler.F_SQinv(username));
			json.put("status","success");
			break;
		case MSG.T_OQinv:
			json.put("status","passed");
			break;
			
		case MSG.T_SQgold:
			json.put("result",ActHandler.F_SQgold(username));
			json.put("status","success");
			break;
			
		case MSG.T_SQequi:
			json.put("status","passed");
			break;
		case MSG.T_OQequi:
			json.put("status","passed");
			break;
			
		case MSG.T_SAuseitem:
			ActHandler.F_SAuseitem(username, Utils.get(request,"id_item"), Utils.get(request,"order"), Utils.get(request,"amount"));
			json.put("result",ActHandler.F_SQinv(username));
			json.put("status","success");
			break;
			
		case MSG.T_SAdropitem:
			ActHandler.F_SAdropitem(username, Utils.get(request,"id_item"), Utils.get(request,"order"), Utils.get(request,"amount"));
			json.put("result",ActHandler.F_SQinv(username));
			json.put("status","success");
			break;
			
		case MSG.T_Qinfo:
			json.put("result",ActHandler.F_Qinfo(username));
			json.put("status","success");
			break;
			
		case MSG.T_Qsigninfo:
			json.put("result",ActHandler.F_Qsigninfo(Utils.get(request,"id_sign")));
			json.put("status","success");
			break;
		case MSG.T_Asigninfo:
			ActHandler.F_Asign_info(
					Utils.get(request,"id_sign"),
					Utils.get(request,"msg"),
					Utils.get(request,"type"),
					Utils.get(request,"writer"),
					Utils.get(request,"time_begin"),
					Utils.get(request,"time_end"));
			json.put("status","success");
			break;
			
		case MSG.T_SQsurrsPlayer:
			json.put("result",ActHandler.F_SQsurrsPlayer(username));
			json.put("status","success");
			break;
		case MSG.T_SQsurrsMonster:
			json.put("result",ActHandler.F_SQsurrsMonster(username));
			json.put("status","success");
			break;
		case MSG.T_Qentityfunclist:
			json.put("status","passed");
			break;
		case MSG.T_Aentityfunc:
			json.put("status","passed");
			break;
			
		case MSG.T_Qcraftinglist:
			json.put("result",CraftHandler.getCanCraftList(username));
			json.put("status","success");
			break;
		case MSG.T_Qcraftingraw:
			json.put("result",CraftHandler.getCraftingRaw(Utils.get(request,"id_crafting")));
			json.put("status","success");
			break;
		case MSG.T_Acraft:
			CraftHandler.executeCrafting(username, Utils.get(request,"id_crafting"));
			json.put("status","success");
			break;
		case MSG.T_Qcancraft:
			System.out.println(username+"查询"+Utils.get(request,"id_crafting"));
			json.put("result",CraftHandler.canCraft(username, Utils.get(request,"id_crafting")));
			json.put("status","success");
			break;
			
		default:
			json.put("status","exception");
			json.put("exception_info","动作不存在");
			json.put("act_request",act);
		}
	}
	catch(Exception e)
	{
		System.out.println("发生错误");
		e.printStackTrace(System.out);
		json.put("status","exception");
	}
	
%>


<%=json.toString() %>



