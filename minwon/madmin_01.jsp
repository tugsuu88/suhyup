<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="session" class="Bean.Front.Common.FrontDbUtil"/>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %>
<%@ include file="include/top_menu0201.jsp" %>

<%
	String ListPage = Converter.nullchk(request.getParameter("ListPage"));
	//String pageNum = request.getParameter("pageNum");
	String myPage = request.getRequestURI();
	String finance_buseo=Converter.nullchk((String)session.getAttribute("buseo"));

	try
	{
		String cmd = Converter.nullchk(request.getParameter("cmd"));	//검색어
	    String KEY = Converter.nullchk(request.getParameter("KEY"));	//검색어
	    if(KEY != null && !KEY.equals("")) {
	    	KEY = StringReplace.sqlFilter(KEY);		//금지어 필터링
	    }
	    //out.println("KEY : " + KEY + "<br>");
	    String FIELD = Converter.nullchk(request.getParameter("FIELD"));	//검색구분
		String category = Converter.nullchk(request.getParameter("category"));
		String minwon_gubun = Converter.nullchk(request.getParameter("minwon_gubun"));
		String status  = Converter.nullchk(request.getParameter("status"));
		String buse_name  = Converter.nullchk(request.getParameter("buse_name"));
		String start  = Converter.nullchk(request.getParameter("start"));
		String end  = Converter.nullchk(request.getParameter("end"));
		String result  = Converter.nullchk(request.getParameter("result"));

		int PAGE = 1;

		///////////////////////////////////////////////////////////////////////////
		String TableName = " sh_minwon ";
		String SelectCondition = null;
		String WhereCondition = null;
		String OrderCondition = null;

		if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){
			PAGE = 1;
	    }else{
			PAGE = Integer.parseInt(request.getParameter("PAGE"));
	    }

	    SelectCondition = " mid, category, minwon_gubun, subject, name, status,";
		SelectCondition += "to_char(creation_date, 'YYYYMMDD') AS creation_date, buse_name, result,";
		SelectCondition += "to_char(answer_date, 'YYYY-MM-DD') AS answer_date, to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date, answer,fname";
	    OrderCondition  = " ORDER BY mid DESC ";
		WhereCondition = "where 1 = 1 ";

		//변경
	    if(!(finance_buseo.equals("감사실") || finance_buseo.equals("감사부")) &&  !finance_buseo.equals("금융소비자보호부")){
	    	WhereCondition+=" and buse_name='" + finance_buseo + "' ";
	    }
	    if(finance_buseo.equals("금융소비자보호부")){
	    	WhereCondition+=" and junbuseo='Y' ";
	    }

        if(cmd.equals("search")){
			if(!start.equals("") && !end.equals("")){
				WhereCondition += " and to_char(creation_date, 'yyyymmdd') >= '"+start+"' and to_char(creation_date, 'yyyymmdd') <= '"+end+"'";
			}
			if (!category.equals("")) {
				WhereCondition += " and category = '"+category+"'";
			}
			if (!minwon_gubun.equals("")) {
				WhereCondition += " and minwon_gubun = '"+minwon_gubun+"'";
			}
			if (!status.equals("")) {
				WhereCondition += " and status = '"+status+"'";
			}
			if (!buse_name.equals("")) {
				WhereCondition += " and buse_name = '"+buse_name+"'";
			}
			if (!result.equals("")) {
				WhereCondition += " and result = '"+result+"'";
			}
			if(!FIELD.equals("")){
	    		WhereCondition+=" and " + FIELD + " like '%" + KEY + "%'";
	    	}
			else{
	    		WhereCondition+=" and (subject like '%" + KEY + "%' or name like '%" + KEY + "%' or content like '%" + KEY + "%')";
	    	}
		}

		int StartRecord = 0;
		int EndRecord   = 0;
		int DefaultListRecord = 10;
		int DefaultPageBlock = 10;

		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);



