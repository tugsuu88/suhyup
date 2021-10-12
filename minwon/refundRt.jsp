<%@ page import="java.util.*, java.text.*, util.*" contentType="text/html;charset=euc-kr"%>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>
<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	//String pageNum 	= "6";
	//String ListPage = "data_01.jsp";
	//String sh_site 	= "1"; //싸이트 구분
	//String sh_class = "97"; //게시판 구분
	//String incPage 	= request.getParameter("incPage");
	//String myPage 	= request.getRequestURI();
	
	/* String current_date = new SimpleDateFormat("yyyy.MM.dd").format(new Timestamp(System.currentTimeMillis()));
	System.out.println("User - Time : " + new SimpleDateFormat("yyyy.MM.dd hh:MM:ss").format(new Timestamp(System.currentTimeMillis())));
	System.out.println("User - Remote Addr: " + request.getRemoteAddr());
	System.out.println("User - Remote Host: " + request.getRemoteHost());
	System.out.println("User - X-Forwarded-For: " + request.getHeader("x-forwarded-for"));
	String spath = request.getServletPath();  
	String url = request.getRequestURL().toString();  
	String strCurrentUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	System.out.println("User - spath : " + spath );
	System.out.println("User - url : " + url);
	System.out.println("User - strCurrentUrl : " +strCurrentUrl);  */
	
	String ip = request.getRemoteAddr();
	String ResultIP2 = FrontBoard.AddDatarefundRtminwon(ip);
	
	String name = request.getParameter("name");

	if(name == null) name="";

	name = name.replaceAll("'", "");
	name = name.replaceAll("&", "");
	name = name.replaceAll("\'", "");
	name = name.replaceAll("<", "");
	name = name.replaceAll(">", "");
	name = name.replaceAll("-", "");
	name = name.replaceAll("%", "");
	
	String cnm = request.getParameter("cnm");

	if(cnm == null) cnm="";

	cnm = cnm.replaceAll("'", "");
	cnm = cnm.replaceAll("&", "");
	cnm = cnm.replaceAll("\'", "");
	cnm = cnm.replaceAll("<", "");
	cnm = cnm.replaceAll(">", "");
	cnm = cnm.replaceAll("-", "");
	cnm = cnm.replaceAll("%", "");
	
	String ymd = request.getParameter("ymd");

	if(ymd == null) ymd="";

	ymd = ymd.replaceAll("'", "");
	ymd = ymd.replaceAll("&", "");
	ymd = ymd.replaceAll("\'", "");
	ymd = ymd.replaceAll("<", "");
	ymd = ymd.replaceAll(">", "");
	ymd = ymd.replaceAll("-", "");
	ymd = ymd.replaceAll("%", "");
	
	String TableName = " dual ";
	String SelectCondition = " ncas.FN_GET_HOMEPAGE_MASSAGE@LK_SUHYUP_NCAS('"+cnm+"', '"+ymd+"', '"+name+"') AS RTV ";
	String WhereCondition = null;
	String OrderCondition = null;
	
	Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 0, 0);
	
	String rtv = "";
	
	if( ResultVector.size() > 0){

		for (int i=0; i < ResultVector.size(); i++){

			Hashtable h = (Hashtable)ResultVector.elementAt(i);

			rtv = (String)h.get("RTV");
		}
	}
	

	
	String sResponseNumber = request.getParameter("code");   //고유키값	
	
	String TableName1 = " NICE_CHECK ";
    String WhereCondition1 = "where sName = '"+ name +"' and sBirthDate = '"+ ymd +"' and sResponseNumber='"+sResponseNumber+"'";
	
	//20180813 NICE_CHECK 실명인증 했는지 확인
    int TotalRecordCount = FrontBoard.TotalCount(TableName1, WhereCondition1);
	String count_check = "";
	if(TotalRecordCount > 0) {
	
		count_check = "find";
		
	} else {
		count_check = "notfind";
	}
%>
<%@ include file="../inc/requestSecurity.jsp" %>
<%@ include file="../inc/login_check.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>민원신청 &gt; 전자민원창구 &gt; 고객지원 &gt; 수협</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<link rel="stylesheet" type="text/css" href="/css/new/service.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var titleName = "출자·배당금 환급조회 > 고객지원 > 수협";
			document.title = titleName;
		});
		
		//돌아가기
		function fnReturn(){
			pbform.action = "refund.jsp";
			pbform.submit();
		}
	</script>
</head>
<body id="minwon01">
	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->

	<!-- container -->
	<div id="ContentLayer">
		
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->

		<form name="pbform" method="post" action="">

			<input type="hidden" name="vDiscrNo" value=""/>
			<!-- contents -->
			<div id="primaryContent">
				<p class="indicate"><span class="shHome">수협</span><span>고객지원</span><span>출자·배당금 환급조회</span>조회결과</p>
				<h3>출자·배당금 환급조회</h3>
				<div class="pdl20 pdr30">
					<div class="box_result mgl15">
					<% if("find".equals(count_check)) { %>
						<% if( rtv != null){ %>
							<h4><span><%=name%></span> 님의 출자·배당금 환급조회 결과입니다.</h4>
							<p><%=rtv%></p>
						<% } else { %>
							<h4>죄송합니다.  출자·배당금 환급 대상이 아닙니다.</h4>
						<% } %>
					<% } else { %>
						<h4>실명인증을 해주시기바랍니다.</h4>
					<% } %>
					</div>
					<div class="btnR mgt30">
						<a href="javascript:fnReturn();" class="btn_gray_arrowB01 w150"><span>돌아가기</span></a>
					</div>
				</div>
			</div>
			<!-- //contents -->
		
		</form>
		
	</div>
	<!-- //container -->

	<!-- footer -->
	<%@ include file="/include/shFooter.jsp" %>
	<!-- //footer -->

</body>

</html>