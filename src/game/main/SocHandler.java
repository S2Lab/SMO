package game.main;

import java.sql.*;
import net.sf.json.*;


public class SocHandler {
	protected static SocHandler instance;
	
	protected static Connection conn;
	
	public SocHandler() throws Exception
	{
		conn=DatabaseConnectionManager.getConnection("社交处理机",true);
		instance=this;
	}
	
	// 获取好友列表
	public static JSONObject getFriendList(String usernameIn)
	{
		JSONObject json=new JSONObject();
		int amount=0;
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from friend_list where username='"+usernameIn+"'");
			ResultSet rs=stmt.getResultSet();
			while(rs.next())
			{
				json.accumulate("friendname", rs.getString("friendname"));
				json.accumulate("begintime", rs.getDate("begintime").toString());
				json.accumulate("status", rs.getString("status"));
				amount++;
			}
			stmt.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		json.put("amounts", amount);
		
		return json;
	}
	
	// 发送交友请求
	public static void setRequesting(String usernameIn,String targetIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from friend_list where username='"+usernameIn+"' and friendname='"+targetIn+"'");
			ResultSet rs=stmt.getResultSet();
			if(rs.next())
			{
try
{
	;				// test1;
}
catch(Exception e)
{
	;
}
			}
			else // 没有任何数据 // 这个时候插入一条数据
			{
				stmt.executeUpdate("insert into friend_list value('"+usernameIn+"','"+targetIn+"','"+new java.sql.Date(System.currentTimeMillis()).toLocaleString()+"','requesting')");
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	// 接受好友请求
	public static void setConfirmed(String usernameIn,String targetIn)
	{
	}
	// 拒绝好友请求
	public static void setDenyed(String usernameIn,String targetIn)
	{
	}
	// 删除好友
	public static void setRemove(String usernameIn,String targetIn)
	{
		;
	}
	
	
	// 获取公会信息
	public static JSONObject getUnionInfo(int unionIdIn)
	{
		JSONObject json=new JSONObject();
		
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from smo.union where id_union="+unionIdIn);
			ResultSet rs=stmt.getResultSet();
			rs.next();
			json.put("id_union", rs.getInt("id_union"));
			json.put("name_union",rs.getString("name_union"));
			json.put("establisher_union", rs.getString("establisher_union"));
			json.put("establish_time", rs.getDate("establish_time"));
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return json;
	}
	public static JSONObject getUnionInfo(String unionNameIn)
	{
		JSONObject json=new JSONObject();
		
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from smo.union whrer name_union='"+unionNameIn+"'");
			ResultSet rs=stmt.getResultSet();
			rs.next();
			json.put("id_union", rs.getInt("id_union"));
			json.put("name_union",rs.getString("name_union"));
			json.put("establisher_union", rs.getString("establisher_union"));
			json.put("establish_time", rs.getDate("establish_time"));
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return json;
	}
	// 获取公会成员列表
	public static JSONObject getUnionMemberList(String unionNameIn)
	{
		JSONObject json=new JSONObject();
		int amount=0;
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select id_union from smo.union where name_union='"+unionNameIn+"'");
			ResultSet rs=stmt.getResultSet();
			rs.next();
			int id_union=rs.getInt("id_union");
			stmt.executeQuery("select * from union_member");
			rs=stmt.getResultSet();
			while(rs.next())
			{
				json.accumulate("username", rs.getString("username"));
				json.accumulate("time_join", rs.getString("time_join"));
				json.accumulate("permission", rs.getString("permission"));
				amount++;
			}
			
			stmt.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		json.put("amounts", amount);
		
		return json;
	}
}
