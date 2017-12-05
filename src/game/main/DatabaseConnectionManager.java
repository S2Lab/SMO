package game.main;

import java.sql.*;
import java.util.*;

public class DatabaseConnectionManager {
	public static String host_addr="localhost";
	public static int host_port=3306;
	public static String db_name="smo";
	public static String username="root";
	public static String password="root";
	
	static
	{
		conns=new HashMap<String,Connection>();
	}
	
	public static HashMap<String,Connection> conns;
	
	public static Connection getConnection(String getterNameIn,boolean should_keep) throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn=DriverManager.getConnection("jdbc:mysql://"+host_addr+":"+String.valueOf(host_port)+"/"+db_name+"?useUnicode=true&characterEncoding=utf-8&useSSL=false",username,password);
		
		if(should_keep)
			conns.put(getterNameIn, conn);
		
		return conn;
	}

}
