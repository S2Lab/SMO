<%@page import="net.sf.json.*"%>
<%@page import="net.sf.json.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="servlet.*" %>
<%
new game.main.SMOMain();

String username=Utils.get(request,"username");
String password=Utils.get(request,"password");
String area=Utils.get(request,"area");

boolean as_admin="on".equals(Utils.get(request,"as-admin"));

boolean passed=game.main.AccoHandler.check(username, password, as_admin);

out.print("if_passed=="+passed);

if(passed)
{
	session.setAttribute("passed","true");
	session.setAttribute("username",username);
	session.setAttribute("permission",(as_admin?"admin":"player"));
	session.setAttribute("area", area);
	if(as_admin)
		response.sendRedirect("AdminPage.jsp");
	else
		response.sendRedirect("GamePage.jsp");
}
else
{
	session.invalidate();
	response.sendRedirect("LoginError.jsp");
}
%>