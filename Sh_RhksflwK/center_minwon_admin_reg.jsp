<%@ page import="java.util.*, util.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1" />
<jsp:useBean id="FrontDbUtil" scope="session" class="Bean.Front.Common.FrontDbUtil" />

<%@ include file="include/admin_session.jsp"%>
<%@ include file="include/logincheck.jsp"%>
<%@ include file="include/top_login.jsp"%>
<%@ include file="include/top_menu0204.jsp"%>

<%

	String ListPage = Converter.nullchk(request.getParameter("ListPage"));
	String myPage = request.getRequestURI();
	String finance_buseo = Converter.nullchk((String) session.getAttribute("buseo"));

	try {
	    String cmd = Converter.nullchk(request.getParameter("cmd"));
		String KEY = Converter.nullchk(request.getParameter("KEY")); //검색어
		if (KEY != null && !KEY.equals("")) {
			KEY = StringReplace.sqlFilter(KEY); //금지어 필터링
		}
		//out.println("KEY : " + KEY + "<br>");
		String FIELD = Converter.nullchk(request.getParameter("FIELD")); //검색구분
		String category = Converter.nullchk(request.getParameter("category"));
		String minwon_gubun = Converter.nullchk(request.getParameter("minwon_gubun"));
		String status = Converter.nullchk(request.getParameter("status"));
		String buse_name = Converter.nullchk(request.getParameter("buse_name"));
		String start = Converter.nullchk(request.getParameter("start"));
		String end = Converter.nullchk(request.getParameter("end"));
		String result = Converter.nullchk(request.getParameter("result"));
		/* String bupin = Converter.nullchk(request.getParameter("bupin")); */

		String where_buseo = "";

		int PAGE = 1;

	    // System.out.println("cmd reg.jsp: " + cmd + "<br>");
		String msg = "";
		String btn_name = "";

    	String center_minwon_admin_no = "";
    	String center = "";
    	String sh_no = "";

		String damdangmobile=FrontBoard.OnlyOne("Select  from sh_minwon_admin ");
    	Vector AdminResultVector = FrontBoard.list("sh_minwon_admin", " sh_no, sh_id, sh_name, sh_mobile  "," where 1 = 1 " , " ORDER BY  sh_name ", 1, 1);
		// System.out.println("AdminResultVector.size()=" + AdminResultVector.size());

		String TableName = " center_minwon_admin ";
		Vector ResultVector;
	    String SelectCondition = null;
	    String WhereCondition = null;
	    String OrderCondition = null;

		if(cmd.equals("add")) {
			msg = "등록";
			btn_name = "record.gif";
       	}
		else
		{
       		msg = "수정";
       		btn_name = "adjust.gif";
       		center_minwon_admin_no = Converter.nullchk(request.getParameter("center_minwon_admin_no"));


		    SelectCondition = "  center_minwon_admin_no, center, sh_no ";
		    // SelectCondition += " sh_inuser, to_char(sh_indate, 'YYYY-MM-DD') AS sh_indate, sh_upuser, sh_update  ";
			WhereCondition  = " where center_minwon_admin_no =  " + Integer.parseInt(center_minwon_admin_no) ;
	    	OrderCondition  = " ORDER BY center_minwon_admin_no ";

	    	ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 1, 1);

	    	if( ResultVector.size() > 0){
				for (int i=0; i < ResultVector.size();i++){
					Hashtable h = (Hashtable)ResultVector.elementAt(i);

					center = (String)h.get("CENTER");
					sh_no = (String)h.get("SH_NO");
				}
			}
		}
       	// System.out.println("center_minwon_admin_no in reg=" + center_minwon_admin_no);
		int DefaultListRecord = 10;

		/*SelectCondition = " mid, category, minwon_gubun, subject, name, status, bupin, sh_fileno, sh_file_name, ";
		SelectCondition += "to_char(creation_date, 'YYYY-MM-DD AM HH24:MI:SS') AS creation_date, buse_name, result,";
		SelectCondition += "to_char(answer_date, 'YYYY-MM-DD AM HH24:MI:SS') AS answer_date, to_char(abandon_date, 'YYYY-MM-DD AM HH24:MI:SS') AS abandon_date, answer,fname";
		OrderCondition = " ORDER BY mid DESC ";

		if("감사실".equals(finance_buseo)){
			where_buseo = "where bupin in('1','2','3')";
		}else if("감사부".equals(finance_buseo)){
			where_buseo = "where bupin = '2'";
		}else if("준법감시실(중앙회)".equals(finance_buseo)){
			where_buseo = "where bupin = '1'";
		}else if("준법감시실(조합)".equals(finance_buseo)){
			where_buseo = "where bupin = '3'";
		}else if("금융소비자보호부".equals(finance_buseo)){
			where_buseo = "where bupin = '2'";
		}else{
			//where_buseo = "where 1 = 1";
			where_buseo = "where buse_name='" + finance_buseo + "' ";
		}

		WhereCondition = where_buseo;

		//변경

		if (cmd.equals("search")) {
			if (!start.equals("") && !end.equals("")) {
				WhereCondition += " and to_char(creation_date, 'yyyymmdd') >= '" + start
						+ "' and to_char(creation_date, 'yyyymmdd') <= '" + end + "'";
			}
			if (!category.equals("")) {
				WhereCondition += " and category = '" + category + "'";
			}
			if (!minwon_gubun.equals("")) {
				WhereCondition += " and minwon_gubun = '" + minwon_gubun + "'";
			}
			if (!status.equals("")) {
				WhereCondition += " and status = '" + status + "'";
			}
			if (!buse_name.equals("")) {
				WhereCondition += " and buse_name = '" + buse_name + "'";
			}
			if (!result.equals("")) {
				WhereCondition += " and result = '" + result + "'";
			}
			if (!FIELD.equals("")) {
				WhereCondition += " and " + FIELD + " like '%" + KEY + "%'";
			} else {
				WhereCondition += " and (subject like '%" + KEY + "%' or name like '%" + KEY
						+ "%' or content like '%" + KEY + "%')";
			}
		}
		int StartRecord = 0;
		int EndRecord = 0;
		int DefaultPageBlock = 10;
		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
		*/