%>
<script language="javascript" src="js/common.js"></script>
<script language="javascript">
<!--

	function GoReg(){

		if(!compareDt(pbform.start.value, pbform.end.value)){
          alert("시작일은 종료일을 넘을 수 없습니다.");
		  return;
		}

		if(!pbform.start.value && !pbform.category.value && !pbform.minwon_gubun.value && !pbform.status.value && !pbform.buse_name.value && !pbform.result.value ){
			/*
			if(!pbform.FIELD.value){
				alert("조회구분을 해주세요");
				pbform.FIELD.focus();
				return;
			}
			*/
			if(!pbform.KEY.value){
				alert("검색어를 적어주세요");
				pbform.KEY.focus();
				return;
			}
		}

		pbform.cmd.value = "search";
	    pbform.submit();

	}

	function goView(mid,PAGE){
		pbform.mid.value=mid;
		pbform.PAGE.value=PAGE;
		pbform.action = "madmin_01_view.jsp";
		pbform.submit();
	}

	function goDetailView(mid,PAGE){
		pbform.mid.value=mid;
		pbform.PAGE.value=PAGE;
		pbform.action = "madmin_01_detail.jsp";
		pbform.submit();
	}

	function DownloadPopup(mid){
		pbform.mid.value=mid;
		var wint = (screen.height - 245) / 2;
		var winl = (screen.width - 300) / 2;
		winprops = 'height=245,width=300,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'
		winurl = 'include/file_popup1.jsp?mid='+mid;
		win = window.open(winurl, "file_popup1", winprops)
	}


