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
	<title>用户信息管理</title>
	<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
</head>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery.checkbox.js"></script>
<script language="javascript">
$(function(){ 
	    $("#edit").click(function(){
		
		  var str="你选中的是：\r\n";
		  var $tmp=$('[name=checkbox]:checkbox');
		  var recordN="";
		  if($tmp.filter(':checked').length==0){
			alert("对不起！尚未选择，请选择！");
		       }else if($tmp.filter(':checked').length>1){
			alert("对不起！选择多行！");
			$tmp.attr("checked",false);
		    }else{
			str+=$('[name=checkbox]:checkbox:checked').val()+"\r\n";
	
			alert(str);
			userid=$('[name=checkbox]:checkbox:checked').val();
	
			$.ajax({
				  type: "POST",
				  url:"userinfo.do?action=edit&id="+userid,
			      async:false,	  
				  dataType: "json",
				  success : function(data){
					  if(data!=null){
					       
					       $("#userId").val(data.userId);
					     $("#userNameU").val(data.userName);
						
					     $("#passwordU").val(data.password);
					     $("#mobileU").val(data.mobile);
					     $("#emailU").val(data.email);
					     showdivU();
				      }
			      }
			     });
	      }
      });
	    
	
		
		
	$("#allchoose").bind("click",function(){
			$("#checked input[type=checkbox]").checkBox("all");
		});		
		//反选
		$("#reverse").bind("click",function(){
			$("#checked input[type=checkbox]").checkBox("toggle");
		});
	});
	//页面加载时div的隐藏函数
	function dispdiv(){	
		
		var divA=document.getElementById("divadd");
		var divU=document.getElementById("divupdate");
		divA.style.display='none';
		divU.style.display='none';
	}
		function showdiv(){	
		
		var divS=document.getElementById("divadd");
		divS.focus();
		divS.style.display='inline';
	}

function showdivU(){	
		var divS=document.getElementById("divupdate");
		divS.focus();
		divS.style.display='inline';
		
	
	}
	function checkAddUser(){
			var f=document.form;
			if(f.userName.value.length==0||f.userName.value.length>8){
				alert("请输入不大于8位字符的用户名！");
				document.getElementById("userName").select();
				return false;
			}		
			if(f.password.value.length==0||f.password.value.length>10){
				alert("请输入不大于10位的密码");
				document.getElementById("password").select();
				return false;
			}			
			if(isNaN(f.mobile.value)||f.mobile.value.length!=11){
				alert("请正确输入11位手机号！");
				document.getElementById("mobile").select();
				return false;
			}
			if(f.email.value.length==0||f.value.length>50){
				alert("请输入正确的邮箱");
				document.getElementById("email").select();
				return false;
			}
					
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
			    <li><a href="#" class="active"><span>用户信息管理</span></a></li>
			    <li><a href="mrinfo.do?action=queryByPage"><span>会议室信息管理</span></a></li>
			    <li><a href="chartAdmin.jsp" ><span>查看统计图表</span></a></li>
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
			<a href="#">用户信息管理</a>
			<span>&gt;</span>
			用户信息列表
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
						<h2 class="left">用户信息列表</h2>
						<div class="right">
							<label>搜索用户</label>
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
								<th>用户名</th>
								<th>密码</th>
								<th>手机</th>
								<th>邮箱</th>
								<th width="110" class="al">删除</th>
							</tr>
												
							
							<logic:iterate id="userInfo" name="list">
				<tr id="checked">
				<td><input type="checkbox" class="checkbox" name="checkbox" value="${userInfo.userId}"/></td>
				<td>
					<h3><font color="#ba4c32">${userInfo.userId }</font></h3></a>
					</td>
					<td>
						<h3>${userInfo.userName }</h3>
					</td>
					<td>
						<h3><font color="#ba4c32">${userInfo.password }</font></h3>
					</td>
					<td>
						<h3>${userInfo.mobile }</h3>
					</td>
					<td>
						<h3>${userInfo.email }</h3>
					</td>
					<td><a href="userinfo.do?action=delete&id=${userInfo.userId}" class="ico del">删除</a></td>			  
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
	   <a href="userinfo.do?action=queryByPage&firstResult=<%=nextFirstResult%>">下一页</a><a href="userinfo.do?action=queryByPage&firstResult=<%= finalFirstResult%>">末页</a>   
		  </div>
     <%}else if(currentPage==totalPage){%>
     <div class="left">		    共<%=totalNum%>条    当前第<%=currentPage%>页/<%=totalPage %>页 
    </div>
      <div class="right">
	    <a href="userinfo.do?action=queryByPage&firstResult=0">首页</a> <a href="userinfo.do?action=queryByPage&firstResult=<%=lastFirstResult%>">上一页 </a>       
		 </div>
		<%}else{ %>
		  <div class="left">
                共<%=totalNum%>条    当前第<%=currentPage%>页/<%=totalPage %>页 
                 </div>
                <div class="right"> 
	    <a href="userinfo.do?action=queryByPage&firstResult=0">首页</a> <a href="userinfo.do?action=queryByPage&firstResult=<%=lastFirstResult%>">上一页 </a> <a href="userinfo.do?action=queryByPage&firstResult=<%=nextFirstResult%>">下一页</a>   <a href="userinfo.do?action=queryByPage&firstResult=<%= finalFirstResult%>">末页</a>    
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
						<a onclick="showdiv()" class="add-button"><span>增加用户信息</span></a>
						<div class="cl">&nbsp;</div>
						
						<a id="edit" onclick="showdivU()" class="add-button"><span>更改用户信息</span></a>
						<div class="cl">&nbsp;</div>
				
						<a id="allchoose" class="add-button"><span>全选&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span></a>
						<div class="cl">&nbsp;</div>
						<a id="reverse" class="add-button"><span>反选&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span></a>
						<div class="cl">&nbsp;</div>
						
						<!-- add info div -->
						<div class="sort">
							
							
							
							
							
				<!-- Box -->
				<div id="divadd" class="box">
					<!-- Box Head -->
					<div class="box-head">
						<h2>添加新的用户</h2>
					</div>
					<!-- End Box Head -->
					
					<form name="form" action="userinfo.do?action=add" method="post" onSubmit="return checkAddUser()">
						
						<!-- Form -->
						<div class="form" >
							
									
									<label>用户名<span>(必填)</span></label>
									<input type="text" class="field size1" name="userName" id="userName" />
								
									
									<label>密码<span>(必填)</span></label>
									<input type="text" class="field size1" name="password" id="password"/>
								
						
									
									<label>手机<span>(必填)</span></label>
									<input type="text" class="field size1" name="mobile" id="mobile" />
								<label>邮箱<span>(必填)</span></label>
									<input type="text" class="field size1" name="email" id="email"/>
								
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
						<!-- End add info div -->
						
						
						
						
						
						<!-- start edit div  -->
				<div id="divupdate" class="box">
					<!-- Box Head -->
					<div class="box-head">
						<h2>修改用户信息</h2>
					</div>
					<!-- End Box Head -->
					
					<form name="formU" action="userinfo.do?action=update" method="post" onSubmit="return checkUpdateUser()">
						
						<!-- Form -->
						<div class="form">
								
											
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