<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<title>会议室统计图表</title>
	<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
</head>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script language="javascript">
	//页面加载时div的隐藏函数
	function dispdiv(){		
		var divP=document.getElementById("piechart");
		var divB=document.getElementById("barchart");
		divP.style.display='none';
		divB.style.display='none';
	}
	//查询div的显示函数
	function showdivP(){	
	    dispdiv();	
		var divP=document.getElementById("piechart");
		divP.style.display='inline';
		
	}	
		//查询div的显示函数
	function showdivB(){	
	    dispdiv();	
		var divB=document.getElementById("barchart");
		divB.style.display='inline';
		
	}		



</script>
<body onload="dispdiv()">
<!-- Header -->
<div id="header">
	<div class="shell">
		<!-- Logo + Top Nav -->
		<div id="top">
			<h1><a href="#"><font face="黑体">会议室预约管理系统</font> </a></h1>
			<div id="top-navigation">
			    欢迎 <a href="#"><strong>管理员</strong></a>
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
			    <li><a href="userinfo.do?action=queryByPage" ><span>用户信息管理</span></a></li>
			    <li><a href="mrinfo.do?action=queryByPage"><span>会议室信息管理</span></a></li>
			    <li><a href="chartAdmin.jsp" class="active"><span>查看统计图表</span></a></li>
			    <li><a href="minfo.do?action=queryByPage"><span>查看记录报表</span></a></li>
			    
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
			<a href="#">欢迎查看统计图表</a>
			
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
						<h2 class="left">统计图表</h2>
					
					</div>
					<!-- End Box Head -->	

					<!-- Table -->
					<div class="table" id="piechart">
						
							<img  src="/myThirdSSH/pie"></img>				
						</div>
						<!-- end table -->
						
						<!-- Table -->
					<div class="table" id="barchart">
						
							<img  src="/myThirdSSH/bar"></img>				
						</div>
						<!-- end table -->
						
						
						</div>
						<!-- end box -->
					</div>
			   <!-- end content -->
			<!-- Sidebar -->
			<div id="sidebar">
				
				<!-- Box -->
				<div class="box">
					
					<!-- Box Head -->
					<div class="box-head">
						<h2>请选择查看内容</h2>
					</div>
					<!-- End Box Head-->
					
					
					
					<!-- Manage Head -->
					<div class="box-content">
						<a onclick="showdivP()" class="add-button"><span>被预约比例</span></a>
						<div class="cl">&nbsp;</div>
						<div class="cl">&nbsp;</div>
						<div class="cl">&nbsp;</div>
						<div class="cl">&nbsp;</div>
						
						<a onclick="showdivB()" class="add-button"><span>用户预约次数</span></a>
						<div class="cl">&nbsp;</div>
						
						
						
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