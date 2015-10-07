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
<script type="text/javascript" src="js/html.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script language="javascript">

$(function(){ 
$("#updateMyInfo").click(function(){
var uname=$("#username").val();
        $.ajax({//其实也可以直接根据姓名查找的，但是这个就要求不能有重复的姓名，所以要进行添加时候的验证。
				  type: "POST",
				  url:"userinfo.do?action=findByUserName&username="+uname,
			      async:false,	  
				  dataType: "json",
				  success : function(data){
				
					 var userid=data.userId;
					 		$.ajax({
				 		   type: "POST",
				  		  url:"userinfo.do?action=edit&id="+userid,
			              async:false,	  
				        dataType: "json",
				         success : function(data){
					  if(data!=null){
					       showdivS();
					       $("#userId").val(data.userId);
					     $("#userNameU").val(data.userName);
					     $("#passwordU").val(data.password);
					     $("#mobileU").val(data.mobile);
					     $("#emailU").val(data.email);
					     
				      }
			      }
			     });
			      }
			     });
			     });
	});
	//页面加载时div的隐藏函数
	function dispdiv(){		
		var divS=document.getElementById("divupdateInfo");
		divS.style.display='none';
	}
	//查询div的显示函数
	
	function showdivS(){		
		var divS=document.getElementById("divupdateInfo");
		divS.style.display='inline';	
	}	
	 function checkUpdateUser(){
			var f=document.formU;
			if(f.userName.value.length==0||f.userName.value.length>12){
				alert("请输入不大于12位字符的用户名！");
				document.getElementById("userNameU").select();
				return false;
			}		
			if(f.password.value.length==0||f.password.value.length>10){
				alert("请输入不大于10位的密码");
				document.getElementById("passwordU").select();
				return false;
			}			
			if(isNaN(f.mobile.value)||f.mobile.value.length!=11){
				alert("请正确输入11位手机号！");
				document.getElementById("mobileU").select();
				return false;
			}
			if(f.email.value.length==0||f.value.length>50){
				alert("请输入正确的邮箱");
				document.getElementById("emaiU").select();
				return false;
			}
					
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
			    欢迎 <a href="#"><strong id="usernameid"><%=username %></strong></a>
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
			    <li><a href="userinfo.do?action=queryByPage" class="active"><span>首页</span></a></li>
			    <li><a href="mrinfo.do?action=queryByPageUser"><span>开始预约</span></a></li>
			    <li><a href="myMinfo.do?action=queryByPageMyBook"><span>我的预约</span></a></li>
			    <li><a href="chartUser.jsp" ><span>查看统计图表</span></a></li>
			    
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
			<a href="#">首页</a>
			<span>&gt;</span>
			常用会议室快速预约入口
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
						<h2 class="left">点击图片--快速预约</h2>
						<div class="right">
							<label>搜索记录</label>
							<input type="text" class="field small-field" />
							<input type="submit" class="button" value="搜索" />
						</div>
					</div>
					<!-- End Box Head -->	

					<!-- Table -->
					<div class="table">
						
					<script type="text/javascript" language="javascript">printFlash('mainVisual.swf','750','350','mainVisual','xml=mainVisual.xml&currItem=1');</script>			
							
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
						<a id="updateMyInfo" class="add-button"><span>更改个人信息</span></a>
						<div class="cl">&nbsp;</div>						
				
						
						<!-- Sort -->
						<div class="sort">
						<!-- 6-15加的更改个人信息 -->
						<div id="divupdateInfo" class="box">
					<!-- Box Head -->
					<div class="box-head">
						<h2>修改个人信息</h2>
					</div>
					<!-- End Box Head -->
					
					<form name="formU" action="userinfo.do?action=updateMyInfo" method="post" onSubmit="return checkUpdateUser()">
						
						<!-- Form -->
						<div class="form">
								
										<input type="hidden" name="username" id="username" value="<%=username%>"/>
										<input type="hidden" name="userId" id="userId"/>
								
									
									<label>用户名 </label>
									<input type="text" class="field size1" name="userName" id="userNameU" />
								</p>
									
									<label>密码</label>
									<input type="text" class="field size1" name="password" id="passwordU"/>
							</p>
									<label>手机 </label>
									<input type="text" class="field size1" name="mobile" id="mobileU"/>
								</p>
									<label>邮箱</label>
									<input type="text" class="field size1" name="email" id="emailU"/>
								</p>
								
			
								
							
						</div>
						<!-- End Form -->
						
						<!-- Form Buttons -->
						<div class="buttons">
							<input type="reset" class="button" value="重置" />
							<input type="submit" class="button" value="提交" />
						</div>
						<!-- End Form Buttons -->
					</form>
				</div>
				<!-- End Box -->
						</div>
						<!-- End edit  -->
						<!-- End 6月15加的更改个人信息 -->
						
						
						
						
						
						
						
						
						
						
						</div>
						<!-- End Sort -->
						
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
		<span class="left">&copy; 2010 - 毕业设计</span>
		<span class="right">
			网络101-李昀隆</a>
		</span>
	</div>
</div>
<!-- End Footer -->
	
</body>
</html>