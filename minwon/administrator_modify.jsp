<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page contentType="text/html;charset=euc-kr" %>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>

<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />

<%

	String no = request.getParameter("sh_no");
	if(no == null) no="0";
	int sh_no = Integer.parseInt(no);

	String sh_name = "";
	String sh_id = "";
	String sh_pwd = "";
	String sh_mobile = "";
	String sh_inuser = "";
	String sh_indate = "";
	String sh_buseo = "";
	String sh_gicwe = "";
	String sh_gicgub = "";

	String sh_admin_manager ="";

	String sh_admin_faq ="";

	String sh_admin_minwonall="";

	String sh_admin_buseo="";

	String sh_admin_result="";

	String sh_admin_jebo="";

	String sh_admin_bujori="";

	String sh_admin_myunsei="";

	String sh_admin_corruption="";

	String sh_tel_1 = "";
	String sh_tel_2 = "";
	String sh_tel_3 = "";

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

		sql = " select sh_name, sh_id, sh_pwd,sh_mobile,sh_admin_manager,sh_admin_faq,sh_admin_minwonall,sh_admin_buseo,";

		sql +=" sh_admin_result, sh_admin_jebo, sh_admin_bujori, sh_admin_myunsei, sh_admin_corruption, sh_buseo, sh_gicwe, sh_gicgub";

		sql +=" from sh_minwon_admin " ;

		sql += " where sh_no = '"+sh_no+"'";

		stmt=conn.createStatement();
		rs = stmt.executeQuery(sql);

		StringTokenizer token = new StringTokenizer(sh_mobile," ");

		if(rs.next()){
			sh_name = rs.getString("SH_NAME");
			if(sh_name == null) sh_name="";
			sh_id = rs.getString("SH_ID");
			if(sh_id == null) sh_id="";
			sh_pwd = rs.getString("SH_PWD");
			if(sh_pwd == null) {
				sh_pwd="";
			} else {
				sh_pwd= aes.aesDecode(sh_pwd);
			}

			sh_mobile = rs.getString("sh_mobile");
			if(sh_mobile == null) sh_mobile="";
			if (sh_mobile.indexOf("--",0) == -1 ){
			token = new StringTokenizer(sh_mobile,"-");
				while(token.hasMoreTokens()){
					sh_tel_1 = token.nextToken();
					sh_tel_2 = token.nextToken();
			   		sh_tel_3 = token.nextToken();
	    		}
			}
			sh_admin_manager = rs.getString("sh_admin_manager");

			if(sh_admin_manager == null) sh_admin_manager="";

			sh_admin_faq = rs.getString("sh_admin_faq");

			if(sh_admin_faq == null) sh_admin_faq="";

			sh_admin_minwonall = rs.getString("sh_admin_minwonall");

			if(sh_admin_minwonall == null) sh_admin_minwonall="";

			sh_admin_buseo = rs.getString("sh_admin_buseo");

			if(sh_admin_buseo == null) sh_admin_buseo="";

			sh_admin_result = rs.getString("sh_admin_result");

			if(sh_admin_result == null) sh_admin_result="";

			sh_admin_jebo = rs.getString("sh_admin_jebo");

			if(sh_admin_jebo == null) sh_admin_jebo="";

			sh_admin_bujori = rs.getString("sh_admin_bujori");

			if(sh_admin_bujori == null) sh_admin_bujori="";

			sh_admin_myunsei = rs.getString("sh_admin_myunsei");

			if(sh_admin_myunsei == null) sh_admin_myunsei="";

			sh_admin_corruption = rs.getString("sh_admin_corruption");

			if(sh_admin_corruption == null) sh_admin_corruption="";

			sh_buseo = rs.getString("sh_buseo");

			if(sh_buseo == null) sh_buseo="";

			sh_gicwe = rs.getString("sh_gicwe");

			if(sh_gicwe == null) sh_gicwe="";

			sh_gicgub = rs.getString("sh_gicgub");

			if(sh_gicgub == null) sh_gicgub="";
		}

		rs.close();
		conn.close();

	}
	catch(Exception e){
		out.println(e.toString());
	}
%>

