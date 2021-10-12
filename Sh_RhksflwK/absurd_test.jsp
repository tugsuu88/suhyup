<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %>
<%@ include file="include/top_menu05.jsp" %>


<%
	// 사용할 객체 초기화
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;	

	int i = 0;	
	
	try 
	{
		Class.forName("oracle.jdbc.OracleDriver");
		conn = DriverManager.getConnection("jdbc:oracle:thin:@138.251.1.134:3006:dmzdbs", "SUHYUP", "SUHYUP_HOME");

		// 게시물 목록을 얻는 쿼리 실행
		pstmt = conn.prepareStatement("SELECT DEPTNAME FROM jhs_test");

		rs = pstmt.executeQuery();
		//rs.next();		
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<title>### 회원조합 전산기기 신청 ###</title>
<link />
</head>

<link rel="stylesheet" type="text/css" href="css/board.css" />
<script type="text/javascript" src="js/board.js"></script>

<body>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="session" class="Bean.Front.Common.FrontDbUtil"/>

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
	    if(!finance_buseo.equals("감사실") &&  !finance_buseo.equals("금융소비자보호단") || !finance_buseo.equals("감사부")){
	    	WhereCondition+=" and buseo='" + finance_buseo + "' ";
	    }
	    if(finance_buseo.equals("금융소비자보호단")){
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



	    String TableName2 = " JHS_TEST ";
	    String SelectCondition2 = null;
	    String WhereCondition2 = null;
        String OrderCondition2 = null;

	    SelectCondition2 = " DEPTNAME";
	    WhereCondition2 =" where 1=1 ";
	    OrderCondition2  = " ORDER BY DEPTNAME";

	   
		Vector TableDept = FrontBoard.list(TableName2, SelectCondition2, WhereCondition2, OrderCondition2, 0, 1);
                            //////////////////////////






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
<% while (rs.next()) { out.println("<option value='" + rs.getString("DEPTNAME") + "'>" + rs.getString("DEPTNAME") + "</option>"); i++;} %>
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

</body>
</html>

<%@ include file="include/bottom.jsp" %>
<%
	} catch(Exception e) {
		out.println("absurd.jsp : " + e.getMessage());
	} finally {

	}
%>