%>
<script language="javascript" src="../js/common.js"></script>
<script language="javascript">

	function GoReg(){
		if(!isInput(pbform.center, "민원종류 선택해 주세요"))  return;
		if(!isInput(pbform.sh_no, "담당자 선택해 주세요"))  return;

		pbform.encoding="multipart/form-data";
		pbform.submit();
	}
	//삭제
	function GoDel() {
		if(confirm("삭제하시겠습니까?")){
			pbform.cmd.value = "del"
			pbform.encoding="multipart/form-data";
   			pbform.action = "center_minwon_admin_proc.jsp";
			pbform.submit();
		}else{
			return;
		}
	}

/*	function goView(mid,PAGE){
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
	}*/

	/* 20180314 민원인이 첨부한 파일 다운로드 */
 	function DownloadPopup(mid){
		pbform.mid.value=mid;
		var wint = (screen.height - 245) / 2;
		var winl = (screen.width - 300) / 2;
		winprops = 'height=245,width=300,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'
		winurl = '../minwon/file_popup.jsp?mid='+mid;
		win = window.open(winurl, "file_popup1", winprops)
	}


</script>
<!-- 민원접수현황 검색 폼 -->
<form method=post name="pbform" id="pbform" action="center_minwon_admin_proc.jsp">
	<%--
	<div class="list-header">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td rowspan="2" class="admin_subject">민원접수현황</td>
				<td class="bluesky">신청일</td>
				<td>
					<input type="text" class="input01" size="10" name="start" value="<%=start%>">
					<a href="javascript:Calendar(pbform.start);">
						<img src="img/btn_calender.gif" width="23" height="18" align="absmiddle" border="0">
					</a>
					~
					<input type="text" class="input01" size="10" name="end" value="<%=end%>">
					<a href="javascript:Calendar(pbform.end);">
						<img src="img/btn_calender.gif" width="23" height="18" align="absmiddle" border="0">
					</a>
				</td>
				<td class="bluesky">분야</td>
				<td>
					<select name="category" width="130">
						<option value="">전체</option>
						<option value="수협은행" <%if (category.equals("수협은행")) {%>
						selected <%}%>>수협은행</option>
						<option value="펀드판매관련"
						<%if (category.equals("펀드판매관련")) {%> selected <%}%>>펀드판매관련</option>
						<option value="공제보험" <%if (category.equals("공제보험")) {%> selected <%}%>>공제보험</option>
						<option value="바다마트" <%if (category.equals("바다마트")) {%> selected <%}%>>바다마트</option>
						<option value="공판장(경매)" <%if (category.equals("공판장(경매)")) {%> selected <%}%>>공판장(경매)</option>
						<option value="면세유류" <%if (category.equals("면세유류")) {%> selected <%}%>>면세유류</option>
						<option value="회원조합/어촌계" <%if (category.equals("회원조합/어촌계")) {%> selected <%}%>>회원조합/어촌계</option>
						<option value="고객지원불친절" <%if (category.equals("고객지원불친절")) {%> selected <%}%>>고객지원불친절</option>
						<option value="기타사항" <%if (category.equals("기타사항")) {%> selected <%}%>>기타사항</option>
					</select>
				</td>
				<td class="bluesky">민원분류</td>
				<td>
					<select name="minwon_gubun">
						<option value="">전체</option>
						<option value="일반민원"
						<%if (minwon_gubun.equals("일반민원")) {%> selected <%}%>>일반민원</option>
						<option value="단순질의"
						<%if (minwon_gubun.equals("단순질의")) {%> selected <%}%>>단순질의</option>
					</select>
				</td>
				<td class="bluesky">처리상태</td>
				<td>
					<select name="status">
						<option value="">선택</option>
						<option value="신청" <%if (status.equals("신청")) {%> selected <%}%>>신청</option>
						<option value="접수" <%if (status.equals("접수")) {%> selected <%}%>>접수</option>
						<option value="이첩" <%if (status.equals("이첩")) {%> selected <%}%>>이첩</option>
						<option value="반송" <%if (status.equals("반송")) {%> selected <%}%>>반송</option>
						<option value="처리중" <%if (status.equals("처리중")) {%> selected <%}%>>처리중</option>
						<option value="답변완료" <%if (status.equals("답변완료")) {%> selected <%}%>>답변완료</option>
						<option value="민원철회" <%if (status.equals("민원철회")) {%> selected <%}%>>민원철회</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bluesky">담당부서</td>
				<td>
					<select name="buse_name" style="width: 130px;">
						<option value="">선택</option>
						<%
						//Vector ResultVector;

						String TableNameBuseo = " sh_buseo ";
						String SelectCondition1 = " BUSEO_CD, BUSEO_NM";
						String WhereCondition1 = "where 1 = 1 ";
						String OrderCondition1 = "";

						ResultVector = FrontBoard.list(TableNameBuseo, SelectCondition1, WhereCondition1, OrderCondition1, 1, 0, 100);

						String sh_buseo_cd = "";
						String sh_buseo_nm = "";

						if( ResultVector.size() > 0){
						for (int i=0; i < ResultVector.size();i++){

						Hashtable h = (Hashtable)ResultVector.elementAt(i);

						sh_buseo_cd = (String)h.get("BUSEO_CD");
						sh_buseo_nm = (String)h.get("BUSEO_NM");

						%>

						<%if(buse_name.equals(sh_buseo_cd)){ %>
						<option value="<%=sh_buseo_cd%>" selected id="selectBuseo">
							<% } else { %>
						<option value="<%=sh_buseo_cd%>" id="selectBuseo">
							<% } %>
							<%=sh_buseo_nm%>
						</option>

						<% } %>
						<% } %>

					</select>
				</td>
				<td class="bluesky">처리결과</td>
				<td>
						<select name="result" style="width: 100px">
						<option value="">선택</option>
						<option value="조치/시정" <%if (result.equals("조치/시정")) {%> selected <%}%>>조치/시정</option>
						<option value="절차안내" <%if (result.equals("절차안내")) {%> selected <%}%>>절차안내</option>
						<option value="합의/조정" <%if (result.equals("합의/조정")) {%> selected <%}%>>합의/조정</option>
						<option value="설득이해" <%if (result.equals("설득이해")) {%> selected <%}%>>설득이해</option>
						<option value="법령/제도상불능" <%if (result.equals("법령/제도상불능")) {%> selected <%}%>>법령/제도상불능</option>
						<option value="내용불합리" <%if (result.equals("내용불합리")) {%> selected <%}%>>내용불합리</option>
						<option value="재정" <%if (result.equals("재정")) {%> selected <%}%>>재정</option>
						<option value="사실상이" <%if (result.equals("사실상이")) {%> selected <%}%>>사실상이</option>
						<option value="사적분쟁" <%if (result.equals("사적분쟁")) {%> selected <%}%>>사적분쟁</option>
						<option value="소송/수사" <%if (result.equals("소송/수사")) {%> selected <%}%>>소송/수사</option>
						<option value="불문(민원아님)" <%if (result.equals("불문(민원아님)")) {%> selected <%}%>>불문(민원아님)</option>
						<option value="건의/검토" <%if (result.equals("건의/검토")) {%> selected <%}%>>건의/검토</option>
						<!-- -->
					</select>
				</td>
				<td class="bluesky">조회구분</td>
				<td colspan="4">
					<select name="FIELD" style="width: 70px;">
						<option value="">선택</option>
						<option value="subject">제목</option>
						<option value="content">내용</option>
						<option value="name">민원인</option>
						<!-- -->
					</select>
					<input type="text" class="input01" style="width: 120px" name="KEY" value="<%=KEY%>">
					<a href="javascript:GoReg();"><img src="img/btn_search.gif" width="38" height="17" border="0" alt="검색"></a>
					<a href="javascript:pbform.reset();">
						<img src="img/btn_refresh.gif" width="48" height="17" border="0" alt="초기화"></a>
				</td>
			</tr>
		</table>
	</div>
	 --%>
	<!-- // 민원접수현황 검색 폼 -->
	<br>
	<div class="tbl-wrap">
				<!-- 검색결과 -->
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<%--
						<td height="30"><img src="img/result.gif" align="absmiddle">
							검색결과 : <span class="result_text">총<%=TotalRecordCount%>건
						</span></td>
						<td height="30" align="right"><a
							href="excel/madmin_excel.jsp?cmd=<%=cmd%>&KEY=<%=KEY%>&FIELD=<%=FIELD%>&start=<%=start%>&end=<%=end%>&status=<%=status%>&buse_name=<%=buse_name%>&category=<%=category%>&result=<%=result%>&minwon_gubun=<%=minwon_gubun%>"><img
								src="img/btn_excel.gif" width="66" height="21" alt="엑셀"
								border="0"></a></td>
						  --%>
					</tr>
				</table> <!-- // 검색결과 -->
		<!-- 민원접수현황 리스트 -->
				<div class="subtit"><img src="img/arrow.gif" width="13" height="16" align="absmiddle"> <span class="txt_title">민원담당 SMS관리</span></div>

				<table border="0" cellpadding="0" cellspacing="0" width="980">
	<tr>
		<td height="2" colspan="4" class="board_topline"></td>
    </tr>
     <tr>
        <td width="100" align="center" class="board_bg_title" >* 민원종류 </td>
        <td colspan="3" class="write_padding" style="padding-left:10px;">
        	<select name="center" >
				<option value="" > 종류 </option>
				<option value='complaint1'  <% if (center.equals("complaint1")) { %>selected<% } %> >준법감시실(중앙회)</option>
				<option value='complaint2' <% if (center.equals("complaint2")) { %>selected<% } %>>금융소비자보호부</option>
				<option value='complaint3' <% if (center.equals("complaint3")) { %>selected<% } %>>준법감시실(조합)</option>
			</select>
        </td>
    </tr>
     <tr>
        <td width="100" align="center" class="board_bg_title" >* 담당자</td>
        <td colspan="3" class="write_padding" style="padding-left:10px;">
        	<select name="sh_no" >
				<option value="" >이름, ID </option>
				<%
					String sh_name="";
					String sh_no_l="";
					String sh_id="";
					String sh_mobile="";
					for (int i=0; i < AdminResultVector.size();i++){
						Hashtable h2 = (Hashtable)AdminResultVector.elementAt(i);
						sh_name = (String)h2.get("SH_NAME");
						sh_id = (String)h2.get("SH_ID");
						sh_no_l = (String)h2.get("SH_NO");
						sh_mobile = (String)h2.get("SH_MOBILE");
				%>
				<option value='<%=sh_no_l%>'   <% if (sh_no_l.equals(sh_no)) { %>selected<% } %>   ><%=sh_name%> <%=sh_id%> (<%=sh_mobile%>)</option>
				<%
					}
				%>
			</select>
        </td>
    </tr>
