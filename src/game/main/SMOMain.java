package game.main;

import servlet.*;

public class SMOMain {
	
	protected static SMOMain instance;
	
	public SMOMain()
	{
		if(instance!=null)
			return;
		
		try
		{
			log("SMO主机开始初始化");
			
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
			
			instance=this;
			log("SMO主机初始化完成");
		}
		catch(Exception e)
		{
			log("出现错误 终止初始化");
		}
	}
	
	public void log(String logIn)
	{
		System.out.println(logIn);
	}
}
