<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>광운서점[관리자용]</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/main.css" />
	</head>


	<body class="landing">


		<!-- Header -->
			<header id="header" class="alt">
				<h1><strong><a href="#">광운서점[관리자용]</a></strong></h1>
				<nav id="nav">
					<ul>
						<li><a href="book.jsp">도서관리</a></li>
						<li><a href="#">회원정보</a></li>
						<li><a href="money.html">매출관리</a></li>
					</ul>
				</nav>
			</header>

			<a href="#menu" class="navPanelToggle"><span class="fa fa-bars"></span></a>

		<!-- Banner -->
			<section id="banner">
				
			</section>
	<form action="../myroom/myroomIndex.jsp" method="post" name="user_info">
		   	<input type="hidden" name="name">
		  	 <input type="hidden" name="id">
		  	 <input type="hidden" name="pw">
		  	 <input type="hidden" name="phone">
		   	<input type="hidden" name="addr">
		   <input type="hidden" name="mileage">
	</form>
			<!-- One -->
					
					<div class="ohyeong">
					<h3>가입 회원 정보 열람</h3>
							<div class="table-wrapper" >
								<table class="alt">
							
										<tr>
											<th>No</th>
											<th>Name</th>
											<th>Id</th>
											<th> </th>
										</tr>
									
									<tbody>
							<%
										   String driverName="com.mysql.jdbc.Driver";
										   String url="jdbc:mysql://localhost:3306/hw3";
										   String id="root";
										   String pw="k726843oy!";
										   int index=0;
										   
										   request.setCharacterEncoding("utf-8");
										   
										   PreparedStatement ps=null; //동적쿼리
										   ResultSet rs=null; //데이터주소값 이용하기
										   
										   try{
										   Class.forName(driverName);
										   Connection conn = DriverManager.getConnection(url,id,pw);
										   Statement stat=conn.createStatement();
										   
										   String[] names;
										   String[] uids;
										   String[] upws;
										   String[] phones;
										   String[] addrs;
										   String[] points;

										   int num=0;
										   String query1="select count(*) from user_info;";
										   ps= conn.prepareStatement(query1);
										   rs=ps.executeQuery();
										   
										   while(rs.next()){
											   num= Integer.parseInt((rs.getString("count(*)")));
										   }
										   
										   names=new String[num];
										   uids=new String[num];
										   upws=new String[num];
										   phones=new String[num];
										   addrs=new String[num];
										   points=new String[num];
										   
										   String query2="";
										   String query2_1="select * from user_info limit ";
										   String query2_2=",1;";
										   
										   for(int i=0; i<num; i++)
										   {
											   query2 += query2_1 + Integer.toString(i) + query2_2;
											   try{
												   ps= conn.prepareStatement(query2);
												   rs=ps.executeQuery();
												   while(rs.next()){
													   names[i]=rs.getString("Uname");
													   uids[i]=rs.getString("id");
													   upws[i]=rs.getString("pw");
													   phones[i]=rs.getString("phone");
													   addrs[i]=rs.getString("addr");
													   points[i]=rs.getString("mileage");
						%>
											<script>
											function show_info(name,id,pw,phone,addr,point){			
												this.document.user_info.name.value=name
												this.document.user_info.id.value=id
												this.document.user_info.pw.value=pw
												this.document.user_info.phone.value=phone
												this.document.user_info.addr.value=addr
												this.document.user_info.mileage.value=point
												this.document.user_info.submit();
											}
											</script>
																		
							       <tr>
										   <td><%=i%></td>
									       <td><%=names[i]%></td>
									       <td><%=uids[i]%></td>
									       <td><button onclick="show_info('<%=names[i] %>','<%=uids[i] %>','<%=upws[i] %>','<%=phones[i] %>','<%=addrs[i] %>','<%=points[i] %>')" 
									       class="button special small">정보보기</button></td>
																        
							        </tr>
				<%
							   }   
						   }catch(Exception e){
							   e.printStackTrace();
						   }
						   query2="";
						   
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

						</div>
						
					<br><br><br>
					<br><br><br>
					<br><br><br>
					

				
		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>