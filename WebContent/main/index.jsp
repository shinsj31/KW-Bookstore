<!DOCTYPE HTML>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/main.css" />
	</head>
	<body class="landing">
	
		<script type="text/javascript">
		function logout(){
			window.alert("로그아웃 되었습니다.");
			location.href="../main/index.html";
		}
		function myroom(){
			document.myroom_info.submit();
		}
		var chk;
		function buy(chk){
			document.cart_info.submit();
		}
		</script>

		<!-- Header -->
			<header id="header" class="alt">
				<h1><strong><a href="#">광운서점</a></strong></h1>
				<nav id="nav">
					<ul>
						<li><a href="javascript:logout()">로그아웃</a></li>
						<li><a href="javascript:myroom()">마이룸</a></li>
						<li><a href="javascript:buy()">장바구니</a></li>
					</ul>
				</nav>
			</header>

			<a href="#menu" class="navPanelToggle"><span class="fa fa-bars"></span></a>

		<!-- Banner -->
			<section id="banner">
				
			</section>

			<!-- One -->
         <section class="ohyeong">
                     <div class="wrapper style1">
                     <div class="select-wrapper" id="Main_category">
                           <select name="category" id="category">
                              <option value="">- Category -</option>
                              <option id=1 value="1">통합검색</option>
                              <option id=2 value="2">책 제목</option>
                              <option id=3 value="3">저자</option>
                              <option id=4 value="4">출판사</option>
                           </select>
                        </div>
                        
                        <div class="6u 12u$(xsmall)"  id="Main_search">
                              <input type="text" name="Bookname" id="Bookname" value="" placeholder="도서검색" />
                        </div>
                        
                        <script type="text/javascript">
                        function search(){
                        	var search_category=document.getElementById("category");
                        	var option_value=search_category.options[search_category.selectedIndex].value;
                        	var search_text=document.getElementById("Bookname").value;
                        	
                        	if(option_value=="")
                        		window.alert("카테고리를 선택해주세요.");
                        	else if(option_value=="1"){
                        		this.document.login_info.query.value=
                        			"select * from book_info where Bname='"+search_text+"' or Author='"+search_text+
                        			"' or Publish='"+search_text+"';";
                        		this.document.login_info.submit();
                        	}
                        	else if(option_value=="2"){
                        		this.document.login_info.query.value=
                        			"select * from book_info where Bname='"+search_text+"';";
                        		this.document.login_info.submit();
                        	}
                        	else if(option_value=="3"){
                        		this.document.login_info.query.value=
                        			"select * from book_info where Author='"+search_text+"';";
                        		this.document.login_info.submit();
                        	}
                        	else if(option_value=="4"){
                        		this.document.login_info.query.value=
                        			"select * from book_info where Publish='"+search_text+"';";
                        		this.document.login_info.submit();
                        	}
                        }
                        </script>
            
      
                        <div id="Main_button">
                           	<button onclick="javascript:search()" class="button special small">검색</button>
                        </div>
                     </div>
         </section>
               
               
         <section id="one" class="wrapper style1">
      
               
                     
            <div class="ohyeong">
         
               <div class="table-wrapper" >
                        <table>
                           <thead>
                              <tr>
                                 <th>장바구니</th>
                                 <th>책 이름</th>
                                 <th>저 자</th>
                                 <th>출판사</th>
                                 <th>가격</th>
                                 <th>재고</th>
                              </tr>
                           </thead>
                           <tbody>
                     <%
                                 String driverName="com.mysql.jdbc.Driver";
                                 String url="jdbc:mysql://localhost:3306/hw3";
                                 String id="root";
                                 String pw="k726843oy!";
                                 
                                 request.setCharacterEncoding("utf-8");
                                 
                                 PreparedStatement ps=null; //동적쿼리
                                 ResultSet rs=null; //데이터주소값 이용하기
                                 
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
                                 String query1=request.getParameter("query");
                                 System.out.println(query1);
                                 ps= conn.prepareStatement(query1);
                                 rs=ps.executeQuery();
                                 
                                 while(rs.next())
                                    num++;
                                 
                                 names=new String[num];
                                 authors = new String[num];
                                 publish = new String[num];
                                 cost = new int[num];
                                 howmany = new int[num];
                                 int[] ids=new int[num];
                                 
                                 ps= conn.prepareStatement(query1);
                                 rs=ps.executeQuery();
                                 
                                 for(int i=0; i<num; i++)
                                 {
                                    try{
                                       while(rs.next()){
                                          names[i]=rs.getString("Bname");
                                          authors[i]=rs.getString("Author");
                                          publish[i]=rs.getString("Publish");
                                          cost[i]=rs.getInt("cost");
                                          howmany[i]=rs.getInt("Many");
                                          ids[i]=rs.getInt("id");
                                          str=Integer.toString(i);
                        %>
                             				 <script>
											function add_cart(id){	
												window.open("","pop","width=300, height=200");
												this.document.cart.bid.value=id;
												this.document.cart.action="addCart.jsp";
												this.document.cart.target="pop";
												this.document.cart.method="post";
												this.document.cart.submit();
											}
											</script>
											

                                            <tr>
                                               <td>
                                                  <div class="6u 12u$(small)">
                                                   <button onclick="javascript:add_cart('<%=ids[i] %>')">추가</button>
                                                   <label for=<%=str%>></label>
                                                </div>
                                               </td>
                                               <td><%=names[i]%></td>
                                               <td><%=authors[i]%></td>
                                               <td><%=publish[i]%></td>
                                               <td><%=cost[i]%>원</td>
                                               <td><%=howmany[i]%></td>
                                            
                                            </tr>
                        <%
                        System.out.println(str);
                                       }   
                                    }catch(Exception e){
                                       e.printStackTrace();
                                    }
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
               
</section>
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
		<form action="../myroom/myroomIndex.jsp" method="post" name="myroom_info">
				   <input type="hidden" name="name" value=<%=name%>>
				   <input type="hidden" name="id" value=<%=uid%>>
				   <input type="hidden" name="pw" value=<%=upw%>>
				   <input type="hidden" name="phone" value=<%=phone%>>
				   <input type="hidden" name="addr" value=<%=addr%>>
				   <input type="hidden" name="mileage" value=<%=point%>>
			</form>
			<form action="../cart/cart.jsp" method="post" name="cart_info">
				   <input type="hidden" name="name" value=<%=name%>>
				   <input type="hidden" name="id" value=<%=uid%>>
				   <input type="hidden" name="pw" value=<%=upw%>>
				   <input type="hidden" name="phone" value=<%=phone%>>
				   <input type="hidden" name="addr" value=<%=addr%>>
				   <input type="hidden" name="mileage" value=<%=point%>>
			</form>
			<form action="../main/index.jsp" method="post" name="login_info">
				   <input type="hidden" name="name" value=<%=name%>>
				   <input type="hidden" name="id" value=<%=uid%>>
				   <input type="hidden" name="pw" value=<%=upw%>>
				   <input type="hidden" name="phone" value=<%=phone%>>
				   <input type="hidden" name="addr" value=<%=addr%>>
				   <input type="hidden" name="mileage" value=<%=point%>>
				   <input type="hidden" name="query" value="select * from book_info;">
				   </form>
			<form id="cart" name="cart">
				<input type="hidden" name="uid" value=<%=uid %>>>
				<input type="hidden" name="bid">
			</form>
      <!-- Scripts -->
         <script src="assets/js/jquery.min.js"></script>
         <script src="assets/js/skel.min.js"></script>
         <script src="assets/js/util.js"></script>
         <script src="assets/js/main.js"></script>

   </body>
</html>