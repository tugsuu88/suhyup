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


<title>���� - �ٴٻ�� �������</title>


<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />


<link rel='stylesheet' type='text/css' media='all' href='../css/main.css' />


<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />


<script type="text/javascript" src="../js/quickMenu.js"></script>


<script type="text/javascript" src="../js/public.js"></script>


<script type="text/javascript">


<!--


	var CBA_window;





	function openCBAWindow() {


		document.reqCBAForm.retUrl.value = "http://www.suhyup.co.kr/minwon/shingo_test_write.jsp";


		


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


		document.reqCBAForm.retUrl.value = "http://www.suhyup.co.kr/minwon/shingo_test_psword.jsp";


		


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


		document.reqCBAForm.retUrl.value = "http://www.suhyup.co.kr/minwon/absurd_write.jsp";


		


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


		document.reqCBAForm.retUrl.value = "http://www.suhyup.co.kr/minwon/absurd_psword.jsp";


		


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


<table cellpadding="0" cellspacing="0" border="0">


  <tr>


    <td id="content"><!-- include start -->


        <table cellpadding="0" cellspacing="0" border="0" width="745" id="text_content">


          <tr>


            <td  id="bullet02"></td>


            <td id="titleImg01"><img src="images/pcST050201_01.gif" vspace="6" /></td>


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


            <td id="titleImg03"><p>�����ּ� : ����� ���ı� ��õ�� 11-6 �����߾�ȸ �����(�� 138-730)</p>


                <p>�� ȭ (��): 02) 2240-3387, 3397</p>


              <p>FAX : 02) 2240-3076</p></td>


          </tr>


          <tr>


            <td colspan="2" align="center" style="padding:25px 0 15px 0;"><img src="images/pcST050201_11.gif" alt=""/><br />


              <a href="javascript:openCBAWindow();"><img src="images/pcST050201_14.gif" alt="�ۿø���" vspace="10" border="0" /></a> <a href="javascript:openCBAWindow1();"> <img src="images/pcST050201_15.gif" alt="�Ű�������ȸ" vspace="10" border="0" /></a> </td>


          </tr>


          <tr>


            <td  id="bullet02"></td>


            <td id="titleImg01"><img src="images/pcST050201_06.gif" vspace="6" /></td>


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


                <p>�Ű���� : ���� ������</p></td>


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


            <td colspan="2" style="padding:10px;"><table cellspacing="0">


                <tr>


                  <td style="padding:10px; background-color:#f2f2f2;">���⿡ �Ű��Ǵ� ������ ��ȸ ����ǿ����� ������ �� �����Ƿ� �Ű��� �� �Ű����뿡 ���Ͽ��� ���� ����� ����Ǹ�, 


                    ������ ������ ���� ó���� �� ȸ���� �����帳�ϴ�. �Ű� �Ͻ� ������ �Ǹ��� ��Ģ���� �ϹǷ� �� ��ϻ����� ��Ȯ�� �Է��Ͽ� 


                    �ֽñ� �ٶ��, �͸� �� ���� �ּ��� ��쿡�� ���뿡 ������� �������� �˷��帳�ϴ�.</td>


                </tr>


            </table></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg02"><img src="images/pcST050201_10.gif" /></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg03"><p>�����ּ� : ����� ���ı� ��õ�� 11-6 �����߾�ȸ ����� (��138-730)</p>


                <p>�� ȭ(��): 02) 2240-3385, 3390, 3392</p>


              <p>FAX : 02) 2240-3076</p></td>


          </tr>


          <tr>


            <td colspan="2" align="center" style="padding:25px 0 15px 0;"><img src="images/pcST050201_13.gif" alt=""/><br />


              <a href="javascript:openCBAWindow2();"><img src="images/pcST050201_14.gif" alt="" vspace="10" border="0" /></a> <a href="javascript:openCBAWindow3();"> <img src="images/pcST050201_15.gif" alt="�Ű�������ȸ" vspace="10" border="0" /></a> </td>


          </tr>


        </table>


      <!-- include end -->    </td>


  </tr>


</table>


<!-- start content table-->


<form name="reqCBAForm" method="post" action="">


	<input type="hidden" name="id" value="SHU001">


	<input type="hidden" name="srvNo" value="001029">


	<input type="hidden" name="reqNum" value="<%=member01%>">


	<input type="hidden" name="retUrl" value="" />


</form>





</form>


<!-- end content table-->


</body>


</html>