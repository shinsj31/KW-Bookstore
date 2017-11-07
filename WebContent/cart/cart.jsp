<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
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
        
		function goroom(){
			this.document.my_info.submit();
		}
		
		function gomain(){
			this.document.my_info2.submit();
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
		   }catch(Exception e){
			   ;
		   }
		   %>
	
		<!-- Header -->
			<header id="header" class="alt">
				<h1><strong><a href="javascript:gomain()">광운서점</a></strong></h1>
				<nav id="nav">
					<ul>
						<li><a href="javascript:logout()">로그아웃</a></li>
						<li><a href="javascript:goroom()">마이룸</a></li>
						<li><a href="#">장바구니</a></li>
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

			 <section id="one" class="wrapper style1">
      
               
			  <div class="ohyeong">
         
               <div class="table-wrapper" >
               <h3>장바구니</h3>
                        <table>
                           <thead>
                              <tr>
                                 <th>책 이름</th>
                                 <th>저 자</th>
                                 <th>출판사</th>
                                 <th>가격</th>
                           
                              </tr>
                           </thead>
                           <tbody>
                     <%
                           
                                 String bids="";
                                 int count=0;
                                 request.setCharacterEncoding("utf-8");
                                 
                                 
                                 int total=0;
                                 
                                 try{
                                 Class.forName(driverName);
                                 Connection conn = DriverManager.getConnection(url,id,pw);
                                 Statement stat=conn.createStatement();
                                 
                                 String[] names;
                                 String[] authors;
                                 String[] publish;
                                 int[] cost;
                                 int[] howmany;
                                 String str="";
                                 
                                 int num=0;
                                 String query="select Bid from order_list where buy=false and Uid='"+uid+"';";
                              
                                 ps= conn.prepareStatement(query);
                                 rs=ps.executeQuery();
                                 
                                 
                                 int index=0;
                                
                                 while(rs.next())
                                    count++;
                                 
                                 int[] Bid=new int[count];
                                 ps= conn.prepareStatement(query);
                                 rs=ps.executeQuery();
                                 
                                 while(rs.next())
                                     Bid[index++]=rs.getInt("Bid");
                                 
                                 names=new String[count];
                                 authors = new String[count];
                                 publish = new String[count];
                                 cost = new int[count];
                                 howmany = new int[count];
                                 
                                 for(int i=0; i<count; i++)
                                 {
                                	 String query2="select * from book_info where Id='"+Bid[i]+"'";
                                	 if(bids=="")
                                		 bids+=Bid[i];
                                	 else
                                	 	bids=bids+","+Bid[i];
                                     System.out.println("Bids: "+bids);
                                    try{
                                       ps= conn.prepareStatement(query2);
                                       rs=ps.executeQuery();
                                       rs.next();
                                       
                                       names[i]=rs.getString("Bname");
                                       authors[i]=rs.getString("Author");
                                       publish[i]=rs.getString("Publish");
                                       cost[i]=rs.getInt("cost");
                                      total+=cost[i];
                                       str=Integer.toString(i);
                                    
                        %>
                              
                                            <tr>
                                               
                                               <td><%=names[i]%></td>
                                               <td><%=authors[i]%></td>
                                               <td><%=publish[i]%></td>
                                               <td><%=cost[i]%>원</td>
                                          
                                            
                                            </tr>
                        <%
                                 }   
                                catch(Exception e){
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
                         <tr>
                                               
                         <td>합계</td>
                        <td> </td>
                        <td> </td>
                        <td><%=total %>원</td>
                                          
                         </tr>
                              
                        </table>
           </div>
            <script>
 function buy(arg0, arg1, arg2, arg3)
 {
	    var mileage=document.getElementById("point_input").value;
	   
		window.open("","pop1","width=300, height=200");
		this.document.buy_book.Uid.value=arg0;
	    this.document.buy_book.Bids.value=arg1;
	    this.document.buy_book.Total.value=arg2-mileage;
	    this.document.buy_book.Use_Point.value=mileage;
	    this.document.buy_book.action="buy_book.jsp";
	    this.document.buy_book.target="pop1";
	    this.document.buy_book.method="post";
	    this.document.buy_book.submit();
 }
 </script>
                     <div id="buybutton">
                     <b>마일리지 사용</b>
<input type="text" style="width:40%; margin-right: 5%; float:left; height:3em" placeholder="마일리지 사용" value="0" id="point_input">
<button onclick="javascript:buy('<%=uid %>','<%=bids %>','<%=total %>','<%=point %>')" >구매하기</button>
                     
                     </div>
               </div>


</section>

<br><br>

       



					
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
<form id="buy_book" name="buy_book">
		<input type="hidden" name="Bids">
		<input type="hidden" name="Uid">
		<input type="hidden" name="Use_Point">
		<input type="hidden" name="Total">
		</form>
		
		 <form action="../myroom/myroomIndex.jsp" method="post" name="my_info">
		   <input type="hidden" name="name" value=<%=name%>>
		   <input type="hidden" name="id" value=<%=uid%>>
		   <input type="hidden" name="pw" value=<%=upw%>>
		   <input type="hidden" name="phone" value=<%=phone%>>
		   <input type="hidden" name="addr" value=<%=addr%>>
		   <input type="hidden" name="mileage" value=<%=point%>>
		   </form>
		   
		   <form action="../main/index.jsp" method="post" name="my_info2">
		   <input type="hidden" name="name" value=<%=name%>>
		   <input type="hidden" name="id" value=<%=uid%>>
		   <input type="hidden" name="pw" value=<%=upw%>>
		   <input type="hidden" name="phone" value=<%=phone%>>
		   <input type="hidden" name="addr" value=<%=addr%>>
		   <input type="hidden" name="mileage" value=<%=point%>>
		   <input type="hidden" name="query" value="select * from book_info;">
		   </form>
	</body>
</html>