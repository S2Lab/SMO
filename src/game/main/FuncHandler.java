package game.main;

import java.sql.*;
import java.util.*;
import java.io.*;
import net.sf.json.*;

public class FuncHandler
{
	protected FuncHandler instance;
	protected static Connection conn;
	
	public FuncHandler() throws Exception
	{
		if(instance!=null)
			return;
		
		conn=DatabaseConnectionManager.getConnection();
		
		instance=this;
	}
	
	// 获取目标可能的动作
	public static JSONObject getFuncList(String id_rangeIn)
	{
		try
		{
			return getFuncList(Integer.valueOf(id_rangeIn));
		}
		catch(Exception e)
		{
			JSONObject json=new JSONObject();
			json.put("amounts", 0);
			e.printStackTrace();
			return json;
		}
	}
	public static JSONObject getFuncList(int id_rangeIn)
	{
		JSONObject json=new JSONObject();
		
		try
		{
			Statement stmt=conn.createStatement();
			
			stmt.executeQuery("select * from data_func where id_range="+id_rangeIn);
			ResultSet rs=stmt.getResultSet();
			int amount=0;
			while(rs.next())
			{
				json.accumulate("func_type", rs.getString("func_type"));
				json.accumulate("id_target", rs.getInt("id_target"));
				json.accumulate("name_to_show", rs.getString("name_to_show"));
				amount++;
			}
			json.put("amounts", amount);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		return json;
	}

	public static JSONObject executeFunc(String usernameIn,String id_targetIn,String funcIn,String param1,String param2,String param3,String param4)
	{
		try
		{
			return executeFunc(usernameIn,Integer.valueOf(id_targetIn),funcIn,param1,param2,param3,param4);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return new JSONObject();
		}
	}
	public static JSONObject executeFunc(String usernameIn,int id_targetIn,String funcIn,String param1,String param2,String param3,String param4)
	{
		System.out.println("execute func username="+usernameIn+",id_target="+id_targetIn+",func="+funcIn);
		JSONObject json=new JSONObject();
		try
		{
			Statement stmt=conn.createStatement();
			
			switch(funcIn)
			{
			case "resource": // 采集资源
				
				DBAPI.giveLootToPlayer(usernameIn, id_targetIn);
				
				break;
			case "check_shop":
				break;
			case "buy_from":
				break;
			case "sell_to":
				break;
			case "talk_with":
				break;
			case "fight_with":
				break;
			
			case "make_friends_with":
				break;
			case "trade":
				break;
				
			case "write_on":
				break;
			default:
				break;
			}
			
			
			return json;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return json;
		}
	}
	public static boolean hasFunc(int id_targetIn,String funcIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			return false;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
	}

}
