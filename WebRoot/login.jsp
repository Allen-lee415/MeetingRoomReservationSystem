<%@ page language="java" pageEncoding="utf-8"%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html:html lang="true">

<head>
	<html:base />

	<title>login</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>
<style type="text/css">
.login{
  position: absolute;
  left: 845px;
  top:290px;
}


</style>
<body background="login.jpg">
	<div class="login">
	<form action="userinfo.do?action=login" method="post">

		<table cellpadding="5px" >
      
			<tr>
				
				<td width="100px">
					<input type="text" name="userName" />
				</td>
			</tr>
			<tr>
			
				<td width="100px">
					<input type="password" name="password" />
				</td>
			</tr>
			<tr>
				
				<td width="100px">
					<select name="role">
						<option value="user">
							用户
						</option>
						<option value="admin">
							管理员
						</option>

					</select>
				</td>
			</tr>
		
			<tr>
				<td>
					<input type="submit" value="提交" />
					<input type="reset" value="重置" />
				</td>
			
			</tr>

		</table>

	</form>
	</div>
</body>
</html:html>
