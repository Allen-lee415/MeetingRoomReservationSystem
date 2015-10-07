<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			String username=(String)session.getAttribute("username");
%>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
		<title>欢迎使用会议室预约管理系统</title>
		<link rel="stylesheet" href="css/style.css" type="text/css"
			media="all" />
	</head>
	<script type="text/javascript" src="../js/jquery-1.4.2.min.js">
	<script type="text/javascript" src="js/jquery.checkbox.js">
</script>
	<script language="javascript">
//页面加载时div的隐藏函数
$(dispdiv(){		
		var divS=document.getElementById("divadd");
		divS.style.display='none';
	});
	//查询div的显示函数
	function showdivS(){		
		var divS=document.getElementById("divS");
		divS.style.display='inline';
		dispdivA();
		dispdivU();
	}			
	//查询div的隐藏函数
	function dispdivS(){		
		var divS=document.getElementById("divS");
		divS.style.display='none';
	}

</script>
	<body>
		<!-- Header -->
		<div id="header">
			<div class="shell">
				<!-- Logo + Top Nav -->
				<div id="top">
					<h1>
						<a href="#"><font face="黑体">会议室预约管理系统</font> </a>
					</h1>
					<div id="top-navigation">
						欢迎
						<a href="#"><stron><%=username %></stron></strong>
						</a>
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
						 <li><a href="firstPage.jsp"><span>首页</span></a></li>
			    <li><a href="mrinfo.do?action=queryByPageUser"  ><span>会议室预约</span></a></li>
			    <li><a href="myMinfo.do?action=queryByPageMyBook" class="active"><span>我的预约</span></a></li>
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
					<a href="#">我的预约</a>
					<span>&gt;</span> 我的预约使用记录
				</div>
				<!-- End Small Nav -->

				<br />
				<!-- Main -->
				<div id="main">
					<div class="cl">
						&nbsp;
					</div>

					<!-- Content -->
					<div id="content">

						<!-- Box -->
						<div class="box">
							<!-- Box Head -->
							<div class="box-head">
								<h2 class="left">
									我的预约使用记录
								</h2>
								<div class="right">
									<label>
										搜索记录
									</label>
									<input type="text" class="field small-field" />
									<input type="submit" class="button" value="搜索" />
								</div>
							</div>
							<!-- End Box Head -->

							<!-- Table -->
							<div class="table">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									name="myMinfo">
									<tr>
										<th width="13">
											<input type="checkbox" class="checkbox" />
										</th>
										<th>
											编号
										</th>
										<th>
											用户编号
										</th>
										<th>
											会议室编号
										</th>
										<th>
											日期
										</th>
										<th>
											开始时间
										</th>
										<th>
											结束时间
										</th>
										<th>
											主题
										</th>
										<th width="110" class="al">
											删除
										</th>
									</tr>


									<logic:iterate id="meetInfo" name="list">
										<tr>
											<td>
												<input type="checkbox" class="checkbox" />
											</td>
											<td>
												<h3>
													<font color="#ba4c32">${meetInfo.meetingId }</font>
												</h3>
												</a>
											</td>
											<td>
												<h3>
													${meetInfo.userinfo.userId }
												</h3>
											</td>
											<td>
												<h3>
													<font color="#ba4c32">${meetInfo.meetingroominfo.meetingroomId
														}</font>
												</h3>
											</td>
											<td>
												<h3>
													${meetInfo.date }
												</h3>
											</td>
											<td>
												<h3>
													${meetInfo.startTime }
												</h3>
											</td>
											<td>
												<h3>
													${meetInfo.endTime }
												</h3>
											</td>
											<td>
												<h3>
													${meetInfo.topic }
												</h3>
											</td>
											<td>
												<a href="myMinfo.do?action=deleteMy&id=${meetInfo.meetingId}"
													class="ico del">Delete</a>
													
											</td>
										</tr>
									</logic:iterate>

								</table>

								<!-- Pagging -->
								<%
									int firstResult = Integer.parseInt(request.getAttribute(
											"firstResult").toString());
									int maxResult = Integer.parseInt(request.getAttribute("maxResult")
											.toString());
									int totalNum = Integer.parseInt(request.getAttribute("totalNum")
											.toString());
									int totalPage = Integer.parseInt(request.getAttribute("totalPage")
											.toString());
									int currentPage = Integer.parseInt(request.getAttribute(
											"currentPage").toString());
								%>
								<%
									int nextFirstResult = firstResult + maxResult;
									int lastFirstResult = firstResult - maxResult;
									int finalFirstResult = maxResult * (totalPage - 1);
								%>


								<!-- 长底条里面有左右两个div -->
								<div class="pagging">
								
							<div class="left">
										当前第1页/1页
									</div>

									

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
								<h2>
									管理
								</h2>
							</div>
							<!-- End Box Head-->



							<!-- Manage Head -->
							<div class="box-content">
								<a onclick="dispdiv()" class="add-button"><span>更改个人信息</span>
								</a>
								<div class="cl">
									&nbsp;
								</div>
									
						<a id="allchoose" class="add-button"><span>全选&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span></a>
						<div class="cl">&nbsp;</div>
						<a id="reverse" class="add-button"><span>反选&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span></a>
						<div class="cl">&nbsp;</div>

							

								<!-- Sort -->
								<div class="sort">
								
								</div>
								<!-- End Sort -->

							</div>
						</div>
						<!-- End Box -->
					</div>
					<!-- End Sidebar -->

					<div class="cl">
						&nbsp;
					</div>
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