<%@ page language="java" import="java.lang.*, java.util.*, java.sql.*, util.*, Bean.Front.Common.*, java.net.*, java.io.*  " %>


<%@ page contentType="text/html; charset=euc-kr" %>





<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>


<%@ include file="../inc/requestSecurity.jsp" %>





<%


	//가상식별에 필요한 유니크한 값생성


	String member01 = DateTime.getCurrentDateTime();


	//out.println("member01 : " + member01 + "<br/>");


%>


<% 


	String pageNum = "5";


	String incPage = request.getParameter("incPage");


	String myPage = request.getRequestURI();





%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">


<head>


<title>수협 - 바다사랑 고객사랑</title>


<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />


<link rel='stylesheet' type='text/css' media='all' href='../css/main.css' />


<script type="text/javascript" src="../js/quickMenu.js"></script>


<script type="text/javascript" src="../js/public.js"></script>


<script type="text/javascript">


<!--


	var CBA_window;


	function openCBAWindow() {


		document.reqCBAForm.retUrl.value = "http://www.suhyup.co.kr/minwon/minwon_apply_test.jsp";


		


		var wint = (screen.height - 450) / 2;


		var winl = (screen.width - 410) / 2;


		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';


		CBA_window = window.open('', "CbaWindow", winprops)


		


		//CBA_window = window.open('', 'CbaWindow', 'width=410, height=450, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=0, top=0');


		


		document.reqCBAForm.action='http://name.siren24.com/vname/jsp/vname_j10.jsp';


		document.reqCBAForm.target='CbaWindow';


		document.reqCBAForm.submit();


	}


//-->


</script>


</head>





<body id="minwon01">


<form name="reqCBAForm" method="post" action="">


	<input type="hidden" name="id" value="SHU001">


	<input type="hidden" name="srvNo" value="001027">


	<input type="hidden" name="reqNum" value="<%=member01%>">


	<input type="hidden" name="retUrl" value="http://www.suhyup.co.kr/minwon/minwon_apply_test.jsp">


</form>


<!-- start content table-->


<table cellpadding="0" cellspacing="0" border="0">


  <tr>


    <td id="content"><!-- 본문영역 시작 -->


        <table width="745" border="0" cellspacing="0" cellpadding="0">


          <tr>


            <td align="center"><img src="images/minwon01_bg.jpg" width="705" height="288" usemap="#MapMap" border="0" /></td>


          </tr>


        </table>


      <!-- 본문영역 끝-->


    </td>


  </tr>


</table>


<map name="MapMap" id="MapMap">


  <area shape="rect" coords="292,117,433,154" href="javascript:openCBAWindow();" />


</map>


<!-- end content table-->


