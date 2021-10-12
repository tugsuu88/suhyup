<%@ page import="java.util.*, util.*, java.text.* " contentType="text/html;charset=euc-kr"%>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>
<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %>
<%@ include file="include/top_menu07.jsp" %>

<%
	Date date = new Date();
	SimpleDateFormat today=new SimpleDateFormat("yyyy-MM-dd");

%>

<html>
<head>
<!--/********************************************위너다임 작업 시작 2008.03.13****************************************************/-->
<!-- <SCRIPT SRC="http://www.suhyup.co.kr/djemals/js/ax_wdigm/default.js"></SCRIPT> -->
<!--/********************************************위너다임 작업 끝 2008.03.13******************************************************/-->
<script language="javascript" src="../js/common.js"></script>
<script language="javascript">
<!--
	//약관 동의 여부 체크
	function GoReg() {
		var mText  = document.f.answer.value;
		if(f.category.value == 'cho') {
			alert("분류코드를  선택해 주십시오");
			f.category.focus();
			return;
		}

		if (f.question.value.length == 0  ) {
			alert("질문을 입력해 주십시오");
			f.question.focus();
			return;
		}
		// 특수문자 체크: + ; ( ) - 는 가능
		var keyword = f.question.value;
		//var keyword_sp_char = "~`!@#$%^&*_=|\\<,>.?/{}[]:\"'";
		var keyword_sp_char = "`@#$%^&*=|\\<,>:\'";
		if(CheckSpecialChar(keyword, keyword_sp_char) == false)
			{
				alert("특수문자(" + keyword_sp_char + ")를 입력하실 수 없습니다.");
				f.question.focus();
				return;
			}

		if(keyword.length >= 151){
			alert("질문의 글자수가 초과하였습니다. 150자이내로 작성하여주세요.");
			f.question.focus();
			return;
		}
		if (f.answer.value.length == 0 ) {
			alert("답변을 입력해 주십시오");
			f.answer.focus();
			return;
		}
		if(f.answer.value.length >= 2001){
			alert("답변의 글자수가 초과하였습니다. 2000자이내로 작성하여주세요.");
			f.answer.focus();
			return;
		}
		/********************************************위너다임 작업 시작 2008.03.13****************************************************
		try{
			if(UsingRemote == true){
				if(!beScan('',mText,'')){
					return;
				}
			}
		}catch (e){
			var objRtn = objAX.beScanner(policy, '','', this.location, mText, '');
			if(objRtn == 0){
				return;
			}else{
				return;
			}
		}
		********************************************위너다임 작업 끝 2008.03.13******************************************************/

		f.action = "faq_write_proc.jsp";
		f.submit();


	}


//-->
</script>
</head>
<form method=post action="" name="f">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="95" bgcolor="f4f4f4"  style="padding-left:25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0" background="img/title_bg.gif">
        <tr>
          <td width="135">
            <table width="135" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="70" align="center" class="admin_subject">FAQ</td>
              </tr>
            </table>
          </td>
          <td width="5"></td>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="60" class="adminsub_subject" style="padding-left:25;">자주 묻는 질문과 답변을 등록합니다.</td>
              </tr>
            </table></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td style="padding:0 0 10 10 ;">
      <!-- 검색결과 -->
      <table width="960" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30"><img src="img/result.gif" align="absmiddle"> FAQ :
            <span class="result_text">등록</span></td>
          <td height="30" align="right"><a href="javascript:GoReg();"><img src="img/btn_upload.gif" width="55" height="21" alt="등록" border="0"></td>
          <td height="30" align="right" width="60"><a href="javascript:history.go(-1)"><img src="img/btn_cancle.gif" width="55" height="21" alt="취소" border="0"></td>
        </tr>
        <tr>
          <td height="2" class="result_line" colspan="3"></td>
        </tr>
      </table>
      <!-- // 검색결과 -->
    </td>
  </tr>
  <!-- faq 쓰기 -->

  <tr>
    <td style="padding:10 0 10 25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0" class="table_outline">
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">작성자</td>
          <td style="padding-left:25;" class="bluesky" width="540"><%=sa_name%></td>
          <td class="table_bg_title" width="110" align="center">작성일</td>
          <td style="padding-left:25;" width="165" class="bluesky"><%=today.format(date)%></td>
        </tr>

        <tr>
          <td colspan="4" height="1" bgcolor="ffffff"></td>
        </tr>
		 <tr>
          <td width="130" height="35" align="center" class="table_bg_title">분류코드</td>
          <td style="padding-left:25;" class="board_bg_contents" colspan="3">
            <select name="category" onChange="">
			  <option value="cho">선택해주세요</option>
              <option value="수협은행">수협은행</option>
			  <option value="펀드판매관련">펀드판매관련</option>
			  <option value="공제보험">공제보험</option>
			  <option value="바다마트">바다마트</option>
			  <option value="공판장(경매)">공판장(경매)</option>
			  <option value="면세유류">면세유류</option>
			  <option value="회원조합/어촌계">회원조합/어촌계</option>
			  <option value="고객지원불친절">고객지원불친절</option>
			  <option value="기타사항">기타사항</option>
            </select>
          </td>
        </tr>
		<tr>
          <td colspan="4" height="1" bgcolor="ffffff"></td>
        </tr>
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">질문</td>
          <td style="padding-left:25;" class="board_bg_contents" colspan="3">
            <textarea name="question" cols="115" rows="8" wrap="physical" ></textarea>
          </td>
        </tr>
        <tr>
          <td colspan="4" height="1" bgcolor="ffffff"></td>
        </tr>

        <tr>
          <td colspan="4" height="1" bgcolor="ffffff"></td>
        </tr>
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">답변</td>
          <td style="padding-left:25;" class="board_bg_contents" colspan="3">
            <textarea name="answer" cols="115" rows="8" wrap="physical" ></textarea>
          </td>
        </tr>
      </table>

    </td>
  </tr>


</table>
<input type="hidden" name="sa_name" value="<%=sa_name%>" >
<input type="hidden" name="sa_id" value="<%=sa_id%>">
</form>
</html>
<%@ include file="include/bottom.jsp" %>
