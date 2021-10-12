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

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript" src="../js/public.js"></script>

<script type="text/javascript">

<!--

	var CBA_window;



	function openCBAWindow() {

		document.reqCBAForm.retUrl.value = "http://www.suhyup.co.kr/minwon/corruption_write_my.jsp";

		

		var wint = (screen.height - 450) / 2;

		var winl = (screen.width - 410) / 2;

		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';

		CBA_window = window.open('', "CbaWindow", winprops)

		

		//CBA_window = window.open('', 'CbaWindow', 'width=410, height=450, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=0, top=0');

		

		document.reqCBAForm.action='http://name.siren24.com/vname/jsp/vname_j10.jsp';

		document.reqCBAForm.target='CbaWindow';

		document.reqCBAForm.submit();

	}

	function openCBAWindow1() {

		document.reqCBAForm.retUrl.value = "http://www.suhyup.co.kr/minwon/corruption_psword_my.jsp";

		

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



<body id="shingo02">

<%@ include file="/include/shHeader.jsp" %>

<!-- start content table-->

<form name="reqCBAForm" method="post" action="">

	<input type="hidden" name="id" value="SHU001">

	<input type="hidden" name="srvNo" value="001042">

	<input type="hidden" name="reqNum" value="<%=member01%>">

	<input type="hidden" name="retUrl" value="" />

</form>

<table id="contentTable" cellpadding="0" cellspacing="0">

<tr>

	<td id="sideContent" valign="top">

      <table cellpadding="0" cellspacing="0">

        <tr> 

          <td><img src="../member/images/sc_title_bn_mypage.gif" width="180" height="60" /></td>

        </tr>

        <tr> 

          <td height="10"></td>

        </tr>

        <tr> 

          <td><a href="../member/modify.jsp"><img src="../member/images/sc_bt_off_09.gif" width="190" height="21" border="0" /></a></td>

        </tr>

        <tr> 

          <td><a href="../member/change_pw.jsp"><img src="../member/images/sc_bt_off_10.gif" width="190" height="21" border="0" /></a></td>

        </tr> <tr> 

          <td><a href="../member/delete_main.jsp"><img src="../member/images/sc_bt_off_12.gif" width="190" height="21" border="0" /></a></td>

        </tr>

        <tr> 

          <td height="3"></td>

        </tr>

        <tr> 

          <td><a href="../member/join_list.jsp"><img src="../member/images/sc_bt_off_11.gif" width="190" height="21" border="0" /></a></td>

        </tr>

       

	<tr>

		<td><a href="../minwon/minwon_apply03_my.jsp"><img src="../member/images/sc_bt_on_13.gif" width="190" height="21" /></a></td>

	</tr>

	<tr>

		<td height="3"></td>

	</tr>

	<tr>

		<td><a href="../minwon/minwon_apply03_my.jsp"><img src="../member/images/sc_bt_off_13_01.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td><a href="../minwon/shingo_001_my.jsp"><img src="../member/images/sc_bt_off_13_02.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td><a href="../minwon/corruption_my.jsp"><img src="../member/images/sc_bt_on_13_03.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td height="3"></td>

	</tr>

   

        

        <tr> 

          <td height="15"></td>

        </tr>

      </table>

	</td>

	<td id="primaryContent" valign="top">

	<table cellpadding="0" cellspacing="0">

	<tr>

		<td><IMG SRC="../images/pc_bg_topline.gif" WIDTH="795" HEIGHT="5" BORDER="0" alt="" /></td>

	</tr>

	<tr>

		<td style="background:url(../images/pc_middle_line.gif); padding-left:30px;" valign="top">

		<table cellpadding="0" cellspacing="0" border="0">

		<tr>

                <td id="navigator"><a href="/">Home</a> &gt; 마이페이지 > <a href="../minwon/corruption_my.jsp">나의민원/신고</a> 

			> 행동강령 신고·상담센터</td>

		</tr>

		<tr>

			<td id="title"><img src="images/pcTitle050401.gif" width="200" height="31" /></td>

		</tr>

		<tr>

			<td id="content">

			<!-- include start -->

			<table cellpadding="0" cellspacing="0" border="0" width="745" id="text_content">

			<tr>

				<td  id="bullet02" width="23"></td>

				<td id="titleImg01" width="722"><img src="images/pcST050401_01.gif" vspace="6" /></td>

			</tr>

			<tr>

				<td colspan="2" style="padding-top:12px;"><img src="images/pcST050401_02.gif" width="745" height="120" alt="" /></td>

			</tr>

			<tr>

				<td></td>

                <td id="titleImg02"><img src="images/pcST050401_03.gif" /></td>

			</tr>

			<tr>

				<td></td>

				<td id="titleImg03"><p>신고자·상담자 : 제한 없음</p>

				  <p>신고대상 : 수협임직원</p>            </td>

			</tr>

			<tr>

				<td></td>

                <td id="titleImg02"><img src="images/pcST050401_04.gif" /></td>

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

			<tr>

				<td></td>

                <td id="titleImg02"><img src="images/pcST050401_05.gif" /></td>

			</tr>

			<tr>

				<td></td>

				<td id="titleImg03"><p>우편번호 : 서울시 송파구 신천동 11-6 수협중앙회 감사실(우 138-730)</p>

				  <p>전화번호 : 02)2240-3383, 3392</p>

				<p>팩스번호 : 02)22240-3076 </p></td>

			</tr>

			<tr>

				      <td colspan="2" align="center" style="padding:25px 0 15px 0;">

					    <!-- <img src="images/pcST050301_08.gif" alt=""/><br />

                      <a href="javascript:openCBAWindow();"><img src="images/pcST050201_14.gif" alt="글올리기" vspace="10" border="0" /></a> -->

                        <a href="javascript:openCBAWindow1();"> <img src="images/pcST050201_15.gif" alt="신고내용조회" vspace="10" border="0" /></a> 

                      </td>

			</tr>

			</table>

			<!-- include end -->

			</td>

		</tr>

		</table>

		</td>

	</tr>

	<tr>

		<td><IMG SRC="../images/pc_bg_bottomline.gif" WIDTH="795" HEIGHT="4" BORDER="0" alt="" /></td>

	</tr>

	<tr>

		<td height="20"></td>

	</tr>

	</table>

	</td>

</tr>

</table>

<!-- end content table-->

<%@ include file="/include/shFooter.jsp" %>

</body>

</html>