<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
		request.setCharacterEncoding("UTF-8");
		
		/*장바구니 추가에 필요한 정보 : Uid, Bid*/
		String uid ,bid;
		uid=request.getParameter("uid");
		bid=request.getParameter("bid");
		
		Date d= new Date();
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		String date=sdf.format(d);
		
		//쿼리문
		String query="insert into order_list values('"+uid+"','"+date+"','"+bid+"',1,false,0);";
		
		System.out.println(query);
		
		String driverName="com.mysql.jdbc.Driver";
		String url="jdbc:mysql://localhost:3306/hw3";
		String id="root";
		String pw="k726843oy!";

		PreparedStatement ps=null; //동적쿼리
		
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
try{
	Class.forName(driverName);
	Connection conn = DriverManager.getConnection(url,id,pw);
	Statement stat=conn.createStatement();
	stat.executeUpdate(query);
	
}
catch(Exception e){
	System.err.println(e.toString());

}

%>
장바구니에 담았습니다.

</body>

</html>