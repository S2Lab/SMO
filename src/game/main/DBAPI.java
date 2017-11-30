package game.main;

import java.sql.*;

public class DBAPI {
	protected static DBAPI instance;
		
	protected static Connection conn;
	
	public DBAPI() throws Exception
	{
		if(instance!=null)
			return;
		conn=DatabaseConnectionManager.getConnection();
		instance=this;
	}
	
	
	// 用来获取item的详细属性
	public static ItemAttrSet getItemAttrSet(int id_itemIn)
	{
		return ItemUseHandler.getItemAttrSet(id_itemIn);
	}
	
	
	/*
	 * 这几个API用来操作物品栏中的物品 的数量
	 * 普通物品 是材料、消耗品、任务物品、无成长性物品等
	 * 独特物品 是可成长的武器、装备等
	 * 
	 * 根据输入的id和order在数据库内寻找物品
	 * 
	 */
	public static void Inventory_Remove(String usernameIn,int id_itemIn,int orderIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeUpdate("delete from inventory where id_item="+id_itemIn+" and inventory.order="+orderIn);
			stmt.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("删除物品时出现异常");
		}
	}
	public static void Inventory_Edit(String usernameIn,int id_itemIn,int orderIn,int amount_to_change)
	{
		// 如果变动数量为0 就直接返回
		if(amount_to_change==0)
			return;
		
		try
		{
			Statement stmt=conn.createStatement();
			/*	改变物品数量有这几种情况
				仓库里有n物品 数量增加x
				仓库里有n物品 数量减少x
				
				仓库里没有n物品 数量增加x // 新建记录
				仓库里没有n物品 数量减少x // 不执行
			*/
			
			stmt.executeQuery("select * from inventory where username='"+usernameIn+"' and id_item="+id_itemIn+" and inventory.order="+orderIn);
			ResultSet rs=stmt.getResultSet();

			// 获取仓库里本来的数量
			int amount_old;
			if(rs.next())
			{
				amount_old=rs.getInt("amount");
			}
			else
				amount_old=0;
			
			if(amount_old>0) // 如果原本的数量大于0
			{
				// 计算变更后的数量
				int amount_new=amount_old+amount_to_change;
				
				if(amount_new>0) // 变更后数量大于0
				{
					stmt.executeUpdate("update inventory set amount="+amount_new+" where inventory.order="+orderIn+" and id_item="+id_itemIn+" and username='"+usernameIn+"'");
				}
				else // 变更后数量小于等于0 // 直接删除记录
				{
					stmt.executeUpdate("delete from inventory where inventory.order="+orderIn+" and id_item="+id_itemIn+" and username='"+usernameIn+"'");
				}
			}
			else // 原本没有
			{
				if(amount_to_change>0) // 增加数量 // 执行
				{
					stmt.executeUpdate("insert into inventory value('"+usernameIn+"',"+id_itemIn+","+amount_to_change+","+orderIn+",0)");
				}
				else // 减少数量 // 不执行
					return;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("编辑物品时出现异常");
		}
	}
	public static int Inventory_Amount(String usernameIn,int id_itemIn,int orderIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from inventory where username='"+usernameIn+"' and id_item="+id_itemIn+" and inventory.order="+orderIn);
			ResultSet rs=stmt.getResultSet();
			if(rs.next())
			{
				return rs.getInt("amount");
			}
			else
				return 0;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("查询物品时出现异常");
			return 0;
		}
	}
	
	
	// 这几个API用来操作HP和MP相关属性
	public static int Player_HP_Amount(String usernameIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select hp from player where username='"+usernameIn+"'");
			ResultSet rs=stmt.getResultSet();
			if(rs.next())
			{
				return rs.getInt("hp");
			}
			else
				return 0;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return 0;
		}
	}
	public static void Player_HP_Edit(String usernameIn,int amountIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeUpdate("select hp,hp_limit from player where username='"+usernameIn+"'");
			int hp_old,hp_limit,hp_new;
			ResultSet rs=stmt.getResultSet();
			hp_old=rs.getInt("hp");
			hp_limit=rs.getInt("hp_limit");
			hp_new=hp_old+amountIn;
			if(hp_new>=0 && hp_new<=hp_limit)
			{
				stmt.executeUpdate("update player set hp="+hp_new+" where username='"+usernameIn+"'");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	public static int Player_MP_Amount(String usernameIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select mp from player where username='"+usernameIn+"'");
			ResultSet rs=stmt.getResultSet();
			if(rs.next())
			{
				return rs.getInt("mp");
			}
			else
				return 0;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return 0;
		}
	}
	public static void Player_MP_Edit(String usernameIn,int amountIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeUpdate("select mp,mp_limit from player where username='"+usernameIn+"'");
			int mp_old,mp_limit,mp_new;
			ResultSet rs=stmt.getResultSet();
			mp_old=rs.getInt("mp");
			mp_limit=rs.getInt("mp_limit");
			mp_new=mp_old+amountIn;
			if(mp_new>=0 && mp_new<=mp_limit)
			{
				stmt.executeUpdate("update player set mp="+mp_new+" where username='"+usernameIn+"'");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 这几个API用来操作玩家的货币数量
	
	public static int Player_getCoin(String usernameIn,COIN typeIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from player where username='"+usernameIn+"'");
			ResultSet rs=stmt.getResultSet();
			rs.next();
			return rs.getInt(typeIn.name());
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return 0;
		}
	}
	public static Coins Player_getCoins(String usernameIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select gold,silver,copper,irisia from player where username='"+usernameIn+"'");
			ResultSet rs=stmt.getResultSet();
			rs.next();
			return new Coins(rs.getInt("gold"),rs.getInt("silver"),rs.getInt("copper"),rs.getInt("irisia"));
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return new Coins(0,0,0,0);
		}
	}
	public static void Player_setCoin(String usernameIn,COIN typeIn,int valueIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeUpdate("update player set "+typeIn.name()+"="+valueIn+" where username='"+usernameIn+"'");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	public static void Player_editCoin(String usernameIn,COIN typeIn,int valueToChange)
	{
		int old_value=Player_getCoin(usernameIn,typeIn);
		int new_value=old_value+valueToChange;
		if(new_value<0)
			new_value=0;
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeUpdate("update player set "+typeIn.name()+"="+new_value+" where username='"+usernameIn+"'");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	
	// 这几个API用来操作玩家状态
	// 冻结玩家
	public static void Player_freeze(String usernameIn,long timeIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			// 当前时间加上冻结长度
			java.sql.Date freeze_to=new java.sql.Date(new java.util.Date().getTime()+timeIn);
			stmt.executeUpdate("update last_action set freeze_to='"+freeze_to.toLocaleString()+"' where username='"+usernameIn+"'");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	// 解冻玩家
	public static void Player_free(String usernameIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			// 把锁定时间设为现在就好了
			stmt.executeUpdate("update last_action set freeze_to='"+new java.sql.Date(new java.util.Date().getTime()).toLocaleString()+"' where username='"+usernameIn+"'");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	// 剩余冻结时间
	public static long Player_freeze_remain(String usernameIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select freeze_to from last_action where username='"+usernameIn+"'");
			ResultSet rs=stmt.getResultSet();
			rs.next();
			long freeze_to=rs.getDate("freeze_to").getTime();
			long now=new java.util.Date().getTime();
			
			return freeze_to-now >= 0 ? freeze_to-now : 0;
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return 0;
		}
	}
	
	// 这几个API用来操作loot表
	// 读取一个loot表并且自动计算本次的随机数量 然后添加到一个玩家的物品栏
	public static void Loot_giveLootToPlayer(String usernameIn,int id_lootIn)
	{
		try
		{
			Statement stmt=conn.createStatement();
			stmt.executeQuery("select * from data_loot where id_loot="+id_lootIn);
			ResultSet rs=stmt.getResultSet();
			while(rs.next())
			{
				int id_item=rs.getInt("id_item");
				int order=rs.getInt("order");
				int amount_min=rs.getInt("amount_min");
				int amount_max=rs.getInt("amount_max");
				float proprobability=rs.getFloat("probability");
				
				System.out.println("give id_item"+id_item+", * "+amount_max);
				DBAPI.Inventory_Edit(usernameIn, id_item, order, amount_max);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 这几个API用来操作玩家和range的距离问题
	// 是否可以交互
	public static boolean can_executeWith(String usernameIn,int id_rangeIn)
	{
		return false;
	}

}
enum COIN
{
	gold,silver,copper,irisia
}
class Coins
{
	public int gold;
	public int silver;
	public int copper;
	public int irisia;
	public Coins(int goldIn,int silverIn,int copperIn,int irisiaIn)
	{
		gold=goldIn;
		silver=silverIn;
		copper=copperIn;
		irisia=irisiaIn;
	}
}
class ItemAttrSet
{
	// 基础属性
	public String name_item;
	
	public boolean is_usable;
	public boolean is_soldable;
	public boolean is_dropable;
	public boolean is_wearable;
	public boolean is_enchantable;
	public boolean is_strenthenable;
	public short order_type;
	public short slot;
	// 增益属性
	public int atk_p;
	public int def_p;
	public int atk_m;
	public int def_m;
	public int speed;
	public int acc;
	public int hp;
	public int hp_re;
	public int hp_limit;
	public int mp;
	public int mp_re;
	public int mp_limit;
	public ItemAttrSet(ResultSet rsIn) throws SQLException
	{
		name_item=rsIn.getString("name_item");
		
		is_usable=rsIn.getBoolean("is_usable");
		is_soldable=rsIn.getBoolean("is_soldable");
		is_dropable=rsIn.getBoolean("is_dropable");
		is_wearable=rsIn.getBoolean("is_wearable");
		is_enchantable=rsIn.getBoolean("is_enchantable");
		is_strenthenable=rsIn.getBoolean("is_strenthenable");
		slot=rsIn.getShort("slot");
		order_type=rsIn.getShort("order_type");
		
		atk_p=rsIn.getInt("atk_p");
		def_p=rsIn.getInt("def_p");
		atk_m=rsIn.getInt("atk_m");
		def_m=rsIn.getInt("def_m");
		speed=rsIn.getInt("speed");
		acc=rsIn.getInt("acc");
		hp=rsIn.getInt("hp");
		hp_re=rsIn.getInt("hp_re");
		hp_limit=rsIn.getInt("hp_limit");
		mp=rsIn.getInt("mp");
		mp_re=rsIn.getInt("mp_re");
		mp_limit=rsIn.getInt("mp_limit");
	}
	public ItemAttrSet()
	{
		is_soldable=is_dropable=is_wearable=is_enchantable=is_strenthenable=false;
		order_type=-1;
	}
}

/**   
 * Created by yuliang on 2015/3/20.   
 */    
// 用来计算距离的工具
class LocationUtils {    
    private static double EARTH_RADIUS = 6378.137;    
    
    private static double rad(double d) {    
        return d * Math.PI / 180.0;    
    }    
    
    /**   
     * 通过经纬度获取距离(单位：米)   
     * @param lat1   
     * @param lng1   
     * @param lat2   
     * @param lng2   
     * @return   
     */    
    public static double getDistance(double lat1, double lng1, double lat2,    
                                     double lng2) {    
        double radLat1 = rad(lat1);    
        double radLat2 = rad(lat2);    
        double a = radLat1 - radLat2;    
        double b = rad(lng1) - rad(lng2);    
        double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2)    
                + Math.cos(radLat1) * Math.cos(radLat2)    
                * Math.pow(Math.sin(b / 2), 2)));    
        s = s * EARTH_RADIUS;    
        s = Math.round(s * 10000d) / 10000d;    
        s = s*1000;    
        return s;    
    }    
}  