<%@ include file="include/top_login.jsp" %>
<%@ include file="include/top_menu01.jsp" %>
<!-- 민원정보담당자관리 설명 -->
<head>
<script language="javascript">
<!--
	//약관 동의 여부 체크
	function GoReg(sh_no){
		//goCk();
		if(f.sh_buseo.value == 'buseo') {
			alert("부서를 선택해 주십시오");
			f.sh_buseo.focus();
			return;
		}
		if (f.sh_name.value.length == 0) {alert("성명을 입력해 주십시오"); f.sh_name.focus(); return;}
		if(f.sh_gicwe.value == 'gicwe') {
			alert("직위를 선택해 주십시오");
			f.sh_gicwe.focus();
			return;
		}
		if(f.sh_gicgub.value == 'gicgub') {
			alert("직급를 선택해 주십시오");
			f.sh_gicgub.focus();
			return;
		}
		if (f.sh_id.value.length == 0) {alert("아이디를 입력해 주십시오"); f.sh_id.focus(); return;}
		if (f.sh_pwd.value.length == 0) {alert("비밀번호를 입력해 주십시오"); f.sh_pwd.focus(); return;}
		f.sh_no.value=sh_no;
		f.action = "admin_update_proc.jsp";
		f.submit();
	}

	function goCk() {

		if(f.sh_buseo.value == 'buseo') {
			alert("부서를 선택해 주십시오");
			f.sh_buseo.focus();
			return;
		}

		if (f.sh_name.value.length == 0) {alert("성명을 입력해 주십시오"); f.sh_name.focus(); return;}

		if(f.sh_gicwe.value == 'gicwe') {
			alert("직위를 선택해 주십시오");
			f.sh_gicwe.focus();
			return;
		}

		if(f.sh_gicgub.value == 'gicgub') {
			alert("직급를 선택해 주십시오");
			f.sh_gicgub.focus();
			return;
		}

		if (f.sh_id.value.length == 0) {alert("아이디를 입력해 주십시오"); f.sh_id.focus(); return;}

		if (f.sh_pwd.value.length == 0) {alert("비밀번호를 입력해 주십시오"); f.sh_pwd.focus(); return;}
	}
