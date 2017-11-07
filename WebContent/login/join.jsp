<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KW Book Store</title>
</head>
<body>
<%
   String driverName="com.mysql.jdbc.Driver";
   String url="jdbc:mysql://localhost:3306/hw3";
   String id="root";
   String pw="k726843oy!";
   
   String _msg="가입이 완료되었습니다.";
   
   request.setCharacterEncoding("utf-8");
   try{
   Class.forName(driverName);
   Connection conn = DriverManager.getConnection(url,id,pw);
   Statement stat=conn.createStatement();
   
   String name,uid,upw,phone,addr;
   name=request.getParameter("name");
   uid=request.getParameter("id");
   upw=request.getParameter("pw");
   phone=request.getParameter("phone");
   addr=request.getParameter("addr");
   String query="insert into user_info values('"
         +name+"','"+uid+"','"+upw+"','"+phone+"','"+addr+"',0);";
         
   try{
      stat.executeUpdate(query);   
   }
   catch(com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e){
      _msg="이미 가입 된 아이디입니다.";
   }
   stat.close();
   conn.close();
   }
   catch(Exception e){
      System.err.println(e.toString());
   }
%>
<script>
var msg='<%=_msg%>';
window.alert(msg);
</script>
<meta http-equiv="refresh" content="0; url=./index.html"/>
</body>
</html>