<%@ page language="java" import="java.lang.*, java.util.*, java.sql.*, java.text.*, util.*,Bean.Front.Common.*, java.net.*, java.io.* SafeNC.kisinfo.*, Kisinfo.Check.IPINClient"%>
<%@ page contentType="text/html; charset=euc-kr" %>

<%
	String pSite_flag 	= "K751";				// �ѽ��򿡼� �߱޹��� ����Ʈ id 
	String pSite_pwd  	= "60218445";
	String pSeqid	   	= DateTime.getCurrentDateTime();	// ���� ��û Sequence : �ѽ��� ���μ��� ������ ������ ���Դϴ�. �ʿ�ÿ� ����� �ּ���.
	String pReturn_url	= "http://www.suhyup.co.kr/member/certnc_return.jsp";// ������� ���� ������ URL(��ü���� ������� ������ URL�Դϴ�.): ����ĺ��� �ʿ��� ����ũ�� ������
	String pReserved1	= "";					// ��Ÿ Reserved data1 : �ѽ��� ���μ��� ������ ������ ���Դϴ�. �ʿ�ÿ� ����� �ּ���.
	String pReserved2	= "";					// ��Ÿ Reserved data2 : �ѽ��� ���μ��� ������ ������ ���Դϴ�. �ʿ�ÿ� ����� �ּ���.
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