//-->
</script>
<!-- 민원접수현황 검색 폼 -->
<form method=post name="pbform" action="">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="95" bgcolor="f4f4f4"  style="padding-left:25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0" background="img/title_bg.gif">
        <tr>
          <td width="135">
            <table width="135" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="70" align="center" class="admin_subject">민원접수현황</td>
              </tr>
            </table>
          </td>
          <td width="5"></td>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="30" class="adminsub_subject" style="padding-left:5;">
                  <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr>
                      <td width="60" class="bluesky">신청일</td>
                      <td width="100">
                        <input type="text" class="input01" size="10" name="start" value="<%=start%>" readonly>
                        <a href="javascript:Calendar(pbform.start);"><img src="img/btn_calender.gif" width="23" height="18" align="absmiddle" border="0"></a>
                      </td>
                      <td width="20" align="center">~</td>
                      <td width="100">
                        <input type="text" class="input01" size="10" name="end" value="<%=end%>" readonly>
                        <a href="javascript:Calendar(pbform.end);"><img src="img/btn_calender.gif" width="23" height="18" align="absmiddle" border="0"></a>
                      </td>
                      <td width="15">&nbsp;</td>
                      <td width="40" class="bluesky">분야</td>
                      <td>
                        <select name="category">
						  <option value="">전체</option>
                          <option value="수협은행"<%if(category.equals("수협은행")) { %>selected<% } %>>수협은행</option>
						  <option value="펀드판매관련"<%if(category.equals("펀드판매관련")) { %>selected<% } %>>펀드판매관련</option>
						  <option value="공제보험"<%if(category.equals("공제보험")) { %>selected<% } %>>공제보험</option>
						  <option value="바다마트"<%if(category.equals("바다마트")) { %>selected<% } %>>바다마트</option>
						  <option value="공판장(경매)"<%if(category.equals("공판장(경매)")) { %>selected<% } %>>공판장(경매)</option>
						  <option value="면세유류"<%if(category.equals("면세유류")) { %>selected<% } %>>면세유류</option>
						  <option value="회원조합/어촌계"<%if(category.equals("회원조합/어촌계")) { %>selected<% } %>>회원조합/어촌계</option>
						  <option value="고객지원불친절"<%if(category.equals("고객지원불친절")) { %>selected<% } %>>고객지원불친절</option>
						  <option value="기타사항"<%if(category.equals("기타사항")) { %>selected<% } %>>기타사항</option>
                        </select>
                      </td>
                      <td width="15">&nbsp;</td>
                      <td width="60" class="bluesky">민원분류</td>
                      <td>
                        <select name="minwon_gubun">
                          <option value="">전체</option>
						  <option value="일반민원"<%if(minwon_gubun.equals("일반민원")) { %>selected<% } %>>일반민원</option>
						  <option value="단순질의"<%if(minwon_gubun.equals("단순질의")) { %>selected<% } %>>단순질의</option>
                        </select>
                      </td>
                      <td width="15">&nbsp;</td>
                      <td width="60" class="bluesky">처리상태</td>
                      <td>
                         <select name="status">
                          <option value="">선택</option>
						  <option value="신청"<%if(status.equals("신청")) { %>selected<% } %>>신청</option>
						  <option value="접수"<%if(status.equals("접수")) { %>selected<% } %>>접수</option>
  						  <option value="이첩"<%if(status.equals("이첩")) { %>selected<% } %>>이첩</option>
  						  <option value="반송"<%if(status.equals("반송")) { %>selected<% } %>>반송</option>
  						  <option value="처리중"<%if(status.equals("처리중")) { %>selected<% } %>>처리중</option>
  						  <option value="답변완료"<%if(status.equals("답변완료")) { %>selected<% } %>>답변완료</option>
  						  <option value="민원철회"<%if(status.equals("민원철회")) { %>selected<% } %>>민원철회</option>
                        </select>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td height="30" class="adminsub_subject" style="padding-left:5;">
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="60" class="bluesky">담당부서</td>
                      <td width="100">
                        <select name="buse_name">
                          <option value="">선택</option>
                    <option value="감사실" <%if(buse_name.equals("감사실")) { %>selected<% } %>>감사실</option>
                    <option value="감사부" <%if(buse_name.equals("감사부")) { %>selected<% } %>>감사부</option>
                    <option value="ICT전략실" <%if(buse_name.equals("ICT전략실")) { %>selected<% } %>>ICT전략실</option>
                    <option value="인사총무부" <%if(buse_name.equals("인사총무부")) { %>selected<% } %>>인사총무부</option>
                    <option value="개인금융부" <%if(buse_name.equals("개인금융부")) { %>selected<% } %>>개인금융부</option>
                    <option value="공제보험부" <%if(buse_name.equals("공제보험부")) { %>selected<% } %>>공제보험부</option>
                    <option value="전략기획부" <%if(buse_name.equals("전략기획부")) { %>selected<% } %>>전략기획부</option>
                    <option value="기획부" <%if(buse_name.equals("기획부")) { %>selected<% } %>>기획부</option>
                    <option value="노량진시장 현대화사업본부" <%if(buse_name.equals("노량진시장 현대화사업본부")) { %>selected<% } %>>노량진시장 현대화사업본부</option>
                    <option value="단체급식사업단" <%if(buse_name.equals("단체급식사업단")) { %>selected<% } %>>단체급식사업단</option>
                    <option value="리스크관리본부" <%if(buse_name.equals("리스크관리본부")) { %>selected<% } %>>리스크관리본부</option>
                    <option value="방카펀드사업부(펀드)" <%if(buse_name.equals("방카펀드사업부(펀드)")) { %>selected<% } %>>방카펀드사업부(펀드)</option>
                    <option value="상호금융부" <%if(buse_name.equals("상호금융부")) { %>selected<% } %>>상호금융부</option>
                    <option value="수산경제연구원" <%if(buse_name.equals("수산경제연구원")) { %>selected<% } %>>수산경제연구원</option>
                    <option value="수산금융부" <%if(buse_name.equals("수산금융부")) { %>selected<% } %>>수산금융부</option>
                   <%--  <option value="가공물류부" <%if(buse_name.equals("가공물류부")) { %>selected<% } %>>가공물류부</option> --%>
                    <option value="신탁사업본부" <%if(buse_name.equals("신탁사업본부")) { %>selected<% } %>>신탁사업본부</option>
                    <option value="심사부" <%if(buse_name.equals("심사부")) { %>selected<% } %>>심사부</option>
