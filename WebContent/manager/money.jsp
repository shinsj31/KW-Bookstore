<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
		request.setCharacterEncoding("UTF-8");
		
		String startDate,endDate;
		startDate=request.getParameter("datepicker1");
		endDate=request.getParameter("datepicker2");
		
		System.out.println(startDate+" "+endDate);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>광운서점[관리자용] - 매출 조회</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/money.css" />
<link href="./jquery-ui-1.12.1.custom/jquery-ui.css" rel="stylesheet">
<script type="text/javascript">
		function checkFrm(){
			if(document.money_info.datepicker1.value=="" || document.money_info.datepicker2.value=="")
				alert("조회기간을 설정해주세요.");
			else
				document.money_info.submit();
		}
		</script>
</head>
<body class="landing">
<%
   String driverName="com.mysql.jdbc.Driver";
   String url="jdbc:mysql://localhost:3306/hw3";
   String id="root";
   String pw="k726843oy!";

   request.setCharacterEncoding("utf-8");
   
   PreparedStatement ps=null; //동적쿼리
   ResultSet rs=null; //데이터주소값 이용하기
   ResultSet rs2=null; //데이터주소값 이용하기
   int total=0; 
   int count=0;
   String[] ids=new String[count];
   String[] dates=new String[count];
   String[] books=new String[count];
   String[] amounts=new String[count];
   int[] mileages=new int[count];
   
  try{
   Class.forName(driverName);
   Connection conn = DriverManager.getConnection(url,id,pw);
   Statement stat=conn.createStatement();
   
   String query="select * from order_list where (Odata>'"+startDate+"'or Odata='"+startDate
		   +"') and (OData<'"+endDate+"' or Odata='"+endDate+"');";
  
   ps= conn.prepareStatement(query);
   rs=ps.executeQuery();
   while(rs.next()){
	   int Bid=rs.getInt("Bid");
	   String q2="select cost from book_info where Id='"+Bid+"';";
	   ps= conn.prepareStatement(q2);
	   rs2=ps.executeQuery();
	   rs2.next();
	   int cost=rs2.getInt("cost");
	   int many=rs.getInt("many");
	   total=total+cost*many;
	   count++;
	}
   ids=new String[count];
   dates=new String[count];
   books=new String[count];
   amounts=new String[count];
   mileages=new int[count];
   int i=0;
   ps= conn.prepareStatement(query);
   rs=ps.executeQuery();
   while(rs.next()){
	   ids[i]=rs.getString("Uid");
	   dates[i]=rs.getString("OData");
	   int Bid=rs.getInt("Bid");
	   String q2="select Bname from book_info where Id='"+Bid+"';";
	   ps= conn.prepareStatement(q2);
	   rs2=ps.executeQuery();
	   rs2.next();
	   books[i]=rs2.getString("Bname");
	   int many=rs.getInt("many");
	   amounts[i]=Integer.toString(many);
	   mileages[i]=rs.getInt("mileage");
	   total-=mileages[i];
	   i++;
	}
	conn.close();
	System.out.println(total);
   }catch(Exception e){
      System.err.println(e.toString());
   }
%>
		<!-- Header -->
			<header id="header" class="alt">
				<h1><strong><a href="userinfo.jsp">광운서점[관리자용]</a></strong></h1>
				<nav id="nav">
					<ul>
						<li><a href="book.jsp">도서관리</a></li>
						<li><a href="userinfo.jsp">회원정보</a></li>
						<li><a href="#">매출관리</a></li>
					</ul>
				</nav>
			</header>

			<a href="#menu" class="navPanelToggle"><span class="fa fa-bars"></span></a>

		<!-- Banner -->
			<section id="banner">
				
			</section>
				<div class="ohyeong">
					<section>
						<div class="row uniform 50%">
							<div class="12u$">
								조회기간<br>
								<form action="money.jsp" method="post" name="money_info">
								<input type="text" id="datepicker1" name="datepicker1">
								<label id="date">~</label>
								<input type="text" id="datepicker2" name="datepicker2">
								</form>
							</div>

							<div class="12u$">
								<ul class="actions">
									<li><input type="button" onclick="checkFrm()" value="조회" class="special" /></li>
									
								</ul>
							</div>
						</div>
						</section>
						
						<br><br>
						<font size=25>총 매출액: <%=total %>원</font>
						<br><br><br>
						<font size=5><b>판매 리스트 </b></font>
							<div class="table-wrapper">
							
								<table>
									<thead>
										<tr>
											<th>ID</th>
											<th>Date</th>
											<th>Book Name</th>
											<th>Amount</th>
											<th>Use Mileage</th>
											
										</tr>
									</thead>
									<tbody>
									<%
									for(int i=0; i<count; i++){ %>
										<tr>
											<td><%=ids[i] %></td>
											<td><%=dates[i] %></td>
											<td><%=books[i] %></td>
											<td><%=amounts[i] %></td>
											<td><%=mileages[i] %></td>
										</tr>
										<%} %>
									</tbody>
									
								</table>
							</div>
							<br><br><br>
</div>
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
	</body>
</html>