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

                <td id="navigator"><a href="/">Home</a> &gt; ���������� > <a href="../minwon/corruption_my.jsp">���ǹο�/�Ű�</a> 

			> �ൿ���� �Ű���㼾��</td>

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

				<td id="titleImg03"><p>�Ű��ڡ������ : ���� ����</p>

				  <p>�Ű��� : ����������</p>            </td>

			</tr>

			<tr>

				<td></td>

                <td id="titleImg02"><img src="images/pcST050401_04.gif" /></td>

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

			<tr>

				<td></td>

                <td id="titleImg02"><img src="images/pcST050401_05.gif" /></td>

			</tr>

			<tr>

				<td></td>

				<td id="titleImg03"><p>�����ȣ : ����� ���ı� ��õ�� 11-6 �����߾�ȸ �����(�� 138-730)</p>

				  <p>��ȭ��ȣ : 02)2240-3383, 3392</p>

				<p>�ѽ���ȣ : 02)22240-3076 </p></td>

			</tr>

			<tr>

				      <td colspan="2" align="center" style="padding:25px 0 15px 0;">

					    <!-- <img src="images/pcST050301_08.gif" alt=""/><br />

                      <a href="javascript:openCBAWindow();"><img src="images/pcST050201_14.gif" alt="�ۿø���" vspace="10" border="0" /></a> -->

                        <a href="javascript:openCBAWindow1();"> <img src="images/pcST050201_15.gif" alt="�Ű�����ȸ" vspace="10" border="0" /></a> 

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