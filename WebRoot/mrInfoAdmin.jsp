<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic"%>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<title>会议室信息管理</title>
	<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
</head>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery.checkbox.js"></script>
<script language="javascript">
$(function(){ 
	    $("#edit").click(function(){//判断复选框的选择问题,通过复选框的选择得到离职编号，然后进行修改和删除操作
		
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
			mrid=$('[name=checkbox]:checkbox:checked').val();//得到离职编号，然后准备传给servlet通过编号去查询本条记录的信息，交给修改界面显示
		
			$.ajax({
				  type: "POST",
				  url:"mrinfo.do?action=edit&id="+mrid,
			      async:false,	  
				  dataType: "json",
				  success : function(data){
					  if(data!=null){
					       showdivU();
					       $("#meetingrommId").val(data.meetingroomId);
					     $("#mrname").val(data.meetingroomName);
						
					     $("#seatNumU").val(data.seatNum);
					     $("#locationU").val(data.location);
					     $("#projectorU").attr("select",true);
					     
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
			if(f.meetingroomName.value.length==0||f.meetingroomName.value.length>20){
				alert("请输入不大于20位字符的会议室名称！");
				document.getElementById("meetingroomName").select();
				return false;
			}		
			if(isNaN(f.seatNum.value)||f.seatNum.value.length>4||f.seatNum.value==0){
				alert("请输入座位数，不大于10000且不为0的整数！");
				document.getElementById("seatNum").select();
				return false;
			}			
			if(f.location.value.length==0||f.meetingroomName.value.length>30){
				alert("请输入不大于30位字符的会议室地址！");
				document.getElementById("deptCount").select();
				return false;
			}
					
  }
  
  	function checkAddUserU(){
			var f=document.formU;
			if(f.meetingroomName.value.length==0||f.meetingroomName.value.length>20){
				alert("请输入不大于20位字符的会议室名称！");
				document.getElementById("meetingroomName").select();
				return false;
			}		
			if(isNaN(f.seatNum.value)||f.seatNum.value.length>4||f.seatNum.value==0){
				alert("请输入座位数，不大于10000且不为0的整数！");
				document.getElementById("seatNum").select();
				return false;
			}			
			if(f.location.value.length==0||f.meetingroomName.value.length>30){
				alert("请输入不大于30位字符的会议室地址！");
				document.getElementById("deptCount").select();
				return false;
			}
					
  }
</script>
<body onload="dispdiv()">
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
			    <li><a href="userinfo.do?action=queryByPage"><span>用户信息管理</span></a></li>
			    <li><a href="mrInfoAdmin.jsp" class="active"><span>会议室信息管理</span></a></li>
			    <li><a href="chartAdmin.jsp"><span>查看统计图表</span></a></li>
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
						<table width="100%" border="0" cellspacing="0" cellpadding="0" name="userinfo">
							<tr>
								<th width="13"><input name="checkbox" id="checkbox" type="checkbox" class="checkbox" /></th>
								<th>编号</th>
								<th>会议室名称</th>
								<th>座位数</th>
								<th>地址</th>
								<th>有无投影</th>
								<th width="90" class="al">删除</th>
							</tr>
												
							
							<logic:iterate id="mrInfo" name="list">
				<tr id="checked">
				<td><input type="checkbox" class="checkbox" name="checkbox" value="${mrInfo.meetingroomId}"/></td>
				<td >
					<h3  ><font  color="#ba4c32">${mrInfo.meetingroomId }</font></h3></a>
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
					<td><a href="mrinfo.do?action=delete&id=${mrInfo.meetingroomId}" class="ico del">删除</a></td>			  
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
						<a onclick="showdiv()" class="add-button"><span>增加会议室信息</span></a>
						<div class="cl">&nbsp;</div>
						
						<a id="edit" class="add-button"><span>更改会议室信息</span></a>
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
						<h2>添加新的会议室</h2>
					</div>
					<!-- End Box Head -->
					
					<form name="form" action="mrinfo.do?action=add" method="post" onSubmit="return checkAddUser()">
						
						<!-- Form -->
						<div class="form">
							
									
									<label>会议室名称 <span>(必填)</span></label>
									<input type="text" class="field size1" name="meetingroomName" id="meetingroomName" />
								
									
									<label>座位数<span>(必填)</span></label>
									<input type="text" class="field size1" name="seatNum" id="seatNum"/>
								
						
									
									<label>地址 <span>(必填)</span></label>
									<input type="text" class="field size1" name="location" id="location" />
								
									<label>有无投影 <span>(必填)</span></label>
									<select class="field size1" name="projector">
									<option value="1">有</option>
									<option value="0">无</option>
									</select>
								
							
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
						<h2>修改会议室</h2>
					</div>
					<!-- End Box Head -->
					
					<form  name="formU" action="mrinfo.do?action=update" method="post" onSubmit="return checkUpdateUser()">
						
						<!-- Form -->
						<div class="form">
								
											
									<input type="hidden" name="meetingroomId" id="meetingrommId"/>
								
									
									<label>会议室名称 </label>
									<input type="text" class="field size1" name="meetingroomName" id="mrname" />
								</p>
									
									<label>座位数</label>
									<input type="text" class="field size1" name="seatNum" id="seatNumU"/>
							</p>
									<label>地址 </label>
									<input type="text" class="field size1" name="location" id="locationU"/>
								</p>
									<label>有无投影 <label>
									<select class="field size1" name="projector" id="projectorU">
									<option value="1">有</option>
									<option value="0">无</option>
									</select>
								
							
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