</table>

				<br> <!-- // 민원접수현황 리스트 --> <!-- 페이지 넘버링 -->
				<table width="980" border="0" cellspacing="0" cellpadding="0" bgcolor="#F7F7F7">
						<td><a href="center_minwon_admin_list.jsp?PAGE=<%=PAGE%>&FIELD=<%=FIELD%>&KEY=<%=KEY%>"><img src="../images/button/list.gif" border="0" align="absmiddle"></a></td>
						<td align="right">
							<a href="javascript:GoReg();"><img src="../images/button/record.gif" border="0" align="absmiddle"></a>
						</td>
						<% if(cmd.equals("edit")) { %>
				    	<td width="59"><a href="javascript:GoDel();"><img src="../images/button/del.gif" border="0" align="absmiddle"></a></td>
				    	<% } %>
					<tr>
						<%--
						<td width="17"><img src="../Sh_DjemalS/images/common/board_list_boxleft.gif"></td>
						<td width="17"><img src="../Sh_DjemalS/images/common/board_list_boxright.gif"></td>
						<td align="center">
							<%
								if (TotalRecordCount > 0) {
							%> <%=FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock,
							"madmin_01.jsp?KEY=" + KEY + "&cmd=" + cmd + "&FIELD=" + FIELD + "&start=" + start + "&end="
									+ end + "&category=" + category + "&minwon_gubun=" + minwon_gubun + "&status="
									+ status + "&buse_name=" + buse_name + "&PAGE=",
							"<img src=img/board_prev.gif width=13 height=13 align=absmiddle border=0>",
							"<img src=img/board_next.gif width=13 height=13 align=absmiddle border=0>")%>
							<% } %>
						</td>
						 --%>
					</tr>
				</table> <!-- 페이지 넘버링 -->
	</div>
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="center_minwon_admin_no" value="<%=center_minwon_admin_no%>">
 <input type="hidden" name="mid">
 <input type="hidden" name="PAGE">
</form>
<%@ include file="include/bottom.jsp"%>
<%
	} catch(Exception e) {
		out.println("center_minwon_admin_reg.jsp : " + e.getMessage());
	} finally {

	}
%>