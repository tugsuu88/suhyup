<%@ page language="java" import="java.lang.*, java.util.*, java.sql.*, java.text.*, util.*,Bean.Front.Common.*, java.net.*, java.io.* SafeNC.kisinfo.*, Kisinfo.Check.IPINClient"%>
<%@ page contentType="text/html; charset=euc-kr" %>

<%
	String pSite_flag 	= "K751";				// 한신평에서 발급받은 사이트 id 
	String pSite_pwd  	= "60218445";
	String pSeqid	   	= DateTime.getCurrentDateTime();	// 고객사 요청 Sequence : 한신평 프로세스 진행후 받으실 값입니다. 필요시에 사용해 주세요.
	String pReturn_url	= "http://www.suhyup.co.kr/member/certnc_return.jsp";// 결과값을 리턴 받으실 URL(업체에서 결과값을 받으실 URL입니다.): 가상식별에 필요한 유니크한 값생성
	String pReserved1	= "";					// 기타 Reserved data1 : 한신평 프로세스 진행후 받으실 값입니다. 필요시에 사용해 주세요.
	String pReserved2	= "";					// 기타 Reserved data2 : 한신평 프로세스 진행후 받으실 값입니다. 필요시에 사용해 주세요.
	String pReserved3	= "";					// 기타 Reserved data3 : 한신평 프로세스 진행후 받으실 값입니다. 필요시에 사용해 주세요.
	String enc_data		= "";
	
	// 데이타를 암호화,복호화 하는 모듈입니다.
	SafeNCCipher safeNC = new SafeNCCipher();
	
	//**********************************************************************************************
	// 데이타를 암호화 합니다. 
	//**********************************************************************************************	
	
	if( safeNC.request(pSite_flag,pSite_pwd,pSeqid,pReturn_url,pReserved1,pReserved2,pReserved3) == 0 ) {
		enc_data = safeNC.getEncParam();		
	}else {
		enc_data = "";
	}
	
	
	// IPIN
	/********************************************************************************************************************************************
		NICE신용평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
		
		서비스명 : 가상주민번호서비스 (IPIN) 서비스
		페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
	*********************************************************************************************************************************************/
	
	String sSiteCode				= "B031";			// IPIN 서비스 사이트 코드		(NICE신용평가정보에서 발급한 사이트코드)
	String sSitePw					= "27991884";			// IPIN 서비스 사이트 패스워드	(NICE신용평가정보에서 발급한 사이트패스워드)
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
	String sReturnURL				= "http://www.suhyup.co.kr/member/ipin_return.jsp";
	
	
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
<script type="text/javascript">
<!--
	window.name ="join_window";
	var CBA_window;

	function openCBAWindow() {
		//document.reqCBAForm.retUrl.value = "/minwon/shingo_write.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		window.open('', "CbaWindow", winprops);

		document.reqCBAForm.target='CbaWindow';
		document.reqCBAForm.action="https://cert.vno.co.kr/ipin.cb";
		document.reqCBAForm.submit();
	}
	function openCBAWindow1() {
		//document.reqCBAForm.retUrl.value = "/minwon/shingo_psword.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops)

		document.reqCBAForm1.action="https://cert.vno.co.kr/ipin.cb";
		document.reqCBAForm1.target='CbaWindow';
		document.reqCBAForm1.submit();
	}
	function openCBAWindow2() {
		//document.reqCBAForm.retUrl.value = "/minwon/absurd_write.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops);

		document.reqCBAForm2.action="https://cert.vno.co.kr/ipin.cb";
		document.reqCBAForm2.target='CbaWindow';
		document.reqCBAForm2.submit();
	}
	function openCBAWindow3() {
		//document.reqCBAForm.retUrl.value = "/minwon/absurd_psword.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops);

		document.reqCBAForm3.action="https://cert.vno.co.kr/ipin.cb";
		document.reqCBAForm3.target='CbaWindow';
		document.reqCBAForm3.submit();
	}
//-->
</script>
</head>

<body id="shingo01"> 
<form name="reqCBAForm" method="post">
	<input type="hidden" name="m" value="pubmain">
    <input type="hidden" name="enc_data" value="<%= sEncData %>">
    <input type="hidden" name="param_r1" value="2">
    <input type="hidden" name="param_r2" value="/minwon/shingo_write.jsp">
    <input type="hidden" name="param_r3" value="" />
