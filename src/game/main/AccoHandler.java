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

}
