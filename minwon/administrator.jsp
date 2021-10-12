<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>
<% String pageNum = "7"; %>
<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %>
<%@ include file="include/top_menu01.jsp" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>
<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />

<%
		String KEY = request.getParameter("KEY");	//검색어
	    if(KEY != null && !KEY.equals("")) {
	    	KEY = StringReplace.sqlFilter(KEY);		//금지어 필터링
	    }
		else{
			KEY="";
		}

		String TableName = " sh_minwon_admin ";
	    String SelectCondition = null;
	    String OrderCondition = null;
		String WhereCondition = null;

		int PAGE = 1;

		if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){
			PAGE = 1;
	    }else{
			PAGE = Integer.parseInt(request.getParameter("PAGE"));
	    }
		String midstr=FrontBoard.OnlyOne("Select Max(sh_no) from sh_minwon_admin");

		SelectCondition = " sh_no, sh_buseo, sh_name, sh_id, sh_pwd, sh_inuser, sh_mobile,";
		SelectCondition += " to_char(sh_indate, 'YYYY-MM-DD') AS sh_indate ";
	    OrderCondition  = " ORDER BY sh_no DESC ";
		WhereCondition = "where 1 = 1 ";

		if (KEY != null && !KEY.equals("")) {
			WhereCondition += " and sh_buseo like '%"+KEY+"%'";

		}
		int StartRecord = 0;
		int EndRecord   = 0;
		int DefaultListRecord = 10;
		int DefaultPageBlock = 10;

		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
//		out.println(TableName+"<br>");
//		out.println(SelectCondition);
//		out.println(TotalRecordCount);
		//out.print("TotalRecordCount : " + TotalRecordCount + "<br><br>");
		///////////////////////////////////////////////////////////////////////////

%>
<!-- 민원정보담당자관리 설명 -->
<head>
<script language="javascript">
<!--
	//아이디중복체크

	function CheckID()  {


		var wint = (screen.height - 170) / 2;

		var winl = (screen.width - 340) / 2;

		winprops = 'height=230,width=362,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'

		winurl = 'check_id.jsp?return=sh_id&id='+f.sh_id.value;
		win = window.open(winurl, "idcheck", winprops)

		}

	//약관 동의 여부 체크
	function GoReg() {

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



		if (f.sh_han1.value.length == 0){
				alert("휴대폰번호가 입력되지 않았습니다.");
				f.sh_han1.focus();
				return;
		}else if(f.sh_han2.value.length == 0){
				alert("휴대폰번호가 입력되지 않았습니다.");
				f.sh_han2.focus();
				return;
		}else if(f.sh_han3.value.length == 0){
				alert("휴대폰번호가 입력되지 않았습니다.");
				f.sh_han3.focus();
				return;
		}
		if(!(f.sh_buseo.value == "감사실" || f.sh_buseo.value == "감사부" || f.sh_buseo.value == "금융소비자보호부" || f.sh_buseo.value == "준법감시실(중앙회)")){

			if(f.sh_admin_minwonall.checked){

				alert("민원현황은 감사실과 금융소비자보호부, 준법감시실(중앙회) 부서만 사용하실수있습니다.");

					return;

			}

		}

		f.action = "admin_reg.jsp";
		f.submit();

	}

	function goView(sh_no){
		f.sh_no.value=sh_no;
		f.action = "administrator_modify.jsp";
		f.submit();
	}

	function goDel(sh_no){
		f.sh_no.value=sh_no;
		if (confirm("삭제하시겠습니까?")) {
			f.action = "admin_delete_proc.jsp";
			f.submit();
		}
		else {
		alert("취소되었습니다!");
		}
	}
	//검색
	function form_check(){

		if (f.KEY.value == null || f.KEY.value == ""){
				alert("검색어를 입력하세요.");
				f.KEY.focus();
				return;
		}
		f.action = "administrator.jsp";
		f.submit();
	}