<%
	//����ĺ��� �ʿ��� ����ũ�� ������
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
<title>���� - �ٴٻ�� �����</title>
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
	<!-- ��ü���� ����ޱ� ���ϴ� ����Ÿ�� �����ϱ� ���� ����� �� ������, ������� ����� �ش� ���� �״�� �۽��մϴ�. �ش� �Ķ���ʹ� �߰��Ͻ� �� �����ϴ�. -->
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
	<!-- ��ü���� ����ޱ� ���ϴ� ����Ÿ�� �����ϱ� ���� ����� �� ������, ������� ����� �ش� ���� �״�� �۽��մϴ�. �ش� �Ķ���ʹ� �߰��Ͻ� �� �����ϴ�.
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
		<td width="180" height="125" valign="top"><img src="images/left_large_tit.gif" alt="���ڹο����нŰ�" width="180" height="170" /></td>
	</tr>
	<tr>
		<td height="10"></td>
	</tr>
	<tr>
		<td><a href="minwon_03.jsp"><img src="images/sc_bt_off_01.gif" alt="���ڹο�â��" /></a></td>
	</tr>
	<tr>
		<td><img src="images/sc_bt_on_02.gif" alt="�������Ű�" /></td>
	</tr>
  	<tr>
		<td height="5"></td>
	</tr>
	<tr>
		  <td><a href="taxfree.jsp"><img src="images/sc_bt_off_03.gif" alt="�鼼����������Ű�"  border="0" /></a></td>
	</tr>
		  <tr>
		  <td><a href="corruption.jsp"><img src="images/sc_bt_off_04.gif" alt="��㼾��" border="0" /></a></td>
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
			<td width="290" id="title"><img src="../images/pcTitle050201.gif" alt="�������/�����������Ű�"/></td>			
		    <td width="455" align="right" id="title"><a href="/">Home</a> &gt; <a href="minwon_01.jsp">���ڹο�/���нŰ�</a> > �������/�����������Ű�</td>

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
				<td id="titleImg03"><p>�� �� �� : ���Ѿ���.</p>
				<p>������� : ���� �繫�� �� ���� ������.</p>
				<p>��������(����) : Ⱦ��, ����, ����, ��ǰ����, ������˼�, ������úδ�����, �����Ǹ�������,
				��Ģ���� �� �������� ���� �δ�����</p></td>
			</tr>
			<tr>
				<td></td>
                <td id="titleImg02"><img src="images/pcST050201_04.gif" /></td>
			</tr>
			<tr>
				<td></td>
				<td id="titleImg03"><p>������� �����ڿ� ���� ����� ��ȣ�ǿ��� ��������� �Ǹ����� �Ͻñ� �ٶ��ϴ�.</p>
				<p>â�� ��ģ��, ����, �Ҹ� �� �����������ڹο�â������ �̿��Ͽ� �ֽñ� �ٶ��, �̷� ���¡���������������� �� �� ���� �������� ��ġ �� ȸ���� �� �帱 �� ������ �˷��帳�ϴ�</p></td>
			</tr>
			<tr>
				<td></td>
                <td id="titleImg02"><img src="images/pcST050201_05.gif" /></td>
			</tr>
			<tr>
				<td></td>
				<td id="titleImg03"><p>�����ּ� : ����� ���ı� ���ݷ� 62(��õ�� 11-6) �����߾�ȸ �����(�� 138-730)</p>
				<p>�� ȭ (��): 02) 2240-3383</p>
				<p>FAX : 02) 2240-3076</p></td>
			</tr>
			<tr>
				      <td colspan="2" align="center" style="padding:25px 0 15px 0;"><img src="images/pcST050201_11.gif" alt=""/><br />
                        <a href="javascript:openCBAWindow();"><img src="images/pcST050201_14.gif" alt="�ۿø���" vspace="10" border="0" /></a>
                        <a href="javascript:openCBAWindow1();"> <img src="images/pcST050201_15.gif" alt="�Ű�����ȸ" vspace="10" border="0" /></a>
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
				<td id="titleImg03"><p>�� �� �� : ���Ѿ���.</p>
				<p>�Ű��� : ���� ������</p></td>
			</tr>
			<tr>
				<td></td>
                <td id="titleImg02"><img src="images/pcST050201_09.gif" /></td>
			</tr>
			<tr>
				<td></td>
				<td id="titleImg03"><p>��ǰ����ǰ�ǡ����� ���� �䱸 �� ���� ����</p>
				<p>���� ���� �䱸 �� ���� ����</p>
				<p>���� �� �λ� ���� ûŹ ����</p>
				<p>�߼ұ������ ���� ���⳪ Ŀ�̼� �䱸 ����</p>
				<p>�������� �� �ٹ��Ⱝ���� ��</p></td>
			</tr>
			<tr>
				<td colspan="2" style="padding:10px;">
				<table cellspacing="0">
				<tr>
					<td style="padding:10px; background-color:#f2f2f2;">���⿡ �Ű�Ǵ� ������ ��ȸ ����ǿ����� ������ �� �����Ƿ� �Ű��� �� �Ű��뿡 ���Ͽ��� ���� ����� ����Ǹ�,
					������ ������ ���� ó���� �� ȸ���� �����帳�ϴ�. �Ű� �Ͻ� ������ �Ǹ��� ��Ģ���� �ϹǷ� �� ��ϻ����� ��Ȯ�� �Է��Ͽ�
					�ֽñ� �ٶ��, �͸� �� ���� �ּ��� ��쿡�� ���뿡 ������� �������� �˷��帳�ϴ�.</td>
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
				<td id="titleImg03"><p>�����ּ� : ����� ���ı� ���ݷ� 62(��õ�� 11-6) �����߾�ȸ ����� (��138-730)</p>
				<p>�� ȭ(��): 02) 2240-3383</p>
				<p>FAX : 02) 2240-3076</p></td>
			</tr>
			<tr>
				      <td colspan="2" align="center" style="padding:25px 0 15px 0;"><img src="images/pcST050201_13.gif" alt=""/><br />
                        <a href="javascript:openCBAWindow2();"><img src="images/pcST050201_14.gif" alt="" vspace="10" border="0" /></a>
                        <a href="javascript:openCBAWindow3();"> <img src="images/pcST050201_15.gif" alt="�Ű�����ȸ" vspace="10" border="0" /></a>
                      </td>
			</tr>
			</table>

<!-- contents  -->				
			
			</td>
		</tr>
		</table>
		<!-- ������ �� -->
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