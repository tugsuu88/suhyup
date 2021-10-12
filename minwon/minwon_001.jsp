<%

/*****************************************************************************

*Title			: join_step01.jsp

*@author		: K.H.S

*@date			: 2007-12

*@Description	: 회원가입 구분 선택

*@Copyright		:

******************************************************************************

*수정일		*수정자		*수정사유

******************************************************************************/

%>

<%@ page language="java" import="java.lang.*, java.util.*, java.sql.*, java.text.*, util.*,Bean.Front.Common.*, java.net.*, java.io.*, SafeNC.kisinfo.*, Kisinfo.Check.IPINClient"%>

<%@ page contentType="text/html; charset=euc-kr" %>



<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="../inc/requestSecurity.jsp" %>



<%

	String myPage = request.getRequestURI();

	if( ( myPage.toUpperCase().indexOf("SCRIPT") >= 0 ) || ( myPage.toUpperCase().indexOf("ALERT")  >= 0 ) ) {

		%>

		    <script type=text/javascript>

		       alert("홈페이지 보안을 위해 \n\n 특수문자(script, alert) \n\n 사용을 제한합니다.");

		       location.href = "/index.jsp";

		    </script>

		<%

	 }

%>





<%



    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();



    String sSiteCode		= "Q011";				  // NICE신용평가정보로부터 부여받은 사이트 코드

    String sSitePassword	= "73368478";		

    String sIPINSiteCode	= "F012";				// NICE신용평가정보로부터 부여받은 아이핀사이트 코드

	  String sIPINPassword	= "34977358";		



    String sRequestNO		= "";							// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 필요시 사용

    String sClientImg		= "";							// 서비스 화면 로고 선택: default 는 null 입니다.(full 경로 입력해 주세요.)



    String sReturnURL 	= "http://www.suhyup.co.kr/member/certnc_return.jsp";	//결과 수신 URL



	  String sReserved1	= "3";					// 기타 Reserved data1 : 프로세스 진행후 받으실 값입니다. 필요시에 사용해 주세요.

	  String sReserved2	= "/minwon/minwon_apply01.jsp";					// 기타 Reserved data2 : 프로세스 진행후 받으실 값입니다. 필요시에 사용해 주세요.

	  String sReserved3	= "";					// 기타 Reserved data3 : 프로세스 진행후 받으실 값입니다. 필요시에 사용해 주세요.



	  sRequestNO = niceCheck.getRequestNO(sSiteCode);	//요청고유번호 / 비정상적인 접속 차단을 위해 필요

  	session.setAttribute("REQ_SEQ" , sRequestNO);	//해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

    System.out.println ("sRequestNO : " + sRequestNO + "<br/>");



    // 입력될 plain 데이타를 만든다.

    String sPlainData = "7:RTN_URL" + sReturnURL.getBytes().length + ":" + sReturnURL +

                        "7:REQ_SEQ" + sRequestNO.getBytes().length + ":" + sRequestNO +

                        "7:IMG_URL" + sClientImg.getBytes().length + ":" + sClientImg +

                        "9:RESERVED1" + sReserved1.getBytes().length + ":" + sReserved1 +

                        "9:RESERVED2" + sReserved2.getBytes().length + ":" + sReserved2 +

                        "9:RESERVED3" + sReserved3.getBytes().length + ":" + sReserved3 +

                        "13:IPIN_SITECODE" + sIPINSiteCode.getBytes().length + ":" + sIPINSiteCode +

                        "17:IPIN_SITEPASSWORD" + sIPINPassword.getBytes().length + ":" + sIPINPassword ;



    String sMessage = "";

    String enc_data = "";



    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);

    if( iReturn == 0 )

    {

        enc_data = niceCheck.getCipherData();

        System.out.println ("요청정보_암호화_성공[ : " + enc_data + "]");

    }

    else if( iReturn == -1)

    {

        sMessage = "암호화 시스템 에러입니다.";

    }

    else if( iReturn == -2)

    {

        sMessage = "암호화 처리오류입니다.";

    }

    else if( iReturn == -3)

    {

        sMessage = "암호화 데이터 오류입니다.";

    }

    else if( iReturn == -9)

    {

        sMessage = "입력 데이터 오류입니다.";

    }

    else

    {

        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;

    }





	String pSeqid	   	= DateTime.getCurrentDateTime();



	// IPIN

	/********************************************************************************************************************************************

		NICE신용평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED



		서비스명 : 가상주민번호서비스 (IPIN) 서비스

		페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지

	*********************************************************************************************************************************************/



	sSiteCode				= "F012";			// IPIN 서비스 사이트 코드		(NICE신용평가정보에서 발급한 사이트코드)

	String sSitePw					= "34977358";			// IPIN 서비스 사이트 패스워드	(NICE신용평가정보에서 발급한 사이트패스워드)

	String sEncData					= "";			// 암호화 된 데이타

	String sRtnMsg					= "";			// 처리결과 메세지

	/*

	┌ sReturnURL 변수에 대한 설명  ─────────────────────────────────────────────────────

		NICE신용평가정보 팝업에서 인증받은 사용자 정보를 암호화하여 귀사로 리턴합니다.

		따라서 암호화된 결과 데이타를 리턴받으실 URL 정의해 주세요.



		* URL 은 http 부터 입력해 주셔야하며, 외부에서도 접속이 유효한 정보여야 합니다.

		* 당사에서 배포해드린 샘플페이지 중, ipin_process.jsp 페이지가 사용자 정보를 리턴받는 예제 페이지입니다.



		아래는 URL 예제이며, 귀사의 서비스 도메인과 서버에 업로드 된 샘플페이지 위치에 따라 경로를 설정하시기 바랍니다.

		예 - http://www.test.co.kr/ipin_process.jsp, https://www.test.co.kr/ipin_process.jsp, https://test.co.kr/ipin_process.jsp

	└────────────────────────────────────────────────────────────────────

	*/

	sReturnURL				= "http://www.suhyup.co.kr/member/ipin_return.jsp";





	/*

	┌ sCPRequest 변수에 대한 설명  ─────────────────────────────────────────────────────

		[CP 요청번호]로 귀사에서 데이타를 임의로 정의하거나, 당사에서 배포된 모듈로 데이타를 생성할 수 있습니다.



		CP 요청번호는 인증 완료 후, 암호화된 결과 데이타에 함께 제공되며

		데이타 위변조 방지 및 특정 사용자가 요청한 것임을 확인하기 위한 목적으로 이용하실 수 있습니다.



		따라서 귀사의 프로세스에 응용하여 이용할 수 있는 데이타이기에, 필수값은 아닙니다.

	└────────────────────────────────────────────────────────────────────

	*/

	String sCPRequest				= pSeqid;



	// 객체 생성

	IPINClient pClient = new IPINClient();





	// 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.

	sCPRequest = pClient.getRequestNO(sSiteCode);



	// CP 요청번호를 세션에 저장합니다.

	// 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.

	// 필수사항은 아니며, 보안을 위한 권고사항입니다.

	session.setAttribute("CPREQUEST" , sCPRequest);





	// Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.

	int iRtn = pClient.fnRequest(sSiteCode, sSitePw, sCPRequest, sReturnURL);



	// Method 결과값에 따른 처리사항

	if (iRtn == 0)

	{

		// fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.

		// 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.

		sEncData = pClient.getCipherData();

		sRtnMsg = "정상 처리되었습니다.";



	}

	else if (iRtn == -1 || iRtn == -2)

	{

		sRtnMsg =	"배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<br/>귀사 서버환경에 맞는 모듈이 없다면 ..<br/><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";

	}

	else if (iRtn == -9)

	{

		sRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";

	}

	else

	{

		sRtnMsg = "iRtn 값 확인 후, NICE신용평가정보 개발 담당자에게 문의해 주세요.";

	}



	System.out.println(enc_data);

	System.out.println(enc_data);

	System.out.println(sRtnMsg);

