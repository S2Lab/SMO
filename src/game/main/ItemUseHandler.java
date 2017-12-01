package game.main;

import java.sql.*;
import java.io.*;
import java.util.*;
import net.sf.json.*;

public class ItemUseHandler {
	protected static ItemUseHandler instance;
	
	protected static Connection conn;
	
	protected static HashMap<Integer,ItemAttrSet> attrs;
	
	public ItemUseHandler() throws Exception
	{
		if(instance!=null)
			return;
		conn=DatabaseConnectionManager.getConnection();
		instance=this;
		
		attrs=new HashMap<Integer,ItemAttrSet>();
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from data_item");
			ResultSet rs=stmt.getResultSet();
			while(rs.next())
			{
				attrs.put(Integer.valueOf(rs.getString("id_item")), new ItemAttrSet(rs));
			}
			System.out.println("读取到"+attrs.size()+"条物品属性");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return;
		}
	}
	
	public static void use(String usernameIn,int id_itemIn,int orderIn,int amountIn)
	{
		if(getItemAttrSet(id_itemIn).is_wearable) // 是装备
		{
			useEquip(usernameIn,id_itemIn,orderIn,amountIn);
		}
		else // 不是装备
		{
			useItem(usernameIn,id_itemIn,orderIn,amountIn);
		}
	}
	
	public static void drop(String usernameIn,int id_itemIn,int orderIn,int amountIn)
	{
		DBAPI.Inventory_Edit(usernameIn, id_itemIn, orderIn, -1);
	}
	
	protected static void useItem(String usernameIn,int id_itemIn,int orderIn,int amountIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			
			ItemAttrSet attr=getItemAttrSet(id_itemIn);
			if(!attr.is_usable) // 不能使用直接返回
				return;
				
			int amount_old=DBAPI.Inventory_Amount(usernameIn, id_itemIn, orderIn);
			int amount_to_use=amount_old>=amountIn?amountIn:amount_old;// 计算将要使用的数量
			
			// 先更新一下当前数量
			// 至于"用了道具但是没有效果"的问题 不想管也管不了
			DBAPI.Inventory_Edit(usernameIn, id_itemIn, orderIn, -amount_to_use); // amount_to_use是正数 要处理成负数
			
			
			for(int times=0;times<amount_to_use;times++) // 使用多次
			{
				switch(id_itemIn)
				{
				case 2: // 测试物品2
					DBAPI.Inventory_Edit(usernameIn,11, -1,5); // 给玩家5个金锭
					break;
					
					
				case 200: // 村民口粮
					DBAPI.Player_HP_Edit(usernameIn, 10);
					break;
				case 201: // 下级体力药剂
					DBAPI.Player_HP_Edit(usernameIn, 20);
					break;
				case 202: // 普通体力药剂
					DBAPI.Player_HP_Edit(usernameIn, 50);
					break;
				case 203: // 上级体力药剂
					DBAPI.Player_HP_Edit(usernameIn, 100);
					break;
				case 204: // 大师体力药剂
					DBAPI.Player_HP_Edit(usernameIn, 300);
					break;
				case 205: // 下级伤害药剂
					DBAPI.Player_HP_Edit(usernameIn, -10);
					break;
				case 206: // 普通伤害药剂
					DBAPI.Player_HP_Edit(usernameIn, -20);
					break;
				case 207: // 上级伤害药剂
					DBAPI.Player_HP_Edit(usernameIn, -50);
					break;
				case 208: // 大师伤害药剂
					DBAPI.Player_HP_Edit(usernameIn, -300);
					break;
				case 209: // 体力完全恢复药剂
					stmt.executeUpdate("update player set hp=hp_limit where username='"+usernameIn+"'");
					break;
					
				case 220: // 村民酒
					DBAPI.Player_MP_Edit(usernameIn, 10);
					break;
				case 221: // 下级法力药剂
					DBAPI.Player_MP_Edit(usernameIn, 20);
					break;
				case 222: // 普通法力药剂
					DBAPI.Player_MP_Edit(usernameIn, 50);
					break;
				case 223: // 上级法力药剂
					DBAPI.Player_MP_Edit(usernameIn, 100);
					break;
				case 224: // 大师法力药剂
					DBAPI.Player_MP_Edit(usernameIn, 300);
					break;
				case 229: // 法力完全恢复药剂
					stmt.executeUpdate("update player set mp=mp_limit where username='"+usernameIn+"'");
					break;
					
				case 280: // 小钱袋
					DBAPI.Player_editCoin(usernameIn, COIN.copper, 50);
					DBAPI.Player_editCoin(usernameIn, COIN.silver, 50);
					DBAPI.Player_editCoin(usernameIn, COIN.gold, 50);
					DBAPI.Player_editCoin(usernameIn, COIN.irisia, 50);
					break;
				case 281: // 钱袋
					DBAPI.Player_editCoin(usernameIn, COIN.copper, 100);
					DBAPI.Player_editCoin(usernameIn, COIN.silver, 100);
					DBAPI.Player_editCoin(usernameIn, COIN.gold, 100);
					DBAPI.Player_editCoin(usernameIn, COIN.irisia, 100);
					break;
				case 282: // 大钱袋
					DBAPI.Player_editCoin(usernameIn, COIN.copper, 200);
					DBAPI.Player_editCoin(usernameIn, COIN.silver, 200);
					DBAPI.Player_editCoin(usernameIn, COIN.gold, 200);
					DBAPI.Player_editCoin(usernameIn, COIN.irisia, 200);
					break;
					
				case 284: // 下级药水袋
					DBAPI.Inventory_Edit(usernameIn, 201, -1, 5);
					DBAPI.Inventory_Edit(usernameIn, 221, -1, 5);
					break;
				case 285: // 普通药水袋
					DBAPI.Inventory_Edit(usernameIn, 202, -1, 5);
					DBAPI.Inventory_Edit(usernameIn, 222, -1, 5);
					break;
				case 286: // 上级药水袋
					DBAPI.Inventory_Edit(usernameIn, 203, -1, 5);
					DBAPI.Inventory_Edit(usernameIn, 223, -1, 5);
					break;
					
				case 283: // 新手套装礼包
					DBAPI.Inventory_Edit(usernameIn, 600, -1, 1);
					DBAPI.Inventory_Edit(usernameIn, 601, -1, 1);
					DBAPI.Inventory_Edit(usernameIn, 602, -1, 1);
					DBAPI.Inventory_Edit(usernameIn, 603, -1, 1);
					DBAPI.Inventory_Edit(usernameIn, 200, -1, 5);
					break;
					
				case 288: // 诡异的盒子
					DBAPI.Inventory_Edit(usernameIn, 205, -1, 3);
					DBAPI.Inventory_Edit(usernameIn, 206, -1, 3);
					DBAPI.Inventory_Edit(usernameIn, 207, -1, 3);
				default:
					break;
				}
			}
			
			stmt.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	protected static void useEquip(String usernameIn,int id_itemIn,int orderIn,int amountIn)
	{
		try
		{
			// 获取要装备的物品应在的slot
			int slot=getItemAttrSet(id_itemIn).slot;
			
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from inventory where username='"+usernameIn+"' and slot="+slot);
			ResultSet rs=stmt.getResultSet();
			// 判断指定slot有没有装备
			if(rs.next()) // 有的话取下
			{
				stmt.executeUpdate("update inventory set slot=0 where username='"+usernameIn+"' and slot="+slot);
				// 如果指定的装备就是当前已经装备的物品 那就直接返回 不用再装备了
				if(rs.getInt("id_item")==id_itemIn && rs.getInt("order")==orderIn)
					return;
			}
			// 装备指定物品
			stmt.executeUpdate("update inventory set slot="+slot+" where username='"+usernameIn+"' and id_item="+id_itemIn+" and inventory.order="+orderIn);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	public static void deuseEquip(String usernameIn,int slotIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from inventory where username='"+usernameIn+"' and slot="+slotIn);
			ResultSet rs=stmt.getResultSet();
			// 判断指定slot有没有装备
			if(rs.next()) // 有的话取下
			{
				stmt.executeUpdate("update inventory set slot=0 where username='"+usernameIn+"' and slot="+slotIn);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public static ItemAttrSet getItemAttrSet(int id_itemIn)
	{
		ItemAttrSet result= attrs.get(Integer.valueOf(id_itemIn));
		if(result!=null)
			return result;
		else
			return new ItemAttrSet();
	}
	public static String getItemName(int id_itemIn)
	{
		return getItemAttrSet(id_itemIn).name_item;
	}

}

