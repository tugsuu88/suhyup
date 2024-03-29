<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>
<%@ page import="common.Constants" %>
<%@ page import="java.sql.*" %>	

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %>
<%@ include file="include/top_menu05.jsp" %>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="session" class="Bean.Front.Common.FrontDbUtil"/>

<%
	String ListPage = Converter.nullchk(request.getParameter("ListPage"));
	//String pageNum = request.getParameter("pageNum");
	String myPage = request.getRequestURI();
	String finance_buseo=Converter.nullchk((String)session.getAttribute("buseo"));

	try
	{

		// 사용할 객체 초기화
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

/*		int k = 0; */


		// 데이터베이스 객체 생성
		Class.forName(Constants.DB_DRIVER);
		conn = DriverManager.getConnection(Constants.DB_URL, Constants.DB_ID, Constants.DB_PASSWORD);

		// 게시물 목록을 얻는 쿼리 실행
		pstmt = conn.prepareStatement("SELECT DEPTNAME FROM JHS_TEST");

		rs = pstmt.executeQuery();


		String cmd = Converter.nullchk(request.getParameter("cmd"));	//검색어
	    String KEY = Converter.nullchk(request.getParameter("KEY"));	//검색어
	    if(KEY != null && !KEY.equals("")) {
	    	KEY = StringReplace.sqlFilter(KEY);		//금지어 필터링
	    }
	    //out.println("KEY : " + KEY + "<br>");
	    String FIELD = Converter.nullchk(request.getParameter("FIELD"));	//검색구분
	    String startday=Converter.nullchk(request.getParameter("startday"));
	    String endday=Converter.nullchk(request.getParameter("endday"));
	    String status=Converter.nullchk(request.getParameter("status"));
	    String buse_name=Converter.nullchk(request.getParameter("buse_name"));
		String result=Converter.nullchk(request.getParameter("result"));

		int PAGE = 1;

		///////////////////////////////////////////////////////////////////////////
	    String TableName = " sh_financetrouble ";
	    String SelectCondition = null;
	    String WhereCondition = null;
	    String OrderCondition = null;

		if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){
			PAGE = 1;
	    }else{
			PAGE = Integer.parseInt(request.getParameter("PAGE"));
	    }

	    SelectCondition = " parcode,thid, name,title,publication,code,result,buseo,";
	    SelectCondition += "to_char(time1, 'YYYY-MM-DD') AS time1, to_char(time2, 'YYYY-MM-DD') AS time2, to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date ";
	    OrderCondition  = " ORDER BY thid DESC";
	    WhereCondition=" where parcode=2 ";
	    if(!finance_buseo.equals("감사실") &&  !finance_buseo.equals("금융소비자보호부") || !finance_buseo.equals("감사부")){
	    	WhereCondition+=" and buseo='" + finance_buseo + "' ";
	    }
	    if(finance_buseo.equals("금융소비자보호부")){
	    	WhereCondition+=" and junbuseo='Y' ";
	    }

	    if(cmd.equals("search")){
	    	if(!startday.equals("") && !endday.equals("")){
	    		WhereCondition+=" and to_char(time1,'YYYY-MM-DD')>='" + startday + "' and to_char(time1, 'YYYY-MM-DD')<='" + endday + "'";
	    	}
	    	if(!status.equals("")){
	    		WhereCondition+=" and code='" + status + "'";
	    	}
	    	if(!buse_name.equals("")){
	    		WhereCondition+=" and buseo='" + buse_name + "'";
	    	}
			if(!result.equals("")){
	    		WhereCondition+=" and result='" + result + "'";
	    	}
	    	if(!FIELD.equals("")){
	    		WhereCondition+=" and " + FIELD + " like '%" + KEY + "%'";
	    	}
			else{
	    		WhereCondition+=" and (title like '%" + KEY + "%' or name like '%" + KEY + "%' or text like '%" + KEY + "%')";
	    	}
	    }

		int StartRecord = 0;
		int EndRecord   = 0;
		int DefaultListRecord = 10;
		int DefaultPageBlock = 10;

		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
		//out.print("TotalRecordCount : " + TotalRecordCount + "<br><br>");
		///////////////////////////////////////////////////////////////////////////
