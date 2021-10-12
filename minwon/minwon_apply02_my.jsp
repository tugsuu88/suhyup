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

<title>수협 - 바다사랑 고객사랑</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/minwon.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />

<script type="text/javascript" src="../js/quickMenu.js"></script>

<!--/********************************************위너다임 작업 시작 2008.03.13****************************************************/-->

<!-- <SCRIPT SRC="http://www.suhyup.co.kr/djemals/js/ax_wdigm/default.js"></SCRIPT> -->

<!--/********************************************위너다임 작업 끝 2008.03.13******************************************************/-->

<script type="text/javascript" src="../js/public.js"></script>

<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript">

<!--

	//약관 동의 여부 체크

	function GoReg() {

			var mText  = document.pbform.contents.value;



			if (pbform.sh_title.value.length == 0) {alert("제목을 입력해 주십시오"); pbform.sh_title.focus(); return;}



			// 특수문자 체크: + ; ( ) - 는 가능

			var keyword = pbform.sh_title.value;

			//var keyword_sp_char = "~`!@#$%^&*_=|\\<,>.?/{}[]:\"'";

			var keyword_sp_char = "`@#$%^&*=|\\<,>:\'";

			if(CheckSpecialChar(keyword, keyword_sp_char) == false)

			{

				alert("특수문자(" + keyword_sp_char + ")를 입력하실 수 없습니다.");

				pbform.sh_title.focus();

				return;

			}



			if(keyword.length >= 101){

				alert("제목의 글자수가 초과하였습니다. 100자이내로 작성하여주세요.");

				pbform.sh_title.focus();

				return;

			}



			if (pbform.contents.value.length == 0) {alert("내용을 입력해 주십시오"); pbform.contents.focus(); return;}



			if(pbform.contents.value.length >= 2001){

				alert("내용의 글자수가 초과하였습니다. 2000자이내로 작성하여주세요.");

				pbform.contents.focus();

				return;

			}



			var istrue = uploadFile_Change(pbform.file1.value);

			if(!istrue){

				return;

			}



			var src = getFileExtension(pbform.file1.value);

						/********************************************위너다임 작업 시작 2008.03.13****************************************************

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

			********************************************위너다임 작업 끝 2008.03.13******************************************************/

			pbform.action = "minwon_proc_my.jsp";

			pbform.encoding="multipart/form-data";

			pbform.submit();

	}

		//파일을 선택 후 포커스 이동시 호출

	function uploadFile_Change( value ){

    	var src = getFileExtension(value);

    	if (src == "") {

        	//alert("올바른 파일을 입력하세요");

        	return true;

    	}else if( !((src.toLowerCase() == "hwp") || (src.toLowerCase() == "ppt") || (src.toLowerCase() == "xls")|| (src.toLowerCase() == "gul")||(src.toLowerCase() == "doc")||(src.toLowerCase() == "txt")||(src.toLowerCase() == "pdf")) ){

        	alert("hwp 와 ppt, xls, gul, doc, txt, pdf 파일만 첨부 가능합니다.");

			pbform.file1.value = "";

        	//document.form1.afile.value = "";

        	//form1.afile.focus();

        	return false;

    	}

	}





	//파일의 확장자를 가져옮

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

                <td id="navigator"><a href="/">Home</a> &gt; <a href="../minwon/minwon_apply03_my.jsp">전자민원/부패신고</a>

                  > 전자민원창구</td>

              </tr>

              <tr>

                <td id="title"><img src="../images/pcTitle050101.gif" /></td>

              </tr>

              <tr>

                <td id="content">

                  <!-- 본문영역 시작 -->

                  <table width="200" border="0" cellspacing="0" cellpadding="0">

                    <tr>

                      <td height="80" valign="top"> <img src="images/minwon_topimg.gif" width="745" height="60" /></td>

                    </tr>

                  </table>

                  <table cellpadding="0" cellspacing="0" class="writeTable">

                    <tr>

                      <td class="lineLeft"><span>제목</span></td>

                      <td class="lineRight">

                        <input type="text" name="sh_title" class="typeText subject" value="" />

                      </td>

                    </tr>

                    <tr>

                      <td class="title">내용</td>

                      <td class="cols02">

                        <textarea name="contents"  value="" cols="25" rows="14" class="typeText content" wrap="virtual"></textarea>

                      </td>

                    </tr>

                    <tr>

                      <td class="title">파일</td>

                      <td class="cols02">

					  <input type="file" class="typeText file" size="70" name="file1" value="" />

					  <br />

                        (※hwp 와 ppt, xls, gul, doc, txt, pdf 파일만 첨부 가능합니다. 파일이름은 영문을 권장하며 띄워쓰기없이 입력해 주십시요.) </td>

                    </tr>

                  </table>

                  <!-- button table start -->

                  <table cellspacing="0" class="button">

                    <tr>

                      <td> <a href="javascript:GoReg();"><img src="../pub_img/btminwon_ok.gif" title="민원신청버튼" width="68" height="18" /></a><a href="javascript:pbform.reset();"><img src="../pub_img/btminwon_cancle.gif" title="다시입력버튼" width="68" height="18" /></a>

                      </td>

                    </tr>

                  </table>

                  <!-- button table end -->

                  <!-- 본문영역 끝-->

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