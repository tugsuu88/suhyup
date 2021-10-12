<%@ page import="java.util.*, util.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<%
// 	String  filename = new String("청탁금지법위반신고.".getBytes(),"ISO8859_1");
	
// 	response.setContentType("application/vnd.ms-excel;charset=euc-kr");
//     response.setHeader("Content-disposition","attachment;filename="+ filename +"");
// 	response.setHeader("Content-Description", "JSP Generated Data"); 
// 	request.setCharacterEncoding("KSC5601");
	
	String filename = "청탁금지법위반신고";
	String ext = ".xls";

	filename = java.net.URLEncoder.encode(filename, "UTF-8");

	response.setContentType("application/octer-stream");
	response.setHeader("Content-Transper-Encoding", "binary");
	response.setHeader("Content-Disposition", "attachment;filename="+filename+ext);
	
	
%>
<jsp:useBean id="FrontBoard" scope="session"
	class="Bean.Front.Common.FrontBoradType1" />
<jsp:useBean id="FrontDbUtil" scope="session"
	class="Bean.Front.Common.FrontDbUtil" />
<%

	String finance_buseo=Converter.nullchk((String)session.getAttribute("buseo"));
	
	try 
	{	      
		
		String cmd = request.getParameter("cmd");	//검색어
	    String KEY = request.getParameter("KEY");	//검색어
	    if(KEY != null && !KEY.equals("")) {
	    	KEY = StringReplace.sqlFilter(KEY);		//금지어 필터링
	    }
	    //out.println("KEY : " + KEY + "<br>");
	    String FIELD = request.getParameter("FIELD");	//검색구분
	    String startday=request.getParameter("startday");
	    String endday=request.getParameter("endday");
	    String status=request.getParameter("status");
	    String buse_name=request.getParameter("buse_name");
		String result=request.getParameter("result");
				
		int PAGE = 1;
		
		///////////////////////////////////////////////////////////////////////////
	    String TableName = " sh_chungtak ";
	    String SelectCondition = "";
	    String WhereCondition = "";
	    String OrderCondition = "";
		
		if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){
			PAGE = 1;
	    }else{
			PAGE = Integer.parseInt(request.getParameter("PAGE"));
	    } 

	    SelectCondition = " parcode, thid, sg_name, title, sg_publication, code, result, buseo, abandon_date,";
	    SelectCondition += " to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date,";
	    SelectCondition += "to_char(time1, 'YYYY-MM-DD') AS time1, to_char(time2, 'YYYY-MM-DD') AS time2 ";
	    OrderCondition  = " ORDER BY thid DESC";
	    WhereCondition=" where parcode=6 ";
	    
		if(!(finance_buseo.equals("감사실") || finance_buseo.equals("감사부")) &&  !finance_buseo.equals("준법감시실")){
	    	WhereCondition+=" and buseo='" + finance_buseo + "' ";
	    }
	    if(finance_buseo.equals("준법감시실")){
	    	WhereCondition+=" and junbuseo='Y' ";
	    }

	    
	    String fStartday = "";
		String fEndday = "";
		
		if(cmd.equals("search")){
			
			
			fStartday = startday.substring(0, 4) +"-"+ startday.substring(4, 6) +"-"+ startday.substring(6, 8);
			fEndday = endday.substring(0, 4) +"-"+ endday.substring(4, 6) +"-"+ endday.substring(6, 8);
			
	    	if(!startday.equals("") && !endday.equals("")){
	    		WhereCondition+=" and to_char(time1,'YYYY-MM-DD')>='" + fStartday + "' and to_char(time1, 'YYYY-MM-DD')<='" + fEndday + "'";
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
	    		WhereCondition+=" and (title like '%" + KEY + "%' or sg_name like '%" + KEY + "%' or ct_content like '%" + KEY + "%')";
	    	}
	    }
		
		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
		//out.print("TotalRecordCount : " + TotalRecordCount + "<br><br>");
		///////////////////////////////////////////////////////////////////////////
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-left: 25;" align="center"><font size="5">
				청탁금지법 위반 신고 제보리스트</font></td>
	</tr>
	<tr>
		<td style="padding: 10 0 0 25;">
			<table width="945" border="1" cellspacing="0" cellpadding="0">
				<tr height="30">
					<td class="board_bg_title" width="70" align="center">번호</td>
					<td class="board_bg_title" width="120" align="center">특수코드</td>
					<td class="board_bg_title" width="300" align="center">제목</td>
					<td class="board_bg_title" width="80" align="center">민원인</td>
					<td class="board_bg_title" width="70" align="center">신청일</td>
					<td class="board_bg_title" width="70" align="center">처리상태</td>
					<td class="board_bg_title" width="90" align="center">담당부서</td>
<!-- 					<td class="board_bg_title" width="75" align="center">처리결과</td> -->
					<td class="board_bg_title" width="70" align="center">답변일</td>
				</tr>
				<%
				Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 1, 1);
			    
			    if( ResultVector.size() > 0){
					for (int i=0; i < ResultVector.size();i++){
						Hashtable h = (Hashtable)ResultVector.elementAt(i);
			
						String TITLE = (String)h.get("TITLE");	//제목
						if (TITLE.length() > 31){
							TITLE = TITLE.substring(0,31);
							TITLE += "...";
						}
						//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //글번호 계산 
						int listnum = (TotalRecordCount) - (i);	//글번호 계산(역순)
						String time2 = (String)h.get("TIME2");
						String code = (String)h.get("CODE");
						String abandon_date = (String)h.get("ABANDON_DATE");
						
		%>
				<tr height="30">
					<td align="center"><%=listnum %></td>
					<td align="center"><%="S" + (String)h.get("SG_PUBLICATION")%></td>
					<td style="padding-left: 10;"><%=TITLE %></td>
					<td align="center"><%=(String)h.get("SG_NAME") %></td>
					<td align="center"><%=(String)h.get("TIME1") %></td>
					<td align="center"><%=(String)h.get("CODE") %></td>
					<td align="center"><%=(String)h.get("BUSEO") %></td>
<%-- 					<td align="center"><%=(String)h.get("RESULT") %></td> --%>
					<%if("철회완료".equals(code)){ %>
					<td align="center"><%=abandon_date%></td>
					<%}else{ %>
					<td align="center"><%=time2%></td>
					<%} %>
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
		</td>
	</tr>
</table>
<% 
	} catch(Exception e) {
		e.printStackTrace();
		out.println("favors.jsp : " + e.getMessage());
	} finally {

	}
%>




