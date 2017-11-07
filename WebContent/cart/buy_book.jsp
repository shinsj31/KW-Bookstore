<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8");
String uid=request.getParameter("Uid");
String bids=request.getParameter("Bids");
String total=request.getParameter("Total");
String use_point=request.getParameter("Use_Point");
System.out.println("전송받은 쿼리: "+uid+" "+bids+" "+total+" "+use_point);
String[] Bids=bids.split(",");

for(int i=0; i<Bids.length;i++)
	System.out.println("0's bid: "+Bids[i]);

String driverName="com.mysql.jdbc.Driver";
String url="jdbc:mysql://localhost:3306/hw3";
String id="root";
String pw="k726843oy!";

try{
	Class.forName(driverName);
	Connection conn = DriverManager.getConnection(url,id,pw);
	Statement stat=conn.createStatement();
	int sub_point=Integer.parseInt(use_point);
	for(int i=0;i<Bids.length;i++){
		String query="update order_list set buy=true where Uid='"+uid+"' and Bid="+Bids[i]+";";
		String query3="update book_info set Many=Many-1 where Id="+Bids[i]+";";
		
		stat.executeUpdate(query);
		stat.executeUpdate(query3);
	}
	int add_point=Integer.parseInt(total)/10;
	String query2="update order_list set mileage=mileage+"+sub_point/2+" where Uid='"+uid+"';";
	String query="update user_info set Mileage=Mileage+"+(add_point-sub_point)+" where id='"+uid+"';";
	stat.executeUpdate(query);
	stat.executeUpdate(query2);
}
catch(Exception e){
	System.err.println(e.toString());
}
%>
구매를 완료하였습니다.
</body>
</html>