%>

<% String pageNum = "7"; %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>

<title>수협 - 바다사랑 고객사랑</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

<!--[if IE 7]><link rel="stylesheet" type="text/css" href="../css/footer.css"     /><![endif]-->

<!--[if IE 8]><link rel="stylesheet" type="text/css" href="../css/footer_IE8.css" /><![endif]-->

<script type="text/javascript">

<!--

	window.name ="join_window";



	var CBA_window;

	function openCBAWindow() {

		document.reqCBAForm.retUrl.value = "http://www.suhyup.co.kr/minwon/minwon_apply01.jsp";

		var wint = (screen.height - 450) / 2;

		var winl = (screen.width - 410) / 2;

		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';

		CBA_window = window.open('', "CbaWindow", winprops)

		//CBA_window = window.open('', 'CbaWindow', 'width=410, height=450, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=0, top=0');

		document.reqCBAForm.action='http://name.siren24.com/vname/jsp/vname_j10.jsp';

		document.reqCBAForm.target='CbaWindow';

		document.reqCBAForm.submit();

	}



	/**

	 * 실명인증 처리 부분

	 */

	function fnPopupNameCheck()

	{

   	   //한국신용평가정보 안심 실명확인 팝업페이지를 띄웁니다.

	   window.open('', 'popupNameCheck','width=500, height=550,toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,top=0,left=0');

	   document.frmNameCheck.target = "popupNameCheck";

	   document.frmNameCheck.action = "https://cert.namecheck.co.kr/NiceID2/certpass_input.asp";

	   document.frmNameCheck.submit();

	}



	// IPIN 인증

	function fnPopupIpinCheck(){

		window.open('', 'popupNameCheck', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');

		document.frmIpinCheck.target = "popupNameCheck";

		document.frmIpinCheck.action = "https://cert.vno.co.kr/ipin.cb";

		document.frmIpinCheck.submit();

	}

//-->

</script>

</head>



<body id="minwon01">

<%@ include file="/include/shHeader.jsp" %>

<form method="post" name="frmNameCheck">

	<input type="hidden" name="enc_data" value="<%=enc_data%>">

</form>



<form name="frmIpinCheck" method="post">

	<input type="hidden" name="m" value="pubmain">

    <input type="hidden" name="enc_data" value="<%= sEncData %>">

    <input type="hidden" name="param_r1" value="2">

    <input type="hidden" name="param_r2" value="/minwon/minwon_apply01.jsp">

    <input type="hidden" name="param_r3" value="" />

</form>



<form name="vnoform" method="post" action="/minwon/minwon_apply01.jsp">

	<input type="hidden" name="enc_data">

	<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다. 해당 파라미터는 추가하실 수 없습니다. -->

    <input type="hidden" name="param_r1" value="" />

    <input type="hidden" name="param_r2" value="" />

    <input type="hidden" name="param_r3" value="" />

</form>

<form name="reqCBAForm" method="post" action="">

	<input type="hidden" name="id" value="SHU001">

	<input type="hidden" name="srvNo" value="001016">

	<input type="hidden" name="reqNum" value="<%=pSeqid%>">

	<input type="hidden" name="retUrl" value="/minwon/minwon_apply01.jsp">

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

		<td><img src="images/sc_bt_on_01.gif" alt="전자민원창구" /></td>

	</tr>

  	<tr>

		<td height="3"></td>

	</tr>

	<tr>

		<td><a href="minwon_03.jsp"><img src="images/sc_bt_off_013.gif" alt="민원사무편람" /></a></td>

	</tr>

	<tr>

		<td><a href="minwon_001.jsp"><img src="images/sc_bt_on_011.gif" alt="민원신청"/></a></td>

	</tr>

	<tr>

		<td><a href="minwon_apply03.jsp"><img src="images/sc_bt_off_012.gif" alt="민원처리결과조회" /></a></td>

	</tr>

	<tr>

		<td><a href="minwon_result.jsp"><img src="images/sc_bt_off_014.gif" alt="민원처리결과공시" /></a></td>

	</tr>

	<tr>

		<td height="15"></td>

	</tr>

	<tr>

		<td><a href="shingo_001.jsp"><img src="images/sc_bt_off_02.gif" alt="금융사고신고" /></a></td>

	</tr>

	<tr>

		<td><a href="taxfree.jsp"><img src="images/sc_bt_off_03.gif" alt="면세유부정유통신고" /></a></td>

	</tr>

		  <tr>

		  <td><a href="corruption.jsp"><img src="images/sc_bt_off_04.gif" alt="상담센터" border="0" /></a></td>

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

			<td width="350" id="title"><img src="../images/pcTitle050101.gif"  alt="민원창구"/></td>

		    <td width="395" align="right" id="title"><a href="/">Home</a> > <a href="minwon_01.jsp">전자민원/부패&middot;공익신고</a>  > <a href="minwon_01.jsp">전자민원창구</a> > 민원신청</td>

		<tr>

			<td colspan="2" id="content">

<!-- contents  -->

					<table width="745" border="0" cellspacing="0" cellpadding="0">

                      <tr>

                      <td align="center"><img src="images/minwon01_bg.jpg" width="705" height="288" usemap="#Map" border="0" /></td>

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

<!-- end content table-->



</td></tr></table>

<map name="Map">

  <area shape="rect" coords="294,118,429,156" href="javascript:fnPopupNameCheck();" alt="실명인증"/>

    <area shape="rect" coords="440,119,572,156" href="javascript:fnPopupIpinCheck();" alt="아이핀인증"/>

</map>

</div><%@ include file="/include/shFooter.jsp" %></body>

</html>