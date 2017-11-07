<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
		request.setCharacterEncoding("UTF-8");
		
		String startDate,endDate;
		startDate=request.getParameter("datepicker1");
		endDate=request.getParameter("datepicker2");
		
		System.out.println(startDate+" "+endDate);
%>

<%
		request.setCharacterEncoding("UTF-8");
	
		String name,uid,upw,phone,addr;
		int point;
		name=request.getParameter("name");
		uid=request.getParameter("id");
		upw=request.getParameter("pw");
		phone=request.getParameter("phone");
		addr=request.getParameter("addr");
		point=Integer.parseInt(request.getParameter("mileage"));
%>
<html>
	<head>
		<title>광운서점</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<link href="./jquery-ui-1.12.1.custom/jquery-ui.css" rel="stylesheet">
		<script type="text/javascript">
		function logout(){
			window.alert("로그아웃 되었습니다.");
			location.href="../main/index.html";
		}
	
		function checkFrm(){
			if(document.buy_info.datepicker1.value=="" || document.buy_info.datepicker2.value=="")
				alert("조회기간을 설정해주세요.");
			else
				document.buy_info.submit();
		}
		</script>
		
	</head>
	
<body class="landing">

		
		   <script>
		   function checkFrm(){
				if(document.login_info.id.value=="")
					alert("ID가 없습니다.");
				else
				document.login_info.submit();
			}
		   function gocart(){
			   this.document.my_info.submit();
		   }
			</script>
