package game.main;

import java.sql.*;

public class FightHandler {
	
	protected static FightHandler instance;
	
	protected static Connection conn;
	
	public FightHandler() throws Exception
	{
		conn=DatabaseConnectionManager.getConnection("战斗处理机",true);
		instance=this;
	}
	
	protected static ResultFight getResultFight(String usernameIn,int id_monsterIn)
	{
		ResultFight ret=new ResultFight(false,false);
		
		AttrsEntity A=new AttrsEntity(usernameIn,conn);
		AttrsEntity B=new AttrsEntity(id_monsterIn,conn);
		
		ret= getResultFight(A,B);
		
		ret.is_player_A=true;
		ret.is_player_B=false;
		
		return ret;
	}
	protected static ResultFight getResultFight(String username1,String username2)
	{
		ResultFight ret=new ResultFight(false,false);
		
		AttrsEntity A=new AttrsEntity(username1,conn);
		AttrsEntity B=new AttrsEntity(username2,conn);
		
		ret=getResultFight(A,B);
		
		ret.is_player_A=true;
		ret.is_player_B=true;
		
		return ret;
	}
	protected static ResultFight getResultFight(AttrsEntity attrs1,AttrsEntity attrs2)
	{
		ResultFight ret=new ResultFight(false,false);
		
		// 真正的计算过程在这里
		;
		
		return ret;
	}
	
	protected static void executeResultFight(String username1,String username2,ResultFight rfIn)
	{
		if(rfIn.is_player_A)
		{
			DBAPI.Player_HP_Edit(username1, rfIn.HP_cost_A);
			DBAPI.Player_MP_Edit(username1, rfIn.MP_cost_A);
		}
		if(rfIn.is_player_B)
		{
			DBAPI.Player_HP_Edit(username2, rfIn.HP_cost_B);
			DBAPI.Player_MP_Edit(username2, rfIn.MP_cost_B);
		}
	}
	
	public static void executeFight(String usernameIn,int id_monsterIn)
	{
		ResultFight rf=getResultFight(usernameIn,id_monsterIn);
		executeResultFight(usernameIn,null,rf);
	}
	private static void executeFight(String username1,String username2)
	{
		System.out.println("暂未提供玩家对战功能");
		return;
	}
}
class ResultFight
{
	public int HP_cost_A;
	public int HP_cost_B;
	
	public int MP_cost_A;
	public int MP_cost_B;
	
	public boolean is_player_A;
	public boolean is_player_B;
	
	public ResultFight(boolean is_player_AIn,boolean is_player_BIn)
	{
		is_player_A=is_player_AIn;
		is_player_B=is_player_BIn;
		HP_cost_A=HP_cost_B=MP_cost_A=MP_cost_B=0;
	}
	public ResultFight(boolean is_player_AIn,boolean is_player_BIn,int haIn,int maIn,int hbIn,int mbIn)
	{
		is_player_A=is_player_AIn;
		is_player_B=is_player_BIn;
		HP_cost_A=haIn;
		HP_cost_B=hbIn;
		MP_cost_A=maIn;
		MP_cost_B=mbIn;
	}
}
class AttrsEntity
{
	public String name;
	
	public int atk_p;
	public int def_p;
	public int atk_m;
	public int def_m;
	public int speed;
	public int acc;
	public int hp_limit;
	public int hp_re;
	public int hp;
	public int mp_limit;
	public int mp_re;
	public int mp;
	
	public AttrsEntity()
	{
		name="";
		atk_p=def_p=atk_m=def_m=speed=acc=
		hp_limit=hp_re=hp=
		mp_limit=mp_re=mp
		=0;
	}
	public AttrsEntity(String usernameIn,Connection conn)
	{
		name=usernameIn;
		atk_p=def_p=atk_m=def_m=speed=acc=
		hp_limit=hp_re=hp=
		mp_limit=mp_re=mp
		=0;
		
		try
		{
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery("select * from player where username='"+usernameIn+"");
			rs.next();
			
			readFromResultSet(rs);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	public AttrsEntity(int id_monsterIn,Connection conn)
	{
		atk_p=def_p=atk_m=def_m=speed=acc=
		hp_limit=hp_re=hp=
		mp_limit=mp_re=mp
		=0;
		
		try
		{
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery("select * from data_monster where id_monster="+id_monsterIn);
			rs.next();
			
			readFromResultSet(rs);
			
			name=rs.getString("name_monster");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	public AttrsEntity(java.sql.ResultSet rsIn)
	{
		name="";
		atk_p=def_p=atk_m=def_m=speed=acc=
		hp_limit=hp_re=hp=
		mp_limit=mp_re=mp
		=0;
		
		readFromResultSet(rsIn);
	}
	
	private void readFromResultSet(java.sql.ResultSet rsIn)
	{
		try
		{
			atk_p=rsIn.getInt("atk_p");
			def_p=rsIn.getInt("def_p");
			atk_m=rsIn.getInt("atk_m");
			def_m=rsIn.getInt("def_m");
			speed=rsIn.getInt("speed");
			acc=rsIn.getInt("acc");
			hp_limit=rsIn.getInt("hp_limit");
			hp_re=rsIn.getInt("hp_re");
			hp=rsIn.getInt("hp");
			mp_limit=rsIn.getInt("mp_limit");
			mp_re=rsIn.getInt("mp_re");
			mp=rsIn.getInt("mp");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("读取属性时发生错误 已知实体名称"+name);
		}
	}
}