<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%
   String driverName="com.mysql.jdbc.Driver";
   String url="jdbc:mysql://localhost:3306/hw3";
   String id="root";
   String pw="k726843oy!";
   String _msg="책이 등록되었습니다.";
   
   request.setCharacterEncoding("utf-8");
   
   PreparedStatement ps=null; //동적쿼리
   ResultSet rs=null; //데이터주소값 이용하기
   
   try{
	   
   Class.forName(driverName);
   Connection conn = DriverManager.getConnection(url,id,pw);
   Statement stat=conn.createStatement();
   
   String book_num,name,author,publish,cost_s,howmany_s;
   int book_num_i=0;
   int cost_i=0;
   int howmany_i=0;
   String query="select Max(id) from book_info;";
   
   ps= conn.prepareStatement(query);
   rs=ps.executeQuery();
   
	try{
   while(rs.next()){
	   book_num=rs.getString("Max(id)");
	   book_num_i=Integer.parseInt(book_num);
   }
	}
	catch(java.lang.NumberFormatException e){
		book_num_i=0;
	}
   book_num_i++;
	
   name=request.getParameter("name");
   author=request.getParameter("author");
   publish=request.getParameter("publish");
   cost_s=request.getParameter("cost");
   howmany_s=request.getParameter("howmany");
   
   cost_i=Integer.parseInt(cost_s);
   howmany_i = Integer.parseInt(howmany_s);
   
  	query="insert into book_info values("
		   +book_num_i+",'"+name+"','"+publish+"','"+author+"',"+cost_i+","+howmany_i+");";

   try{
      stat.executeUpdate(query);   
   }
   catch(Exception e){
	  _msg="정보를 모두 입력해주세요.";
   }
   }
   catch(Exception e){
	   _msg="11";
      System.err.println(e.toString());
   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>광운서점[관리자용]</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/book.css" />
		<link href="./jquery-ui-1.12.1.custom/jquery-ui.css" rel="stylesheet">
		
	<script>
			function delete_book(id){			
				this.document.book_id.id.value=id;
				this.document.book_id.submit();
			}
			
	</script>

</head>
<body class="landing">

		<!-- Header -->
			<header id="header" class="alt">
				<h1><strong><a href="userinfo.jsp">광운서점[관리자용]</a></strong></h1>
				<nav id="nav">
					<ul>
						<li><a href="#">도서관리</a></li>
						<li><a href="userinfo.jsp">회원정보</a></li>
						<li><a href="money.html">매출관리</a></li>
					</ul>
				</nav>
			</header>
			<a href="#menu" class="navPanelToggle"><span class="fa fa-bars"></span></a>

		<!-- Banner -->
			<section id="banner">
				
			</section>
	<div class="ohyeong">
	
			<!-- One --><section>
							<h3>책 등록</h3>
							<form method="post" action="book.jsp">
								<div class="row uniform 50%">
									<div class="6u 12u$(xsmall)">
										<input type="text" name="name" id="name" value="" placeholder="책이름" />
									</div>
									<div class="6u$ 12u$(xsmall)">
										<input type="text" name="author" id="author" value="" placeholder="저자" />
									</div>
									<div class="6u 12u$(xsmall)">
										<input type="text" name="publish" id="publish" value="" placeholder="출판사" />
									</div>
									<div class="6u$ 12u$(xsmall)">
										<input type="text" name="cost" id="cost" value="" placeholder="가격" />
									</div>
									<div class="6u$ 12u$(xsmall)">
										<input type="text" name="howmany" id="howmany" value="" placeholder="재고" />
									</div>
									<div class="12u$">
										<textarea name="message" id="message" placeholder="기타 도저정보를 입력해주세요" rows="6"></textarea>
									</div>
									<div class="12u$">
										<ul class="actions">
											<li><input type="submit" value="등록" class="special" /></li>
											<li><input type="reset" value="Reset" /></li>
										</ul>
									</div>
								</div>
							</form>
						</section>
		</div>
		
		<br>
		 <section class="ohyeong">
		 
                     <h3>도서 검색</h3>
                     <div class="select-wrapper" id="Main_category">
                           <select name="category" id="category">
                              <option value="">- Category -</option>
                              <option value="1">통합검색</option>
                              <option value="2">책 제목</option>
                              <option value="3">저자</option>
                              <option value="4">출판사</option>
                           </select>
                        </div>
                         
                        <div class="6u 12u$(xsmall)"  id="Main_search">
                              <input type="text" name="Bookname" id="Bookname" value="" placeholder="도서 검색" />
                        </div>
            
            			<script type="text/javascript">
                        function search(){
                        	var search_category=document.getElementById("category");
                        	var option_value=search_category.options[search_category.selectedIndex].value;
                        	var search_text=document.getElementById("Bookname").value;
                        	
                        	if(option_value=="")
                        		window.alert("카테고리를 선택해주세요.");
                        	else if(option_value=="1"){
                        		this.document.book_query.query.value=
                        			"select * from book_info where Bname='"+search_text+"' or Author='"+search_text+
                        			"' or Publish='"+search_text+"';";
                        		this.document.book_query.submit();
                        	}
                        	else if(option_value=="2"){
                        		this.document.book_query.query.value=
                        			"select * from book_info where Bname='"+search_text+"';";
                        		this.document.book_query.submit();
                        	}
                        	else if(option_value=="3"){
                        		this.document.book_query.query.value=
                        			"select * from book_info where Author='"+search_text+"';";
                        		this.document.book_query.submit();
                        	}
                        	else if(option_value=="4"){
                        		this.document.book_query.query.value=
                        			"select * from book_info where Publish='"+search_text+"';";
                        		this.document.book_query.submit();
                        	}
                        }
                        </script>
      
                        <div id="Main_button" >
                           <button onclick="javascript:search()" class="button special small">검색</button>
                        </div>
                   
         </section>
        <form action="out.jsp" method="post" name="book_id" style="width:0px">
				<input type="hidden" name="id">
		</form>
<br><br><br>
		
		
					<div class="ohyeong">
					 <h3>도서 변경 및 폐기</h3>
					<div class="table-wrapper" >
								<table>
									<thead>
										<tr>
											<th>책 Id</th>
											<th>책 이름</th>
											<th>저 자</th>
											<th>출판사</th>
											<th>가격</th>
											<th>재고</th>
											<th>수량변경</th>
											<th>폐기</th>
										</tr>
									</thead>
									<tbody>
							<%
										 
										   request.setCharacterEncoding("utf-8");
										   
						
										   try{
										   Class.forName(driverName);
										   Connection conn = DriverManager.getConnection(url,id,pw);
										   Statement stat=conn.createStatement();
										   
										   int[] ids;
										   String[] names;
										   String[] authors;
										   String[] publish;
										   int[] cost;
										   int[] howmany;
										   String str="item";
										   String str2="count";
										   
										   int num=0;
										   String query1="select count(*) from book_info;";
										   ps= conn.prepareStatement(query1);
										   rs=ps.executeQuery();
										   
										   while(rs.next()){
											   num= Integer.parseInt((rs.getString("count(*)")));
										   }
										   
										   ids=new int[num];
										   names=new String[num];
										   authors = new String[num];
										   publish = new String[num];
										   cost = new int[num];
										   howmany = new int[num];
										   
										   String query2="";
										   String query2_1="select * from book_info limit ";
										   String query2_2=",1;";
										   
										   for(int i=0; i<num; i++)
										   {
											   query2 += query2_1 + Integer.toString(i) + query2_2;
											   try{
												   ps= conn.prepareStatement(query2);
												   rs=ps.executeQuery();
												   while(rs.next()){
													   ids[i]=rs.getInt("id");
													   names[i]=rs.getString("Bname");
													   authors[i]=rs.getString("Author");
													   publish[i]=rs.getString("Publish");
													   cost[i]=rs.getInt("cost");
													   howmany[i]=rs.getInt("Many");
													   str+=Integer.toString(i);
													   str2+=ids[i];
													   
								%>
										
												        <tr>
												        	<td><%=ids[i]%></td>
													        <td><%=names[i]%></td>
													        <td><%=authors[i]%></td>
													        <td><%=publish[i]%></td>
													        <td><%=cost[i]%>원</td>
													        <td><%=howmany[i]%></td>
													        <td style="width: 20%">
														        <form action="update.jsp" method="post" name="book_id2">
														        	<input type="hidden" name="id" value="<%=ids[i]%>">
														        	<input type="text" name="count" style="width:40%; margin-right: 5%; float:left; height:3em" placeholder="수량"/>
														        
													        		<input type="submit" class="button special small" value="변경">
													        	</form>
													        </td>
												        	<td>
												        		<input onclick="javascript:delete_book('<%=ids[i]%>');" type="button" class="button special small" value="폐기"/>
								
												        	</td>
												        
												        </tr>
								<%
														str="item";
														str2="count";
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
					

				</section>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>
			<script src="./jquery-ui-1.12.1.custom/external/jquery/jquery.js"></script>
			<script src="./jquery-ui-1.12.1.custom/jquery-ui.js"></script>
			

	</body>
	
	<form action="book_search.jsp" method="post" name="book_query">
				   <input type="hidden" name="query" value="select * from book_info;">
	</form>
<script>
var msg='<%=_msg%>';
if("11".equals(msg))
	;
else{
	window.alert(msg);
}

</script>


</html>