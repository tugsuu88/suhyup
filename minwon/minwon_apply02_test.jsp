<%@ page language="java" import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*"%>

<%@ page contentType="text/html;charset=euc-kr" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="../inc/requestSecurity.jsp" %>

<%

		String vDiscrNo = Converter.nullchk(request.getParameter("vDiscrNo"));

	    String name = Converter.nullchk(request.getParameter("name"));

		if(name == null) name="";

		String sh_post_1 = Converter.nullchk(request.getParameter("sh_post_1"));

		if(sh_post_1 == null) sh_post_1="";

		String sh_post_2 = Converter.nullchk(request.getParameter("sh_post_2"));

		if(sh_post_2 == null) sh_post_2="";

		String sh_address_1 = Converter.nullchk(request.getParameter("sh_address_1"));

		if(sh_address_1 == null) sh_address_1="";

		String sh_address_2 = Converter.nullchk(request.getParameter("sh_address_2"));

		if(sh_address_2 == null) sh_address_2="";

		String sh_tel_1 = Converter.nullchk(request.getParameter("sh_tel_1"));

		if(sh_tel_1 == null) sh_tel_1="";

		String sh_tel_2 = Converter.nullchk(request.getParameter("sh_tel_2"));

		if(sh_tel_2 == null) sh_tel_2="";

		String sh_tel_3 = Converter.nullchk(request.getParameter("sh_tel_3"));

		if(sh_tel_3 == null) sh_tel_3="";

		String sh_han_1 = Converter.nullchk(request.getParameter("sh_han_1"));

		if(sh_han_1 == null) sh_han_1="";

		String sh_han_2 = Converter.nullchk(request.getParameter("sh_han_2"));

		if(sh_han_2 == null) sh_han_2="";

		String sh_han_3 = Converter.nullchk(request.getParameter("sh_han_3"));

		if(sh_han_3 == null) sh_han_3="";

		String sh_email_1 = Converter.nullchk(request.getParameter("sh_email_1"));

		if(sh_email_1 == null) sh_email_1="";

		String sh_email_2 = Converter.nullchk(request.getParameter("sh_email_2"));

		if(sh_email_2 == null) sh_email_2="";

		String sh_cata = Converter.nullchk(request.getParameter("sh_cata"));

		if(sh_cata == null) sh_cata="";

		String sh_reply_type = Converter.nullchk(request.getParameter("sh_reply_type")); //ȸ�Ź��

		if(sh_reply_type == null) sh_reply_type="";

		String psword = Converter.nullchk(request.getParameter("psword"));

		if(psword == null) psword="";
		
		//2014-08-19 ������� , ���� , ��󿵾��� �߰� 
		String Year =Converter.nullchk(request.getParameter("Year"));
		
		if(Year == null) Year="";
		
		String Month =Converter.nullchk(request.getParameter("Month"));
		
		if(Month == null) Month="";
		
		String Day =Converter.nullchk(request.getParameter("Day"));
		
		if(Day == null) Day="";
		
		String sh_center =Converter.nullchk(request.getParameter("sh_center"));
		
		if(sh_center == null) sh_center="";
		
		String self_text =Converter.nullchk(request.getParameter("self_text"));
		
		if(self_text == null) self_text="";
		



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

<!--[if IE 7]><link rel="stylesheet" type="text/css" href="../css/footer.css"     /><![endif]-->

<!--[if IE 8]><link rel="stylesheet" type="text/css" href="../css/footer_IE8.css" /><![endif]-->

<!--/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************/-->

<SCRIPT SRC="http://www.suhyup.co.kr/supervisor/js/ax_wdigm/default.js"></SCRIPT>

