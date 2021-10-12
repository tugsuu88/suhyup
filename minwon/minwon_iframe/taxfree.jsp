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


            <td id="titleImg03"><p>신고자 : 제한 없음</p>


                <p>신고대상 : 제한 없음</p>


              <p>신고처리<br />


                * 이미 조사 또는 검사 착수한 사항에 관한 신고는 신고로 처리하지 아니한다.<br />


                * 신고 내용이 중복될 때에는 선순위 신고에 의하고 동시 신고로 처리한다.</p></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg02"><img src="images/pcST050301_04.gif" /></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg03"><p>가정용 보일러에 사용하는 행위</p>


                <p>차량용 연료로 사용하는 행위</p>


              <p>양식장 관리사 난방용으로 사용하는 행위</p>


              <p>주유소에 판매하는 행위</p>


              <p>다른 어민 등에게 면세유 또는 출고지시서를 넘기는 행위 등</p></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg02"><img src="images/pcST050301_05.gif" /></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg03"><p>지급기준 : 신고자에 의해 접수된 내용이 부정유통로 확정될 경우에 한함.단, 익명에 의한 신고에 대하여는 지급하지 아니함.</p>


                <p>보상금 지급 : 200,000원 ~ 1,000,000원</p></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg02"><img src="images/pcST050301_06.gif" /></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg03"><p>부정유통 신고자에 대한 비밀은 보호되오니 신고시 실명으로 하시기 바랍니다.</p>


                <p>업무질의 및 면세유 공급의 진정, 불만 등 사항은 「전자민원창구」를 이용하여 주시기 바라며, 


                  이런 경우는 부정유통 신고로 볼 수 없음을 알려드리오니 양해 바랍니다.</p></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg02"><img src="images/pcST050301_07.gif" /></td>


          </tr>


          <tr>


            <td></td>


            <td id="titleImg03"><p>우편번호 : 서울시 송파구 신천동 11-6 수협중앙회 자재사업부(우 138-730)</p>


                <p>전화번호 : 02)2240-3221~2</p>


              <p>팩스번호 : 02)2240-3041 </p></td>


          </tr>


          <tr>


            <td colspan="2" align="center" style="padding:25px 0 15px 0;"><img src="images/pcST050301_08.gif" alt=""/><br />


              <a href="javascript:openCBAWindow();"><img src="images/pcST050201_14.gif" alt="글올리기" vspace="10" border="0" /></a> <a href="javascript:openCBAWindow1();"> <img src="images/pcST050201_15.gif" alt="신고내용조회" vspace="10" border="0" /></a> </td>


          </tr>


        </table>


      <!-- include end -->    </td>


  </tr>


</table>


<!-- end content table-->


</body>


</html>