package game.main;

import java.sql.*;
import net.sf.json.*;

public class CraftHandler {
	protected static CraftHandler instance;
	
	protected static Connection conn;
	
	public CraftHandler() throws Exception
	{
		conn=DatabaseConnectionManager.getConnection("合成处理机",true);
		instance=this;
	}
	
	// 获取可以合成的列表
	public static JSONObject getCanCraftList(String usernameIn)
	{
		JSONObject json=new JSONObject();
		int amount=0;
		
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from data_crafting");
			ResultSet rs=stmt.getResultSet();
			while(rs.next())
			{
				json.accumulate("id_crafting", rs.getInt("id_crafting"));
				json.accumulate("lv_need", rs.getInt("lv_need"));
				json.accumulate("product_id_item", rs.getInt("product_id_item"));
				json.accumulate("product_amount", rs.getInt("product_amount"));
				json.accumulate("des", rs.getString("des"));
				amount++;
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		json.put("amounts", amount);
		
		return json;
	}
	// 获取某一个的原材料
	public static JSONObject getCraftingRaw(String id_craftingIn)
	{
		try
		{
			return getCraftingRaw(Integer.valueOf(id_craftingIn));
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return new JSONObject();
		}
	}
	public static JSONObject getCraftingRaw(int id_craftingIn)
	{
		JSONObject json=new JSONObject();
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from data_crafting where id_crafting="+id_craftingIn);
			ResultSet rs=stmt.getResultSet();
			rs.next();
			
			// 获取详细信息
			json.put("class_need", rs.getString("class_need"));
			json.put("lv_need", rs.getInt("lv_need"));
			json.put("class_sub_need", rs.getString("class_sub_need"));
			json.put("lv_sub_need", rs.getInt("lv_sub_need"));
			json.put("gold_need", rs.getInt("gold_need"));
			json.put("exp_need", rs.getInt("exp_need"));
			
			
			// 获取物品材料
			stmt.executeQuery("select * from data_crafting_raw where id_crafting="+id_craftingIn);
			rs=stmt.getResultSet();
			int amount=0;
			while(rs.next())
			{
				json.accumulate("raw_id_item", rs.getInt("raw_id_item"));
				json.accumulate("raw_amount", rs.getInt("raw_amount"));
				amount++;
			}
			json.put("amounts", amount);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return json;
	}
	// 判断某一个能不能合成
	public static boolean canCraft(String usernameIn,String id_craftingIn)
	{
		try
		{
			return canCraft(usernameIn,Integer.parseInt(id_craftingIn));
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
	}
	public static boolean canCraft(String usernameIn,int id_craftingIn)
	{
		try
		{
			// 拿到原材料列表
			
			JSONObject raws=getCraftingRaw(id_craftingIn);
			
			System.out.println(raws);
			
			
			String class_need,class_sub_need;
			int lv_need,lv_sub_need;
			int gold_need,exp_need;
			class_need=raws.getString("class_need");
			class_sub_need=raws.getString("class_sub_need");
			lv_need=raws.getInt("lv_need");
			lv_sub_need=raws.getInt("lv_sub_need");
			gold_need=raws.getInt("gold_need");
			exp_need=raws.getInt("exp_need");
			
			// 拿到
			// 判断每一种原材料是否足够
			int size=raws.getInt("amounts");
			if(size==1)
			{
				if(DBAPI.Inventory_Amount(usernameIn, raws.getInt("raw_id_item"), -1) >= raws.getInt("raw_amount"))
					return true; // 材料足够 判断下一个
				else
					return false; // 材料不够 返回否
			}
			else
			{
				for(int step=0;step<size;step++)
				{
					if(DBAPI.Inventory_Amount(usernameIn, raws.getJSONArray("raw_id_item").getInt(step), -1) >= raws.getJSONArray("raw_amount").getInt(step))
						continue; // 材料足够 判断下一个
					else
						return false; // 材料不够 返回否
				}
			}
			
			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return false;
	}
	
	// 合成 // 这个方法用来从玩家物品栏中移除对应原材料
	public static void executeCrafting(String usernameIn,String id_craftingIn)
	{
		try
		{
			executeCrafting(usernameIn,Integer.valueOf(id_craftingIn));
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	public static void executeCrafting(String usernameIn,int id_craftingIn)
	{
		if(!canCraft(usernameIn,id_craftingIn)) // 如果不能合成 直接继续
			return;
		try
		{
			JSONObject raws=getCraftingRaw(id_craftingIn);
			// 先不管物品素材之外的东西
			
			// 以后再加
			
			int size=raws.getInt("amounts");
			if(size==1)
			{
				DBAPI.Inventory_Edit(usernameIn, raws.getInt("raw_id_item"), -1, - raws.getInt("raw_amount"));
			}
			else
			{
				for(int step=0;step<size;step++)
				{
					// 挨个移除物品
					DBAPI.Inventory_Edit(usernameIn, raws.getJSONArray("raw_id_item").getInt(step), -1, - raws.getJSONArray("raw_amount").getInt(step));
				}
			}
			
			// 现在开始给予玩家合成产物
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from data_crafting where id_crafting="+id_craftingIn);
			ResultSet rs=stmt.getResultSet();
			if(rs.next())
			{
				DBAPI.Inventory_Edit(usernameIn, rs.getInt("product_id_item"), -1, rs.getInt("product_amount"));
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	/*
	 * <<笔记>>
	 * 把合成表相关的数据库弄成两个
	 * 一个记录需要的等级 金币之类的数据
	 * 一个记录所有的原材料
	 * 
	 * data_crafting_raws
	 * data_crafting
	 * */
}
