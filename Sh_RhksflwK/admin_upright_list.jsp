<%@ page import="java.util.*, util.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1" />
<jsp:useBean id="FrontDbUtil" scope="session" class="Bean.Front.Common.FrontDbUtil" />

<%@ include file="include/admin_session.jsp"%>
<%@ include file="include/logincheck.jsp"%>
<%@ include file="include/top_login.jsp"%>
<%@ include file="include/top_menu0203.jsp"%>

<%
	String cmd = Converter.nullchk(request.getParameter("cmd"));
	String start = Converter.nullchk(request.getParameter("start"));
	String end = Converter.nullchk(request.getParameter("end"));
	String FIELD = Converter.nullchk(request.getParameter("FIELD"));
	String searchText = Converter.nullchk(request.getParameter("searchText"));
	
	int PAGE = 1;
	String TableName = " UPRIGHT_MEMBER ";
	String SelectCondition = null;
	String WhereCondition = null;
	String OrderCondition = null;
	
	if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){
		PAGE = 1;
	}else{
		PAGE = Integer.parseInt(request.getParameter("PAGE"));
	}
	
	SelectCondition = " CINDEX, to_char(INS_DATE, 'YYYYMMDD') as INS_DATE , CMEM_NM, GMEM_NM, GJOHAP, GFILE_NAME";
	OrderCondition  = " ORDER BY CINDEX  DESC ";
	WhereCondition  = " WHERE 1=1 ";
	
	if(cmd.equals("search")){
		if (!start.equals("") && !end.equals("") && !FIELD.equals("")) {
				WhereCondition += "and to_char(INS_DATE, 'yyyymmdd') >= '" + start
								+ "'and to_char(INS_DATE, 'yyyymmdd') <= '" + end
								+ "'and "+ FIELD +" like '%" + searchText + "%'";
		} else if (!start.equals("") && !end.equals("") && FIELD.equals("")) {
			WhereCondition += " and to_char(INS_DATE, 'yyyymmdd') >= '" + start
					+ "' and to_char(INS_DATE, 'yyyymmdd') <= '" + end + "'";
		} else if (!FIELD.equals("") && start.equals("") && end.equals("")) {
			WhereCondition += " and "+ FIELD +" like '%" + searchText + "%'";
		} else {
		
		}
		
	}
	System.out.println("###########"+TableName);
	System.out.println("###########"+WhereCondition);
	
	int TotalRecordCount =0;
	
	int StartRecord = 0;
	int EndRecord   = 0;
	int DefaultListRecord = 10;
	int DefaultPageBlock = 10;
	
	TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
	
%>
<script language="javascript" src="js/common.js"></script>
<script type="text/javascript">
	function GoReg(){
	
		pbform.cmd.value = "search";
	    pbform.submit();
    
	}
	
	function reset() {
		
		pbform.cmd.value = "";
		pbform.start.value = "";
		pbform.end.value = "";
		pbform.submit();
		
	}
	
	function goView(index,page){
		pbform.index.value=index;
		pbform.page.value=page;
		pbform.action = "admin_upright_view.jsp";
		pbform.submit();
	}
	
	function DownloadPopup(index) {
		pbform.index.value = index;
		var wint = (screen.height - 245) / 2;
		var winl = (screen.width - 300) / 2;
		winprops = 'height=245,width=300,top=' + wint + ',left=' + winl	+ ',status=no,scrollbars=no,resize=no'
		winurl = 'include/upright_file_popup.jsp?index=' + index;
		win = window.open(winurl, "file_popup1", winprops)
	}
