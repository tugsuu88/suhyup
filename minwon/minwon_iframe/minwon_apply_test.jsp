<%@ page language="java" import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*"%>

<%@ page contentType="text/html;charset=euc-kr" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="../inc/requestSecurity.jsp" %>

<%

	//2008-01-25 : 가상식별 실명인증 결과값

	String retInfo = Converter.nullchk(request.getParameter("retInfo")).trim();

	// 암호화 모듈 (jar)

    com.sci.vname.secu.aes.SciPacketConversion sciSecu = new com.sci.vname.secu.aes.SciPacketConversion();



    com.sci.vname.secu.SciSecuManager sciSecuMg = new com.sci.vname.secu.SciSecuManager();



    com.sci.vname.secu.hmac.SciHmac hmac     = new com.sci.vname.secu.hmac.SciHmac();



    StringBuffer retInfoTemp    = new StringBuffer("");



    retInfoTemp = sciSecu.RecvWritePacket(retInfo);

    retInfo = retInfoTemp.toString();



    int info1 = retInfo.indexOf("/",0);

    int info2 = retInfo.indexOf("/",info1+1);

    int info3 = retInfo.indexOf("/",info2+1);

    int info4 = retInfo.indexOf("/",info3+1);

	int info5 = retInfo.indexOf("/",info4+1);

    int info6 = retInfo.indexOf("/",info5+1);



	String reqNum     = retInfo.substring(0,info1);

    String vDiscrNo   = retInfo.substring(info1+1,info2);

    String name       = retInfo.substring(info2+1,info3);

    String result     = retInfo.substring(info3+1,info4);

    String discrHash  = retInfo.substring(info4+1,info5);

    String msg        = retInfo.substring(info5+1,info6);

%>

<% String pageNum = "5"; %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>

<title>수협 - 바다사랑 고객사랑</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/main.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/member.css' />

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript" src="../js/public.js"></script>

<script type="text/javascript" src="../js/common.js"></script>

<script type="text/javascript">

<!--

	//약관 동의 여부 체크

	function GoReg() {

	

		if (document.all.agree.checked == true){

			var d = document.pbform;



			if (d.name.value.length == 0) {alert("성명을 입력해 주십시오"); d.name.focus(); return;}



			if (pbform.sh_post_1.value.length == 0 || pbform.sh_post_2.value.length == 0){

				alert("주소가 입력되지 않았습니다."); 

				return;

			}else if(pbform.sh_address_1.value.length == 0 || pbform.sh_address_2.value.length == 0  ){

				alert("주소가 입력되지 않았습니다."); d.sh_address_2.focus(); return;

			}



			if (pbform.sh_tel_1.value.length == 0){

				alert("전화번호가 입력되지 않았습니다."); 

				d.sh_tel_1.focus();

				return;

			}else if(pbform.sh_tel_2.value.length == 0){

				alert("전화번호가 입력되지 않았습니다."); 

				d.sh_tel_2.focus(); 

				return;

			}else if(pbform.sh_tel_3.value.length == 0){

				alert("전화번호가 입력되지 않았습니다."); 

				d.sh_tel_3.focus(); 

				return;

			}



			if (pbform.sh_han_1.value.length == 0){

				alert("핸드폰번호가 입력되지 않았습니다."); 

				d.sh_han_1.focus(); 

				return;

			}else if(pbform.sh_han_2.value.length == 0){

				alert("핸드폰번호가 입력되지 않았습니다."); 

				d.sh_han_2.focus(); 

				return;

			}else if(pbform.sh_han_3.value.length == 0){ 

				alert("핸드폰번호가 입력되지 않았습니다."); 

				d.sh_han_3.focus(); 

				return;

			}

			if(pbform.sh_email_1.value !== ""){

			//선택했을때 검사

				if(!chkEmail2(pbform.sh_email_1,pbform.sh_email_2))  return;

			}else if(pbform.sh_email_3.value !== ""){

				//직접입력시 검사

				if(!chkEmail2(pbform.sh_email_3,pbform.sh_email_4))  return;

			}else{

				if (!isInput(pbform.sh_email_1,"메일을 입력해 주세요")){ 	return; }

				else if(!isInput(pbform.sh_email_3,"메일을 입력해 주세요")){	return;}

			}			

		

			if (d.psword.value.length == 0) {alert("패스워드를 입력해 주십시오"); d.psword.focus(); return;}

			if(!chkPWD(d.psword)) return;

			

			if(d.sh_cata.value == 'cho') {

				alert("분야를 선택해 주십시오");

				d.sh_cata.focus();

				return;

			}

			//select_change();

			pbform.action = "minwon_apply_test02.jsp";

			pbform.submit();



		}else {

			alert("약관에 동의하셔야 민원신청이 가능합니다");

		}

	

	}



	//우편번호 검색

	function ZipSearch(){

		var wint = (screen.height - 350) / 2;

		var winl = (screen.width - 400) / 2;

		winprops = 'height=402,width=383,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'

		winurl = 'find_addr.jsp?return1=pbform.sh_post_1&amp;return2=pbform.sh_post_2&amp;return3=pbform.sh_address_1';

		win = window.open(winurl, "zipsearch", winprops)

	}

	

	//검색 우편번호 세팅

	function input_zipcode(zip1,zip2,address){

		var frm = document.pbform;

		//alert(zip1)

		frm.sh_post_1.value = zip1;

		frm.sh_post_2.value = zip2;

		frm.sh_address_1.value = address;

		frm.sh_address_2.focus();

	}

	// 사용자가 이메일 도메인에 이벤트를 가했을때

	function mail_change() {

		var A = document.pbform;

		

		// 밑에 직접 입력란을 활성화 시켜준다.

		if(A.sh_email_3.value == 'etc') {

			A.sh_email_2.value = '';			

		} else {

			A.sh_email_2.value = A.sh_email_3.value;			

		}

	}



	/*

		function select_change() {

		var A = document.pbform;

	

		if(A.sh_cata.value == 'cho') {

			alert("분야를 선택해 주십시오");

			d.sh_cata.focus();

			return;

		}

		

	}

*/



