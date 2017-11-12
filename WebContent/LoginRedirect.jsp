<%@page import="net.sf.json.*"%>
<%@page import="net.sf.json.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="servlet.*" %>
<%
String username=Utils.get(request,"username");
String password=Utils.get(request,"password");

boolean as_admin="on".equals(Utils.get(request,"as-admin"));


JSONObject json=new JSONObject();
json.put("name1","value1");
json.put("name2","value2");
out.print(json.toString());


boolean correct=false;

// boolean correct=AccountHandler.check(username,password,as_admin);
/*
if(correct)
{
	response.sendRedirect("GamePage.jsp");
}
else
{
	response.sendRedirect("LoginError.jsp");
}
*/
%>