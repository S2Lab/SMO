<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.io.*,java.sql.*,net.sf.json.*,game.main.*,servlet.*" %>

<%
JSONObject json=new JSONObject();
json.put("msg_type","data_range");

Connection conn=DatabaseConnectionManager.getConnection("区域信息发送器",false);
PreparedStatement stmt=conn.prepareStatement("select * from data_range where area='"+Utils.get(session,"area")+"'");
stmt.execute();
int amount=0;
ResultSet rs=stmt.getResultSet();
while(rs.next())
{
	json.accumulate("id_range",rs.getInt("id_range"));
	json.accumulate("name_range",rs.getString("name_range"));
	json.accumulate("func",rs.getString("func"));
	json.accumulate("pos",rs.getString("pos"));
	json.accumulate("des",rs.getString("des"));
	amount++;
}
json.put("amounts",amount);

%>

<%=json.toString() %>