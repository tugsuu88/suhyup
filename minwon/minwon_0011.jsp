<%

/*****************************************************************************

*Title			: join_step01.jsp

*@author		: K.H.S

*@date			: 2007-12

*@Description	: ȸ������ ���� ����

*@Copyright		: 

******************************************************************************

*������		*������		*��������

******************************************************************************/

%> 

<%@ page language="java" import="java.lang.*, java.util.*, java.sql.*, java.text.*, util.*,Bean.Front.Common.*, java.net.*, java.io.* SafeNC.kisinfo.*, Kisinfo.Check.IPINClient"%>

<%@ page contentType="text/html; charset=euc-kr" %>



<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="../inc/requestSecurity.jsp" %>



<%

	String myPage = request.getRequestURI();

	if( ( myPage.toUpperCase().indexOf("SCRIPT") >= 0 ) || ( myPage.toUpperCase().indexOf("ALERT")  >= 0 ) ) {

		%>

		    <script type=text/javascript>

		       alert("Ȩ������ ������ ���� \n\n Ư������(script, alert) \n\n ����� �����մϴ�.");

		       location.href = "/index.jsp";

		    </script>

		<%

	 }

%>





<%

	String pSite_flag 	= "K751";				// �ѽ��򿡼� �߱޹��� ����Ʈ id 

	String pSite_pwd  	= "60218445";

	String pSeqid	   	= DateTime.getCurrentDateTime();	// ���� ��û Sequence : �ѽ��� ���μ��� ������ ������ ���Դϴ�. �ʿ�ÿ� ����� �ּ���.

	String pReturn_url	= "http://www.suhyup.co.kr/member/certnc_return.jsp";// ������� ���� ������ URL(��ü���� ������� ������ URL�Դϴ�.): ����ĺ��� �ʿ��� ����ũ�� ������

	String pReserved1	= "1";					// ��Ÿ Reserved data1 : �ѽ��� ���μ��� ������ ������ ���Դϴ�. �ʿ�ÿ� ����� �ּ���.

	String pReserved2	= "/minwon/minwon_apply01.jsp";					// ��Ÿ Reserved data2 : �ѽ��� ���μ��� ������ ������ ���Դϴ�. �ʿ�ÿ� ����� �ּ���.

	String pReserved3	= "";					// ��Ÿ Reserved data3 : �ѽ��� ���μ��� ������ ������ ���Դϴ�. �ʿ�ÿ� ����� �ּ���.

	String enc_data		= "";

	

	// ����Ÿ�� ��ȣȭ,��ȣȭ �ϴ� ����Դϴ�.

	SafeNCCipher safeNC = new SafeNCCipher();

	

	//**********************************************************************************************

	// ����Ÿ�� ��ȣȭ �մϴ�. 

	//**********************************************************************************************	

	

	if( safeNC.request(pSite_flag,pSite_pwd,pSeqid,pReturn_url,pReserved1,pReserved2,pReserved3) == 0 ) {

		enc_data = safeNC.getEncParam();		

	}else {

		enc_data = "";

	}

	

	

	// IPIN

	/********************************************************************************************************************************************

		NICE�ſ������� Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED

		

		���񽺸� : �����ֹι�ȣ���� (IPIN) ����

		�������� : �����ֹι�ȣ���� (IPIN) ȣ�� ������

	*********************************************************************************************************************************************/

	

	String sSiteCode				= "B031";			// IPIN ���� ����Ʈ �ڵ�		(NICE�ſ����������� �߱��� ����Ʈ�ڵ�)

	String sSitePw					= "27991884";			// IPIN ���� ����Ʈ �н�����	(NICE�ſ����������� �߱��� ����Ʈ�н�����)

	String sEncData					= "";			// ��ȣȭ �� ����Ÿ

	String sRtnMsg					= "";			// ó����� �޼���

	/*

	�� sReturnURL ������ ���� ����  ����������������������������������������������������������������������������������������������������������

		NICE�ſ������� �˾����� �������� ����� ������ ��ȣȭ�Ͽ� �ͻ�� �����մϴ�.

		���� ��ȣȭ�� ��� ����Ÿ�� ���Ϲ����� URL ������ �ּ���.

		

		* URL �� http ���� �Է��� �ּž��ϸ�, �ܺο����� ������ ��ȿ�� �������� �մϴ�.

		* ��翡�� �����ص帰 ���������� ��, ipin_process.jsp �������� ����� ������ ���Ϲ޴� ���� �������Դϴ�.

		

		�Ʒ��� URL �����̸�, �ͻ��� ���� �����ΰ� ������ ���ε� �� ���������� ��ġ�� ���� ��θ� �����Ͻñ� �ٶ��ϴ�.

		�� - http://www.test.co.kr/ipin_process.jsp, https://www.test.co.kr/ipin_process.jsp, https://test.co.kr/ipin_process.jsp

	������������������������������������������������������������������������������������������������������������������������������������������

	*/

	String sReturnURL				= "http://www.suhyup.co.kr/member/ipin_return.jsp";

	

	

	/*

	�� sCPRequest ������ ���� ����  ����������������������������������������������������������������������������������������������������������

		[CP ��û��ȣ]�� �ͻ翡�� ����Ÿ�� ���Ƿ� �����ϰų�, ��翡�� ������ ���� ����Ÿ�� ������ �� �ֽ��ϴ�.

		

		CP ��û��ȣ�� ���� �Ϸ� ��, ��ȣȭ�� ��� ����Ÿ�� �Բ� �����Ǹ�

		����Ÿ ������ ���� �� Ư�� ����ڰ� ��û�� ������ Ȯ���ϱ� ���� �������� �̿��Ͻ� �� �ֽ��ϴ�.

		

		���� �ͻ��� ���μ����� �����Ͽ� �̿��� �� �ִ� ����Ÿ�̱⿡, �ʼ����� �ƴմϴ�.

	������������������������������������������������������������������������������������������������������������������������������������������

	*/

	String sCPRequest				= pSeqid;



	// ��ü ����

	IPINClient pClient = new IPINClient();

	

	

	// �ռ� ����帰 �ٿͰ���, CP ��û��ȣ�� ������ ����� ���� �Ʒ��� ���� ������ �� �ֽ��ϴ�.

	sCPRequest = pClient.getRequestNO(sSiteCode);

	

	// CP ��û��ȣ�� ���ǿ� �����մϴ�.

	// ���� ������ ������ ������ ipin_result.jsp ���������� ����Ÿ ������ ������ ���� Ȯ���ϱ� �����Դϴ�.

	// �ʼ������� �ƴϸ�, ������ ���� �ǰ�����Դϴ�.

	session.setAttribute("CPREQUEST" , sCPRequest);

	

	

	// Method �����(iRtn)�� ����, ���μ��� ���࿩�θ� �ľ��մϴ�.

	int iRtn = pClient.fnRequest(sSiteCode, sSitePw, sCPRequest, sReturnURL);

	

	// Method ������� ���� ó������

	if (iRtn == 0)

	{

		// fnRequest �Լ� ó���� ��ü������ ��ȣȭ�� �����͸� �����մϴ�.

		// ����� ��ȣȭ�� ����Ÿ�� ��� �˾� ��û��, �Բ� �����ּž� �մϴ�.

		sEncData = pClient.getCipherData();

		sRtnMsg = "���� ó���Ǿ����ϴ�.";

	

	}

	else if (iRtn == -1 || iRtn == -2)

	{

		sRtnMsg =	"������ �帰 ���� ��� ��, �ͻ� ����ȯ�濡 �´� ����� �̿��� �ֽñ� �ٶ��ϴ�.<br/>�ͻ� ����ȯ�濡 �´� ����� ���ٸ� ..<br/><B>iRtn ��, ���� ȯ�������� ��Ȯ�� Ȯ���Ͽ� ���Ϸ� ��û�� �ֽñ� �ٶ��ϴ�.</B>";

	}

	else if (iRtn == -9)

	{

		sRtnMsg = "�Է°� ���� : fnRequest �Լ� ó����, �ʿ��� 4���� �Ķ���Ͱ��� ������ ��Ȯ�ϰ� �Է��� �ֽñ� �ٶ��ϴ�.";

	}

	else

	{

		sRtnMsg = "iRtn �� Ȯ�� ��, NICE�ſ������� ���� ����ڿ��� ������ �ּ���.";

	}



	System.out.println(enc_data);

	System.out.println(enc_data);

	System.out.println(sRtnMsg);

