<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="refresh" content="0; url=book.jsp"/>
<title>Insert title here</title>
</head>
<body>

<%
   String driverName="com.mysql.jdbc.Driver";
   String url="jdbc:mysql://localhost:3306/hw3";
   String id="root";
   String pw="k726843oy!";
   request.setCharacterEncoding("utf-8");
   
   PreparedStatement ps=null; //동적쿼리
   ResultSet rs=null; //데이터주소값 이용하기
   
   String bid=request.getParameter("id");
   
   String query="delete from book_info where id=";       // sql 쿼리

   query+=bid+";";

   try{
	   
   Class.forName(driverName);
   Connection conn = DriverManager.getConnection(url,id,pw);
   PreparedStatement pstmt = null;

   
   
   pstmt = conn.prepareStatement(query);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.

  

   pstmt.executeUpdate();                                        // 쿼리를 실행한다.


   conn.close();
   
   
   }
   catch(Exception e){
      System.err.println(e.toString());
   }
 
   %>
   <script>
   		window.alert("도서가 폐기되었습니다.");
	</script>
</body>
</html>