</form>
<form name="reqCBAForm1" method="post">
	<input type="hidden" name="m" value="pubmain">
    <input type="hidden" name="enc_data" value="<%= sEncData %>">
    <input type="hidden" name="param_r1" value="2">
    <input type="hidden" name="param_r2" value="/minwon/shingo_psword.jsp">
    <input type="hidden" name="param_r3" value="" />
</form>
<form name="reqCBAForm2" method="post">
	<input type="hidden" name="m" value="pubmain">
    <input type="hidden" name="enc_data" value="<%= sEncData %>">
    <input type="hidden" name="param_r1" value="2">
    <input type="hidden" name="param_r2" value="/minwon/absurd_write.jsp">
    <input type="hidden" name="param_r3" value="" />
</form>
<form name="reqCBAForm3" method="post">
	<input type="hidden" name="m" value="pubmain">
    <input type="hidden" name="enc_data" value="<%= sEncData %>">
    <input type="hidden" name="param_r1" value="2">
    <input type="hidden" name="param_r2" value="/minwon/absurd_psword.jsp">
    <input type="hidden" name="param_r3" value="" />
</form>
<form name="vnoform" method="post">
	<input type="hidden" name="enc_data" />
	<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다. 해당 파라미터는 추가하실 수 없습니다. -->
    <input type="hidden" name="param_r1" value="" />
    <input type="hidden" name="param_r2" value="" />
    <input type="hidden" name="param_r3" value="" />
</form>

 
<%@ include file="/include/shHeader.jsp" %>

<!--
<form name="reqCBAForm" method="post" action="">
	<input type="hidden" name="retUrl" value="" />
</form>
<form name="vnoform" method="post">
	<input type="hidden" name="enc_data" />
	<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다. 해당 파라미터는 추가하실 수 없습니다.
    <input type="hidden" name="param_r1" value="" />
    <input type="hidden" name="param_r2" value="" />
    <input type="hidden" name="param_r3" value="" />
</form>   -->
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
		<td><img src="images/sc_bt_on_02.gif" alt="금융사고신고" /></td>
	</tr>
  	<tr>
		<td height="5"></td>
	</tr>
	<tr>
		  <td><a href="taxfree.jsp"><img src="images/sc_bt_off_03.gif" alt="면세유부정유통신고"  border="0" /></a></td>
	</tr>
		  <tr>
		  <td><a href="corruption.jsp"><img src="images/sc_bt_off_04.gif" alt="상담센터" border="0" /></a></td>
	</tr>
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
			<td width="290" id="title"><img src="../images/pcTitle050201.gif" alt="금융사고/금융부조리신고"/></td>			
		    <td width="455" align="right" id="title"><a href="/">Home</a> &gt; <a href="minwon_01.jsp">전자민원/부패신고</a> > 금융사고/금융부조리신고</td>

		</tr>
<tr>
			<td colspan="2" id="content">
<!-- contents  -->			
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
				<td id="titleImg03"><p>우편주소 : 서울시 송파구 오금로 62(신천동 11-6) 수협중앙회 감사실(우 138-730)</p>
				<p>전 화 (☏): 02) 2240-3383</p>
				<p>FAX : 02) 2240-3076</p></td>
			</tr>
			<tr>
				      <td colspan="2" align="center" style="padding:25px 0 15px 0;"><img src="images/pcST050201_11.gif" alt=""/><br />
                        <a href="javascript:openCBAWindow();"><img src="images/pcST050201_14.gif" alt="글올리기" vspace="10" border="0" /></a>
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
				<td id="titleImg03"><p>우편주소 : 서울시 송파구 오금로 62(신천동 11-6) 수협중앙회 감사실 (우138-730)</p>
				<p>전 화(☏): 02) 2240-3383</p>
				<p>FAX : 02) 2240-3076</p></td>
			</tr>
			<tr>
				      <td colspan="2" align="center" style="padding:25px 0 15px 0;"><img src="images/pcST050201_13.gif" alt=""/><br />
                        <a href="javascript:openCBAWindow2();"><img src="images/pcST050201_14.gif" alt="" vspace="10" border="0" /></a>
                        <a href="javascript:openCBAWindow3();"> <img src="images/pcST050201_15.gif" alt="신고내용조회" vspace="10" border="0" /></a>
                      </td>
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

</div><%@ include file="/include/shFooter.jsp" %></body>
</html>