<%
		   String driverName="com.mysql.jdbc.Driver";
		   String url="jdbc:mysql://localhost:3306/hw3";
		   String id="root";
		   String pw="k726843oy!";
		
		   request.setCharacterEncoding("utf-8");
		   
		   PreparedStatement ps=null; //동적쿼리
		   ResultSet rs=null; //데이터주소값 이용하기
		   ResultSet rs2=null; //데이터주소값 이용하기
		  
		   try{
			   Class.forName(driverName);
		   
			   Connection conn = DriverManager.getConnection(url,id,pw);
	           Statement stat=conn.createStatement();

			   String query="select mileage from user_info where id='"+uid+"';";
			   
			   ps= conn.prepareStatement(query);
	           System.out.println("1");
	           rs=ps.executeQuery();
	           
	           rs.next();
	           
	           point=rs.getInt("mileage");
	
		   %>
	

		<!-- Header -->
			<header id="header" class="alt">
				<h1><strong><a onclick="javascript:checkFrm()">광운서점</a></strong></h1>
				<nav id="nav">
					<ul>
						<li><a href="javascript:logout()">로그아웃</a></li>
						<li><a href="#">마이룸</a></li>
						<li><a href="javascript:gocart()">장바구니</a></li>
					</ul>
				</nav>
			</header>

			<a href="#menu" class="navPanelToggle"><span class="fa fa-bars"></span></a>

		<!-- Banner -->
			<section id="banner">

			<div id=username>
				<output id=username2><%=name %></output>

			</div>
			<div id=info>
				<div id=info2>
					<output name="id"><%=uid %></output><br>
					<output name="pw"><%=upw %></output><br>
					<output name="addr"><%=addr %></output><br>
					<output name="phone"><%=phone %></output><br>
					<output name="mailage"><%=point %></output><br>
				</div>
			</div>
				
			</section>
				<br> <br>
			
	<div class="ohyeong">	
               
               <h3>주문 내역</h3>
                        <table>
                           <thead>
                              <tr>
                                 <th>구입 날짜</th>
                                 <th>책 이름</th>
                                 <th>출판사</th>
                                 <th>수량</th>
                                 <th>가격</th>
                           		<th>총 가격</th>
                              </tr>
                           </thead>
                           <tbody>
                     <%
                                 request.setCharacterEncoding("utf-8");
                                 
                            
                                // Class.forName(driverName);
                                 //conn = DriverManager.getConnection(url,id,pw);
                                // stat=conn.createStatement();
                                 
                                 String date;
                                 String book_name;
                                 String book_publish;
                                 int book_id;
                                 int many;
                                 int cost;
                                 int total_cost;
                                 
                                 String str="";
                                 
                                 int num=0;
                                 String query1="select count(*) from order_list where uid='";
                                 query1+=uid+"';";
                                 ps= conn.prepareStatement(query1);
                                 System.out.println("4");
                                 rs=ps.executeQuery();
                                 
                                 while(rs.next()){
                                    num= Integer.parseInt((rs.getString("count(*)")));
                                 }
                                 
                                 String query2="";
                                 String query2_1="select * from order_list where uid='";
                                 String query2_2= uid+"' and buy=true;";
                                 
                                 String query3="";
                                 query2 += query2_1 + query2_2;
                                 
                             // //   for(int i=0; i<num; i++)
                            //     {
                                    try{
                                       ps= conn.prepareStatement(query2);
                                       System.out.println("5");
                                       rs=ps.executeQuery();
                                       while(rs.next()){
                                    	   date=rs.getString("OData");
                                    	   book_id=rs.getInt("Bid");
                                    	   many=rs.getInt("Many");
                                    	   
                                    	   
                                    	   query3="select * from book_info where Id='"+book_id+"';";
                                    	   ps= conn.prepareStatement(query3);
                                    	   System.out.println("6");
                                    	   rs2= ps.executeQuery();
                                    	   rs2.next();
                                    	   cost=rs2.getInt("cost");
                                    	   book_name=rs2.getString("Bname");
                                    	   book_publish=rs2.getString("Publish");
                                    	   total_cost=cost*many;
                                    	   
                        %>
                              
                                            <tr>
	                                            <td><%=date%></td>
	                                            <td><%=book_name%></td>
	                                            <td><%=book_publish%></td>
	                                            <td><%=many%></td>
	                                            <td><%=cost%>원</td>
	                                        	<td><%=total_cost%>원</td>
                                            </tr>
                        <%
                        System.out.println(str);
                                       }   
                                    }catch(Exception e){
                                       e.printStackTrace();
                                    }
                               
                                     
                                 stat.close();
                                 conn.close();
                                 }
                                 catch(Exception e){
                                    e.printStackTrace();
                                 }
   
                      %>
                              
                        </table>
                 </div>
      


					<br><br><br>
					<br><br><br>
					<br><br><br>
					
		<!-- Footer -->
			<footer id="footer">
				<div class="container">
					<ul class="icons">
						<li><a href="#" class="icon fa-facebook"></a></li>
						<li><a href="#" class="icon fa-twitter"></a></li>
						<li><a href="#" class="icon fa-instagram"></a></li>
					</ul>
					<ul class="copyright">
						<li>&copy; Untitled</li>
						<li>Design: <a href="http://templated.co">TEMPLATED</a></li>
						<li>Images: <a href="http://unsplash.com">Unsplash</a></li>
					</ul>
				</div>
			</footer>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

			<script src="./jquery-ui-1.12.1.custom/external/jquery/jquery.js"></script>
			<script src="./jquery-ui-1.12.1.custom/jquery-ui.js"></script>
	<script>

		$( "#datepicker" ).datepicker({
			inline: true
		});
		$( "#datepicker1,#datepicker2" ).datepicker({
			 dateFormat: 'yy-mm-dd'
		});

</script>
	<form action="../main/index.jsp" method="post" name="login_info">
		   <input type="hidden" name="name" value=<%=name%>>
		   <input type="hidden" name="id" value=<%=uid%>>
		   <input type="hidden" name="pw" value=<%=upw%>>
		   <input type="hidden" name="phone" value=<%=phone%>>
		   <input type="hidden" name="addr" value=<%=addr%>>
		   <input type="hidden" name="mileage" value=<%=point%>>
		   <input type="hidden" name="query" value="select * from book_info;">
		   </form>
		   
		   <form action="../cart/cart.jsp" method="post" name="my_info">
		   <input type="hidden" name="name" value=<%=name%>>
		   <input type="hidden" name="id" value=<%=uid%>>
		   <input type="hidden" name="pw" value=<%=upw%>>
		   <input type="hidden" name="phone" value=<%=phone%>>
		   <input type="hidden" name="addr" value=<%=addr%>>
		   <input type="hidden" name="mileage" value=<%=point%>>
		   </form>
	</body>
</html>