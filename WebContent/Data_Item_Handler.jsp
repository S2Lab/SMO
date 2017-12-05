<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.io.*,java.sql.*,net.sf.json.*,game.main.*" %>

<%
JSONObject json=new JSONObject();
json.put("msg_type","data_item");

Connection conn=DatabaseConnectionManager.getConnection("物品信息发送器",false);
PreparedStatement stmt=conn.prepareStatement("select * from data_item");
stmt.execute();
int amount=0;
ResultSet rs=stmt.getResultSet();
while(rs.next())
{
	json.accumulate("id_item", rs.getInt("id_item"));
	json.accumulate("rarity",rs.getShort("rarity"));
	json.accumulate("name_item", rs.getString("name_item"));
	json.accumulate("order_type", rs.getShort("order_type"));
	json.accumulate("is_usable", rs.getBoolean("is_usable"));
	json.accumulate("is_wearable", rs.getBoolean("is_wearable"));
	json.accumulate("is_dropable", rs.getBoolean("is_dropable"));
	json.accumulate("is_soldable", rs.getBoolean("is_soldable"));
	json.accumulate("is_enchantable", rs.getBoolean("is_enchantable"));
	json.accumulate("is_strenthenable", rs.getBoolean("is_strenthenable"));
	json.accumulate("des", rs.getString("des"));
	amount++;
}
json.put("amounts",amount);

%>



<%=json.toString() %>