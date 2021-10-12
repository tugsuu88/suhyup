<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %>
<%@ include file="include/top_menu07.jsp" %>
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

		String FIELD = Converter.nullchk(request.getParameter("FIELD"));	//검색구분
		String category = Converter.nullchk(request.getParameter("category"));
		
		int PAGE = 1;

		///////////////////////////////////////////////////////////////////////////
		String TableName = " sh_minwon_faq ";
		String SelectCondition = null;
		String WhereCondition = null;
		String OrderCondition = null;
		
		if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){
			PAGE = 1;
	    }else{
			PAGE = Integer.parseInt(request.getParameter("PAGE"));
	    }
	
     
	    SelectCondition = " sh_no, sh_code, sh_subject, sh_content, sh_hit, sh_name, to_char(sh_indate, 'YYYY-MM-DD') AS sh_indate";
		OrderCondition  = " ORDER BY sh_no DESC ";
		WhereCondition = "where 1 = 1 ";
		
		if(cmd.equals("search")){
			if (!category.equals("")) {
				WhereCondition += " and sh_code = '"+category+"'";
			}
			if(!FIELD.equals("")){
	    		WhereCondition+=" and " + FIELD + " like '%" + KEY + "%'";
	    	}
		}
		
		int StartRecord = 0;
		int EndRecord   = 0;
		int DefaultListRecord = 10;
		int DefaultPageBlock = 10;

		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
		//out.println("TotalRecordCount ======================================= " + TotalRecordCount + "<br><br>");
		///////////////////////////////////////////////////////////////////////////
	

%>
<script language="javascript">
<!--
	
	function GoReg(){
		
		
		pbform.cmd.value = "search";
	    pbform.submit();
     
	}
	function goModify(sh_no){
		pbform.sh_no.value=sh_no;
		pbform.action = "faq_modify.jsp";
		pbform.submit();
	}
//-->
</script>
<form method=post name="pbform" action="">
<input type="hidden" name="cmd" value="">
<!-- FAQ   검색-->
  <div class="list-header">
    <table border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td rowspan="2" class="admin_subject">FAQ</td>
        <td height="30" style="padding-left:10;" class="bluesky" width="135">분류코드</td>
        <td>
          <select name="category">
            <option value="">전체</option>
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
        <td style="padding-left:10;" class="bluesky">조회구분</td>
        <td>
          <select name="FIELD">
            <option value="">선택하세요</option>
            <option value="sh_subject">제목</option>
            <option value="sh_content">내용</option>
            <!-- -->
          </select>
          <input type="text" class="input01" size="48" name="KEY" value="">
          <a href="javascript:GoReg();"><img src="img/btn_search.gif" width="38" height="17" border="0" alt="검색"></a>
          <a href="javascript:pbform.reset();"><img src="img/btn_refresh.gif" width="48" height="17" border="0" alt="초기화"></a>
        </td>
      </tr>
    </table>
  </div>

<!-- // FAQ 검색-->
<br>
  <div class="tbl-wrap">
      <!-- 검색결과 -->
      <table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30"><img src="img/result.gif" align="absmiddle"> 검색결과 :
            <span class="result_text">총<%=TotalRecordCount%>건</span></td>
          <td height="30" align="right"><a href="faq_write.jsp"><img src="img/btn_upload.gif" width="55" height="21" alt="등록" border="0"></a></td>
          <td height="30" align="right" width="70"><a href="excel/faq_excel.jsp?cmd=<%=cmd%>&KEY=<%=KEY%>&FIELD=<%=FIELD%>&category=<%=category%>"><img src="img/btn_excel.gif" width="66" height="21" alt="엑셀" border="0"></td>
        </tr>
      </table>
      <table border="0" cellspacing="0" cellpadding="0" class="tbl-list">
        <tr>
          <td class="board_bg_title" align="center">No</td>
          <td class="board_bg_title"  align="center">분류코드</td>
          <td class="board_bg_title"  align="center">제목</td>
          <td class="board_bg_title" align="center">조회수</td>
          <td class="board_bg_title"  align="center">등록자</td>
          <td class="board_bg_title"  align="center">등록일</td>
        </tr>
       <%
			Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);
			   
		    if( ResultVector.size() > 0){
				for (int i=0; i < ResultVector.size();i++){
					Hashtable h = (Hashtable)ResultVector.elementAt(i);
			
					String SH_SUBJECT = (String)h.get("SH_SUBJECT");	//제목
					if (SH_SUBJECT.length() > 31){
						SH_SUBJECT = SH_SUBJECT.substring(0,31);
						SH_SUBJECT += "...";
					}
					//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //글번호 계산
					int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//글번호 계산(역순)
					//String answer_date =(String)h.get("ANSWER_DATE");
		%>
       <tr  onMouseOver=this.style.backgroundColor='F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'>
          <td align="center"><%=listnum%></td>
          <td align="center"><%=(String)h.get("SH_CODE") %></td>
          <td style="padding-left:10;"><a href="javascript:goModify('<%=(String)h.get("SH_NO")%>');"><%=SH_SUBJECT%></a></td>
          <td align="center"><%=(String)h.get("SH_HIT") %></td>
          <td align="center"><%=(String)h.get("SH_NAME") %></td>
          <td align="center"><%=(String)h.get("SH_INDATE") %></td>
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
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">
          	<% if(TotalRecordCount > 0) { %>
			<%=FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock, "madmin_01.jsp?KEY="+KEY+"&cmd=" + cmd + "&FIELD=" + FIELD + "&sh_code=" + category +"&PAGE=","<img src=img/board_prev.gif width=13 height=13 align=absmiddle border=0>","<img src=img/board_next.gif width=13 height=13 align=absmiddle border=0>")%>
			<% } %>
          </td>
        </tr>
      </table>
  </div>
<input type="hidden" name="sh_no">
</form>
<%@ include file="include/bottom.jsp" %>
<%
	} catch(Exception e) {
		out.println("faq.jsp : " + e.getMessage());
	} finally {

	}
%>