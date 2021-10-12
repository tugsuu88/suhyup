<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page contentType="text/html;charset=euc-kr" %>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %> 
<%@ include file="include/top_menu07.jsp" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>
<%
	String no = request.getParameter("sh_no");
	if(no == null) no="0";
	int sh_no = Integer.parseInt(no);

	String sh_name = "";
	String sh_code = "";
	String sh_subject = "";
	String sh_content = "";
	String sh_indate = "";
	String sh_hit = "0";

	// CNT update 
	Vector vtsheet   = new Vector();
	vtsheet.addElement("update sh_minwon_faq set sh_hit = sh_hit + 1 where sh_no = ? ");
	vtsheet.addElement("int");
	vtsheet.addElement(no);
	String Result = FrontBoard.DataProcess(vtsheet);  
	
	try {	
		
		DataSource ds = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		PreparedStatement pstmt=null;

		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();
		
		String sql = "";	
		
		sql = " select sh_name, sh_code, sh_subject, sh_content, to_char(sh_indate, 'YYYY-MM-DD') AS sh_indate from sh_minwon_faq " ;
		sql += " where sh_no = '"+sh_no+"'";

		stmt=conn.createStatement();
		rs = stmt.executeQuery(sql);
		 
		if(rs.next()){
			sh_name = rs.getString("sh_name");			if(sh_name != null && !sh_name.equals("")){				sh_name = sh_name.replaceAll("<", "&lt;").replaceAll(">", "&gt;");			}
			sh_code = rs.getString("sh_code");			if(sh_code != null && !sh_code.equals("")){				sh_code = sh_code.replaceAll("<", "&lt;").replaceAll(">", "&gt;");			}
			sh_subject = rs.getString("sh_subject");			if(sh_subject != null && !sh_subject.equals("")){				sh_subject = sh_subject.replaceAll("<", "&lt;").replaceAll(">", "&gt;");			}
			sh_content = rs.getString("sh_content");			if(sh_content != null && !sh_content.equals("")){				sh_content = sh_content.replaceAll("<", "&lt;").replaceAll(">", "&gt;");			}
			sh_indate = rs.getString("sh_indate");			if(sh_indate != null && !sh_indate.equals("")){				sh_indate = sh_indate.replaceAll("<", "&lt;").replaceAll(">", "&gt;");			}
		}
		
		rs.close();
		conn.close();
		
	}
	catch(Exception e){
		out.println(e.toString());
	}
%>

<!-- 금융사고 제보 설명 -->
<script language="javascript">
<!--
		
	function goReg(sh_no){	
		
		if(pbform.sh_code.value == 'cho') {
			alert("분류코드를 선택해 주십시오");
			pbform.sh_code.focus();
			return;
		}
		pbform.sh_no.value=sh_no;
		pbform.action = "faq_modify_proc.jsp";
		pbform.submit();
        
	}

	function goDel(sh_no){
		if (confirm("삭제하시겠습니까?")) {
			pbform.sh_no.value=sh_no;
			pbform.action = "faq_delete_proc.jsp";
			pbform.submit();
		}
		else {
			alert("취소되었습니다!");		
		}
		
	}

//-->
</script>
<form method=post action="" name="pbform">
<input type="hidden" name="sh_no" value="<%=sh_no%>">
<input type="hidden" name="sh_name" value="<%=sh_name%>">
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
<!-- // 금융사고 제보 설명 -->
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td style="padding:0 0 10 10 ;"> 
      <!-- 검색결과 -->
      <table width="960" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30"><img src="img/result.gif" align="absmiddle"> FAQ : 
            <span class="result_text">수정</span></td>
          <td height="30" align="right">&nbsp;</td>
          <td height="30" align="right" width="60">&nbsp;</td>
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
          <td width="130" height="35" align="center" class="table_bg_title">등록자</td>
          <td style="padding-left:25;" class="bluesky" width="540"><%=sh_name%></td>
          <td class="table_bg_title" width="110" align="center">등록일</td>
          <td style="padding-left:25;" width="165" class="bluesky"><%=sh_indate%></td>
        </tr>
		
        <tr> 
          <td colspan="4" height="1" bgcolor="ffffff"></td>
        </tr>
		 <tr> 
          <td width="130" height="35" align="center" class="table_bg_title">분류코드</td>
          <td style="padding-left:25;" class="board_bg_contents" colspan="3"> 
            <select name="sh_code" onChange="" value="">
				<option value="cho">전체</option>
                <option value="수협은행"<%if(sh_code.equals("수협은행")) { %>selected<% } %>>수협은행</option>
				<option value="펀드판매관련"<%if(sh_code.equals("펀드판매관련")) { %>selected<% } %>>펀드판매관련</option> 
				<option value="공제보험"<%if(sh_code.equals("공제보험")) { %>selected<% } %>>공제보험</option>
				<option value="바다마트"<%if(sh_code.equals("바다마트")) { %>selected<% } %>>바다마트</option> 
				<option value="공판장(경매)"<%if(sh_code.equals("공판장(경매)")) { %>selected<% } %>>공판장(경매)</option>
				<option value="면세유류"<%if(sh_code.equals("면세유류")) { %>selected<% } %>>면세유류</option> 
				<option value="회원조합/어촌계"<%if(sh_code.equals("회원조합/어촌계")) { %>selected<% } %>>회원조합/어촌계</option>
				<option value="고객지원불친절"<%if(sh_code.equals("고객지원불친절")) { %>selected<% } %>>고객지원불친절</option>
				<option value="기타사항"<%if(sh_code.equals("기타사항")) { %>selected<% } %>>기타사항</option>
            </select>
          </td>
        </tr>
		<tr> 
          <td colspan="4" height="1" bgcolor="ffffff"></td>
        </tr>
		<tr> 
          <td width="130" height="35" align="center" class="table_bg_title">제목</td>
          <td style="padding-left:25;" class="board_bg_contents" colspan="3">
            <input type="text" class="input01" size="135" name="sh_subject" value="<%=sh_subject%>">
          </td>
        </tr>
		<tr> 
          <td colspan="4" height="1" bgcolor="ffffff"></td>
        </tr>
        <tr> 
          <td width="130" height="35" align="center" class="table_bg_title">질문</td>
          <td style="padding:5 0 5 25;" class="board_bg_contents" colspan="3"> 
            <textarea name="sh_content" cols="114" rows="8" wrap="physical" ><%=sh_content%></textarea>
          </td>
        </tr>
        <tr> 
          <td colspan="4" height="1" bgcolor="ffffff"></td>
        </tr>
       
      
      </table>
     
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td align="right" height="10" colspan="3"></td>
        </tr>
        <tr> 
          <td><a href="faq.jsp"><a href="javascript:history.go(-1);"><img src="img/btn_list.gif" width="55" height="21" alt="목록" border="0"></a></td>
          <td align="right"><a href="javascript:goReg('<%=sh_no%>');"><img src="img/btn_adjust.gif" border="0" width="55" height="21" alt="수정"> 
            <a href="javascript:goDel('<%=sh_no%>');"><img src="img/btn_delete.gif" border="0" width="55" height="21" alt="삭제"> <a href="javascript:history.go(-1);"><img src="img/btn_cancle.gif" width="55" height="21" border="0" alt="취소"></td>
        </tr>
      </table>
    </td>
  </tr>
  <!--//  faq 쓰기 -->
 
</table>
</form>
<%@ include file="include/bottom.jsp" %>