//-->

</script>

</head>

<body id="minwon01"> 

<!-- start content table-->

<form name="pbform" method="post" action="">

<input type="hidden" name="vDiscrNo" value="<%=vDiscrNo%>">

<table width="745" cellpadding="0" cellspacing="0">

  <tr>

    <td width="835"><!-- 개인정보제공 동의서 시작 -->

        <table cellspacing="0" style="width:745px; border:1px solid #E9E9E9; background-color:#F8F8F7;">

          <tr>

            <td style="padding-left:10px; padding-top:10px;"><b><font color="#0033CC">:: 

              개인정보제공 및 활용 동의서 ::</font></b></td>

          </tr>

          <tr>

            <td style="padding:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="10px" style="border:1px solid #E9E9E9; background-color:#FFFFFF;">

                <tr>

                  <td><!-- 약관 내용 시작 -->

                    귀하가 제출한 민원의 사실 확인을 위하여 민원내용 및 귀하의 개인정보를 본회에 제공 및 활용하는 것에 대해 동의하는지 여부를 표시하여 주시기 바랍니다. <br />

                    만일 귀하가 본회의 민원처리절차에 동의하지 않아 사실 확인을 할 수 없는 경우에는 귀하의 

                    민원처리를 종결할 수 있음을 알려드립니다.

                    <!-- 약관 내용 끝 -->

                  </td>

                </tr>

            </table></td>

          </tr>

          <!-- 체크 버튼 -->

          <tr>

            <td style="padding-left:10px; padding-bottom:10px;"><input type="checkbox" name="agree" value="ok" />

              위에 내용에 동의합니다.</td>

          </tr>

        </table>

      <br />

        <!-- 개인정보제공 동의서 끝 -->

        <!-- 민원신청 입력 창 시작 -->

        <table cellspacing="0" class="join_form">

          <caption class="basic">

            :: 민원 결과 조회 확인시 꼭 필요한 사항으로 *표시가 

            되어있는 항목은 반드시 정확하게 입력해 주세요 ::

          </caption>

          <tr>

            <th class="essential">이름</th>

            <td><input type="text" class="typeText" name="name" onkeydown="" value="<%=name%>" />

              ( 이름은 실명으로 공백없이 입력하세요.) </td>

          </tr>

          <tr>

            <th class="essential">주소</th>

            <td><input type="text" size="4" name="sh_post_1" value="" readonly="readonly" class="typeText input_mini" />

                <span class="sp_txt">-</span>

                <input type="text" size="4" name="sh_post_2" value="" readonly="readonly" class="typeText input_mini" />

                <a href="javascript:ZipSearch();"><img src="../pub_img/mb_bt_addr.gif" title="주소찾기" /></a> <br />

                <input type="text" name="sh_address_1" readonly="readonly" value="" class="typeText input_addr_01"/>

              <br />

                <input type="text" name="sh_address_2" value="" class="typeText input_addr_02" />

            </td>

          </tr>

          <tr>

            <th class="essential">전화번호</th>

            <td><input type="text" maxlength="3" name="sh_tel_1" value="" class="typeText input_mini" />

                <span class="sp_txt">-</span>

                <input type="text" maxlength="4" name="sh_tel_2" value="" class="typeText input_mini" />

                <span class="sp_txt">-</span>

                <input type="text" maxlength="4" name="sh_tel_3" value="" class="typeText input_mini" />

            </td>

          </tr>

          <tr>

            <th class="essential">휴대폰</th>

            <td><input type="text" maxlength="3" name="sh_han_1" value="" class="typeText input_mini" />

                <span class="sp_txt">-</span>

                <input type="text" maxlength="4" name="sh_han_2" value="" class="typeText input_mini" />

                <span class="sp_txt">-</span>

                <input type="text" maxlength="4" name="sh_han_3" value="" class="typeText input_mini" />

            </td>

          </tr>

          <tr>

            <th class="essential">이메일</th>

            <td><input type="text" name="sh_email_1" onblur="checkInput(this)" value="" class="typeText input_txt" />

                <span class="sp_txt">@</span>

                <input type="text" name="sh_email_2" value="" class="typeText input_txt" />

                <select name="sh_email_3" onchange="mail_change()">

                  <option value="">선택하세요 </option>

                  <option value='suhyup.co.kr'>수협</option>

                  <option value='empas.com'>엠파스</option>

                  <option value='hanmail.net'>한메일</option>

                  <option value='korea.com'>코리아</option>

                  <option value='nate.com'>네이트</option>

                  <option value='naver.com'>네이버</option>

                  <option value='yahoo.co.kr'>야후</option>

                  <option value='paran.com'>파란</option>

                  <option value="">직접입력</option>

                </select>

            </td>

          </tr>

          <tr>

            <th class="essential">비밀번호</th>

            <td><input type="password" name="psword" value=""class="typeText input_txt" />

              &nbsp;비밀번호는 4자리 이상 6자리 이하로 작성하여주세요. </td>

          </tr>

          <tr>

            <th class="essential">분야선택</th>

            <td><select name="sh_cata">

                <option value='cho'>선택하세요 </option>

                <option value='수협은행'>수협은행</option>

                <option value='펀드판매관련' >펀드판매관련</option>

                <option value='공제보험'>공제보험</option>

                <option value='바다마트'>바다마트</option>

                <option value='공판장(경매)'>공판장(경매)</option>

                <option value='면세유류'>면세유류</option>

                <option value='회원조합/어촌계'>회원조합/어촌계</option>

                <option value='고객지원불친철'>고객지원불친철</option>

                <option value='기타사항'>기타사항</option>

              </select>

            </td>

          </tr>

        </table>

      <p class="essential">필수 입력사항</p>

      <table cellspacing="0" class="button">

          <tr>

            <td><a href="javascript:GoReg();"><img src="../pub_img/btminwon_ok.gif" title="민원신청버튼" width="68" height="18" /></a> <a href="javascript:pbform.reset();"><img src="../pub_img/btminwon_cancle.gif" title="다시입력버튼" width="68" height="18" /></a> </td>

          </tr>

        </table>

      <!-- 민원신청 입력 창 시작 -->

    </td>

  </tr>

</table>

<!-- end content table-->

</form>

</body>

</html>