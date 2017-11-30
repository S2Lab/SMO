package game.main;

import java.io.*;
import java.util.*;
import java.sql.*;

public class AccoHandler {
	
	protected static AccoHandler instance;
	protected static Connection conn;
	
	public AccoHandler() throws Exception
	{
		if(instance!=null)
			return;
		
		conn=DatabaseConnectionManager.getConnection();
		instance=this;
	}
	
	public static boolean check(String usernameIn,String passwordIn,boolean as_adminIn)
	{
		try
		{
			if(usernameIn==null || passwordIn==null)
				return false;
			
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select password,permission from accounts where username='"+usernameIn+"'");
			ResultSet rs=stmt.getResultSet();
			rs.next();
			String password_in_db=rs.getString("password");
			String permission_in_db=rs.getString("permission");
			
			stmt.close();
			
			if(!password_in_db.equals(passwordIn)) // 密码不正确
				return false;
			if(as_adminIn==true && !permission_in_db.equals("admin")) // 权限不正确
				return false;
			
			return true;
		}
		catch(Exception e)
		{
			System.out.println("验证账户信息时发生错误 自动返回false");
			return false;
		}
	}
	
	public static boolean checkUsernameExistence(String usernameIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select username from accounts");
			ResultSet rs=stmt.getResultSet();
			while(rs.next())
			{
				if(rs.getString("username").equals(usernameIn))
					return true;
			}
			return false;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
	}
	
	public static boolean createNew(String usernameIn,String passwordIn,String classIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeUpdate("insert into accounts value('"+usernameIn+"','"+passwordIn+"','player','"+new java.sql.Date(new java.util.Date().getTime()).toLocaleString()+"')");
			stmt.executeUpdate("insert into last_action value('"+usernameIn+"','',0,0,'0000-00-00','0000-00-00')");
			
			switch(classIn)
			{
			case "sword":
				stmt.executeUpdate("insert into player value('"+usernameIn+"',5,2,0,1,3,3,30,1,30,10,1,10,'"+classIn+"',1,'',0,100,0,0,0)");
				break;
			case "magic":
				stmt.executeUpdate("insert into player value('"+usernameIn+"',2,1,0,0,8,8,25,1,25,10,1,10,'"+classIn+"',1,'',0,100,0,0,0)");
				break;
			case "acc":
				stmt.executeUpdate("insert into player value('"+usernameIn+"',2,1,4,2,5,5,25,1,25,30,1,30,'"+classIn+"',1,'',0,100,0,0,0)");
				break;
			default:
				throw new Exception("职业不对");
			}
			
			DBAPI.Inventory_Edit(usernameIn, 283, -1, 1);
			
			return true;
		}
		catch(Exception e)
		{
			try
			{
				Statement stmt=conn.createStatement();
				stmt.executeUpdate("delete from accounts where username='"+usernameIn+"'");
				stmt.executeUpdate("delete from inventory where username='"+usernameIn+"'");
				
			}
			catch(Exception e2)
			{
				e2.printStackTrace();
			}
			e.printStackTrace();
			return false;
		}
	}

}