//-->
</script>
<form method=post name="f" action="">
<input type="hidden" name="sh_no" value="<%=sh_no%>">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="95" bgcolor="f4f4f4"  style="padding-left:25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0" background="img/title_bg.gif">
        <tr>
          <td width="135">
            <table width="135" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="70" align="center" class="admin_subject">민원정보<br>
                  담당자 관리</td>
              </tr>
            </table>
          </td>
          <td width="5"></td>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="60" class="adminsub_subject" style="padding-left:25;">부서별
                  담당자를 등록 및 관리합니다.</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<!-- // 민원정보담당자관리 설명 -->
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td style="padding:0 0 10 10 ;">
      <!-- 검색결과 -->
      <table width="960" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30"><img src="img/result.gif" align="absmiddle"> 검색결과 :
            <span class="result_text">총 5건</span></td>
        </tr>
        <tr>
          <td height="2" class="result_line" colspan="2"></td>
        </tr>
      </table>
      <!-- // 검색결과 -->
    </td>
  </tr>
  <!-- 관리자 수정 -->
  <tr>
    <td style="padding-left:25;"><img src="img/arrow.gif" width="13" height="16" align="absmiddle">
      <span class="txt_title">관리자 수정</span></td>
  </tr>
  <tr>
    <td style="padding:10 0 10 25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="2" colspan="4" class="board_topline"></td>
        </tr>
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">관리담당자</td>
          <td style="padding-left:25;">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="50" class="bluesky">부서</td>
                <td width="140">
                  <select name="sh_buseo" onChange="">
                    <option value="buseo">선택</option>
                    <option value="감사실" <%if(sh_buseo.equals("감사실")) { %>selected<% } %>>감사실</option>
                    <option value="감사부" <%if(sh_buseo.equals("감사부")) { %>selected<% } %>>감사부</option>
                    <option value="ICT전략실" <%if(sh_buseo.equals("ICT전략실")) { %>selected<% } %>>ICT전략실</option>
                    <option value="인사총무부" <%if(sh_buseo.equals("인사총무부")) { %>selected<% } %>>인사총무부</option>
                    <option value="개인금융부" <%if(sh_buseo.equals("개인금융부")) { %>selected<% } %>>개인금융부</option>
                    <option value="공제보험부" <%if(sh_buseo.equals("공제보험부")) { %>selected<% } %>>공제보험부</option>
                    <option value="전략기획부" <%if(sh_buseo.equals("전략기획부")) { %>selected<% } %>>전략기획부</option>
                    <option value="기획부" <%if(sh_buseo.equals("기획부")) { %>selected<% } %>>기획부</option>
                    <option value="노량진시장 현대화사업본부" <%if(sh_buseo.equals("노량진시장 현대화사업본부")) { %>selected<% } %>>노량진시장 현대화사업본부</option>
                    <option value="단체급식사업단" <%if(sh_buseo.equals("단체급식사업단")) { %>selected<% } %>>단체급식사업단</option>
                    <option value="리스크관리본부" <%if(sh_buseo.equals("리스크관리본부")) { %>selected<% } %>>리스크관리본부</option>
                    <option value="방카펀드사업부(펀드)" <%if(sh_buseo.equals("방카펀드사업부(펀드)")) { %>selected<% } %>>방카펀드사업부(펀드)</option>
                    <option value="상호금융부" <%if(sh_buseo.equals("상호금융부")) { %>selected<% } %>>상호금융부</option>
                    <option value="수산경제연구원" <%if(sh_buseo.equals("수산경제연구원")) { %>selected<% } %>>수산경제연구원</option>
                    <option value="수산금융부" <%if(sh_buseo.equals("수산금융부")) { %>selected<% } %>>수산금융부</option>
                   <%--  <option value="가공물류부" <%if(sh_buseo.equals("가공물류부")) { %>selected<% } %>>가공물류부</option> --%>
                    <option value="신탁사업본부" <%if(sh_buseo.equals("신탁사업본부")) { %>selected<% } %>>신탁사업본부</option>
                    <option value="심사부" <%if(sh_buseo.equals("심사부")) { %>selected<% } %>>심사부</option>
                    <option value="어업정보통신본부" <%if(sh_buseo.equals("어업정보통신본부")) { %>selected<% } %>>어업정보통신본부</option>
                    <option value="여신관리부" <%if(sh_buseo.equals("여신관리부")) { %>selected<% } %>>여신관리부</option>
                    <option value="연수원" <%if(sh_buseo.equals("연수원")) { %>selected<% } %>>연수원</option>
                    <option value="글로벌외환사업부" <%if(sh_buseo.equals("글로벌외환사업부")) { %>selected<% } %>>글로벌외환사업부</option>
                    <option value="경제기획부" <%if(sh_buseo.equals("경제기획부")) { %>selected<% } %>>경제기획부</option>
                    <option value="이사회사무국" <%if(sh_buseo.equals("이사회사무국")) { %>selected<% } %>>이사회사무국</option>
                    <option value="자금부" <%if(sh_buseo.equals("자금부")) { %>selected<% } %>>자금부</option>
                    <option value="자재사업부" <%if(sh_buseo.equals("자재사업부")) { %>selected<% } %>>자재사업부</option>
                    <option value="IT개발부" <%if(sh_buseo.equals("IT개발부")) { %>selected<% } %>>IT개발부</option>
                    <option value="정보보호본부" <%if(sh_buseo.equals("정보보호본부")) { %>selected<% } %>>정보보호본부</option>
                    <option value="조합감사실" <%if(sh_buseo.equals("조합감사실")) { %>selected<% } %>>조합감사실</option>
                    <option value="리스크관리실" <%if(sh_buseo.equals("리스크관리실")) { %>selected<% } %>>리스크관리실</option>
                    <option value="자금운용부" <%if(sh_buseo.equals("자금운용부")) { %>selected<% } %>>자금운용부</option>
           <%--          <option value="준법감시팀" <%if(sh_buseo.equals("준법감시팀")) { %>selected<% } %>>준법감시팀</option> --%>
                    <option value="판매사업부" <%if(sh_buseo.equals("판매사업부")) { %>selected<% } %>>판매사업부</option>
                    <option value="총무부" <%if(sh_buseo.equals("총무부")) { %>selected<% } %>>총무부</option>
                    <option value="카드사업부" <%if(sh_buseo.equals("카드사업부")) { %>selected<% } %>>카드사업부</option>
                  <%--   <option value="해양투자금융센터" <%if(sh_buseo.equals("해양투자금융센터")) { %>selected<% } %>>해양투자금융센터</option> --%>
                    <option value="홍보실" <%if(sh_buseo.equals("홍보실")) { %>selected<% } %>>홍보실</option>
                    <option value="회원지원부" <%if(sh_buseo.equals("회원지원부")) { %>selected<% } %>>회원지원부</option>
                   <%--  <option value="사업구조개편단" <%if(sh_buseo.equals("사업구조개편단")) { %>selected<% } %>>사업구조개편단</option> --%>
                    <option value="기업금융부" <%if(sh_buseo.equals("기업금융부")) { %>selected<% } %>>기업금융부</option>
                    <option value="여신정책부" <%if(sh_buseo.equals("여신정책부")) { %>selected<% } %>>여신정책부</option>
                    <option value="정책보험부" <%if(sh_buseo.equals("정책보험부")) { %>selected<% } %>>정책보험부</option>
                    <option value="금융소비자보호부" <%if(sh_buseo.equals("금융소비자보호부")) { %>selected<% } %>>금융소비자보호부</option>
                    <option value="디지털개발부" <%if(sh_buseo.equals("디지털개발부")) { %>selected<% } %>>디지털개발부</option>
                  <%--   <option value="선원지원실" <%if(sh_buseo.equals("선원지원실")) { %>selected<% } %>>선원지원실</option> --%>
					<option value="준법감시실(중앙회)" <%if(sh_buseo.equals("준법감시실(중앙회)")) { %>selected<% } %>>준법감시실(중앙회)</option>
					<option value="준법감시실(조합)" <%if(sh_buseo.equals("준법감시실(조합)")) { %>selected<% } %>>준법감시실(조합)</option>
					
					<option value="IB사업본부" <%if(buse_name.equals("IB사업본부")) { %>selected<% } %>>IB사업본부</option>
					<option value="IT지원부" <%if(buse_name.equals("IT지원부")) { %>selected<% } %>>IT지원부</option>
					<option value="경남지역본부" <%if(buse_name.equals("경남지역본부")) { %>selected<% } %>>경남지역본부</option>
					<option value="경영전략실" <%if(buse_name.equals("경영전략실")) { %>selected<% } %>>경영전략실</option>
					<option value="디지털마케팅부" <%if(buse_name.equals("디지털마케팅부")) { %>selected<% } %>>디지털마케팅부</option>
					<option value="디지털전략부" <%if(buse_name.equals("디지털전략부")) { %>selected<% } %>>디지털전략부</option>
					<option value="무역사업단" <%if(buse_name.equals("무역사업단")) { %>selected<% } %>>무역사업단</option>
					<option value="어촌지원부" <%if(buse_name.equals("어촌지원부")) { %>selected<% } %>>어촌지원부</option>
					<option value="유통사업부" <%if(buse_name.equals("유통사업부")) { %>selected<% } %>>유통사업부</option>
					<option value="전남지역본부" <%if(buse_name.equals("전남지역본부")) { %>selected<% } %>>전남지역본부</option>
					<option value="준법감시실" <%if(buse_name.equals("준법감시실")) { %>selected<% } %>>준법감시실</option>
					<option value="지속경영추진부" <%if(buse_name.equals("지속경영추진부")) { %>selected<% } %>>지속경영추진부</option>
				  </select>
                </td>
                <td width="20">&nbsp;</td>
                <td width="60" class="bluesky">성명</td>
                <td width="100">
                  <input type="text" class="input01" size="15" name="sh_name" value="<%=sh_name%>">
                </td>
                <td width="20">&nbsp;</td>
                <td width="80" class="bluesky">직위</td>
                <td width="130">
                  <select name="sh_gicwe" onChange="">
                    <option value="gicwe">선택</option>
                    <option value="직원" <%if(sh_gicwe.equals("직원")) { %>selected<% } %>>직원</option>
                    <option value="대리" <%if(sh_gicwe.equals("대리")) { %>selected<% } %>>대리</option>
                    <option value="과장" <%if(sh_gicwe.equals("과장")) { %>selected<% } %>>과장</option>
                    <option value="차장" <%if(sh_gicwe.equals("차장")) { %>selected<% } %>>차장</option>
                    <option value="팀장" <%if(sh_gicwe.equals("팀장")) { %>selected<% } %>>팀장</option>
                    <option value="부장/실장" <%if(sh_gicwe.equals("부장/실장")) { %>selected<% } %>>부장/실장</option>
                    <!-- -->
                  </select>
                </td>
                <td width="20">&nbsp;</td>
                <td width="40" class="bluesky">직급</td>
                <td width="100">
                  <select name="sh_gicgub" onChange="">
                    <option value="gicgub">선택</option>
                    <option value="계약직" <%if(sh_gicgub.equals("계약직")) { %>selected<% } %>>계약직</option>
                    <option value="4급" <%if(sh_gicgub.equals("4급")) { %>selected<% } %>>4급</option>
                    <option value="3급" <%if(sh_gicgub.equals("3급")) { %>selected<% } %>>3급</option>
                    <option value="2급" <%if(sh_gicgub.equals("2급")) { %>selected<% } %>>2급</option>
                    <option value="1급" <%if(sh_gicgub.equals("1급")) { %>selected<% } %>>1급</option>
                    <option value="별급" <%if(sh_gicgub.equals("별급")) { %>selected<% } %>>별급</option>
                    <!-- -->
                  </select>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="1" colspan="4" class="board_line"></td>
        </tr>
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">관리계정</td>
          <td style="padding-left:25;">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="50" class="bluesky">아이디</td>
                <td width="140">
                  <input type="text" class="input01" size="15" name="sh_id" value="<%=sh_id%>" readonly>
                </td>
                <td width="20">&nbsp;</td>
                <td width="60" class="bluesky">패스워드</td>
                <td width="100">
                  <input type="password" class="input01" size="12" name="sh_pwd" maxlength="20" value="<%=sh_pwd%>">
                </td>
				<td width="60" class="bluesky">핸드폰</td>
                <td>
                  <input type="text" class="input01" size="5" name="sh_han1" value="<%=sh_tel_1%>">
				   <span class="sp_txt">-</span>
				  <input type="text" class="input01" size="6" name="sh_han2" value="<%=sh_tel_2%>">
				   <span class="sp_txt">-</span>
				  <input type="text" class="input01" size="6" name="sh_han3" value="<%=sh_tel_3%>">
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="1" colspan="4" class="board_line"></td>
        </tr>
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">관리권한</td>
          <td style="padding-left:25;">
            <table width="100%" border="0" cellspacing="5" cellpadding="0">
              <tr>
                <td width="100" class="bluesky"> * 시스템 관리</td>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_manager" value="Y"<%if(sh_admin_manager.equals("Y")){ %>checked<% } %>>
                        관리자 관리</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="checkbox" name="sh_admin_faq" value="Y"<%if(sh_admin_faq.equals("Y")){ %>checked<% } %>>
                        FAQ</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="bluesky">* 전자민원 관리</td>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_minwonall" value="Y"<%if(sh_admin_minwonall.equals("Y")){ %>checked<% } %>>
                        민원접수현황</td>
                      <td>&nbsp;</td>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_buseo" value="Y"<%if(sh_admin_buseo.equals("Y")){ %>checked<% } %>>
                        부서별 민원관리</td>
                      <td>&nbsp;</td>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_result" value="Y"<%if(sh_admin_result.equals("Y")){ %>checked<% } %>>
                        민원처리결과 공시</td>
                     </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="bluesky">* 기타 관리</td>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_jebo" value="Y"<%if(sh_admin_jebo.equals("Y")){ %>checked<% } %>>
                        금융사고제보</td>
                      <td>&nbsp;</td>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_bujori" value="Y"<%if(sh_admin_bujori.equals("Y")){ %>checked<% } %>>
                        금융부조리신고</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="checkbox" name="sh_admin_myunsei" value="Y"<%if(sh_admin_myunsei.equals("Y")){ %>checked<% } %>>
                        면세유류 부정유통 신고</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="checkbox" name="sh_admin_corruption" value="Y"<%if(sh_admin_corruption.equals("Y")){ %>checked<% } %>>
                         행동강령 신고·상담센터</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="1" colspan="4" class="board_line"></td>
        </tr>
      </table>
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="right" height="10" colspan="3"></td>
        </tr>
        <tr>
          <td><a href="administrator.jsp"><img src="img/btn_list.gif" width="55" height="21" alt="목록" border="0"></a></td>
          <td align="right"><a href="javascript:GoReg('<%=sh_no%>');"><img src="img/btn_adjust.gif" width="55" height="21" alt="수정" border="0">
            <a href="administrator.jsp"><img src="img/btn_cancle.gif" width="55" height="21" border="0" alt="취소"></td>
        </tr>
      </table>
      <br>
    </td>
  </tr>
  <!--// 관리자 수정  -->
</table>
</form>
<%@ include file="include/bottom.jsp" %>
