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

	
	// 创建一个物品栏里的 使用 按钮
	public static String UI_InvBtnUse(String idIn,String orderIn)
	{
	    return "<span style=\"border:1px solid gray;\" onclick=\"UI_click_item_use("+idIn+","+orderIn+")\">使用</span>";
	}
		public static String UI_InvBtnUse(int idIn,int orderIn)
		{
			return UI_InvBtnUse(String.valueOf(idIn),String.valueOf(orderIn));
		}
		public static String UI_InvBtnUse(int idIn,String orderIn)
		{
			return UI_InvBtnUse(String.valueOf(idIn),orderIn);
		}
		public static String UI_InvBtnUse(String idIn,int orderIn)
		{
			return UI_InvBtnUse(idIn,String.valueOf(orderIn));
		}
	// 创建一个物品栏里的 丢弃 按钮
	public static String UI_InvBtnDrop(String idIn,String orderIn)
	{
		return "<span style=\"border:1px solid gray;\" onclick=\"UI_click_item_drop("+idIn+","+orderIn+")\">丢弃</span>";
	}
	// 创建一个物品栏里的 检查 按钮
	public static String UI_InvBtnCheck(String idIn,String orderIn)
	{
		return "<span style=\"border:1px solid gray;\" onclick=\"UI_click_item_check("+idIn+","+orderIn+")\">检查</span>";
	}
}
