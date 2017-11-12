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
			new SMOActHandler();
			log("ACT处理机初始化完成");
			
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
