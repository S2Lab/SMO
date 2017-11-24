package game.main;

import java.sql.*;
import java.util.*;
import java.io.*;
import net.sf.json.*;

class FuncHandler
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
	public static String[] getFuncList(int id_targetIn)
	{
		String[] result;
		LinkedList<String> array=new LinkedList<String>();
		
		try
		{
			Statement stmt=conn.createStatement();
			
			stmt.executeQuery("select * from data_func where id_target="+id_targetIn);
			ResultSet rs=stmt.getResultSet();
			while(rs.next())
			{
				array.add(rs.getString("func"));
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		result=new String[array.size()];
		int step=0;
		for(String item:array)
		{
			result[step]=item;
			step++;
		}
		return result;
	}
	protected static int getIDFuncTo()
	{
		return 0;
	}
	public static String executeFunc(String usernameIn,int id_targetIn,String funcIn,String param1,String param2,String param3,String param4)
	{
		JSONObject json=new JSONObject();
		try
		{
			Statement stmt=conn.createStatement();
			
			switch(funcIn)
			{
			case "gather":
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
			
			
			return json.toString();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return json.toString();
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
