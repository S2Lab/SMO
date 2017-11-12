package game.main;

import java.sql.*;
import java.util.*;
import java.io.*;

public class SMOActHandler{
	
	protected static Connection conn;
	
	public SMOActHandler() throws Exception
	{
		conn=DatabaseConnectionManager.getConnection();
	}
	
	
	public static void F_Aping(String usernameIn,String loc_xIn,String loc_yIn) throws SQLException
	{
		conn.createStatement().executeUpdate("update last_action set loc_x="+loc_xIn+",loc_y="+loc_yIn+",last_time='"+new Timestamp(new java.util.Date().getTime())+"' where username='"+usernameIn+"'");
	}
	public static void F_Aping(String usernameIn,double loc_xIn,double loc_yIn) throws SQLException
	{
		F_Aping(usernameIn,String.valueOf(loc_xIn),String.valueOf(loc_yIn));
	}
	
	public static String F_SQinv(String usernameIn)
	{
		return "";
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
	
	public static void F_SAuseitem(String id_itemIn,String amountIn)
	{
		;
	}
	public static void F_SAuseequi(String orderIn)
	{
		;
	}
	
	public static String F_SQinfo()
	{
		return "";
	}
	public static String F_OQinfo(String usernameIn)
	{
		return "";
	}
	
	public static String F_Qsigninfo(String id_signIn)
	{
		return "";
	}
	
	public static String F_SQsurrs()
	{
		return "";
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