//-->
</script>
</head>
<form name="f" method=post action="">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
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
            <span class="result_text">총 <%=TotalRecordCount%>건</span></td>
          <td height="30" align="right"><a href="excel/admin_excel.jsp"><img src="img/btn_excel.gif" width="66" height="21" alt="엑셀" border="0"></a></td>
        </tr>
        <tr>
          <td height="2" class="result_line" colspan="2"></td>
        </tr>
      </table>
      <!-- // 검색결과 -->
    </td>
  </tr>
  <!-- 관리자 등록 -->
  <tr>
    <td style="padding-left:25;"><img src="img/arrow.gif" width="13" height="16" align="absmiddle">
      <span class="txt_title">관리자 등록</span></td>
  </tr>
  <tr>
    <td style="padding:10 0 10 25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0" class="table_outline">
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">관리담당자</td>
          <td style="padding-left:25;" class="board_bg_contents">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="50" class="bluesky">부서</td>
                <td>
                  <select name="sh_buseo" onChange="">
                    <option value="buseo">선택</option>
					<option value="감사실" >감사실</option>
					<option value="감사부" >감사부</option>
					<option value="ICT전략실" >ICT전략실</option>
					<option value="인사총무부" >인사총무부</option>
					<option value="개인금융부" >개인금융부</option>
					<option value="공제보험부" >공제보험부</option>
					<option value="전략기획부" >전략기획부</option>
					<option value="기획부" >기획부</option>
					<option value="노량진시장 현대화사업본부" >노량진시장 현대화사업본부</option>
					<option value="단체급식사업단" >단체급식사업단</option>
					<option value="리스크관리본부" >리스크관리본부</option>
					<option value="방카펀드사업부(펀드)" >방카펀드사업부(펀드)</option>
					<option value="상호금융부" >상호금융부</option>
					<option value="수산경제연구원" >수산경제연구원</option>
					<option value="수산금융부" >수산금융부</option>
					<!-- <option value="가공물류부" >가공물류부</option> -->
					<option value="신탁사업본부" >신탁사업본부</option>
					<option value="심사부" >심사부</option>
					<option value="어업정보통신본부" >어업정보통신본부</option>
					<option value="여신관리부" >여신관리부</option>
					<option value="연수원" >연수원</option>
					<option value="글로벌외환사업부" >글로벌외환사업부</option>
					<option value="경제기획부" >경제기획부</option>
					<option value="이사회사무국" >이사회사무국</option>
					<option value="자금부" >자금부</option>
					<option value="자재사업부" >자재사업부</option>
					<option value="IT개발부" >IT개발부</option>
					<option value="정보보호본부" >정보보호본부</option>
					<option value="조합감사실" >조합감사실</option>
					<option value="리스크관리실" >리스크관리실</option>
					<option value="자금운용부" >자금운용부</option>
					<!-- <option value="준법감시팀" >준법감시팀</option> -->
					<option value="판매사업부" >판매사업부</option>
					<option value="총무부" >총무부</option>
					<option value="카드사업부" >카드사업부</option>
					<!-- <option value="해양투자금융센터" >해양투자금융센터</option> -->
					<option value="홍보실" >홍보실</option>
					<option value="회원지원부" >회원지원부</option>
					<!-- <option value="사업구조개편단" >사업구조개편단</option> -->
					<option value="기업금융부" >기업금융부</option>
					<option value="여신정책부" >여신정책부</option>
					<option value="정책보험부" >정책보험부</option>
					<option value="금융소비자보호부" >금융소비자보호부</option>
					<option value="디지털개발부" >디지털개발부</option>
					<!-- <option value="선원지원실" >선원지원실</option> -->
					<option value="준법감시실(중앙회)" >준법감시실(중앙회)</option>
					<option value="준법감시실(조합)" >준법감시실(조합)</option>
					
					<option value="IB사업본부">IB사업본부</option>
					<option value="IT지원부">IT지원부</option>
					<option value="경남지역본부">경남지역본부</option>
					<option value="경영전략실">경영전략실</option>
					<option value="디지털마케팅부">디지털마케팅부</option>
					<option value="디지털전략부">디지털전략부</option>
					<option value="무역사업단">무역사업단</option>
					<option value="어촌지원부">어촌지원부</option>
					<option value="유통사업부">유통사업부</option>
					<option value="전남지역본부">전남지역본부</option>
					<option value="준법감시실">준법감시실</option>
					<option value="지속경영추진부">지속경영추진부</option>
                  </select>
                </td>
                <td width="70">&nbsp;</td>
                <td width="60" class="bluesky">성명</td>
                <td>
                  <input type="text" class="input01" size="15" name="sh_name" value="">
                </td>
                <td width="30">&nbsp;</td>
                <td width="40" class="bluesky">직위</td>
                <td>
                  <select name="sh_gicwe" onChange="">
                    <option value="gicwe">선택</option>
                    <option value="직원" >직원</option>
                    <option value="대리" >대리</option>
                    <option value="과장" >과장</option>
                    <option value="차장" >차장</option>
                    <option value="팀장" >팀장</option>
                    <option value="부장/실장" >부장/실장</option>
                    <!-- -->
                  </select>
                </td>
                <td width="30">&nbsp;</td>
                <td width="40" class="bluesky">직급</td>
                <td>
                  <select name="sh_gicgub" onChange="">
                    <option value="gicgub">선택</option>
                    <option value="계약직" >계약직</option>
                    <option value="4급" >4급</option>
                    <option value="3급" >3급</option>
                    <option value="2급" >2급</option>
                    <option value="1급" >1급</option>
                    <option value="별급" >별급</option>
                    <!-- -->
                  </select>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td colspan="2" height="1" bgcolor="ffffff"></td>
        </tr>
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">관리계정</td>
          <td style="padding-left:25;" class="board_bg_contents">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="50" class="bluesky">아이디</td>
                <td>
                  <input type="text" class="input01" size="20" name="sh_id">

                </td>

				<td width="10">&nbsp;</td>
                <td width="20"><a href="javascript:CheckID();"><img src="img/mb_bt_check.gif" title="아이디체크" border="0" /></a></td>

				<td width="20">&nbsp;</td>
                <td width="60" class="bluesky">패스워드</td>
                <td>
                  <input type="password" class="input01" size="15" name="sh_pwd" value="">
                </td>
				<td width="20">&nbsp;</td>
				<td width="60" class="bluesky">핸드폰</td>
                <td>
                  <input type="text" class="input01" size="5" name="sh_han1" value="">
				   <span class="sp_txt">-</span>
				  <input type="text" class="input01" size="6" name="sh_han2" value="">
				   <span class="sp_txt">-</span>
				  <input type="text" class="input01" size="6" name="sh_han3" value="">
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td colspan="2" height="1" bgcolor="ffffff"></td>
        </tr>
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">관리권한</td>
          <td style="padding-left:25;" class="board_bg_contents">
            <table width="100%" border="0" cellspacing="5" cellpadding="0">
              <tr>
                <td width="100" class="bluesky"> * 시스템 관리</td>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_manager" value="Y">
                        관리자 관리</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="checkbox" name="sh_admin_faq" value="Y">
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
                        <input type="checkbox" name="sh_admin_minwonall" value="Y">
                        민원접수현황</td>
                      <td>&nbsp;</td>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_buseo" value="Y">
                        부서별 민원관리</td>
                      <td>&nbsp;</td>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_result" value="Y">
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
                        <input type="checkbox" name="sh_admin_jebo" value="Y">
                        금융사고제보</td>
                      <td>&nbsp;</td>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_bujori" value="Y">
                        금융부조리신고</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="checkbox" name="sh_admin_myunsei" value="Y">
                        면세유류 부정유통 신고</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="checkbox" name="sh_admin_corruption" value="Y">
                        행동강령 신고·상담센터</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
     <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="right" height="10"></td>
        </tr>
        <tr>
          <td align="right"><a href="javascript:GoReg();"><img src="img/btn_upload.gif" width="55" height="21" alt="등록" border="0"></td>
        </tr>
      </table>
    </td>
  </tr>
  <!--// 관리자 등록 -->
  <!-- 부서별 관리자 -->
  <tr>
    <td style="padding-left:25;"><img src="img/arrow.gif" width="13" height="16" align="absmiddle">
      <span class="txt_title">부서별 관리자</span></td>
  </tr>
  <tr>
    <td style="padding:10 0 0 25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="17%"/>
			<col width="11%"/>
			<col width="11%"/>
			<col width="11%"/>
			<col width="12%"/>
			<col width="11%"/>
			<col width="11%"/>
			<col width="11%"/>
		</colgroup>
        <tr>
          <td colspan="9" height="2" class="board_topline"></td>
        </tr>
        <tr height="30">
          <td class="board_bg_title" width="45" align="center">번호</td>
          <td class="board_bg_title" width="150" align="center">부서</td>
          <td class="board_bg_title" width="100" align="center">관리자</td>
          <td class="board_bg_title" width="150" align="center">아이디</td>
          <td class="board_bg_title" width="150" align="center">패스워드</td>
		   <td class="board_bg_title" width="150" align="center">핸드폰</td>
          <td class="board_bg_title" width="100" align="center">등록자</td>
          <td class="board_bg_title" width="150" align="center">등록일</td>
          <td class="board_bg_title" width="100" align="center">삭제</td>
        </tr>
        <tr>
          <td colspan="9" height="1" class="board_line"></td>
        </tr>
	<%
		Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);

		String sh_no = "";
	    String sh_buseo = "";
		String sh_name = "";
		String sh_id = "";
		String sh_pwd = "";
		String sh_inuser = "";
		String sh_indate = "";
		String sh_mobile = "";

		if( ResultVector.size() > 0){
			for (int i=0; i < ResultVector.size();i++){

				Hashtable h = (Hashtable)ResultVector.elementAt(i);

				sh_no = (String)h.get("SH_NO");
				sh_buseo = (String)h.get("SH_BUSEO");
				sh_name = (String)h.get("SH_NAME");
				sh_id = (String)h.get("SH_ID");
				sh_pwd = (String)h.get("SH_PWD");
				sh_pwd = aes.aesDecode(sh_pwd);  
				sh_inuser = (String)h.get("SH_INUSER");
				sh_indate = (String)h.get("SH_INDATE");
				sh_mobile = (String)h.get("SH_MOBILE");

				int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));

	%>
        <tr height="30"  onMouseOver=this.style.backgroundColor='F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'>
          <td align="center"><%=listnum%></td>
          <td align="center"><%=sh_buseo%></td>
          <td align="center"><a href="javascript:goView('<%=sh_no%>')"><%=sh_name%></td>
          <td align="center"><%=sh_id%></td>
          <td align="center"><%=sh_pwd%></td>
		  <td align="center"><%=sh_mobile%></td>
          <td align="center"><%=sh_inuser%></td>
          <td align="center"><%=sh_indate%></td>
          <td align="center"><a href="javascript:goDel('<%=sh_no%>')"><img src="img/btn_delete.gif" width="55" height="21" alt="삭제" border="0"></td>
        </tr>
		<%	} %>
	<%	} %>
        <tr>
          <td colspan="9" class="board_line2" height="1"></td>
        </tr>
      </table>
	  <table cellpadding="0" cellspacing="0" border="0" class="search">
			<tr>
				<td class="cols01"></td>
			</tr>
			<tr>

				<td class="cols02">
					<b>부서조회</b>&nbsp;&nbsp;<input type="text" name="KEY" class="inputKey" size="15" value="<%=KEY%>">
					<a href="javascript:form_check();"><input type="image" src="../pub_img/btT01Search.gif" class="btSearch"/></a>
				</td>
				<td class="cols03" align="right" width="700">
					<% if(TotalRecordCount > 0) { %>
						<%=FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock, "administrator.jsp?PAGE=","<img src=img/board_prev.gif width=13 height=13 align=absmiddle border=0>","<img src=img/board_next.gif width=13 height=13 align=absmiddle border=0>")%>
					<% } %>
				</td>
			</tr>
			</table>

    </td>
  </tr>
</table>
<input type="hidden" name="sh_no" value="<%=sh_no%>">
</FORM>
<%@ include file="include/bottom.jsp" %>
