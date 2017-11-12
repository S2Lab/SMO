package game.main;

import java.sql.*;

public class DatabaseConnectionManager {
	public static String host_addr="localhost";
	public static int host_port=3306;
	public static String db_name="smo";
	public static String username="root";
	public static String password="root";
	
	public static Connection getConnection() throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://"+host_addr+":"+String.valueOf(host_port)+"/"+db_name+"",username,password);
	}

}
