<%@ page language="java" import="java.lang.*, java.util.*, java.sql.*, util.*" %>

<%@ page contentType="text/html; charset=euc-kr" %>

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

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />

<!--[if IE 7]><link rel="stylesheet" type="text/css" href="../css/footer.css"     /><![endif]-->

<!--[if IE 8]><link rel="stylesheet" type="text/css" href="../css/footer_IE8.css" /><![endif]-->

<!--

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript" src="../js/public.js"></script>

-->

<script language="javascript">

<!--

	window.name ="join_window";

	var CBA_window;



	function openCBAWindow() {

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

<%@ include file="/include/shHeader.jsp" %>

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



<!-- start content table--><div id="ContentLayer"><table width="920" border="0" align="center" cellpadding="0" cellspacing="0">

<tr><td>

<table cellpadding="0" cellspacing="0" id="contentTable">

<tr>



	<td valign="top" id="sideContent">

	<table cellpadding="0" cellspacing="0">

	<tr>

		<td width="180" height="125" valign="top"><img src="images/left_large_tit.gif" alt="전자민원부패신고" width="180" height="170" /></td>

	</tr>

	<tr>

		<td height="10"></td>

	</tr>

	<tr>

		<td><a href="minwon_03.jsp"><img src="images/sc_bt_off_01.gif" alt="전자민원창구" /></a></td>

	</tr>

	<tr>

		<td><a href="shingo_001.jsp"><img src="images/sc_bt_off_02.gif" alt="금융사고신고" border="0" /></a></td>

	</tr>
 

	<tr>

		  <td><a href="taxfree.jsp"><img src="images/sc_bt_off_03.gif" alt="면세유부정유통신고" border="0" /></a></td>

	</tr>

		  <tr>

		  <td><a href="corruption.jsp"><img src="images/sc_bt_on_04.gif" alt="행동강령신고/상담센터" border="0" /></a></td>

	</tr>
	<tr>
		  <td><a href="budget.jsp"><img src="images/sc_bt_off_05.gif" alt="예산낭비신고센터" border="0" /></a></td>
	</tr>

    <tr><td><a href="shingo_004.jsp"><img src="images/sc_bt_off_06.gif" alt="공익신고제도 안내" border="0" /></a></td></tr>
	</table>

	</td>

	<td width="797" valign="top" id="primaryContent">

	<table cellpadding="0" cellspacing="0">

	<tr>

		<td style="; padding-left:30px;" valign="top">

		<!-- 본문단 시작 -->

		<table cellpadding="0" cellspacing="0">

		<tr>

		  <td height="45" colspan="2">&nbsp;</td>

		  </tr>

		<tr>

			<td width="296" id="title"><img src="../images/pcTitle050401.gif"  alt="행동강령 신고/상담센터"/></td>

		    <td width="465" align="right" id="title"><a href="/">Home</a> > <a href="minwon_01.jsp">전자민원/부패&middot;공익신고</a> >행동강령 신고/상담센터</td>

		<tr>

			<td colspan="2" id="content">

<!-- contents  -->

			<table cellpadding="0" cellspacing="0" border="0" width="745" id="text_content">

			<tr>

				<td  id="bullet02" width="29"></td>

				<td id="titleImg01" width="716"><img src="images/pcST050401_01.gif" vspace="6" alt="행동강령 신고/상담" /></td>

			</tr>

			<tr>

				<td colspan="2" style="padding-top:12px;"><img src="images/pcST050401_02.gif" width="745" height="120" alt="저희 수협은 각종 부패행위를 근절하고 수협중앙회 임직원행동강령을 철저히 준수하고 있습니다." /></td>

			</tr>

			<tr>

				<td></td>

                <td id="titleImg02"><img src="images/pcST050401_03.gif" alt="신고/상담사항" /></td>

			</tr>

			<tr>

				<td></td>

				<td id="titleImg03"><p>신고자·상담자 : 제한 없음</p>

				  <p>신고대상 : 수협임직원</p>            </td>

			</tr>

			<tr>

				<td></td>

                <td id="titleImg02"><img src="images/pcST050401_04.gif" alt="행동강령 위반행위" /></td>

			</tr>

			<tr>

				<td></td>

				<td id="titleImg03"><p>공정한 직무수행을 해치는 지시</p>

				<p>청렴한 계약의 체결 및 이행을 방해하는 행</p>

				<p>인사 등의 알선·청탁 행위</p>

				<p>직무관련 정보를 이용한 거래행위</p>

				<p>직위 및 공용재산·예산 등의 사적사용·수익 행위</p>

				<p>금품·상품권·선물·향응 등의 요구 및 수수행위(배우자 포함)</p>

				<p>대가가 있는 외부강의·회의 등의 미신고행위</p>

				<p>규정에 위반되는 경조사 통지 및 경조금품 수수행위</p>

				<p>성희롱 및 사행성 행위 등</p>

				<br /></td>

			</tr>

			<tr>

			  <td></td>

			  <td style="padding:10px; background-color:#f2f2f2;">이 곳의 내용은 본회 감사실에서만 열람할 수 있으므로 신고 및 상담내용은 절대 비밀이 보장됩니다. 신고·상담은 실명을 원칙으로 하므로 각 등록사항을 정확히 입력하여 주시기 바라며, 익명·허위 주소인 경우에는 내용에 상관없이 삭제됨을 알려드립니다.</td>



			  </tr>

			<tr>

				<td></td>

                <td id="titleImg02"><img src="images/pcST050401_05.gif" alt="연락처" /></td>

			</tr>

			<tr>

				<td></td>

				<td id="titleImg03"><p>우편번호 : 서울시 송파구 오금로 62 수협중앙회 감사실(우 138-730)</p>

				  <p>전화번호 : 02)2240-3383</p>

				<p>팩스번호 : 02)2240-3076 </p></td>

			</tr>

			<tr>

				      <td colspan="2" align="center" style="padding:25px 0 15px 0;">

                        <a href="javascript:openCBAWindow();"><img src="images/pcST050201_14.gif" alt="글올리기" vspace="10" border="0" /></a>

                        <a href="javascript:openCBAWindow1();"> <img src="images/pcST050201_15.gif" alt="신고내용조회" vspace="10" border="0" /></a>                     
						<!-- 20141023 추가 -->						<a href="#"><img src="images/pcST050201_16.gif" alt="신고물품 처리결과 공개" border="0" /></a>						<!-- //20141023 추가 -->					 </td>
			</tr>

			</table>

<!-- contents  -->



			</td>

		</tr>

		</table>

		<!-- 본문단 끝 -->

		</td>

	</tr>

	</table>

	</td>

</tr>

</table>

    </td>

  </tr>

</table>

</div>

<!-- end content table-->

<%@ include file="/include/shFooter.jsp" %></body>

</html>