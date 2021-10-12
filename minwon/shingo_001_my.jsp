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

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript" src="../js/public.js"></script>

<script type="text/javascript">

<!--

	var CBA_window;



	function openCBAWindow() {

		document.reqCBAForm.retUrl.value = "http://www.suhyup.co.kr/minwon/shingo_write_my.jsp";

		

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

		document.reqCBAForm.retUrl.value = "http://www.suhyup.co.kr/minwon/shingo_psword_my.jsp";

		

		var wint = (screen.height - 450) / 2;

		var winl = (screen.width - 410) / 2;

		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';

		CBA_window = window.open('', "CbaWindow", winprops)

		

		//CBA_window = window.open('', 'CbaWindow', 'width=410, height=450, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=0, top=0');

		

		document.reqCBAForm.action='http://name.siren24.com/vname/jsp/vname_j10.jsp';

		document.reqCBAForm.target='CbaWindow';

		document.reqCBAForm.submit();

	}

	function openCBAWindow2() {

		document.reqCBAForm.retUrl.value = "http://www.suhyup.co.kr/minwon/absurd_write_my.jsp";

		

		var wint = (screen.height - 450) / 2;

		var winl = (screen.width - 410) / 2;

		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';

		CBA_window = window.open('', "CbaWindow", winprops)

		

		//CBA_window = window.open('', 'CbaWindow', 'width=410, height=450, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=0, top=0');

		

		document.reqCBAForm.action='http://name.siren24.com/vname/jsp/vname_j10.jsp';

		document.reqCBAForm.target='CbaWindow';

		document.reqCBAForm.submit();

	}

	function openCBAWindow3() {

		document.reqCBAForm.retUrl.value = "http://www.suhyup.co.kr/minwon/absurd_psword_my.jsp";

		

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



<body id="shingo01">

<%@ include file="/include/shHeader.jsp" %>

<!-- start content table-->

<form name="reqCBAForm" method="post" action="">

	<input type="hidden" name="id" value="SHU001">

	<input type="hidden" name="srvNo" value="001040">

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

		<td><a href="../minwon/shingo_001_my.jsp"><img src="../member/images/sc_bt_on_13_02.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td><a href="../minwon/taxfree_my.jsp"><img src="../member/images/sc_bt_off_13_03.gif" width="190" height="18" /></a></td>

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

                <td id="navigator"><a href="/">Home</a> &gt; 마이페이지 > <a href="../minwon/shingo_001_my.jsp">나의민원/신고</a> 

			> 금융사고/금융부조리신고</td>

		</tr>

		<tr>

			<td id="title"><img src="../images/pcTitle050201.gif" /></td>

		</tr>

		<tr>

			<td id="content">

			<!-- include start -->

			<table cellpadding="0" cellspacing="0" border="0" width="745" id="text_content">

			<tr> 

				<td  id="bullet02" width="23"></td>

				<td id="titleImg01" width="722"><img src="images/pcST050201_01.gif" vspace="6" /></td>		

			</tr>

			<tr>

				<td colspan="2" style="padding-top:12px;"><img src="images/pcST050201_02.gif" width="745" height="120" alt="" /></td>

			</tr>

			<tr> 

				<td></td>

                <td id="titleImg02"><img src="images/pcST050201_03.gif" /></td>

			</tr>

			<tr> 

				<td></td>

				<td id="titleImg03"><p>제 보 자 : 제한없음.</p>

				<p>제보대상 : 수협 사무소 및 수협 임직원.</p>

				<p>제보내용(예시) : 횡령, 배임, 공갈, 금품수수, 사금융알선, 저축관련부당행위, 금융실명제위반,

				변칙대출 등 금융관련 각종 부당행위</p></td>

			</tr>

			<tr> 

				<td></td>

                <td id="titleImg02"><img src="images/pcST050201_04.gif" /></td>

			</tr>

			<tr> 

				<td></td>

				<td id="titleImg03"><p>금융사고 제보자에 대한 비밀은 보호되오니 사고제보는 실명으로 하시기 바랍니다.</p>

				<p>창구 불친절, 진정, 불만 등 사항은「전자민원창구」를 이용하여 주시기 바라며, 이런 경우는「금융사고제보」로 볼 수 없어 제보사항 조치 및 회신을 해 드릴 수 없음을 알려드립니다</p></td>

			</tr>

			<tr> 

				<td></td>

                <td id="titleImg02"><img src="images/pcST050201_05.gif" /></td>

			</tr>

			<tr> 

				<td></td>

				<td id="titleImg03"><p>우편주소 : 서울시 송파구 신천동 11-6 수협중앙회 감사실(우 138-730)</p>

				<p>전 화 (☏): 02) 2240-3387, 3397</p>

				<p>FAX : 02) 2240-3076</p></td>

			</tr>

			<tr>

				      <td colspan="2" align="center" style="padding:25px 0 15px 0;">

					  <!-- <img src="images/pcST050201_11.gif" alt=""/><br />

                        <a href="javascript:openCBAWindow();"><img src="images/pcST050201_14.gif" alt="글올리기" vspace="10" border="0" /></a> -->

                        <a href="javascript:openCBAWindow1();"> <img src="images/pcST050201_15.gif" alt="신고내용조회" vspace="10" border="0" /></a>	

                      </td>

			</tr>

			<tr> 

				<td  id="bullet02" width="23"></td>

				<td id="titleImg01" width="722"><img src="images/pcST050201_06.gif" vspace="6" /></td>		

			</tr>

			<tr>

				<td colspan="2" style="padding-top:12px;"><img src="images/pcST050201_07.gif" width="745" height="120" alt="" /></td>

			</tr>

			<tr> 

				<td></td>

                <td id="titleImg02"><img src="images/pcST050201_08.gif" /></td>

			</tr>

			<tr> 

				<td></td>

				<td id="titleImg03"><p>신 고 자 : 제한없음.</p>

				<p>신고대상 : 수협 임직원</p></td>

			</tr>

			<tr> 

				<td></td>

                <td id="titleImg02"><img src="images/pcST050201_09.gif" /></td>

			</tr>

			<tr> 

				<td></td>

				<td id="titleImg03"><p>금품·상품권·선물 등의 요구 및 수수 행위</p>

				<p>향응 등의 요구 및 수수 행위</p>

				<p>대출 및 인사 등의 청탁 행위</p>

				<p>중소기업대출 관련 꺽기나 커미션 요구 행위</p>

				<p>직무유기 및 근무기강해이 등</p></td>

			</tr>

			<tr>

				<td colspan="2" style="padding:10px;">

				<table cellspacing="0">

				<tr>

					<td style="padding:10px; background-color:#f2f2f2;">여기에 신고되는 내용은 본회 감사실에서만 열람할 수 있으므로 신고자 및 신고내용에 대하여는 절대 비밀이 보장되며, 

					소정의 절차에 따라 처리한 후 회신을 보내드립니다. 신고 하실 때에는 실명을 원칙으로 하므로 각 등록사항을 정확히 입력하여 

					주시기 바라며, 익명 · 허위 주소인 경우에는 내용에 상관없이 삭제됨을 알려드립니다.</td>

				</tr>

				</table>

				</td>

			</tr>

			<tr> 

				<td></td>

                <td id="titleImg02"><img src="images/pcST050201_10.gif" /></td>

			</tr>

			<tr> 

				<td></td>

				<td id="titleImg03"><p>우편주소 : 서울시 송파구 신천동 11-6 수협중앙회 감사실 (우138-730)</p>

				<p>전 화(☏): 02) 2240-3385, 3390, 3392</p>

				<p>FAX : 02) 2240-3076</p></td>

			</tr>

			<tr>

				      <td colspan="2" align="center" style="padding:25px 0 15px 0;">

					  <!--<img src="images/pcST050201_13.gif" alt=""/><br />

                        <a href="javascript:openCBAWindow2();"><img src="images/pcST050201_14.gif" alt="" vspace="10" border="0" /></a> -->

                        <a href="javascript:openCBAWindow3();"> <img src="images/pcST050201_15.gif" alt="신고내용조회" vspace="10" border="0" /></a> 

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

</form>

<!-- end content table-->

<%@ include file="/include/shFooter.jsp" %>

</body>

</html>