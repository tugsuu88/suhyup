<%@ page language="java" import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*"%>

<%@ page contentType="text/html;charset=euc-kr" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="../inc/requestSecurity.jsp" %>

<%

		String vDiscrNo = Converter.nullchk(request.getParameter("vDiscrNo"));

	    String name = request.getParameter("name");

		if(name == null) name="";

		String sh_post_1 = request.getParameter("sh_post_1");

		if(sh_post_1 == null) sh_post_1="";

		String sh_post_2 = request.getParameter("sh_post_2");

		if(sh_post_2 == null) sh_post_2="";

		String sh_address_1 = request.getParameter("sh_address_1");

		if(sh_address_1 == null) sh_address_1="";

		String sh_address_2 = request.getParameter("sh_address_2");

		if(sh_address_2 == null) sh_address_2="";

		String sh_tel_1 = request.getParameter("sh_tel_1");

		if(sh_tel_1 == null) sh_tel_1="";

		String sh_tel_2 = request.getParameter("sh_tel_2");

		if(sh_tel_2 == null) sh_tel_2="";

		String sh_tel_3 = request.getParameter("sh_tel_3");

		if(sh_tel_3 == null) sh_tel_3="";

		String sh_han_1 = request.getParameter("sh_han_1");

		if(sh_han_1 == null) sh_han_1="";

		String sh_han_2 = request.getParameter("sh_han_2");

		if(sh_han_2 == null) sh_han_2="";

		String sh_han_3 = request.getParameter("sh_han_3");

		if(sh_han_3 == null) sh_han_3="";

		String sh_email_1 = request.getParameter("sh_email_1");

		if(sh_email_1 == null) sh_email_1="";

		String sh_email_2 = request.getParameter("sh_email_2");

		if(sh_email_2 == null) sh_email_2="";

		String sh_cata = request.getParameter("sh_cata");

		if(sh_cata == null) sh_cata="";

		String psword = request.getParameter("psword");

		if(psword == null) psword="";



%>

<% String pageNum = "5"; %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>

<title>���� - �ٴٻ�� �����</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/minwon.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />

<script type="text/javascript" src="../js/quickMenu.js"></script>

<!--/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************/-->

<!-- <SCRIPT SRC="http://www.suhyup.co.kr/djemals/js/ax_wdigm/default.js"></SCRIPT> -->

