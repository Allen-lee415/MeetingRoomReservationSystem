<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String username=(String)session.getAttribute("username");%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<title>欢迎使用会议室预约管理系统</title>
	<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
</head>
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script language="javascript">

	//页面加载时div的隐藏函数
	function dispdiv(){	
		
		var divA=document.getElementById("divadd");
		var divU=document.getElementById("divupdate");
		divA.style.display='none';
		divU.style.display='none';
	}
		function showdiv(){	
		alert("liang");
		var divS=document.getElementById("divadd");
		divS.focus();
		divS.style.display='inline';
	}

</script>
<body onload="dispdiv()">
<div id="header">
	<div class="shell">
		<!-- Logo + Top Nav -->
		<div id="top">
			<h1><a href="#"><font face="黑体">会议室预约管理系统</font> </a></h1>
			<div id="top-navigation">
			    欢迎 <a href="#"><strong><%=username %></strong></a>
				<span>|</span>
				<a href="#">帮助</a>
				<span>|</span>
				<a href="#">个性化设置</a>
				<span>|</span>
				<a href="login.jsp">退出</a>
			</div>
		</div>
		<!-- End Logo + Top Nav -->
		
		<!-- Main Nav -->
		<div id="navigation">
			<ul>
			    <li><a href="firstPage.jsp"><span>首页 </span></a></li>
			    <li><a href="mrInfoAdmin.jsp" class="active"><span>会议室预约</span></a></li>
			    <li><a href="myMinfo.do?action=queryByPageMyBook"><span>我的预约</span></a></li>
			    <li><a href="chartUser.jsp"><span>查看统计图表</span></a></li>
			    
			</ul>
		</div>
		<!-- End Main Nav -->
	</div>
</div>
<!-- End Header -->

<!-- Container -->
<div id="container">
	<div class="shell">
		
		<!-- Small Nav -->
		<div class="small-nav">
			<a href="#">会议室信息管理</a>
			<span>&gt;</span>
			会议室信息列表
		</div>
		<!-- End Small Nav -->
		
		<br />
		<!-- Main -->
		<div id="main">
			<div class="cl">&nbsp;</div>
			
			<!-- Content -->
			<div id="content">
				
				<!-- Box -->
				<div class="box">
					<!-- Box Head -->
					<div class="box-head">
						<h2 class="left">会议室信息列表</h2>
						<div class="right">
							<label>搜索会议室</label>
							<input type="text" class="field small-field" />
							<input type="submit" class="button" value="搜索" />
						</div>
					</div>
					<!-- End Box Head -->	

					<!-- Table -->
					<div class="table">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" name=userinfo>
							<tr>
								<th width="13"><input type="checkbox" class="checkbox" /></th>
								<th>编号</th>
								<th>会议室名称</th>
								<th>座位数</th>
								<th>地址</th>
								<th>有无投影</th>
								<th width="110" class="ac">内容管理</th>
							</tr>
												
							
							<logic:iterate id="mrInfo" name="list">
				<tr>
				<td><input type="checkbox" class="checkbox" /></td>
				<td>
					<h3><font color="#ba4c32">${mrInfo.meetingroomId }</font></h3></a>
					</td>
					<td>
						<h3>${mrInfo.meetingroomName }</h3>
					</td>
					<td>
						<h3><font color="#ba4c32">${mrInfo.seatNum }</font></h3>
					</td>
					<td>
						<h3>${mrInfo.location }</h3>
					</td>
					<td>
						<h3>${mrInfo.projector }</h3>
					</td>
					<td><a href="user_Book.jsp?id=${mrInfo.meetingroomId}" class="ico edit">开始预约</a></td>			  
				</tr>
			</logic:iterate>
						
						</table>
						
						
						<!-- Pagging -->
		 <%int firstResult=Integer.parseInt(request.getAttribute("firstResult").toString());
		   int maxResult=Integer.parseInt(request.getAttribute("maxResult").toString());
		   int totalNum=Integer.parseInt(request.getAttribute("totalNum").toString());
		   int totalPage=Integer.parseInt(request.getAttribute("totalPage").toString());
		   int currentPage=Integer.parseInt(request.getAttribute("currentPage").toString()); %>
		   <%int nextFirstResult=firstResult+maxResult;
		   int lastFirstResult=firstResult-maxResult;
		   int finalFirstResult=maxResult*(totalPage-1);%>
		  
		  
		  <!-- 长底条里面有左右两个div -->
		  <div class="pagging">
		   <%if(totalPage!=1)  {%>     
     <%if(currentPage==1){%>
         <div class="left">
     	    共<%=totalNum%>条    当前第<%=currentPage%>页/<%=totalPage %>页
     	   </div>
     	   
     	   <div class="right">
	   <a href="mrinfo.do?action=queryByPage&firstResult=<%=nextFirstResult%>">下一页</a><a href="mrinfo.do?action=queryByPage&firstResult=<%= finalFirstResult%>">末页</a>   
		  </div>
     <%}else if(currentPage==totalPage){%>
     <div class="left">		    共<%=totalNum%>条    当前第<%=currentPage%>页/<%=totalPage %>页 
    </div>
      <div class="right">
	    <a href="mrinfo.do?action=queryByPage&firstResult=0">首页</a> <a href="mrinfo.do?action=queryByPage&firstResult=<%=lastFirstResult%>">上一页 </a>       
		 </div>
		<%}else{ %>
		  <div class="left">
                共<%=totalNum%>条    当前第<%=currentPage%>页/<%=totalPage %>页 
                 </div>
                <div class="right"> 
	    <a href="mrinfo.do?action=queryByPage&firstResult=0">首页</a> <a href="mrinfo.do?action=queryByPage&firstResult=<%=lastFirstResult%>">上一页 </a> <a href="mrinfo.do?action=queryByPage&firstResult=<%=nextFirstResult%>">下一页</a>   <a href="mrinfo.do?action=queryByPage&firstResult=<%= finalFirstResult%>">末页</a>    
	    </div>
		<%} %>
		<%}else{ %><div class="left">	
		   共<%=totalNum%>条    当前第<%=currentPage%>页/<%=totalPage %>页 </div>	
		  
		<%} %>
						
						</div>
						<!-- End Pagging -->
						
					</div>
					<!-- Table -->
					
				</div>
				<!-- End Box -->
				

			</div>
			<!-- End Content -->
			
			<!-- Sidebar -->
			<div id="sidebar">
				
				<!-- Box -->
				<div class="box">
					
					<!-- Box Head -->
					<div class="box-head">
						<h2>管理</h2>
					</div>
					<!-- End Box Head-->
					
					
					
					<!-- Manage Head -->
					<div class="box-content">
						<a onclick="showdiv()" class="add-button"><span>更改个人信息</span></a>
						<div class="cl">&nbsp;</div>
						
						
						
						<!-- 增加会议室信息 -->
						<div class="sort">
							
						</div>
						</div>
				</div>
				<!-- End Box -->
			</div>
			<!-- End Sidebar -->
			
			<div class="cl">&nbsp;</div>			
		</div>
		<!-- Main -->
	</div>
</div>
<!-- End Container -->

<!-- Footer -->
<div id="footer">
	<div class="shell">
		<span class="left">&copy; 2014 - 毕业设计</span>
		<span class="right">
		网络101 - 李昀隆 
		</span>
	</div>
</div>
<!-- End Footer -->

</body>
</html>