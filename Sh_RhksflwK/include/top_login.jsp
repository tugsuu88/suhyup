<%@ page contentType="text/html;charset=euc-kr"%>
<%
String sta_buseo="";
sta_buseo = sa_buseo;
if(sa_buseo.equals("all")){
sta_buseo = "���۰�����";
}

String systime  = "";

systime = DateTime.getCurrentDateTime();
systime = DateTime.getFormatDateTime(systime);

%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="euc-kr">
	<title>����</title>
	<meta http-equiv="Expires" content="0">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<LINK href="style.css" type="text/css" rel="stylesheet">
	<LINK href="style_new.css" type="text/css" rel="stylesheet">
	<script language="javascript" src="common.js"></script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<table cellspacing="0" cellpadding="0" width="970" border="0">
	<tr>
		<td align="middle" width="255" height="71" style="padding-left:25;"><img src="img/suhyup_logo.gif" border="0" width="230" height="41"></td>
		<td valign="center" align="right" width="645" height="71"><b><%=sta_buseo%> <%=sa_name%> <%=sa_gicwe%>��</b> �ݰ����ϴ�.(sign in : <%=systime%>)
		</td>
		<td align="right" width="70" height="71">
			<a href="logout.jsp"><img src="img/btn_top_logout.gif" align="absMiddle" border="0" width="56" height="16"></a>
		</td>
	</tr>
</table>