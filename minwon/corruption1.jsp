<%@ page language="java" import="java.lang.*, java.util.*, java.sql.*, util.*" %>

<%@ page contentType="text/html; charset=euc-kr" %>

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

	<!-- ��ü���� ����ޱ� ���ϴ� ����Ÿ�� �����ϱ� ���� ����� �� ������, ������� ����� �ش� ���� �״�� �۽��մϴ�. �ش� �Ķ���ʹ� �߰��Ͻ� �� �����ϴ�. -->

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

		<td width="180" height="125" valign="top"><img src="images/left_large_tit.gif" alt="���ڹο����нŰ�" width="180" height="170" /></td>

	</tr>

	<tr>

		<td height="10"></td>

	</tr>

	<tr>

		<td><a href="minwon_03.jsp"><img src="images/sc_bt_off_01.gif" alt="���ڹο�â��" /></a></td>

	</tr>

	<tr>

		<td><a href="shingo_001.jsp"><img src="images/sc_bt_off_02.gif" alt="�������Ű�" border="0" /></a></td>

	</tr>
 

	<tr>

		  <td><a href="taxfree.jsp"><img src="images/sc_bt_off_03.gif" alt="�鼼����������Ű�" border="0" /></a></td>

	</tr>

		  <tr>

		  <td><a href="corruption.jsp"><img src="images/sc_bt_on_04.gif" alt="�ൿ���ɽŰ�/��㼾��" border="0" /></a></td>

	</tr>
	<tr>
		  <td><a href="budget.jsp"><img src="images/sc_bt_off_05.gif" alt="���곶��Ű���" border="0" /></a></td>
	</tr>

    <tr><td><a href="shingo_004.jsp"><img src="images/sc_bt_off_06.gif" alt="���ͽŰ����� �ȳ�" border="0" /></a></td></tr>
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

			<td width="296" id="title"><img src="../images/pcTitle050401.gif"  alt="�ൿ���� �Ű�/��㼾��"/></td>

		    <td width="465" align="right" id="title"><a href="/">Home</a> > <a href="minwon_01.jsp">���ڹο�/����&middot;���ͽŰ�</a> >�ൿ���� �Ű�/��㼾��</td>

		<tr>

			<td colspan="2" id="content">

<!-- contents  -->

			<table cellpadding="0" cellspacing="0" border="0" width="745" id="text_content">

			<tr>

				<td  id="bullet02" width="29"></td>

				<td id="titleImg01" width="716"><img src="images/pcST050401_01.gif" vspace="6" alt="�ൿ���� �Ű�/���" /></td>

			</tr>

			<tr>

				<td colspan="2" style="padding-top:12px;"><img src="images/pcST050401_02.gif" width="745" height="120" alt="���� ������ ���� ���������� �����ϰ� �����߾�ȸ �������ൿ������ ö���� �ؼ��ϰ� �ֽ��ϴ�." /></td>

			</tr>

			<tr>

				<td></td>

                <td id="titleImg02"><img src="images/pcST050401_03.gif" alt="�Ű�/������" /></td>

			</tr>

			<tr>

				<td></td>

				<td id="titleImg03"><p>�Ű��ڡ������ : ���� ����</p>

				  <p>�Ű��� : ����������</p>            </td>

			</tr>

			<tr>

				<td></td>

                <td id="titleImg02"><img src="images/pcST050401_04.gif" alt="�ൿ���� ��������" /></td>

			</tr>

			<tr>

				<td></td>

				<td id="titleImg03"><p>������ ���������� ��ġ�� ����</p>

				<p>û���� ����� ü�� �� ������ �����ϴ� ��</p>

				<p>�λ� ���� �˼���ûŹ ����</p>

				<p>�������� ������ �̿��� �ŷ�����</p>

				<p>���� �� ������ꡤ���� ���� ������롤���� ����</p>

				<p>��ǰ����ǰ�ǡ����������� ���� �䱸 �� ��������(����� ����)</p>

				<p>�밡�� �ִ� �ܺΰ��ǡ�ȸ�� ���� �̽Ű�����</p>

				<p>������ ���ݵǴ� ������ ���� �� ������ǰ ��������</p>

				<p>����� �� ���༺ ���� ��</p>

				<br /></td>

			</tr>

			<tr>

			  <td></td>

			  <td style="padding:10px; background-color:#f2f2f2;">�� ���� ������ ��ȸ ����ǿ����� ������ �� �����Ƿ� �Ű� �� ��㳻���� ���� ����� ����˴ϴ�. �Ű������ �Ǹ��� ��Ģ���� �ϹǷ� �� ��ϻ����� ��Ȯ�� �Է��Ͽ� �ֽñ� �ٶ��, �͸����� �ּ��� ��쿡�� ���뿡 ������� �������� �˷��帳�ϴ�.</td>



			  </tr>

			<tr>

				<td></td>

                <td id="titleImg02"><img src="images/pcST050401_05.gif" alt="����ó" /></td>

			</tr>

			<tr>

				<td></td>

				<td id="titleImg03"><p>�����ȣ : ����� ���ı� ���ݷ� 62 �����߾�ȸ �����(�� 138-730)</p>

				  <p>��ȭ��ȣ : 02)2240-3383</p>

				<p>�ѽ���ȣ : 02)2240-3076 </p></td>

			</tr>

			<tr>

				      <td colspan="2" align="center" style="padding:25px 0 15px 0;">

                        <a href="javascript:openCBAWindow();"><img src="images/pcST050201_14.gif" alt="�ۿø���" vspace="10" border="0" /></a>

                        <a href="javascript:openCBAWindow1();"> <img src="images/pcST050201_15.gif" alt="�Ű�����ȸ" vspace="10" border="0" /></a>                     
						<!-- 20141023 �߰� -->						<a href="#"><img src="images/pcST050201_16.gif" alt="�Ű�ǰ ó����� ����" border="0" /></a>						<!-- //20141023 �߰� -->					 </td>
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

    </td>

  </tr>

</table>

</div>

<!-- end content table-->

<%@ include file="/include/shFooter.jsp" %></body>

</html>