<!--/********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/-->

<script type="text/javascript" src="../js/public.js"></script>

<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript">

<!--

	//��� ���� ���� üũ

	function GoReg() {

			var mText  = document.pbform.contents.value;

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

			if(istrue == false){

				return;

			}



			var src = getFileExtension(pbform.file1.value);



			alert('������ ������ �ǰ� ����帮��, �ο� �����Ϸκ��� 6������ �̳��� �亯 �帮���� �ϰڽ��ϴ�.');

			pbform.action = "minwon_proc_test.jsp";

			pbform.encoding="multipart/form-data";

			pbform.submit();

	}

		//������ ���� �� ��Ŀ�� �̵��� ȣ��

	function uploadFile_Change( value ){

    	var src = getFileExtension(value);

    	if (src == "") {

        	//alert("�ùٸ� ������ �Է��ϼ���");

        	return true;

    	}else if( !((src.toLowerCase() == "hwp") || (src.toLowerCase() == "ppt") || (src.toLowerCase() == "xls")|| (src.toLowerCase() == "gul")||(src.toLowerCase() == "doc")||(src.toLowerCase() == "txt")||(src.toLowerCase() == "pdf") || (src.toLowerCase() == "jpg") || (src.toLowerCase() == "gif") || (src.toLowerCase() == "bmp")) ){

        	alert("hwp �� ppt, xls, gul, doc, txt, pdf, jpg, gif, bmp ���ϸ� ÷�� �����մϴ�.");

			pbform.file1.value = "";

        	//document.form1.afile.value = "";

        	//form1.afile.focus();

			//pbform.file1.focus();

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

	<input type="hidden" name="sh_reply_type" value="<%=sh_reply_type%>">
	
	<!--2014-8-19 �������,���� , ��󿵾� �߰�  -->
	<input type="hidden" name="Year" value="<%=Year%>">

	<input type="hidden" name="Month" value="<%=Month%>">
	
	<input type="hidden" name="Day" value="<%=Day%>">
	
	<input type="hidden" name="sh_center" value="<%=sh_center%>">
	
	<input type="hidden" name="self_text" value="<%=self_text%>">



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

		<td><img src="images/sc_bt_on_01.gif" alt="���ڹο�â��" /></td>

	</tr>

  	<tr>

		<td height="3"></td>

	</tr>

	<tr>

		<td><a href="minwon_03.jsp"><img src="images/sc_bt_off_013.gif" /></a></td>

	</tr>

	<tr>

		<td><a href="minwon_001.jsp"><img src="images/sc_bt_on_011.gif" alt="�ο���û"/></a></td>

	</tr>

	<tr>

		<td><a href="minwon_apply03.jsp"><img src="images/sc_bt_off_012.gif" alt="�ο�ó�������ȸ" /></a></td>

	</tr>

	<tr>

		<td><a href="minwon_result.jsp"><img src="images/sc_bt_off_014.gif" alt="�ο�ó���������" /></a></td>

	</tr>

	<tr>

		<td height="15"></td>

	</tr>

	<tr>

		<td><a href="shingo_001.jsp"><img src="images/sc_bt_off_02.gif" alt="�������Ű�" /></a></td>

	</tr>

	<tr>

		<td><a href="taxfree.jsp"><img src="images/sc_bt_off_03.gif" alt="�鼼����������Ű�" /></a></td>

	</tr>

		  <tr>

		  <td><a href="corruption.jsp"><img src="images/sc_bt_off_04.gif" alt="��㼾��" border="0" /></a></td>

	</tr>
	<tr>
		  <td><a href="budget.jsp"><img src="images/sc_bt_off_05.gif" alt="���곶��Ű���" border="0" /></a></td>
	</tr>
	<tr>
		<td><a href="shingo_004.jsp"><img src="images/sc_bt_off_06.gif" alt="���ͽŰ����� �ȳ�" border="0" /></a></td>
	</tr>
	</table>

    </td>

    <td id="primaryContent" valign="top">

      <table cellpadding="0" cellspacing="0">

        <tr>

          <td >

            <table cellpadding="0" cellspacing="0" border="0">

              <tr>

                <td id="navigator"><a href="/">Home</a> &gt; <a href="minwon_test1.jsp">���ڹο�</a>

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

                        �ع������� : hwp, ppt, xls, gul, doc, txt, pdf  ���ϸ� ÷�� �����մϴ�.<br />

                        ���̹������� : jpg, gif, bmp ���ϸ� ÷�� �����մϴ�. <br />

                        �������̸��� ������ �����ϸ� ���������� �Է��� �ֽʽÿ�.</td>

                    </tr>

                  </table>

                  <!-- button table start -->

                  <table cellspacing="0" class="button">

                    <tr>

                      <td> <a href="javascript:GoReg();"><img src="../pub_img/btminwon_ok.gif" title="�ο���û��ư" width="68" height="18" /></a>

                      <a href="javascript:pbform.reset();"><img src="../pub_img/btminwon_cancel.gif" title="�ٽ��Է¹�ư" width="68" height="18" /></a>

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



      </table>

    </td>

  </tr>

</table>

    </td>

  </tr>

</table>

</div><!-- end content table-->

</form>

<%@ include file="/include/shFooter.jsp" %>

</body>

</html>