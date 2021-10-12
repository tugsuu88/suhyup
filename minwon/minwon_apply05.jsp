<%@ page language="java"
	import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	response.setContentType("text/html; charset=euc-kr");
%>

<%
	String sName = (String) session.getAttribute("sName");
	if(sName == null || "".equals(sName)) {
%>
<script type="text/javascript">
	alert("잘못된 요청입니다.");	
	window.location.href = '/minwon/minwon_apply01.jsp';
</script>
<% 
		return;
	}
%>


<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1" />
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />

<%@ include file="../inc/requestSecurity.jsp"%>

<%
	String vDiscrNo = Converter.nullchk(request.getParameter("vDiscrNo"));

	String name = Converter.nullchk(request.getParameter("name"));

	if (name == null)
		name = "";

	String sh_post_1 = Converter.nullchk(request.getParameter("sh_post_1"));

	if (sh_post_1 == null)
		sh_post_1 = "";

	String sh_address_1 = Converter.nullchk(request.getParameter("sh_address_1"));

	if (sh_address_1 == null)
		sh_address_1 = "";

	String sh_address_2 = Converter.nullchk(request.getParameter("sh_address_2"));

	if (sh_address_2 == null)
		sh_address_2 = "";

	String sh_tel_1 = Converter.nullchk(request.getParameter("sh_tel_1"));

	if (sh_tel_1 == null)
		sh_tel_1 = "";

	String sh_tel_2 = Converter.nullchk(request.getParameter("sh_tel_2"));

	if (sh_tel_2 == null)
		sh_tel_2 = "";

	String sh_tel_3 = Converter.nullchk(request.getParameter("sh_tel_3"));

	if (sh_tel_3 == null)
		sh_tel_3 = "";

	String sh_han_1 = Converter.nullchk(request.getParameter("sh_han_1"));

	if (sh_han_1 == null)
		sh_han_1 = "";

	String sh_han_2 = Converter.nullchk(request.getParameter("sh_han_2"));

	if (sh_han_2 == null)
		sh_han_2 = "";

	String sh_han_3 = Converter.nullchk(request.getParameter("sh_han_3"));

	if (sh_han_3 == null)
		sh_han_3 = "";

	String sh_email_1 = Converter.nullchk(request.getParameter("sh_email_1"));

	if (sh_email_1 == null)
		sh_email_1 = "";

	String sh_email_2 = Converter.nullchk(request.getParameter("sh_email_2"));

	if (sh_email_2 == null)
		sh_email_2 = "";

	String sh_cata = Converter.nullchk(request.getParameter("sh_cata"));

	if (sh_cata == null)
		sh_cata = "";

	String sh_reply_type = Converter.nullchk(request.getParameter("sh_reply_type")); //회신방식

	if (sh_reply_type == null)
		sh_reply_type = "";

	String psword = Converter.nullchk(request.getParameter("psword"));

	if (psword == null)
		psword = "";

	//2014-08-19 생년월일 , 법인 , 대상영업점 추가 
	String Year = Converter.nullchk(request.getParameter("Year"));

	if (Year == null)
		Year = "";

	String Month = Converter.nullchk(request.getParameter("Month"));

	if (Month == null)
		Month = "";

	String Day = Converter.nullchk(request.getParameter("Day"));

	if (Day == null)
		Day = "";

	String sh_center = Converter.nullchk(request.getParameter("sh_center"));

	if (sh_center == null)
		sh_center = "";

	String self_text = Converter.nullchk(request.getParameter("self_text"));

	if (self_text == null)
		self_text = "";
	
	
	String message = "";
	if("".equals(name)) {
		message = "성명을 입력해 주십시오";
	}
	else if("".equals(sh_post_1)) {
		message = "주소가 입력되지 않았습니다.";
	}
	else if("".equals(sh_address_1) || "".equals(sh_address_2)) {
		message = "주소가 입력되지 않았습니다.";
	}
	else if("".equals(sh_tel_1) || "".equals(sh_tel_2) || "".equals(sh_tel_3)) {
		message = "전화번호가 입력되지 않았습니다.";
	}
	else if("".equals(sh_han_1) || "".equals(sh_han_2) || "".equals(sh_han_3)) {
		message = "핸드폰번호가 입력되지 않았습니다.";
	}
	else if("".equals(sh_email_1) || "".equals(sh_email_2)) {
		message = "메일을 입력해 주세요.";
	}
	else if("".equals(sh_reply_type)) {
		message = "회신방식을 선택해 주십시오.";
	}
	else if("".equals(psword)) {
		message = "패스워드를 입력해 주십시오.";
	}
	else if("".equals(Year)) {
		message = "년을 선택해 주십시오.";
	}
	else if("".equals(Month)) {
		message = "월을 선택해 주십시오.";
	}
	else if("".equals(Day)) {
		message = "일을 선택해주십시오.";
	}
	else if("".equals(sh_center)) {
		message = "민원대상을 선택해 주십시오.";
	}
	else if("".equals(self_text) || "글자수 15자리까지".equals(self_text)) {
		message = "대상영업점을 입력해 주십시오.";
	}
	
	if(!"".equals(message)) {
%>
<script type="text/javascript">
	alert("<%=message%>");
	window.location.href = '/minwon/minwon_apply01.jsp';
</script>
<%	
		return;
	}

	String param_r1 = Converter.nullchk(request.getParameter("param_r1"));
	if (param_r1.equals("1")) {
		session.setAttribute("sessname",aes.aesEncode("suhyupApply1"));	

	} else {
		String RedirectURL = "/minwon/minwon_apply01.jsp";
		response.sendRedirect(RedirectURL);
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>민원 작성하기 &gt; 민원신청 &gt; 전자민원창구 &gt; 고객지원 &gt; 수협</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="/css/screen.css" />
<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
<!--/********************************************위너다임 작업 시작 2008.03.13****************************************************/-->
<!-- <SCRIPT SRC="http://www.suhyup.co.kr/djemals/js/ax_wdigm/default.js"></SCRIPT> -->
<!--/********************************************위너다임 작업 끝 2008.03.13******************************************************/-->
<script type="text/javascript" src="/js/public.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
</head>
<body id="minwon01">
	<!-- header -->
	<%@ include file="/include/shHeader.jsp"%>
	<!-- //header -->
	<!-- container -->
	<div id="ContentLayer">
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp"%>
		<!-- //LNB -->
		<form name="pbform" method="post" enctype="" action="">
			<input type="hidden" name="name" value="<%=name%>" />
			<input type="hidden" name="sh_post_1" value="<%=sh_post_1%>"> 
			<input type="hidden" name="sh_address_1" value="<%=sh_address_1%>">
			<input type="hidden" name="sh_address_2" value="<%=sh_address_2%>">
			<input type="hidden" name="sh_tel_1" value="<%=sh_tel_1%>"> 
			<input type="hidden" name="sh_tel_2" value="<%=sh_tel_2%>"> 
			<input type="hidden" name="sh_tel_3" value="<%=sh_tel_3%>"> 
			<input type="hidden" name="sh_han_1" value="<%=sh_han_1%>"> 
			<input type="hidden" name="sh_han_2" value="<%=sh_han_2%>"> 
			<input type="hidden" name="sh_han_3" value="<%=sh_han_3%>"> 
			<input type="hidden" name="sh_email_1" value="<%=sh_email_1%>"> 
			<input type="hidden" name="sh_email_2" value="<%=sh_email_2%>"> 
			<input type="hidden" name="sh_cata" value="<%=sh_cata%>"> 
			<input type="hidden" name="psword" value="<%=psword%>"> 
			<input type="hidden" name="vDiscrNo" value="<%=vDiscrNo%>"> 
			<input type="hidden" name="sh_reply_type" value="<%=sh_reply_type%>">
			<!--2014-8-19 생년월일,법인 , 대상영업 추가  -->
			<input type="hidden" name="Year" value="<%=Year%>"> 
			<input type="hidden" name="Month" value="<%=Month%>"> 
			<input type="hidden" name="Day" value="<%=Day%>"> 
			<input type="hidden" name="sh_center" value="<%=sh_center%>"> 
			<input type="hidden" name="self_text" value="<%=self_text%>">
			<input type="hidden" name="param_r1" id="param_r1" value="<%=param_r1%>">
		</form>
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/include/shFooter.jsp"%>
	<!-- //footer -->
</body>
<script type="text/javascript">
$(document).ready(function(){
	if($("#param_r1").val()=='1') {
		pbform.action = "minwon_apply02.jsp";
		pbform.submit();
	}
});
</script>

</html>