package servlet;

import javax.servlet.*;
import javax.servlet.http.*;

public class Utils {
	
	public static String get(HttpSession sessionIn,String nameIn)
	{
		String result=(String)sessionIn.getAttribute(nameIn);
		return result==null?"":result;
	}
	
	public static HttpSession set(HttpSession sessionIn,String nameIn,String valueIn)
	{
		sessionIn.setAttribute(nameIn, valueIn);
		return sessionIn;
	}
	
	public static String get(HttpServletRequest requestIn,String nameIn)
	{
		String result=requestIn.getParameter(nameIn);
		return result==null?"":result;
	}

}
