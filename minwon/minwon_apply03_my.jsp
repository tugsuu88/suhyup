<% String pageNum = "5"; %>

<%@ page contentType="text/html;charset=euc-kr" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>

<title>수협 - 바다사랑 고객사랑</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/minwon.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript" src="../js/public.js"></script>

<script type="text/javascript">

<!--

	

	function MM_openBrWindow(theURL,winName,features) { //v2.0

	  window.open(theURL,winName,features);

	}

	

	function GoReg() {

	

		var d = document.pbform;



		if (d.name.value.length == 0) {alert("성명을 입력해 주십시오"); d.name.focus(); return;}

		

		if (pbform.sh_han_1.value.length == 0){

			alert("휴대폰/전화번호를 입력해주십시요"); 

			d.sh_han_1.focus(); 

			return;

		}else if(pbform.sh_han_2.value.length == 0){

			alert("휴대폰/전화번호를 입력해주십시요"); 

			d.sh_han_2.focus(); 

			return;

		}else if(pbform.sh_han_3.value.length == 0){ 

			alert("휴대폰/전화번호를 입력해주십시요"); 

			d.sh_han_3.focus(); 

			return;

		}



		if (d.passwd.value.length == 0) {alert("비밀번호를 입력해 주십시오"); d.passwd.focus(); return;}



		pbform.submit();

	}

	function EnterCheck9() {

		if(event.keyCode == 13)		//익스플로러에서.

		{

			GoReg();

		} else {

			

		}

	}

//-->

</script>

</head>

<body id="minwon02">

<%@ include file="/include/shHeader.jsp" %>

<!-- start content table-->

<form name="pbform" method="post" action="../minwon/minwon_apply06_my.jsp">

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

                <td id="navigator"><a href="/">Home</a> &gt; 마이페이지 > <a href="../minwon/minwon_apply03_my.jsp">나의민원/신고</a> 

                  > 민원처리결과조회</td>

              </tr>

              <tr> 

                <td id="title"><img src="../images/pcTitle050102.gif" /></td>

              </tr>

              <tr> 

                <td id="content"> 

				 <!-- 본문영역 시작 -->

                  <table cellspacing="0" style="width:745px; background:url(images/result_bg_01.gif) no-repeat; border-bottom:2px solid #CFCFCF;">

                    <thead> 

                    <tr> 

                      <th style="width:130px; height:32px;">이름</th>

                      <td style="width:615px; padding-left:10px;"> 

                        <input type="text" onKeyDown="EnterCheck9();" class="typeText" name="name" value="" />

                      </td>

                    </tr>

                    </thead> <tbody> 

                    <tr> 

                      <th style="height:25px; background-color:#F4F4F4;">

							   <select name="telephone">

		                       <option value="휴대폰" >휴대폰</option>

							   <option value="전화번호" >전화번호</option>

						</select></th>

                      <td style="padding-left:10px;"> 

                        <input type="text" maxlength="3" name="sh_han_1" value="" class="typeText input_mini" />

                        <span class="sp_txt">-</span> 

                        <input type="text" maxlength="4" name="sh_han_2" value="" class="typeText input_mini" />

                        <span class="sp_txt">-</span> 

                        <input type="text" maxlength="4" name="sh_han_3" value="" class="typeText input_mini" />

                      </td>

                    </tr>

                    <tr> 

                      <th style="height:25px; background-color:#F4F4F4;">비밀번호</th>

                      <td style="padding-left:10px;"> 

                        <input type="password" onKeyDown="EnterCheck9();" class="typeText input_txt" name="passwd" value="" />

                        <a href="javascript:;" onClick="MM_openBrWindow('../minwon/minwon_psword_my.jsp','','width=360,height=260')"><img src="../pub_img/btminwon_searchpass.gif" width="85" height="20" align="absmiddle" border="0" title="비밀번호찾기버튼" /></a> 

                      </td>

                    </tr>

                    </tbody> 

                  </table>

                  <br/>

				   <!-- button table start -->

                  <table cellspacing="0" class="button">

                    <tr> 

                      <td><a href="javascript:GoReg()"><img src="../pub_img/btminwon_result.gif" title="조회버튼" width="68" height="18" /></a></td>

                    </tr>

                  </table>

				   <!-- button table end-->

                </td>

              </tr>

            </table>

            <br/>

            <br/>

            <br/>

            <br/>

            <br/>

            <br/>

            <br/>

            <br/>

            <br/>

			<!-- 본문영역 끝-->

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