<!--                    <option value="안전관리실" <%if(buse_name.equals("안전관리실")) { %>selected<% } %>>안전관리실</option>  -->
                    <option value="어업정보통신본부" <%if(buse_name.equals("어업정보통신본부")) { %>selected<% } %>>어업정보통신본부</option>
                    <option value="여신관리부" <%if(buse_name.equals("여신관리부")) { %>selected<% } %>>여신관리부</option>
                    <option value="연수원" <%if(buse_name.equals("연수원")) { %>selected<% } %>>연수원</option>
                    <option value="글로벌외환사업부" <%if(buse_name.equals("글로벌외환사업부")) { %>selected<% } %>>글로벌외환사업부</option>
                    <option value="경제기획부" <%if(buse_name.equals("경제기획부")) { %>selected<% } %>>경제기획부</option>
                    <option value="이사회사무국" <%if(buse_name.equals("이사회사무국")) { %>selected<% } %>>이사회사무국</option>
                    <option value="자금부" <%if(buse_name.equals("자금부")) { %>selected<% } %>>자금부</option>
                    <option value="자재사업부" <%if(buse_name.equals("자재사업부")) { %>selected<% } %>>자재사업부</option>
                    <option value="IT개발부" <%if(buse_name.equals("IT개발부")) { %>selected<% } %>>IT개발부</option>
                    <option value="정보보호본부" <%if(buse_name.equals("정보보호본부")) { %>selected<% } %>>정보보호본부</option>
                    <option value="조합감사실" <%if(buse_name.equals("조합감사실")) { %>selected<% } %>>조합감사실</option>
                    <option value="리스크관리실" <%if(buse_name.equals("리스크관리실")) { %>selected<% } %>>리스크관리실</option>
                    <option value="자금운용부" <%if(buse_name.equals("자금운용부")) { %>selected<% } %>>자금운용부</option>
                    <%-- <option value="준법감시팀" <%if(buse_name.equals("준법감시팀")) { %>selected<% } %>>준법감시팀</option> --%>
                    <option value="판매사업부" <%if(buse_name.equals("판매사업부")) { %>selected<% } %>>판매사업부</option>
                    <option value="총무부" <%if(buse_name.equals("총무부")) { %>selected<% } %>>총무부</option>
                    <option value="카드사업부" <%if(buse_name.equals("카드사업부")) { %>selected<% } %>>카드사업부</option>
                   <%--  <option value="해양투자금융센터" <%if(buse_name.equals("해양투자금융센터")) { %>selected<% } %>>해양투자금융센터</option> --%>
                    <option value="홍보실" <%if(buse_name.equals("홍보실")) { %>selected<% } %>>홍보실</option>
                    <option value="회원지원부" <%if(buse_name.equals("회원지원부")) { %>selected<% } %>>회원지원부</option>
                  <%--   <option value="사업구조개편단" <%if(buse_name.equals("사업구조개편단")) { %>selected<% } %>>사업구조개편단</option> --%>
					<option value="기업금융부" <%if(buse_name.equals("기업금융부")) { %>selected<% } %>>기업금융부</option>
				    <option value="여신정책부" <%if(buse_name.equals("여신정책부")) { %>selected<% } %>>여신정책부</option>
					<option value="정책보험부" <%if(buse_name.equals("정책보험부")) { %>selected<% } %>>정책보험부</option>
		            <option value="금융소비자보호부" <%if(buse_name.equals("금융소비자보호부")) { %>selected<% } %>>금융소비자보호부</option>
					<option value="디지털개발부" <%if(buse_name.equals("디지털개발부")) { %>selected<% } %>>디지털개발부</option>
					<%-- <option value="선원지원실" <%if(buse_name.equals("선원지원실")) { %>selected<% } %>>선원지원실</option> --%>
					<option value="준법감시실(중앙회)" <%if(buse_name.equals("준법감시실(중앙회)")) { %>selected<% } %>>준법감시실(중앙회)</option>
					<option value="준법감시실(조합)" <%if(buse_name.equals("준법감시실(조합)")) { %>selected<% } %>>준법감시실(조합)</option>
					
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
                      <td width="7"></td>

                      <td width="55" class="bluesky">처리결과</td>
                      <td width="100">
                        <select name="result">
                        <option value="">선택</option>
						  <option value="조치/시정"<%if(result.equals("조치/시정")) { %>selected<% } %>>조치/시정</option>
						  <option value="절차안내"<%if(result.equals("절차안내")) { %>selected<% } %>>절차안내</option>
						  <option value="합의/조정"<%if(result.equals("합의/조정")) { %>selected<% } %>>합의/조정</option>
						  <option value="설득이해"<%if(result.equals("설득이해")) { %>selected<% } %>>설득이해</option>
						  <option value="법령/제도상불능"<%if(result.equals("법령/제도상불능")) { %>selected<% } %>>법령/제도상불능</option>
						  <option value="내용불합리"<%if(result.equals("내용불합리")) { %>selected<% } %>>내용불합리</option>
						  <option value="재정"<%if(result.equals("재정")) { %>selected<% } %>>재정</option>
						  <option value="사실상이"<%if(result.equals("사실상이")) { %>selected<% } %>>사실상이</option>
						  <option value="사적분쟁"<%if(result.equals("사적분쟁")) { %>selected<% } %>>사적분쟁</option>
						  <option value="소송/수사"<%if(result.equals("소송/수사")) { %>selected<% } %>>소송/수사</option>
						  <option value="불문(민원아님)"<%if(result.equals("불문(민원아님)")) { %>selected<% } %>>불문(민원아님)</option>
						  <option value="건의/검토"<%if(result.equals("건의/검토")) { %>selected<% } %>>건의/검토</option>
						 <!-- -->
                        </select>
                      </td>
                      <td width="7"></td>
                      <td width="50" class="bluesky">조회구분</td>
                      <td>
                        <select name="FIELD">
                          <option value="">선택</option>
						  <option value="subject">제목</option>
						  <option value="content">내용</option>
  						  <option value="name">민원인</option>
                          <!-- -->
                        </select>
                      </td>
					  <td width="4"></td>
                      <td>
                        <input type="text" class="input01" size="24" name="KEY" value="<%=KEY%>">
                      </td>
                     <td width="4"></td>
                      <td width="40"><a href="javascript:GoReg();"><img src="img/btn_search.gif" width="38" height="17" border="0" alt="검색"></a></td>
                      <td width="40"><a href="javascript:pbform.reset();"><img src="img/btn_refresh.gif" width="48" height="17" border="0" alt="초기화"></a></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<!-- // 민원접수현황 검색 폼 -->
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td style="padding:0 0 10 10 ;">
      <!-- 검색결과 -->
      <table width="960" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30"><img src="img/result.gif" align="absmiddle"> 검색결과 :
            <span class="result_text">총<%=TotalRecordCount%>건</span></td>
          <td height="30" align="right"><a href="excel/madmin_excel.jsp?cmd=<%=cmd%>&KEY=<%=KEY%>&FIELD=<%=FIELD%>&start=<%=start%>&end=<%=end%>&status=<%=status%>&buse_name=<%=buse_name%>&category=<%=category%>&result=<%=result%>&minwon_gubun=<%=minwon_gubun%>"><img src="img/btn_excel.gif" width="66" height="21" alt="엑셀" border="0"></a></td>
        </tr>
        <tr>
          <td height="2" class="result_line" colspan="2"></td>
        </tr>
      </table>
      <!-- // 검색결과 -->
    </td>
  </tr>
  <!-- 민원접수현황 리스트 -->
  <tr>
    <td style="padding-left:25;"><img src="img/arrow.gif" width="13" height="16" align="absmiddle">
      <span class="txt_title">민원접수현황</span></td>
  </tr>
  <tr>
    <td style="padding:10 0 0 25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td colspan="11" height="2" class="board_topline"></td>
        </tr>
        <tr height="30">
          <td class="board_bg_title" width="50" align="center">번호</td>
          <td class="board_bg_title" width="120" align="center">분야</td>
          <td class="board_bg_title" width="80" align="center">민원분류</td>
          <td class="board_bg_title" width="220" align="center">제목</td>
          <td class="board_bg_title" width="80" align="center">민원인</td>
          <td class="board_bg_title" width="70" align="center">신청일</td>
          <td class="board_bg_title" width="70" align="center">처리상태</td>
          <td class="board_bg_title" width="90" align="center">담당부서</td>
          <td class="board_bg_title" width="75" align="center">처리결과</td>