<!--/********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/-->

<script type="text/javascript" src="../js/public.js"></script>

<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript">

<!--

	//��� ���� ���� üũ

	function GoReg() {

			var mText  = document.pbform.contents.value;



			if (pbform.sh_title.value.length == 0) {alert("������ �Է��� �ֽʽÿ�"); pbform.sh_title.focus(); return;}



			// Ư������ üũ: + ; ( ) - �� ����

			var keyword = pbform.sh_title.value;

			//var keyword_sp_char = "~`!@#$%^&*_=|\\<,>.?/{}[]:\"'";

			var keyword_sp_char = "`@#$%^&*=|\\<,>:\'";

			if(CheckSpecialChar(keyword, keyword_sp_char) == false)

			{

				alert("Ư������(" + keyword_sp_char + ")�� �Է��Ͻ� �� �����ϴ�.");

				pbform.sh_title.focus();

				return;

			}



			if(keyword.length >= 101){

				alert("������ ���ڼ��� �ʰ��Ͽ����ϴ�. 100���̳��� �ۼ��Ͽ��ּ���.");

				pbform.sh_title.focus();

				return;

			}



			if (pbform.contents.value.length == 0) {alert("������ �Է��� �ֽʽÿ�"); pbform.contents.focus(); return;}



			if(pbform.contents.value.length >= 2001){

				alert("������ ���ڼ��� �ʰ��Ͽ����ϴ�. 2000���̳��� �ۼ��Ͽ��ּ���.");

				pbform.contents.focus();

				return;

			}



			var istrue = uploadFile_Change(pbform.file1.value);

			if(!istrue){

				return;

			}



			var src = getFileExtension(pbform.file1.value);

						/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************

			try{

				if(UsingRemote == true){

					if(!beScan('',mText,'')){

					return;

					}

				}

			}

			catch (e){

				var objRtn = objAX.beScanner(policy, '','', this.location, mText, '');

				if(objRtn == 0){

					return;

				}else{

					return;

				}

			}

			********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/

			pbform.action = "minwon_proc_my.jsp";

			pbform.encoding="multipart/form-data";

			pbform.submit();

	}

		//������ ���� �� ��Ŀ�� �̵��� ȣ��

	function uploadFile_Change( value ){

    	var src = getFileExtension(value);

    	if (src == "") {

        	//alert("�ùٸ� ������ �Է��ϼ���");

        	return true;

    	}else if( !((src.toLowerCase() == "hwp") || (src.toLowerCase() == "ppt") || (src.toLowerCase() == "xls")|| (src.toLowerCase() == "gul")||(src.toLowerCase() == "doc")||(src.toLowerCase() == "txt")||(src.toLowerCase() == "pdf")) ){

        	alert("hwp �� ppt, xls, gul, doc, txt, pdf ���ϸ� ÷�� �����մϴ�.");

			pbform.file1.value = "";

        	//document.form1.afile.value = "";

        	//form1.afile.focus();

        	return false;

    	}

	}





	//������ Ȯ���ڸ� ������

	function getFileExtension( filePath ){

    	var lastIndex = -1;

    	lastIndex = filePath.lastIndexOf('.');

    	var extension = "";



		if ( lastIndex != -1 ){

    		extension = filePath.substring( lastIndex+1, filePath.len );

		} else {

    		extension = "";

		}

    	return extension;

	}

//-->

</script>

</head>

<body id="minwon01">

<%@ include file="/include/shHeader.jsp" %>

<form name="pbform" method="post" enctype="" action="">

	<input type="hidden" name="name" value="<%=name%>" />

	<input type="hidden" name="sh_post_1" value="<%=sh_post_1%>">

	<input type="hidden" name="sh_post_2" value="<%=sh_post_2%>">

	<input type="hidden" name="sh_address_1" value="<%=sh_address_1%>">

	<input type="hidden" name="sh_address_2" value="<%=sh_address_2%>">

	<input type="hidden" name="sh_tel_1" value="<%=sh_tel_1%>">

	<input type="hidden" name="sh_tel_2" value="<%=sh_tel_2%>">

	<input type="hidden" name="sh_tel_3" value="<%=sh_tel_3%>">

	<input type="hidden" name="sh_han_1" value="<%=sh_han_1%>">

	<input type="hidden" name="sh_han_2" value="<%=sh_han_2%>">

	<input type="hidden" name="sh_han_3" value="<%=sh_han_3%>">

	<input type="hidden" name="sh_email_1" value="<%=sh_email_1%>">

	<input type="hidden" name="sh_email_2" value="<%=sh_email_2%>">

	<input type="hidden" name="sh_cata" value="<%=sh_cata%>">

	<input type="hidden" name="psword" value="<%=psword%>">

	<input type="hidden" name="vDiscrNo" value="<%=vDiscrNo%>">



<!-- start content table-->

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

          <td><a href="join_list.jsp"><img src="../member/images/sc_bt_off_11.gif" width="190" height="21" border="0" /></a></td>

        </tr>



	<tr>

		<td><a href="../minwon/minwon_apply03_my.jsp"><img src="../member/images/sc_bt_on_13.gif" width="190" height="21" /></a></td>

	</tr>

	<tr>

		<td height="3"></td>

	</tr>

	<tr>

		<td><a href="../minwon/minwon_apply03_my.jsp"><img src="../member/images/sc_bt_on_13_01.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td><a href="../minwon/shingo_001_my.jsp"><img src="../member/images/sc_bt_off_13_02.gif" width="190" height="18" /></a></td>

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

                <td id="navigator"><a href="/">Home</a> &gt; <a href="../minwon/minwon_apply03_my.jsp">���ڹο�/���нŰ�</a>

                  > ���ڹο�â��</td>

              </tr>

              <tr>

                <td id="title"><img src="../images/pcTitle050101.gif" /></td>

              </tr>

              <tr>

                <td id="content">

                  <!-- �������� ���� -->

                  <table width="200" border="0" cellspacing="0" cellpadding="0">

                    <tr>

                      <td height="80" valign="top"> <img src="images/minwon_topimg.gif" width="745" height="60" /></td>

                    </tr>

                  </table>

                  <table cellpadding="0" cellspacing="0" class="writeTable">

                    <tr>

                      <td class="lineLeft"><span>����</span></td>

                      <td class="lineRight">

                        <input type="text" name="sh_title" class="typeText subject" value="" />

                      </td>

                    </tr>

                    <tr>

                      <td class="title">����</td>

                      <td class="cols02">

                        <textarea name="contents"  value="" cols="25" rows="14" class="typeText content" wrap="virtual"></textarea>

                      </td>

                    </tr>

                    <tr>

                      <td class="title">����</td>

                      <td class="cols02">

					  <input type="file" class="typeText file" size="70" name="file1" value="" />

					  <br />

                        (��hwp �� ppt, xls, gul, doc, txt, pdf ���ϸ� ÷�� �����մϴ�. �����̸��� ������ �����ϸ� ���������� �Է��� �ֽʽÿ�.) </td>

                    </tr>

                  </table>

                  <!-- button table start -->

                  <table cellspacing="0" class="button">

                    <tr>

                      <td> <a href="javascript:GoReg();"><img src="../pub_img/btminwon_ok.gif" title="�ο���û��ư" width="68" height="18" /></a><a href="javascript:pbform.reset();"><img src="../pub_img/btminwon_cancle.gif" title="�ٽ��Է¹�ư" width="68" height="18" /></a>

                      </td>

                    </tr>

                  </table>

                  <!-- button table end -->

                  <!-- �������� ��-->

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

</form>

<%@ include file="/include/shFooter.jsp" %>

</body>

</html>