<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="game.main.*,servlet.*" %>

<%

String username=Utils.get(request,"username");
String password=Utils.get(request,"password");
String class_in=Utils.get(request,"class_in");

System.out.println("username=="+username+"\npassword"+password+"\nclass_in=="+class_in);
if(!AccoHandler.checkUsernameExistence(username) 
		&& username.length()<=25
		&& username.length()>0
		&& password.length()<=25
		&& password.length()>0
		)
{
	game.main.AccoHandler.createNew(username, password, class_in);
	response.sendRedirect("RegisterSuccess.jsp");
}
else
{
	response.sendRedirect("RegisterError.jsp");
}

%>