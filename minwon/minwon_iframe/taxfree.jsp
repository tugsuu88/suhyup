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


<link rel='stylesheet' type='text/css' media='all' href='../css/main.css' />


<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />


<script type="text/javascript" src="../js/quickMenu.js"></script>


<script type="text/javascript" src="../js/public.js"></script>


<script type="text/javascript">


<!--


	var CBA_window;





	function openCBAWindow() {


		document.reqCBAForm.retUrl.value = "http://www.suhyup.co.kr/minwon/taxfree_write.jsp";


		


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


		document.reqCBAForm.retUrl.value = "http://www.suhyup.co.kr/minwon/taxfree_psword.jsp";


		


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


<!-- start content table-->


<form name="reqCBAForm" method="post" action="">


	<input type="hidden" name="id" value="SHU001">


	<input type="hidden" name="srvNo" value="001030">


	<input type="hidden" name="reqNum" value="<%=member01%>">


	<input type="hidden" name="retUrl" value="" />


</form>


<table width="745" border="0" cellpadding="0" cellspacing="0">


  <tr>


    <td id="content"><!-- include start -->


        <table cellpadding="0" cellspacing="0" border="0" width="745" id="text_content">


          <tr>


            <td width="23"  id="bullet02"></td>


            <td width="722" id="titleImg01"><img src="images/pcST050301_01.gif" vspace="6" /></td>


          </tr>


          <tr>


            <td colspan="2" style="padding-top:12px;"><img src="images/pcST050301_02.gif" width="745" height="120" alt="" /></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg02"><img src="images/pcST050301_03.gif" /></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg03"><p>�Ű��� : ���� ����</p>


                <p>�Ű��� : ���� ����</p>


              <p>�Ű�ó��<br />


                * �̹� ���� �Ǵ� �˻� ������ ���׿� ���� �Ű�� �Ű�� ó������ �ƴ��Ѵ�.<br />


                * �Ű� ������ �ߺ��� ������ ������ �Ű� ���ϰ� ���� �Ű�� ó���Ѵ�.</p></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg02"><img src="images/pcST050301_04.gif" /></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg03"><p>������ ���Ϸ��� ����ϴ� ����</p>


                <p>������ ����� ����ϴ� ����</p>


              <p>����� ������ ��������� ����ϴ� ����</p>


              <p>�����ҿ� �Ǹ��ϴ� ����</p>


              <p>�ٸ� ��� ��� �鼼�� �Ǵ� ������ü��� �ѱ�� ���� ��</p></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg02"><img src="images/pcST050301_05.gif" /></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg03"><p>���ޱ��� : �Ű��ڿ� ���� ������ ������ ��������� Ȯ���� ��쿡 ����.��, �͸� ���� �Ű� ���Ͽ��� �������� �ƴ���.</p>


                <p>����� ���� : 200,000�� ~ 1,000,000��</p></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg02"><img src="images/pcST050301_06.gif" /></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg03"><p>�������� �Ű��ڿ� ���� ����� ��ȣ�ǿ��� �Ű�� �Ǹ����� �Ͻñ� �ٶ��ϴ�.</p>


                <p>�������� �� �鼼�� ������ ����, �Ҹ� �� ������ �����ڹο�â������ �̿��Ͽ� �ֽñ� �ٶ��, 


                  �̷� ���� �������� �Ű�� �� �� ������ �˷��帮���� ���� �ٶ��ϴ�.</p></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg02"><img src="images/pcST050301_07.gif" /></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg03"><p>�����ȣ : ����� ���ı� ��õ�� 11-6 �����߾�ȸ ��������(�� 138-730)</p>


                <p>��ȭ��ȣ : 02)2240-3221~2</p>


              <p>�ѽ���ȣ : 02)2240-3041 </p></td>


          </tr>


          <tr>


            <td colspan="2" align="center" style="padding:25px 0 15px 0;"><img src="images/pcST050301_08.gif" alt=""/><br />


              <a href="javascript:openCBAWindow();"><img src="images/pcST050201_14.gif" alt="�ۿø���" vspace="10" border="0" /></a> <a href="javascript:openCBAWindow1();"> <img src="images/pcST050201_15.gif" alt="�Ű�����ȸ" vspace="10" border="0" /></a> </td>


          </tr>


        </table>


      <!-- include end -->    </td>


  </tr>


</table>


<!-- end content table-->


</body>


</html>