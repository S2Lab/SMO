package game.main;

import java.sql.*;
import java.util.*;
import net.sf.json.*;

public class ShopHandler{
	
	protected static ShopHandler instance;
	
	protected static Connection conn;
	
	public ShopHandler() throws Exception
	{
		if(instance!=null)
			return;
		conn=DatabaseConnectionManager.getConnection();
		instance=this;
	}
	
	// 获取详细的交易列表
	public static JSONObject getShopList(String id_shopIn)
	{
		JSONObject json=new JSONObject();
		
		int amount=0;
		
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from data_shop where id_shop="+id_shopIn);
			ResultSet rs=stmt.getResultSet();
			while(rs.next())
			{
				json.accumulate("id_trade", rs.getInt("id_trade"));
				
				json.accumulate("id_item_sold", rs.getInt("id_item_sold"));
				json.accumulate("amount_sold", rs.getInt("amount_sold"));
				
				json.accumulate("gold_need", rs.getInt("gold_need"));
				json.accumulate("silver_need", rs.getInt("silver_need"));
				json.accumulate("copper_need", rs.getInt("copper_need"));
				json.accumulate("irisia_need", rs.getInt("irisia_need"));
				
				json.accumulate("name", rs.getString("name"));
				json.accumulate("des", rs.getString("des"));
				
				amount++;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		json.put("id_shop", id_shopIn);
		json.put("amounts", amount);
		
		return json;
	}
	// 购买
	public static void buyFrom(String usernameIn,String id_shopIn,String id_tradeIn)
	{
		try
		{
			if(!canBuy(usernameIn,id_shopIn,id_tradeIn)) // 不能买就直接返回
				return;
			
			// 获取交易表
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from data_shop where id_shop="+id_shopIn+" and id_trade="+id_tradeIn);
			ResultSet rs=stmt.getResultSet();
			rs.next();
			
			// 获取价格
			int gold_need=rs.getInt("gold_need");
			int silver_need=rs.getInt("silver_need");
			int copper_need=rs.getInt("copper_need");
			int irisia_need=rs.getInt("irisia_need");
			
			int id_item_sold=rs.getInt("id_item_sold");
			int amount_sold=rs.getInt("amount_sold");
			// int order=rs.getInt("data_shop.order"); // 还没考虑order
			
			Coins coins_old=DBAPI.Player_getCoins(usernameIn);
			// 计算能剩下多少钱
			int gold_new=coins_old.gold-gold_need;
			int silver_new=coins_old.silver-silver_need;
			int copper_new=coins_old.copper-copper_need;
			int irisia_new=coins_old.irisia-irisia_need;
			
			// 刷新钱
			stmt.executeUpdate("update player set gold="+gold_new+",silver="+silver_new+",copper="+copper_new+",irisia="+irisia_new+" where username='"+usernameIn+"'");
			
			// 给玩家东西
			DBAPI.Inventory_Edit(usernameIn, id_item_sold, -1, amount_sold);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	// 获取价格
	public static Coins getPrice(String id_shopIn,String id_tradeIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select gold_need,silver_need,copper_need,irisia_need from data_shop where id_shop="+id_shopIn+" and id_trade="+id_tradeIn);
			ResultSet rs=stmt.getResultSet();
			rs.next();
			return new Coins(rs.getInt("gold_need"),rs.getInt("silver_need"),rs.getInt("copper_need"),rs.getInt("irisia_need"));
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return new Coins(9999,9999,9999,9999); // 发生错误的话就返回一个不可能买得起的价格
		}
	}
	// 判断现在钱够不够
	public static boolean canBuy(String usernameIn,String id_shopIn,String id_tradeIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select gold_need,silver_need,copper_need,irisia_need from data_shop where id_shop="+id_shopIn+" and id_trade="+id_tradeIn);
			ResultSet rs=stmt.getResultSet();
			rs.next();
			Coins coins=DBAPI.Player_getCoins(usernameIn);
			if(rs.getInt("gold_need")<=coins.gold
			&& rs.getInt("silver_need")<=coins.silver
			&& rs.getInt("copper_need")<=coins.copper
			&& rs.getInt("irisia_need")<=coins.irisia)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
	}
	
	// 出售
	public static void sold(String usernameIn,int id_itemIn,int orderIn,int amountIn)
	{
		System.out.println("调用了未实现的功能");
	}
}
