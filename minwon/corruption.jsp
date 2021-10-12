<%@ page language="java" import="java.lang.*, java.util.*, java.sql.*, util.*" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<%
	//가상식별에 필요한 유니크한 값생성
	String member01 = DateTime.getCurrentDateTime();
	//out.println("member01 : " + member01 + "<br/>");
%>
<%
	String pageNum = "5";
	String incPage = request.getParameter("incPage");
	//out.println(incPage);
	String myPage = request.getRequestURI();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>행동강령 신고·상담센터 &gt; 신고센터 &gt; 고객지원 &gt; 수협</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
	
<script language="javascript">
<!--
	window.name ="join_window";
	var CBA_window;

	function openCBAWindow() {
		/* document.reqCBAForm.action = "/minwon/corruption_write.jsp"; */
		
		document.reqCBAForm.retUrl.value = "/minwon/corruption_write.jsp";

		 var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops);

		document.reqCBAForm.action='/member/namecheck.jsp';
		document.reqCBAForm.target='CbaWindow';
		document.reqCBAForm.submit();
	}
	function openCBAWindow1() {
		document.reqCBAForm.retUrl.value = "/minwon/corruption_psword.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops)

		document.reqCBAForm.action='/member/namecheck.jsp';
		document.reqCBAForm.target='CbaWindow';
		document.reqCBAForm.submit();
	}
//-->
</script>
</head>

<body id="shingo02">
	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->
<form name="reqCBAForm" method="post" action="">
	<input type="hidden" name="retUrl" value="" />
</form>
<form name="vnoform" method="post">
	<input type="hidden" name="enc_data">
	<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다. 해당 파라미터는 추가하실 수 없습니다. -->
    <input type="hidden" name="param_r1" value="" />
    <input type="hidden" name="param_r2" value="" />
    <input type="hidden" name="param_r3" value="" />
</form>

	<!-- container -->
	<div id="ContentLayer">
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->
		<!-- contents -->
		<div id="primaryContent">
			<p class="indicate"><span class="shHome">수협</span><span>고객지원</span><span>신고센터</span>행동강령 신고·상담센터</p>
			<h3>행동강령 신고·상담센터</h3>
			<div class="pdl20 pdr20">
				<p class="notify_alert mgb35">
					저희 수협은 각종 부패행위를 근절하고 수협중앙회 임직원행동강령을 철저히 준수하여<br />
					청렴한 조직문화를 정립하고자 고객 및 내부직원에게 부패행위 혹은 수협중앙회 임직원<br />
					행동강령 위반사실에 대하여 정보를 수집하고 있습니다.
				</p>
				<h5 class="title_arrow_green01 mgb15">신고 · 상담사항</h5>
				<ul class="list_dot_sky mgl25 mgb35">
					<li>신고자·상담자 : 제한 없음</li>
					<li>신고대상 : 수협임직원</li>
				</ul>
				<h5 class="title_arrow_green01 mgb15">행동강령 위반행위</h5>
				<ul class="list_dot_sky mgl25 mgb35">
					<li>공정한 직무수행을 해치는 지시</li>
					<li>청렴한 계약의 체결 및 이행을 방해하는 행위</li>
					<li>인사 등의 알선·청탁 행위</li>
					<li>직무관련 정보를 이용한 거래행위</li>
					<li>직위 및 공용재산·예산 등의 사적사용·수익 행위</li>
					<li>금품·상품권·선물·향응 등의 요구 및 수수행위(배우자 포함)</li>
					<li>대가가 있는 외부강의·회의 등의 미신고행위</li>
					<li>규정에 위반되는 경조사 통지 및 경조금품 수수행위</li>
					<li>성희롱 및 사행성 행위 등</li>
				</ul>
				<p class="boxGray mgb40 mgl25">
					이 곳의 내용은 본회 준법감시실에서만 열람할 수 있으므로 신고 및 상담내용은 절대 비밀이 보장됩니다.<br />
					신고·상담은 실명을 원칙으로 하므로 각 등록사항을 정확히 입력하여 주시기 바라며,<br />
					익명·허위 주소인 경우에는 내용에 상관없이 삭제됨을 알려드립니다.
				</p>
				<h5 class="title_arrow_green01 mgb15">연락처</h5>
				<ul class="list_dot_sky mgl25 mgb35">
					<li>우편주소 : 서울시 송파구 오금로 62 수협중앙회 준법감시실(우 05510)</li>
					<li>전 화 (☏): 수협중앙회 02) 2240-2483</li>
					<li>FAX : 02) 2240-2569</li>
				</ul>
				<div class="btnL mgt30 mgl25 mgb40">
					<a href="javascript:openCBAWindow();" class="btn_blue_arrowB01 w150" title="새창열림"><span>글올리기 </span></a>
					<a href="javascript:openCBAWindow1();" class="btn_green_arrowB01 w150" title="새창열림"><span>신고내용조회</span></a>
					<a href="new_commodity.jsp" class="btn_gray_arrowB01 w200"><span>신고물품 처리결과 공개</span></a>
				</div>
			</div>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/include/shFooter.jsp" %>
	<!-- //footer -->
</body>
</html>