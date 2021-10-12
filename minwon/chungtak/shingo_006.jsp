<%@ page language="java" import="java.lang.*, java.util.*, java.sql.*, util.*" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>공익신고제도안내 &gt; 신고센터 &gt; 고객지원 &gt; 수협</title><!-- 20150216 -->
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
<!--
	window.name ="join_window";
	var CBA_window;

	function openCBAWindow() {
		document.reqCBAForm.retUrl.value = "/minwon/chungtak/chungtak_write.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops);

		document.reqCBAForm.action='/member/namecheck.jsp';
		document.reqCBAForm.target='CbaWindow';
		document.reqCBAForm.submit();
	}
	function openCBAWindow1() {
		document.reqCBAForm.retUrl.value = "/minwon/chungtak/chungtak_psword.jsp";

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
<body>
	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->
<form name="reqCBAForm" method="post" action="">
	<input type="hidden" name="retUrl" value="" />
</form>
<form name="vnoform" method="post">
	<input type="hidden" name="enc_data" />
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
			
			<p class="indicate"><span class="shHome">수협</span><span>고객지원</span><span>신고센터</span>청탁금지법 위반 신고</p>
			<h3>청탁금지법 위반 신고</h3>
			<div class="pdl20 pdr20">
				<h4 class="title_arrow_green01 mgb15">신고대상</h4>
				<ul class="list_dot_sky mgl20 mgb10">
					<li>수협중앙회 임직원이 「부정청탁 및 금품등 수수의 금지에 관한 법률」에 따른 부정청탁을 받았거나 받은 사실을 알게 된 경우</li>
					<li>수협중앙회 임직원이 「부정청탁 및 금품등 수수의 금지에 관한 법률」에 따른 부정청탁을 받아 그 직무를 수행한 사실을 알게 된 경우</li>
					<li>수협중앙회 임직원이 「부정청탁 및 금품등 수수의 금지에 관한 법률」에 따른 수수 금지 금품등을 받았거나 받은 사실을 알게 된 경우</li>
					<li>수협중앙회 임직원이 「부정청탁 및 금품등 수수의 금지에 관한 법률」에 따른 외부강의등에 대한 초과사례금을 신고하지 않았거나 신고하지 않은 사실을 알게 된 경우 </li>
					<li>기타 수협중앙회 임직원이 「부정청탁 및 금품등 수수의 금지에 관한 법률」을 위반한 사실을 알게 된 경우</li>
				</ul>
				<div class="btnL mgt30 mgl20 mgb40">
					<a href="download_mw.jsp?file_name=shingo_006_poster_01.pdf"  target="_blank"  class="btn_gray_arrowB01 w180" title="청탁금지법 전문 확인 pdf 다운로드"><span>청탁금지법 전문 확인</span></a>
					<a href="download_mw.jsp?file_name=shingo_006_write01.pdf"  target="_blank"  class="btn_gray_arrowB01 w180" title="신고서(자진신고용) hwp 다운로드"><span>자진신고용 신고서</span></a>
					<a href="download_mw.jsp?file_name=shingo_006_write02.pdf"  target="_blank"  class="btn_gray_arrowB01 w180" title="신고서(제3자신고용) hwp 다운로드"><span>제3자용 신고서</span></a>
				</div>
				<h4 class="title_arrow_green01 mgb15">신고 접수 및 처리 절차</h4>
				<ul class="list_dot_sky mgl20 mgb35">
					<li>수협중앙회에 「부정청탁 및 금품등 수수의 금지에 관한 법률」 위반신고가 접수되면 사실 확인 절차를 거쳐 조사가 필요한 경우 감사원, 수사기관 또는 수협중앙회의 감독기관에 송부하고 그 조사결과를 통보받아 신고자에게 알려 드립니다.</li>
					<li>국민권익위원회는「부정청탁 및 금품등 수수의 금지에 관한 법률」 위반신고에 의하여 수협중앙회의 직접적인 수입 회복·증대 또는 비용의 절감 등을 가져온 경우, 신고자에게 신고에 대한 보상금 등을 지급합니다.</li>
					<li>국민권익위원회는 「부정청탁 및 금품등 수수의 금지에 관한 법률」위반신고로 인하여 수협중앙회에 재산상 이익을 가져오거나 손실을  방지한 경우 또는 공익의 증진을 가져온 경우 신고자에게 포상금을 지급할 수 있습니다.</li>
					<li>수협중앙회는 신고자가 안심하고 「부정청탁 및 금품등 수수의 금지에 관한 법률」위반행위 신고를 할 수 있도록 신고자, 협조자 등에 대한 신분보장·신변보호·비밀보장 제도를 운영하고 있습니다.</li>
				</ul>
				<h4 class="title_arrow_green01 mgb15">신고방법</h4>
				<ul class="list_dot_sky mgl20 mgb35">
					<li>누구든지 수협중앙회 임직원이 「부정청탁 및 금품등 수수의 금지에 관한 법률」을 위반한 사실을 알게 된 때는 수협중앙회에 신고할 수 있습니다.</li>
					<li>오프라인으로 직접방문·우편·팩스·전화 등으로 신고할 수 있습니다.</li>
					<li>상담전화 : 02-2240-2483</li>
					<li>우편신고 또는 직접방문 신고 : (05510) 서울특별시 송파구 오금로 62 수협중앙회 8층 준법감시실</li>
					<li>팩스신고 : 02-2240-2569 <br />※ 수협중앙회는 신고자가 현지출장을 요청할 경우 직접 방문하여 신고를 접수할 수 있습니다.</li>
				</ul>
				<div class="btnL mgt30 mgl20 mgb40">
					<a title="새창열림" class="btn_blue_arrowB01 w150" href="javascript:openCBAWindow();"><span>글올리기 </span></a>
					<a title="새창열림" class="btn_green_arrowB01 w150" href="javascript:openCBAWindow1();"><span>신고내용조회</span></a>
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