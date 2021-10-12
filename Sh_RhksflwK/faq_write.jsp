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
<!--/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************/-->
<!-- <SCRIPT SRC="http://www.suhyup.co.kr/djemals/js/ax_wdigm/default.js"></SCRIPT> -->
<!--/********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/-->
<script language="javascript" src="../js/common.js"></script>
<script language="javascript">
<!--
	//��� ���� ���� üũ
	function GoReg() {
		var mText  = document.f.answer.value;
		if(f.category.value == 'cho') {
			alert("�з��ڵ带  ������ �ֽʽÿ�");
			f.category.focus();
			return;
		}

		if (f.question.value.length == 0  ) {
			alert("������ �Է��� �ֽʽÿ�");
			f.question.focus();
			return;
		}
		// Ư������ üũ: + ; ( ) - �� ����
		var keyword = f.question.value;
		//var keyword_sp_char = "~`!@#$%^&*_=|\\<,>.?/{}[]:\"'";
		var keyword_sp_char = "`@#$%^&*=|\\<,>:\'";
		if(CheckSpecialChar(keyword, keyword_sp_char) == false)
			{
				alert("Ư������(" + keyword_sp_char + ")�� �Է��Ͻ� �� �����ϴ�.");
				f.question.focus();
				return;
			}

		if(keyword.length >= 151){
			alert("������ ���ڼ��� �ʰ��Ͽ����ϴ�. 150���̳��� �ۼ��Ͽ��ּ���.");
			f.question.focus();
			return;
		}
		if (f.answer.value.length == 0 ) {
			alert("�亯�� �Է��� �ֽʽÿ�");
			f.answer.focus();
			return;
		}
		if(f.answer.value.length >= 2001){
			alert("�亯�� ���ڼ��� �ʰ��Ͽ����ϴ�. 2000���̳��� �ۼ��Ͽ��ּ���.");
			f.answer.focus();
			return;
		}
		/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************
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
		********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/

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
                <td height="60" class="adminsub_subject" style="padding-left:25;">���� ���� ������ �亯�� ����մϴ�.</td>
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
      <!-- �˻���� -->
      <table width="960" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30"><img src="img/result.gif" align="absmiddle"> FAQ :
            <span class="result_text">���</span></td>
          <td height="30" align="right"><a href="javascript:GoReg();"><img src="img/btn_upload.gif" width="55" height="21" alt="���" border="0"></td>
          <td height="30" align="right" width="60"><a href="javascript:history.go(-1)"><img src="img/btn_cancle.gif" width="55" height="21" alt="���" border="0"></td>
        </tr>
        <tr>
          <td height="2" class="result_line" colspan="3"></td>
        </tr>
      </table>
      <!-- // �˻���� -->
    </td>
  </tr>
  <!-- faq ���� -->

  <tr>
    <td style="padding:10 0 10 25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0" class="table_outline">
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">�ۼ���</td>
          <td style="padding-left:25;" class="bluesky" width="540"><%=sa_name%></td>
          <td class="table_bg_title" width="110" align="center">�ۼ���</td>
          <td style="padding-left:25;" width="165" class="bluesky"><%=today.format(date)%></td>
        </tr>

        <tr>
          <td colspan="4" height="1" bgcolor="ffffff"></td>
        </tr>
		 <tr>
          <td width="130" height="35" align="center" class="table_bg_title">�з��ڵ�</td>
          <td style="padding-left:25;" class="board_bg_contents" colspan="3">
            <select name="category" onChange="">
			  <option value="cho">�������ּ���</option>
              <option value="��������">��������</option>
			  <option value="�ݵ��ǸŰ���">�ݵ��ǸŰ���</option>
			  <option value="��������">��������</option>
			  <option value="�ٴٸ�Ʈ">�ٴٸ�Ʈ</option>
			  <option value="������(���)">������(���)</option>
			  <option value="�鼼����">�鼼����</option>
			  <option value="ȸ������/���̰�">ȸ������/���̰�</option>
			  <option value="��������ģ��">��������ģ��</option>
			  <option value="��Ÿ����">��Ÿ����</option>
            </select>
          </td>
        </tr>
		<tr>
          <td colspan="4" height="1" bgcolor="ffffff"></td>
        </tr>
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">����</td>
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
          <td width="130" height="35" align="center" class="table_bg_title">�亯</td>
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