</script>
<form method=post name="pbform" action="">
	<input type="hidden" name="cmd" value="">
	<input type="hidden" name="index" value="">
	<input type="hidden" name="page" value="">
	<div class="list-header">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td rowspan="2" class="admin_subject">청렴수협인상</td>
				<td class="bluesky">제출일자</td>
				<td>
					<input type="text" class="input01" size="10" name="start" value="<%=start %>">
					<a href="javascript:Calendar(pbform.start);">
						<img src="img/btn_calender.gif" width="23" height="18" align="absmiddle" border="0">
					</a>
					<span>~</span>
					<input type="text" class="input01" size="10" name="end" value="<%=end %>">
					<a href="javascript:Calendar(pbform.end);">
						<img src="img/btn_calender.gif" width="23" height="18" align="absmiddle" border="0">
					</a>
				</td>
			</tr>
			<tr>
				<td class="bluesky">구분</td>
				<td>
					<select name="FIELD">
						<option value="">전체</option>
						<option value="CMEM_NM">추천하는 사람</option>
						<option value="GMEM_NM">추천받는 사람</option>
					</select>
					<input type="text" name="searchText" id="">
					<a href="javascript:GoReg();">
						<img src="img/btn_search.gif" width="38" height="17" border="0" alt="검색">
					</a>
					<a href="javascript:reset();">
						<img src="img/btn_refresh.gif" width="48" height="17" border="0" alt="초기화">
					</a>
				</td>
			</tr>
		</table>
	</div>
	
	<br>
	<div class="tbl-wrap">
			<div class="subtit">
				<img src="img/arrow.gif" width="13" height="16" align="absmiddle">
				<span class="txt_title">청렴수협인상 민원접수현황</span>
			<div>
				<table border="0" cellspacing="0" cellpadding="0" class="tbl-list">
					<tr height="30">
						<td class="board_bg_title" align="center">번호</td>
						<td class="board_bg_title" align="center">제출일자</td>
						<td class="board_bg_title"  align="center">추천하는 사람</td>
						<td class="board_bg_title"  align="center">추천받는 사람</td>
						<td class="board_bg_title" align="center">조합명</td>
						<td class="board_bg_title" align="center">첨부파일</td>
					</tr>
					<tbody>
						<%
							System.out.println("##### 리스트 시작 #####");
							Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);
							
							String index = "";
							String insDate = "";
							String cName = "";
							String gName = "";
							String gJohap = "";
							String fileName = "";
							String iDate = "";
							if( ResultVector.size() > 0){
								for (int i=0; i < ResultVector.size();i++){
									Hashtable h = (Hashtable)ResultVector.elementAt(i);
									
									index 	 = (String)h.get("CINDEX");
									iDate    = (String)h.get("INS_DATE");
									cName    = (String)h.get("CMEM_NM");
									gName    = (String)h.get("GMEM_NM");
									gJohap   = (String)h.get("GJOHAP");
									fileName = (String)h.get("GFILE_NAME");
									
									//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //글번호 계산
									int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//글번호 계산(역순)
								
							%>
									<tr>
										<td align="center"><%=index %></td>
										<td align="center"><%=iDate %></td>
										<td align="center">
											<a href="javascript:goView('<%=index%>','<%=PAGE%>');"><%=cName %></a>
										</td>
										<td align="center"><%=gName %></td>
										<td align="center"><%=gJohap %></td>
										<% if("".equals(fileName)) { %>
											<td></td>
										<% } else { %>
											<td align="center">
												<a href="javascript:DownloadPopup('<%=index%>');">
													<img src="/pub_img/icon_file01.gif" alt="파일첨부" />
												</a>
											</td>
										<% } %>
									</tr>
									
							<%
									} //for
								
								} else {//if
							%>
								 <tr>
			                     	<td class="noData" colspan="6">등록 자료가 없습니다.</td>
			                     </tr>
							
							<% } %>
					</tbody>
				</table><br/>
				<!-- 페이지 넘버링 -->
				<table width="945" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center">
							<td align="center">
							<%
								if (TotalRecordCount > 0) {
							%>
								<%=
									FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock,
									"admin_upright_list.jsp?index=" + index + "&FIELD=" + FIELD + "&start=" + start + "&end=" + end + "&PAGE=",
									"<img src=img/board_prev.gif width=13 height=13 align=absmiddle border=0>",
									"<img src=img/board_next.gif width=13 height=13 align=absmiddle border=0>")
								%>
							<% } %>
						</td>
						</td>
					</tr>
				</table>
				<!-- 페이지 넘버링 -->
		</div>
</form>