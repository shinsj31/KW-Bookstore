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
   
   PreparedStatement ps=null; //��������
   ResultSet rs=null; //�������ּҰ� �̿��ϱ�
   
   String bid=request.getParameter("id");
   
   String query="delete from book_info where id=";       // sql ����

   query+=bid+";";

   try{
	   
   Class.forName(driverName);
   Connection conn = DriverManager.getConnection(url,id,pw);
   PreparedStatement pstmt = null;

   
   
   pstmt = conn.prepareStatement(query);                          // prepareStatement���� �ش� sql�� �̸� �������Ѵ�.

  

   pstmt.executeUpdate();                                        // ������ �����Ѵ�.


   conn.close();
   
   
   }
   catch(Exception e){
      System.err.println(e.toString());
   }
 
   %>
   <script>
   		window.alert("������ ���Ǿ����ϴ�.");
	</script>
</body>
</html>