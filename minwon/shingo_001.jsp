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

	String myPage = request.getRequestURI();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>금융사고/금융부조리 &gt; 신고센터 &gt; 고객지원 &gt; 수협</title><!-- 20150224 -->
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
<!--//-->
	window.name ="join_window";
	var CBA_window;

	function openCBAWindow() {
		document.reqCBAForm.retUrl.value = "/minwon/shingo_write.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops);

		document.reqCBAForm.action='/member/namecheck.jsp';
		document.reqCBAForm.target='CbaWindow';
		document.reqCBAForm.submit();
	}
	function openCBAWindow1() {
		document.reqCBAForm.retUrl.value = "/minwon/shingo_psword.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops)

		document.reqCBAForm.action='/member/namecheck.jsp';
		document.reqCBAForm.target='CbaWindow';
		document.reqCBAForm.submit();
	}
	function openCBAWindow2() {
		document.reqCBAForm.retUrl.value = "/minwon/absurd_write.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops); 

		document.reqCBAForm.action='/member/namecheck.jsp';
		document.reqCBAForm.target='CbaWindow';
		document.reqCBAForm.submit();
	}
	function openCBAWindow3() {
		document.reqCBAForm.retUrl.value = "/minwon/absurd_psword.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops);

		document.reqCBAForm.action='/member/namecheck.jsp';
		document.reqCBAForm.target='CbaWindow';
		document.reqCBAForm.submit();
	}

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
			<p class="indicate"><span class="shHome">수협</span><span>고객지원</span><span>신고센터</span>금융사고/금융부조리/부동산투기 관련 불법대출 신고</p>
			<h3>금융사고/금융부조리/부동산투기 관련 불법대출 신고</h3>
			<div class="pdl20 pdr20">
				<!-- <h4 class="dpNone">금융사고제보</h4>
				<p class="notify_alert mgb35">
					이 곳의 내용은 비공개로 운용되고 있으며, 수협의 각 사무소나 수협 임직원이 금융업무와 관련하여 위법·부당한 행위를 함으로써 수협 또는 고객께 손실을 초래하거나 금융질서를 문란하게 할 우려가 있는 행위에 대하여 정보를 수집받고 있습니다.
				</p> -->
				<h5 class="title_arrow_green01 mgb15">제보사항</h5>
				<ul class="list_dot_sky mgl25 mgb35">
				<li>제보자 : 제한없음</li>
				<li>제보대상 : 수협 사무소 및 수협 임직원.</li>
				<li>
					제보내용(예시) : 
					<ul style="margin-left:5px;"> 
						<li>- 금융사고 : 횡령, 배임, 공갈, 금품수수, 사금융알선, 저축관련부당행위, 금융실명제위반, 변칙대출 등 <br>금융관련 각종 부당행위</li>
						<li>- 금융부조리 유형 : </li>
						<li>
							<ul style="margin-left:20px;">
								<li>· 금품, 상품권, 선물 등의 요구 및 수수행위</li>
								<li>·  향응 등의 요구 및 수수 행위</li>
								<li>· 대출 및 인사 등의 청탁 행위</li>
								<li>· 중소기업대출 관련 꺽기나 커미션 요구 행위</li>
								<li>· 직무유기 및 근무기강해이 등</li>
						</ul>
						</li>
					</ul>
				</li>
				</ul>
				<h5 class="title_arrow_green01 mgb15">기타사항</h5>
				<ul class="list_dot_sky mgl25 mgb35">
				<li>금융사고 제보자에 대한 비밀은 보호되오니 사고제보는 실명으로 하시기 바랍니다.</li>
				<li>창구 불친절, 진정, 불만 등 사항은「전자민원창구」를 이용하여 주시기 바라며, 이런 경우는<br>「금융사고제보」로 볼 수 없어 제보사항 조치 및 회신을 해 드릴 수 없음을 알려드립니다</li>
				</ul>
				<h5 class="title_arrow_green01 mgb15">연락처</h5>
				<ul class="list_dot_sky mgl25 mgb35">
				<li>우편주소 : 서울시 송파구 오금로 62 수협은행 감사부, 수협중앙회 조합감사실(우 05510)</li>
				<li>전 화 (☏): 수협은행 감사부(02-2240-3321), 수협중앙회 조합감사실(02-2240-3424)</li> <!-- 20201211 감사부 민승준과장 요청 -->
				<li>FAX : 02) 2240-3076</li>
				</ul>
				<!-- <h4 class="dpNone">금융부조리 신고</h4>
				<p class="notify_alert pdt33 pdb33 mgb35">
					저희 수협은 금융관련 부조리를 근절하여 깨끗하고 엄정한 금융질서를 확립하고자<br />
					각종 금융관련 부조리 신고를 접수 · 처리하고 있습니다.
				</p> -->
				<div class="btnL mgt30 mgl25">
					<a href="javascript:openCBAWindow2();" title="새창열림" class="btn_blue_arrowB01 w150"><span>글올리기 </span></a>
					<a href="javascript:openCBAWindow3();" title="새창열림" class="btn_green_arrowB01 w150"><span>신고내용조회</span></a>
				</div>
				<p style="margin:10px;"><br></p>
				
				<h3>부동산 투기 관련 불법대출 신고 센터</h3>
				<h5 class="title_arrow_green01 mgb15">제보사항</h5>
				<ul class="list_dot_sky mgl25 mgb35">
				<li>제보자 : 수협 임직원</li>
				<li>제보대상 : 수협 임직원</li>
				<li>
					제보내용 : 부동산 투기 관련 불법 및 부당 대출 등
				</li>
				</ul>
					
				<div class="plus">
				<div class="boxGray mgb40 mgl25" style="border:1px solid #ccc;line-height:1.8;">
				<span style="font-weight:bold;font-size:20px;">◆  불법대출 자진신고 안내</span>
				<p style="margin:10px;">수협 임직원 중 부동산 투기 관련 불법, 부당한 대출을 <span style="font-weight:bold;">자진신고</span>하는 경우 해당 대출 관련 <br><span style="font-weight:bold;">행정제재를 감경</span>
				해주거나 <span style="font-weight:bold;">과태료가 최대 50%까지 감경</span>됩니다.</p>
				<ul class="list_dot_sky mgl25">
				<li>자진신고 기간 : 2021. 4. 6 ~ 4. 30</li>
				<li>자진신고 방법 : 금감원 콜센터 (☏1332) 또는 수협중앙회 홈페이지 '부동산투기 관련 불법대출 신고 센터'</li>
				</ul>
				<p style="margin:10px;">※ 자진신고기간 종료 이후 부동산 투기 관련 불법, 부당한 대출이 확인되는 경우에는<br>    형사처벌, 과태료 등 법령상 벌칙이 엄정히 적용됨.</p>
				</div>
				</div>
				
								
				<!-- <h5 class="title_arrow_green01 mgb15">신고사항</h5>
				<ul class="list_dot_sky mgl25 mgb35">
				<li>신고자 : 제한없음</li>
				<li>신고대상 : 수협 임직원</li>
				</ul>
				<h5 class="title_arrow_green01 mgb15">부조리 행위 유형</h5>
						
				
				<ul class="list_dot_sky mgl25 mgb10">
				<li>금품·상품권·선물 등의 요구 및 수수 행위</li>
				<li>향응 등의 요구 및 수수 행위</li>
				<li>대출 및 인사 등의 청탁 행위</li>
				<li>중소기업대출 관련 꺽기나 커미션 요구 행위</li>
				<li>직무유기 및 근무기강해이 등</li>
				</ul> -->
				<p class="boxGray mgb40 mgl25">
					여기에 신고되는 내용은 본회 감사실에서만 열람할 수 있으므로 신고자 및 신고내용에 대하여는 절대 비밀이 보장되며, 소정의 절차에 따라 처리한 후 회신을 보내드립니다. 
					신고 하실 때에는 실명을 원칙으로 하므로<br> 각 등록사항을 정확히 입력하여 주시기 바라며, 익명·허위 주소인 경우에는 내용에 상관없이 삭제됨을 알려드립니다.
				</p>
				
				<h5 class="title_arrow_green01 mgb15">연락처</h5>
				<ul class="list_dot_sky mgl25 mgb35">
				<li>전 화 (☏): 수협중앙회 조합감사실(02-2240-3459), 금융감독원 콜센터(☏1332)</li> <!-- 20201211 감사부 민승준과장 요청 -->
				</ul>
				
				<div class="btnL mgt30 mgl25">
					<a href="javascript:openCBAWindow2();" title="새창열림" class="btn_blue_arrowB01 w150"><span>글올리기 </span></a>
					<a href="javascript:openCBAWindow3();" title="새창열림" class="btn_green_arrowB01 w150"><span>신고내용조회</span></a>
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