<td class="board_bg_title" width="40" align="center">파일</td>
          <td class="board_bg_title" width="70" align="center">답변일</td>
        </tr>
        <tr>
          <td colspan="11" height="1" class="board_line"></td>
        </tr>
		<!-- loop start -->
        <%
			Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);

		    if( ResultVector.size() > 0){
				for (int i=0; i < ResultVector.size();i++){
					Hashtable h = (Hashtable)ResultVector.elementAt(i);

					String SUBJECT = (String)h.get("SUBJECT");	//제목
					if (SUBJECT.length() > 31){
						SUBJECT = SUBJECT.substring(0,31);
						SUBJECT += "...";
					}
					//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //글번호 계산
					int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//글번호 계산(역순)
					String answer_date =(String)h.get("ANSWER_DATE");
					String abandon_date =(String)h.get("ABANDON_DATE");
					String fname =(String)h.get("FNAME");
					String mid =(String)h.get("MID");
		%>

       <tr height="30"  onMouseOver=this.style.backgroundColor='F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'>

	      <td align="center"><%=listnum%></td>
		  <td align="center"><%=(String)h.get("CATEGORY") %></td>
          <td align="center"><%=(String)h.get("MINWON_GUBUN") %></td>
          <td style="padding-left:10;">
			<%if(answer_date==null || answer_date.equals("")){%>
       			<a href="javascript:goView('<%=mid%>',<%=PAGE %>);"><%=SUBJECT %></a>
			<%}else{%>
          		<a href="javascript:goDetailView('<%=mid%>',<%=PAGE %>);"><%=SUBJECT %></a>
			<%} %>
		  </td>
          <td align="center"><%=(String)h.get("NAME") %></td>
          <td align="center"><%=(String)h.get("CREATION_DATE") %></td>
          <td align="center"><%=(String)h.get("STATUS") %></td>
          <td align="center"><%=(String)h.get("BUSE_NAME") %></td>
          <td align="center"><%=(String)h.get("RESULT") %></td>
		  <%if(fname==null || fname.equals("")){%>
		  <td align="center"></td>
		  <%}else{%>
		  <td align="center"><a href="javascript:DownloadPopup('<%=mid%>');"><img src="img/file_icon.gif" border="0" align="absmiddle"></a></td>
		  <%} %>
		  <%if("철회완료".equals((String)h.get("STATUS"))){ %>
          <td align="center"><%=abandon_date%></td>
          <%}else{ %>
          <td align="center"><%=answer_date%></td>
          <%} %>
        </tr>
        <tr>
          <td colspan="11" class="board_line2" height="1"></td>
        </tr>
        <%
			        }
				} else {
			%>
					<tr>
						<td class="no" align="center" colspan="11">등록 자료가 없습니다.</td>
					</tr>
			<%
				}
			%>
      </table>
      <br>
      <!-- // 민원접수현황 리스트 -->
      <!-- 페이지 넘버링 -->
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">
		<% if(TotalRecordCount > 0) { %>
			<%=FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock, "madmin_01.jsp?KEY="+KEY+"&cmd=" + cmd + "&FIELD=" + FIELD + "&start=" + start + "&end=" + end + "&category=" + category + "&minwon_gubun=" + minwon_gubun + "&status=" + status + "&buse_name=" + buse_name + "&PAGE=","<img src=img/board_prev.gif width=13 height=13 align=absmiddle border=0>","<img src=img/board_next.gif width=13 height=13 align=absmiddle border=0>")%>
			<% } %>
          </td>
         </tr>
      </table>
      <!-- 페이지 넘버링 -->
    </td>
  </tr>
</table>
<input type="hidden" name="cmd">
<input type="hidden" name="mid">
<input type="hidden" name="PAGE">
</form>
<%@ include file="include/bottom.jsp" %>
<%
	} catch(Exception e) {
		out.println("madmin_01.jsp : " + e.getMessage());
	} finally {

	}
%>