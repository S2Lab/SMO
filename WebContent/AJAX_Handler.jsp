<%@page import="game.main.*,servlet.*,java.sql.*,net.sf.json.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	new SMOMain();

	// String username=servlet.Utils.get(request,"username");
	String username=Utils.get(request.getSession(),"username");
	/*
	if(username.length()==0)
		return;
	*/
	String act=servlet.Utils.get(request,"act");
		
	JSONObject json=new JSONObject();
	json.put("status","common");
		
	
	try
	{
		switch(act)
		{
		case MSG.T_Aping: // 唤醒
		case MSG.T_Qloc:
		case MSG.T_SQinv:
		case MSG.T_OQinv:
		case MSG.T_SQcoin:
		case MSG.T_SQequi:
		case MSG.T_OQequi:
		case MSG.T_SAuseitem:
		case MSG.T_SAdropitem:
		case MSG.T_Qinfo:
		case MSG.T_OQinfo:
		case MSG.T_Asigninfo:
		case MSG.T_Ashopbuy:
		case MSG.T_Ashopsell:
		case MSG.T_SQsurrsPlayer:
		case MSG.T_SQsurrsMonster:
		case MSG.T_Qrangefunclist:
		case MSG.T_Arangefunc:

		case MSG.T_Aentityfunc:
		
		case MSG.T_Acraft:
		case MSG.T_Qfriendlist:
			
			String usernameInSession=Utils.get(session,"username");
			if(usernameInSession.equals(""))
				throw new Exception("未登陆");
			
			
		case MSG.T_Qsigninfo:
		case MSG.T_Qshoplist:
		case MSG.T_Qcraftinglist:
		case MSG.T_Qcraftingraw:
		case MSG.T_Qcancraft:
		case "checkUsernameExistence":
			break;
			
		default:
			break;
		}
		
		switch(act)
		{
		case MSG.T_Aping: // 唤醒
			ActHandler.F_Aping(username,Utils.get(request,"loc_x"),Utils.get(request,"loc_y"),request.getRemoteAddr());
			json.put("status","success");
			break;
			
		case MSG.T_Qloc: // 请求位置信息
			ActHandler.F_Qloc(username);
			json.put("status","success");
			break;
			
		case MSG.T_SQinv:
			json.put("result",ActHandler.F_SQinv(username));
			json.put("status","success");
			break;
		case MSG.T_OQinv:
			json.put("status","passed");
			break;
			
		case MSG.T_SQcoin:
			json.put("result",ActHandler.F_SQcoin(username));
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
		case MSG.T_OQinfo:
			json.put("result",ActHandler.F_Qinfo(Utils.get(request,"username")));
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
			
		case MSG.T_Qshoplist:
			json.put("result",ShopHandler.getShopList(Utils.get(request,"id_shop")));
			json.put("status","success");
			break;
		case MSG.T_Ashopbuy:
			ShopHandler.buyFrom(username, Utils.get(request,"id_shop"), Utils.get(request,"id_trade"));
			json.put("status","success");
			break;
		case MSG.T_Ashopsell:
			json.put("status","passed");
			break;
			
		case MSG.T_SQsurrsPlayer:
			json.put("result",ActHandler.F_SQsurrsPlayer(username));
			json.put("status","success");
			break;
		case MSG.T_SQsurrsMonster:
			json.put("result",ActHandler.F_SQsurrsMonster(username));
			json.put("status","success");
			break;
		case MSG.T_Qrangefunclist:
			json.put("result",FuncHandler.getFuncList(Utils.get(request,"id_range")));
			json.put("status","success");
			break;
		case MSG.T_Arangefunc:
			
			json.put("result",FuncHandler.executeFunc(username,Utils.get(request,"id_range"),Utils.get(request,"id_target"),Utils.get(request,"func"),"","","",""));
			json.put("status","success");
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
			json.put("result",CraftHandler.canCraft(username, Utils.get(request,"id_crafting")));
			json.put("status","success");
			break;
			
		case MSG.T_Qfriendlist:
			json.put("result",SocHandler.getFriendList(username));
			json.put("status","success");
			break;
			
			
			
		case "checkUsernameExistence":
			json.put("result",game.main.AccoHandler.checkUsernameExistence(Utils.get(request,"username")));
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



