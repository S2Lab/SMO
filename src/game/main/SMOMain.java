package game.main;

import java.sql.*;
import java.util.*;

import servlet.*;

public class SMOMain {
	
	protected static SMOMain instance;
	
	public static Random rand;
	
	// 内部版本号
	public static String version="0.5.9 in dev";
	// 考核版本号
	public static String version_display="assessment 01.04";
	
	public static Thread dbKeeper;
	
	public SMOMain()
	{
		if(instance!=null)
			return;
		
		try
		{
			log("SMO主机开始初始化");
			
			log("开始初始化随机数发生器");
			rand=new Random();
			log("随机数发生器初始化完成");
			
			
			log("ACT处理机开始初始化");
			new ActHandler();
			log("ACT处理机初始化完成");
			
			log("账户处理机开始初始化");
			new AccoHandler();
			log("账户处理机初始化完成");
			
			log("物品效果处理机开始初始化");
			new ItemUseHandler();
			log("物品效果处理机初始化完成");
			
			log("数据库API初始化");
			new DBAPI();
			log("数据库API初始化完成");
			
			log("动作处理机开始初始化");
			new FuncHandler();
			log("动作处理机初始化完成");
			
			log("合成处理机开始初始化");
			new CraftHandler();
			log("合成处理机初始化完成");
			
			log("社交处理机开始初始化");
			new SocHandler();
			log("社交处理机初始化完成");
			
			log("商店处理机开始初始化");
			new ShopHandler();
			log("商店处理机初始化完成");
			
			log("战斗处理机开始初始化");
			new FightHandler();
			log("战斗处理机初始化完成");
			
			log("连接维持器启动");
			dbKeeper=new Thread(new ConnectionKeeper(600000)); // 每10分钟维持一次连接
			dbKeeper.start();
			
			instance=this;
			log("SMO主机初始化完成");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			log("出现错误 终止初始化");
		}
	}
	
	class ConnectionKeeper implements Runnable
	{
		boolean should_continue;
		long interval;
		
		public ConnectionKeeper(long intervalIn)
		{
			should_continue=true;
			interval=intervalIn;
		}

		@Override
		public void run() {
			do
			{
				log("尝试维持连接");
				for(String key:DatabaseConnectionManager.conns.keySet())
				{
					try
					{
						Connection conn=DatabaseConnectionManager.conns.get(key);
						conn.createStatement().executeQuery("show tables").getStatement().close();;
					}
					catch(Exception e)
					{
						log("在维持 "+key+" 持有连接的唤醒时发生错误");
						e.printStackTrace();
					}
				}
				
				
				try {
					Thread.sleep(interval);
				} catch (InterruptedException e) {
					log("连接维持器尝试暂停时发生错误");
					e.printStackTrace();
				}
			}
			while(should_continue);
		}
		
		public void stop()
		{
			should_continue=false;
		}
	}
	
	public static void log(String logIn)
	{
		System.out.println(logIn);
	}
	
	public static void stop()
	{
		instance=null;
		dbKeeper.stop();
		log("停止连接维持器");
		log("开始关闭数据连接");
		for(String key:DatabaseConnectionManager.conns.keySet())
		{
			try
			{
				log("尝试关闭 "+key+" 的数据连接");
				DatabaseConnectionManager.conns.get(key).close();
			}
			catch(Exception e)
			{
				log("关闭 "+key+" 连接时发生错误");
				e.printStackTrace();
			}
		}
		DatabaseConnectionManager.conns.clear();
		log("关闭数据连接完成");
			
	}
}
