<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.io.*,java.sql.*,net.sf.json.*,game.main.*" %>

<%
JSONObject json=new JSONObject();
json.put("msg_type","data_monster");

Connection conn=DatabaseConnectionManager.getConnection();
PreparedStatement stmt=conn.prepareStatement("select * from data_monster");
stmt.execute();
int amount=0;
ResultSet rs=stmt.getResultSet();
while(rs.next())
{
	json.accumulate("id_moster", rs.getInt("id_moster"));
	json.accumulate("name_monster", rs.getString("name_monster"));
	json.accumulate("atk_p", rs.getInt("atk_p"));
	json.accumulate("def_p", rs.getInt("def_p"));
	json.accumulate("atk_m", rs.getInt("atk_m"));
	json.accumulate("def_m", rs.getInt("def_m"));
	json.accumulate("speed", rs.getInt("speed"));
	json.accumulate("acc", rs.getInt("acc"));
	json.accumulate("hp_limit", rs.getInt("hp_limit"));
	json.accumulate("hp_re", rs.getInt("hp_re"));
	json.accumulate("mp_limit", rs.getInt("mp_limit"));
	json.accumulate("mp_re", rs.getInt("mp_re"));
	json.accumulate("des", rs.getString("des"));
	amount++;
}
json.put("amounts",amount);

%>

<%=json.toString() %>