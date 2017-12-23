package game.main;

import java.sql.*;
import java.util.*;
import java.io.*;
import net.sf.json.*;

public class ActHandler{
	protected static ActHandler instance;
	
	protected static Connection conn;
	
	public ActHandler() throws Exception
	{
		conn=DatabaseConnectionManager.getConnection("动作处理机",true);
		instance=this;
	}
	
	
	public static void F_Aping(String usernameIn,String loc_xIn,String loc_yIn,String ipIn) throws SQLException
	{
		conn.createStatement().executeUpdate("update last_action set ipaddr='"+ipIn+"',loc_x="+loc_xIn+",loc_y="+loc_yIn+",last_time='"+new Timestamp(new java.util.Date().getTime())+"' where username='"+usernameIn+"'");
	}
	public static void F_Aping(String usernameIn,double loc_xIn,double loc_yIn,String ipIn) throws SQLException
	{
		F_Aping(usernameIn,String.valueOf(loc_xIn),String.valueOf(loc_yIn),ipIn);
	}
	
	public static JSONObject F_Qloc(String usernameIn)
	{
		JSONObject json=new JSONObject();
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from last_action where username='"+usernameIn+"'");
			ResultSet rs=stmt.getResultSet();
			
			rs.next();
			json.put("loc_x", rs.getDouble("loc_x"));
			json.put("loc_y", rs.getDouble("loc_y"));
		}
		catch(Exception e)
		{
			e.printStackTrace();
			json.put("loc_x", 0);
			json.put("loc_y", 0);
		}
		return json;
	}
	
	public static String F_SQinv(String usernameIn) throws SQLException
	{
		JSONObject json=new JSONObject();
		
		Statement stmt=conn.createStatement();
		stmt.executeQuery("select * from inventory where username='"+usernameIn+"'");
		ResultSet rs=stmt.getResultSet();
		int amount=0;
		while(rs.next())
		{
			json.accumulate("id_item", rs.getInt("id_item"));
			json.accumulate("amount", rs.getInt("amount"));
			json.accumulate("order", rs.getInt("order"));
			json.accumulate("slot", rs.getInt("slot"));
			amount++;
		}
		json.put("amounts", amount);
		
		return json.toString();
	}
	public static String F_OQinv(String usernameIn)
	{
		return "";
	}
	
	public static String F_SQequi()
	{
		return "";
	}
	public static String F_OQequi(String usernameIn)
	{
		return "";
	}
	
	public static void F_SAuseitem(String usernameIn,String id_itemIn,String orderIn,String amountIn)
	{
		try
		{
			F_SAuseitem(usernameIn,Integer.valueOf(id_itemIn),Integer.valueOf(orderIn),Integer.valueOf(amountIn));
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	public static void F_SAuseitem(String usernameIn,int id_itemIn,int orderIn,int amountIn)
	{
		ItemUseHandler.use(usernameIn, id_itemIn, orderIn, amountIn);
	}
	
	public static void F_SAdropitem(String usernameIn,String id_itemIn,String orderIn,String amountIn)
	{
		try
		{
			F_SAdropitem(usernameIn,Integer.valueOf(id_itemIn),Integer.valueOf(orderIn),Integer.valueOf(amountIn));
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	public static void F_SAdropitem(String usernameIn,int id_itemIn,int orderIn,int amountIn)
	{
		ItemUseHandler.drop(usernameIn, id_itemIn, orderIn, amountIn);
	}
	
	public static String F_Qinfo(String usernameIn) throws SQLException
	{
		JSONObject json=new JSONObject();
		Statement stmt=conn.createStatement();
		stmt.executeQuery("select * from player where username='"+usernameIn+"'");
		ResultSet rs=stmt.getResultSet();
		rs.next();
		json.put("atk_p",rs.getInt("atk_p"));
		json.put("patk_p", rs.getInt("patk_p"));
		json.put("def_p",rs.getInt("def_p"));
		json.put("atk_m",rs.getInt("atk_m"));
		json.put("patk_m", rs.getInt("patk_m"));
		json.put("def_m",rs.getInt("def_m"));
		json.put("speed",rs.getInt("speed"));
		json.put("acc",rs.getInt("acc"));
		json.put("hp_limit",rs.getInt("hp_limit"));
		json.put("hp_re",rs.getInt("hp_re"));
		json.put("hp",rs.getInt("hp"));
		json.put("mp_limit",rs.getInt("mp_limit"));
		json.put("mp_re",rs.getInt("mp_re"));
		json.put("mp",rs.getInt("mp"));
		json.put("class_main",rs.getString("class"));
		json.put("lv",rs.getInt("lv"));
		json.put("class_sub",rs.getString("class_sub"));
		json.put("lv_sub",rs.getInt("lv_sub"));
		
		
		return json.toString();
	}
	public static String F_SQcoin(String usernameIn) throws SQLException
	{
		JSONObject json=new JSONObject();
		Statement stmt=conn.createStatement();
		stmt.executeQuery("select gold,silver,copper,irisia from player where username='"+usernameIn+"'");
		ResultSet rs=stmt.getResultSet();
		rs.next();
		json.put("gold", rs.getInt("gold"));
		json.put("silver", rs.getInt("silver"));
		json.put("copper", rs.getInt("copper"));
		json.put("irisia", rs.getInt("irisia"));
		
		return json.toString();
	}
	
	public static String F_Qsigninfo(String id_signIn) throws SQLException
	{
		Statement stmt=conn.createStatement();
		stmt.executeQuery("select * from sign_msg where id_sign="+id_signIn);
		ResultSet rs=stmt.getResultSet();
		JSONObject json=new JSONObject();
		
		int amount=0;
		while(rs.next())
		{
			json.put("id_msg_"+amount, rs.getString("id_msg"));
			json.put("msg_"+amount, rs.getString("msg"));
			json.put("type_"+amount, rs.getString("type"));
			json.put("writer_"+amount, rs.getString("writer"));
			json.put("time_begin_"+amount, rs.getString("time_begin"));
			json.put("time_end_"+amount, rs.getString("time_end"));
			amount++;
		}
		json.put("amount", amount);
		
		rs.close();
		stmt.close();
		return json.toString();
	}
	public static void F_Asign_info(String id_signIn,String msgIn,String typeIn,String writerIn,String time_beginIn,String time_endIn) throws SQLException
	{
		Statement stmt=conn.createStatement();
		stmt.executeUpdate("insert into sign_msg values("+-2+","+id_signIn+",'"+writerIn+"','"+typeIn+"','"+msgIn+"','"+time_beginIn+"','"+time_endIn+"')");
		
		stmt.close();
	}
	
	public static String F_SQsurrsPlayer(String usernameIn) throws SQLException
	{
		JSONObject json=new JSONObject();
		double locX;
		double locY;
		Statement stmt=conn.createStatement();
		stmt.executeQuery("select * from last_action where username='"+usernameIn+"'");
		ResultSet rs=stmt.getResultSet();
		rs.next();
		// 拿到玩家当前的位置
		locX=rs.getDouble("loc_x");
		locY=rs.getDouble("loc_y");
		// 开始查询周围的东西
		stmt.executeQuery("select * from last_action where abs(loc_x- "+locX+")<=1000 and abs(loc_y-"+locY+")<=1000");
		rs=stmt.getResultSet();/*
		int amount=0;
		while(rs.next())
		{
			if(rs.getString("username").equals(usernameIn))
				continue;
			json.put("username_"+amount, rs.getString("username"));
			json.put("loc_x_"+amount,rs.getDouble("loc_x"));
			json.put("loc_y_"+amount, rs.getDouble("loc_y"));
			amount++;
		}
		json.put("amount", amount);*/
		int amount=0;
		while(rs.next())
		{
			if(rs.getString("username").equals(usernameIn))
				continue;
			json.accumulate("username", rs.getString("username"));
			json.accumulate("loc_x", rs.getDouble("loc_x"));
			json.accumulate("loc_y", rs.getDouble("loc_y"));
			amount++;
		}
		json.put("amount", amount);
				
		return json.toString();
	}
	public static String F_SQsurrsMonster(String usernameIn)
	{
		JSONObject json=new JSONObject();
		
		return json.toString();
	}
	public static String F_Qentityfunclist(String id_entityIn)
	{
		return "";
	}
	public static String F_Aentityfunc(String id_entityIn,String id_functionIn)
	{
		return "";
	}


	public static void close() throws SQLException {
		if(conn==null)
			return;
		if(!conn.isClosed())
			conn.close();
	}
	
}