%>
<script language="javascript" src="js/common.js"></script>
<script language="javascript">
<!--
	function GoReg(){
		if(!pbform.startday.value){
			if(pbform.endday.value){
				alert("시작일을 넣어주세요");
				pbform.startday.focus();
				return;
			}
		}
		if(pbform.startday.value){
			if(!pbform.endday.value){
				alert("종료일을 넣어주세요");
				pbform.endday.focus();
				return;
			}
		}

		if(!compareDt(pbform.startday.value, pbform.endday.value)){
          alert("시작일은 종료일을 넘을 수 없습니다.");
		  return;
		}

		if(!pbform.startday.value && !pbform.buse_name.value && !pbform.status.value && !pbform.result.value ){
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

	function goView(thid,PAGE){
		pbform.thid.value=thid;
		pbform.PAGE.value=PAGE;
		pbform.action = "absurd_view.jsp";
		pbform.submit();
	}
	function goDetailView(thid,PAGE){
		pbform.thid.value=thid;
		pbform.PAGE.value=PAGE;
		pbform.action = "absurd_detail.jsp";
		pbform.submit();
	}

//-->
</script>
<!-- 금융부조리 제보 설명 -->
<form method=post name="pbform" action="" style="margin:0px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="95" bgcolor="f4f4f4"  style="padding-left:25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0" background="img/title_bg.gif">
        <tr>
          <td width="135">
            <table width="135" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="70" align="center" class="admin_subject">금융부조리신고</td>
              </tr>
            </table>
          </td>
          <td width="5"></td>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="30" class="adminsub_subject" style="padding-left:10;">
                  <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr>
                      <td width="60" class="bluesky">신청일</td>
                      <td width="100">
                        <input type="text" class="input01" size="10" name="startday" value="">
                        <a href="javascript:Calendar(pbform.startday);"><img src="img/btn_calender.gif" width="23" height="18" align="absmiddle" border="0"></a>
                      </td>
                      <td width="20" align="center">~</td>
                      <td width="100">
                        <input type="text" class="input01" size="10" name="endday" value="">
                        <a href="javascript:Calendar(pbform.endday);"><img src="img/btn_calender.gif" width="23" height="18" align="absmiddle" border="0"></a>
                      </td>
                      <td width="15">&nbsp;</td>
                      <td width="60" class="bluesky">처리상태</td>
                      <td width="50">
                        <select name="status">
                          <option value="">선택</option>
                          <option value="신청"<%if(status.equals("신청")) { %>selected<% } %>>신청</option>
                          <option value="접수"<%if(status.equals("접수")) { %>selected<% } %>>접수</option>
                          <option value="이첩"<%if(status.equals("이첩")) { %>selected<% } %>>이첩</option>
                          <option value="반송"<%if(status.equals("반송")) { %>selected<% } %>>반송</option>
                          <option value="처리중"<%if(status.equals("처리중")) { %>selected<% } %>>처리중</option>
                          <option value="답변완료"<%if(status.equals("답변완료")) { %>selected<% } %>>답변완료</option>
                          <option value="민원철회"<%if(status.equals("민원철회")) { %>selected<% } %>>민원철회</option>
                          <!-- -->
                        </select>
                      </td>
                      <td width="15">&nbsp;</td>
                      <td width="60" class="bluesky">처리결과</td>
                      <td>
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
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td height="30" class="adminsub_subject" style="padding-left:10;">
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="60" class="bluesky">담당부서</td>
                      <td width="100">
	  					
                        <select class="wid40" name="johap_code" title="조합명 선택!">
							<option value="">선택</option>
				  			<% while (rs.next()) { out.println("<option value='" + rs.getString("DEPTNAME") + "'>" + rs.getString("DEPTNAME") + "</option>"); } %>
						</select>
							<!--
                    <option value="감사실" <%if(buse_name.equals("감사실")) { %>selected<% } %>>감사실</option>
                    <option value="감사부" <%if(buse_name.equals("감사부")) { %>selected<% } %>>감사부</option>
                    <option value="IT관리실" <%if(buse_name.equals("IT관리실")) { %>selected<% } %>>IT관리실</option>
                    <option value="인사총무부" <%if(buse_name.equals("인사총무부")) { %>selected<% } %>>인사총무부</option>
                    <option value="개인금융부" <%if(buse_name.equals("개인금융부")) { %>selected<% } %>>개인금융부</option>
                    <option value="공제보험부" <%if(buse_name.equals("공제보험부")) { %>selected<% } %>>공제보험부</option>
                    <option value="전략기획부" <%if(buse_name.equals("전략기획부")) { %>selected<% } %>>전략기획부</option>
                    <option value="기획부" <%if(buse_name.equals("기획부")) { %>selected<% } %>>기획부</option>
                    <option value="노량진시장 현대화사업본부" <%if(buse_name.equals("노량진시장 현대화사업본부")) { %>selected<% } %>>노량진시장 현대화사업본부</option>
                    <option value="단체급식사업단" <%if(buse_name.equals("단체급식사업단")) { %>selected<% } %>>단체급식사업단</option>
                    <option value="리스크관리본부" <%if(buse_name.equals("리스크관리본부")) { %>selected<% } %>>리스크관리본부</option>
                    <option value="고객자산관리부(펀드)" <%if(buse_name.equals("고객자산관리부(펀드)")) { %>selected<% } %>>고객자산관리부(펀드)</option>
                    <option value="상호금융부" <%if(buse_name.equals("상호금융부")) { %>selected<% } %>>상호금융부</option>
                    <option value="수산경제연구원" <%if(buse_name.equals("수산경제연구원")) { %>selected<% } %>>수산경제연구원</option>
                    <option value="수산금융부" <%if(buse_name.equals("수산금융부")) { %>selected<% } %>>수산금융부</option>
                    <option value="가공물류부" <%if(buse_name.equals("가공물류부")) { %>selected<% } %>>가공물류부</option>
                    <option value="신탁사업본부" <%if(buse_name.equals("신탁사업본부")) { %>selected<% } %>>신탁사업본부</option>
                    <option value="심사부" <%if(buse_name.equals("심사부")) { %>selected<% } %>>심사부</option>
<!--                    <option value="안전관리실" <%if(buse_name.equals("안전관리실")) { %>selected<% } %>>안전관리실</option>
  -->
  <!--
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
                    <option value="준법감시팀" <%if(buse_name.equals("준법감시팀")) { %>selected<% } %>>준법감시팀</option>
                    <option value="판매사업부" <%if(buse_name.equals("판매사업부")) { %>selected<% } %>>판매사업부</option>
                    <option value="총무부" <%if(buse_name.equals("총무부")) { %>selected<% } %>>총무부</option>
                    <option value="카드사업부" <%if(buse_name.equals("카드사업부")) { %>selected<% } %>>카드사업부</option>
                    <option value="해양투자금융센터" <%if(buse_name.equals("해양투자금융센터")) { %>selected<% } %>>해양투자금융센터</option>
                    <option value="홍보실" <%if(buse_name.equals("홍보실")) { %>selected<% } %>>홍보실</option>
                    <option value="회원지원부" <%if(buse_name.equals("회원지원부")) { %>selected<% } %>>회원지원부</option>
                    <option value="사업구조개편단" <%if(buse_name.equals("사업구조개편단")) { %>selected<% } %>>사업구조개편단</option>
                    <option value="기업금융부" <%if(buse_name.equals("기업금융부")) { %>selected<% } %>>기업금융부</option>
                    <option value="여신정책부" <%if(buse_name.equals("여신정책부")) { %>selected<% } %>>여신정책부</option>
                    <option value="정책보험부" <%if(buse_name.equals("정책보험부")) { %>selected<% } %>>정책보험부</option>
                    <option value="금융소비자보호부" <%if(buse_name.equals("금융소비자보호부")) { %>selected<% } %>>금융소비자보호부</option>
                    <option value="디지털금융부" <%if(buse_name.equals("디지털금융부")) { %>selected<% } %>>디지털금융부</option>
                    <option value="선원지원실" <%if(buse_name.equals("선원지원실")) { %>selected<% } %>>선원지원실</option>
					<option value="준법감시실(중앙회)" <%if(buse_name.equals("준법감시실(중앙회)")) { %>selected<% } %>>준법감시실(중앙회)</option>
					<option value="준법감시실(조합)" <%if(buse_name.equals("준법감시실(조합)")) { %>selected<% } %>>준법감시실(조합)</option>

                        </select>
-->
                      </td>
                      <td width="20">&nbsp;</td>
                      <td width="60" class="bluesky">조회구분</td>
                      <td width="70">
                        <select name="FIELD">
                          <option value="">선택</option>
						  <option value="title">제목</option>
						  <option value="text">내용</option>
  						  <option value="name">민원인</option>
                          <!-- -->
                        </select>
                      </td>
                      <td>
                        <input type="text" class="input01" size="48" name="KEY" value="<%=KEY%>">
                      </td>
                      <td width="15">&nbsp;</td>
                      <td width="42"><a href="javascript:GoReg();"><img src="img/btn_search.gif" width="38" height="17" border="0" alt="검색"></a></td>
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
<!-- // 금융부조리 제보 설명 -->
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td style="padding:0 0 10 10 ;">
      <!-- 검색결과 -->
      <table width="960" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30"><img src="img/result.gif" align="absmiddle"> 검색결과 :
            <span class="result_text">총 <%=TotalRecordCount %>건</span></td>
          <td height="30" align="right"><a href="excel/absurd_excel.jsp?cmd=<%=cmd%>&KEY=<%=KEY%>&FIELD=<%=FIELD%>&startday=<%=startday%>&endday=<%=endday%>&status=<%=status%>&buse_name=<%=buse_name%>&result=<%=result%>"><img src="img/btn_excel.gif" width="66" height="21" alt="엑셀" border="0"></a></td>
        </tr>
        <tr>
          <td height="2" class="result_line" colspan="2"></td>
        </tr>
      </table>
      <!-- // 검색결과 -->
    </td>
  </tr>
  <!-- 리스트 -->
  <tr>
    <td style="padding-left:25;"><img src="img/arrow.gif" width="13" height="16" align="absmiddle">
      금융사고 제보</td>
  </tr>
  <tr>
    <td style="padding:10 0 0 25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td colspan="10" height="2" class="board_topline"></td>
        </tr>
        <tr height="30">
          <td class="board_bg_title" width="70" align="center">번호</td>
          <td class="board_bg_title" width="120" align="center">특수코드</td>
          <td class="board_bg_title" width="300" align="center">제목</td>
          <td class="board_bg_title" width="80" align="center">민원인</td>
          <td class="board_bg_title" width="70" align="center">신청일</td>
          <td class="board_bg_title" width="70" align="center">처리상태</td>
          <td class="board_bg_title" width="90" align="center">담당부서</td>
<!--
          <td class="board_bg_title" width="75" align="center">처리결과</td>
-->
          <td class="board_bg_title" width="70" align="center">답변일</td>
        </tr>
        <tr>
          <td colspan="10" height="1" class="board_line"></td>
        </tr>
        <%
				Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);

			    if( ResultVector.size() > 0){
					for (int i=0; i < ResultVector.size();i++){
						Hashtable h = (Hashtable)ResultVector.elementAt(i);

						String TITLE = (String)h.get("TITLE");	//제목
						if (TITLE.length() > 31){
							TITLE = TITLE.substring(0,31);
							TITLE += "...";
						}
						//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //글번호 계산
						int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//글번호 계산(역순)
						String time2=(String)h.get("TIME2");
						String code=(String)h.get("CODE");
		%>
        <tr height="30"  onMouseOver=this.style.backgroundColor='F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'>
          <td align="center"><%=listnum %></td>
          <td align="center"><%=(String)h.get("PUBLICATION") %></td>
          <td style="padding-left:10;">
          <%if(time2==null || time2.equals("")){%>
       			<a href="javascript:goView('<%=(String)h.get("THID")%>',<%=PAGE %>);"><%=TITLE %></a>
          <%}else{%>
          		<a href="javascript:goDetailView('<%=(String)h.get("THID")%>',<%=PAGE %>);"><%=TITLE %></a>
          <%} %>
          </td>
          <td align="center"><%=(String)h.get("NAME") %></td>
          <td align="center"><%=(String)h.get("TIME1") %></td>
          <td align="center"><%=code %></td>
          <td align="center"><%=(String)h.get("BUSEO") %></td>
<!--
          <td align="center"><%=(String)h.get("RESULT") %></td>
-->
          <%if("철회완료".equals(code)){ %>
          <td align="center"><%=(String)h.get("ABANDON_DATE")%></td>
          <%}else{ %>
          <td align="center"><%=time2%></td>
          <%} %>
        </tr>
        <tr>
          <td colspan="9" class="board_line2" height="1"></td>
        </tr>
        <%
					}
				} else {
			%>
					<tr>
						<td class="no" align="center" colspan="9">등록 자료가 없습니다.</td>
					</tr>
			<%
				}
			%>
      </table>
      <br>
      <!-- // 리스트 -->
      <!-- 페이지 넘버링 -->
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">
          	<% if(TotalRecordCount > 0) { %>
			<%=FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock, "absurd.jsp?KEY="+KEY+"&cmd=" + cmd + "&FIELD=" + FIELD + "&startday=" + startday + "&endday=" + endday + "&status=" + status + "&buse_name=" + buse_name + "&PAGE=","<img src=img/board_prev.gif width=13 height=13 align=absmiddle border=0>","<img src=img/board_next.gif width=13 height=13 align=absmiddle border=0>")%>
			<% } %>
          </td>
        </tr>
      </table>
      <!-- 페이지 넘버링 -->
    </td>
  </tr>
</table>
<input type="hidden" name="cmd">
<input type="hidden" name="thid">
<input type="hidden" name="PAGE">
</form>
<%@ include file="include/bottom.jsp" %>
<%
	} catch(Exception e) {
		out.println("absurd.jsp : " + e.getMessage());
	} finally {

	}
%>