%>

<% String pageNum = "7"; %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>

<title>���� - �ٴٻ�� �����</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

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

	 * �Ǹ����� ó�� �κ�

	 */

	function fnPopupNameCheck()

	{

   	   //�ѱ��ſ������� �Ƚ� �Ǹ�Ȯ�� �˾��������� ���ϴ�.	 

	   window.open('', 'popupNameCheck','width=410, height=590');

	   document.frmNameCheck.target = "popupNameCheck";

	   document.frmNameCheck.action = "https://cert.namecheck.co.kr/certnc_input.asp";

	   document.frmNameCheck.submit();

	}

	

	// IPIN ����

	function fnPopupIpinCheck(){

		window.open('', 'popupNameCheck', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');

		document.frmIpinCheck.target = "popupNameCheck";

		document.frmIpinCheck.action = "https://cert.vno.co.kr/ipin.cb";

		document.frmIpinCheck.submit();

	}

//-->	

</script>

</head>

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

	<input type="hidden" name="enc_data" />

	<!-- ��ü���� ����ޱ� ���ϴ� ����Ÿ�� �����ϱ� ���� ����� �� ������, ������� ����� �ش� ���� �״�� �۽��մϴ�. �ش� �Ķ���ʹ� �߰��Ͻ� �� �����ϴ�. -->

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

<!-- start content table-->

<table width="920" border="0" align="center" cellpadding="0" cellspacing="0">

<tr><td>

<table cellpadding="0" cellspacing="0" id="contentTable">

<tr>

	<td valign="top" id="sideContent">

	<table cellpadding="0" cellspacing="0">

	<tr>

		<td width="180" height="125" valign="top"><img src="images/left_large_tit.gif" alt="" width="180" height="170" /></td>

	</tr>

	<tr>

		<td height="10"></td>

	</tr>

	<tr>

		<td><img src="images/sc_bt_on_01.gif" /></td>

	</tr>

  	<tr>

		<td height="3"></td>

	</tr>

	<tr>

		<td><a href="minwon_03.jsp"><img src="images/sc_bt_off_013.gif" /></a></td>

	</tr>

	<tr>

		<td><a href="minwon_001.jsp"><img src="images/sc_bt_on_011.gif" /></a></td>

	</tr>

	<tr>

		<td><a href="minwon_apply03.jsp"><img src="images/sc_bt_off_012.gif" /></a></td>

	</tr>

	<tr>

		<td><a href="minwon_result.jsp"><img src="images/sc_bt_off_014.gif" /></a></td>

	</tr>

	<tr>

		<td height="15"></td>

	</tr>

	<tr>

		<td><a href="shingo_001.jsp"><img src="images/sc_bt_off_02.gif" /></a></td>

	</tr>

	<tr>

		<td><a href="taxfree.jsp"><img src="images/sc_bt_off_03.gif" /></a></td>

	</tr>

		  <tr>

		  <td><a href="corruption.jsp"><img src="images/sc_bt_off_04.gif" border="0" /></a></td>

	</tr>

	</table>

	</td>

	<td width="797" valign="top" id="primaryContent">

	<table cellpadding="0" cellspacing="0">	

	<tr>

		<td style="; padding-left:30px;" valign="top">

		<!-- ������ ���� -->

		<table cellpadding="0" cellspacing="0">		

		<tr>

		  <td height="45" colspan="2">&nbsp;</td>

		  </tr>

		<tr>

			<td width="450" id="title"><img src="../images/pcTitle050101.gif" /></td>			

		    <td width="295" align="right" id="title"><a href="/">Home</a> &gt; <a href="minwon_01.jsp">���ڹο�/���нŰ�</a> > <a href="minwon_01.jsp">���ڹο�â��</a></td>

		</tr>
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

		<!-- ������ �� -->

		</td>

	</tr>

	<tr>

		<td height="20"></td>

	</tr>

	</table>

	</td>

</tr>

</table>

<!-- end content table-->

 

</td></tr></table>

<map name="Map">

  <area shape="rect" coords="294,118,429,156" href="javascript:fnPopupNameCheck();">

    <area shape="rect" coords="440,119,572,156" href="javascript:fnPopupIpinCheck();">

</map>

<%@ include file="/include/shFooter.jsp" %></body>

</html>