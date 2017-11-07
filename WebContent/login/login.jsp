<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login</title>
<script type="text/javascript">
function checkFrm(){
	if(document.login_info.id.value=="")
		alert("ID가 없습니다.");
	else
		document.login_info.submit();
}
</script>
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
   
   String msg="";
   
  try{
   Class.forName(driverName);
   Connection conn = DriverManager.getConnection(url,id,pw);
   Statement stat=conn.createStatement();
   
   
   String uid,upw,rpw;
   uid=request.getParameter("id");
   upw=request.getParameter("pw");
 
   String query="select * from user_info where id='"+uid+"';";
   
   ps= conn.prepareStatement(query);
   rs=ps.executeQuery();
   if(rs.next()){
	   /*일치하면, 회원 정보를 html문서에 포함해서 전송을 해준다.
	    *전송할 정보: 회원이름, 아이디, 비밀번호, 전화번호, 마일리지*/
	   if(upw.equals(rs.getString("pw"))){
		   String user_pw=rs.getString("pw");
		   String user_id=rs.getString("id");
		   	String Uname=rs.getString("Uname");	
		   	String phone=rs.getString("phone");
		   	String addr=rs.getString("addr");
		   	String mileage=Integer.toString(rs.getInt("mileage"));
	   %>
		   <form action="../main/index.jsp" method="post" name="login_info">
		   <input type="hidden" name="name" value=<%=Uname%>>
		   <input type="hidden" name="id" value=<%=user_id%>>
		   <input type="hidden" name="pw" value=<%=user_pw%>>
		   <input type="hidden" name="phone" value=<%=phone%>>
		   <input type="hidden" name="addr" value=<%=addr%>>
		   <input type="hidden" name="mileage" value=<%=mileage%>>
		   <input type="hidden" name="query" value="select * from book_info;">
		   </form>
		   <script type="text/javascript">
		   checkFrm();
		   </script>
	   <%}
	   else{
		   msg="로그인 실패: 비밀밀번호를 확인해 주십시오.";%>
		   <script>
		   var msg='<%=msg%>';
		   window.alert(msg);
		   </script>
	   <% }
   }
   else{
	   msg="로그인 실패: 존재하지 않는 ID입니다.";%>
	   <script>
		msg='<%=msg%>';
		window.alert(msg);
		</script>
<%	}
	conn.close();
   }catch(Exception e){
      System.err.println(e.toString());
   }
%>
<meta http-equiv="refresh" content="0; url=./index.html"/>
</body>
</html>