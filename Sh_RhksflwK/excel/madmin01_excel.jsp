<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>
<%
	String  filename = new String("부서별민원현황리스트.xls".getBytes(),"ISO8859_1"); 
	
	response.setContentType("application/vnd.ms-excel;charset=euc-kr");
    response.setHeader("Content-disposition","attachment;filename="+ filename +"");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	request.setCharacterEncoding("KSC5601");
%>
<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="session" class="Bean.Front.Common.FrontDbUtil"/>

<%
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
		String start  = Converter.nullchk(request.getParameter("start"));
		String end  = Converter.nullchk(request.getParameter("end"));
		String result  = Converter.nullchk(request.getParameter("result"));

		int PAGE = 1;
		
		///////////////////////////////////////////////////////////////////////////
	    String TableName = " sh_minwon ";
	    String SelectCondition = "";
	    String WhereCondition = "";
	    String OrderCondition = "";
		
		if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){
			PAGE = 1;
	    }else{
			PAGE = Integer.parseInt(request.getParameter("PAGE"));
	    }

		SelectCondition = " mid, category, minwon_gubun, subject, name, status,";
		SelectCondition += "to_char(creation_date, 'YYYY-MM-DD') AS creation_date, buse_name, result,";
		SelectCondition += "to_char(answer_date, 'YYYY-MM-DD') AS answer_date, answer";
	    OrderCondition  = " ORDER BY mid DESC ";
		WhereCondition = "where 1 = 1 ";
		
	    if(!(finance_buseo.equals("감사실") || finance_buseo.equals("감사부")) &&  !finance_buseo.equals("준법감시실")){
	    	WhereCondition+=" and buseo='" + finance_buseo + "' ";
	    }
	    if(finance_buseo.equals("준법감시실")){
	    	WhereCondition+=" and junbuseo='Y' ";
	    }
		
		if(cmd.equals("search")){
			if(!start.equals("") && !end.equals("")){
				WhereCondition += " and creation_date >= '"+start+"' and creation_date <= '"+end+"'";
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

		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);



%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td style="padding-left:25;" align="center"><font size="5">
      부서별 민원현황 리스트</font></td>
  </tr>
  <tr> 
    <td style="padding:10 0 0 25;"> 
      <table width="945" border="1" cellspacing="0" cellpadding="0">
        <tr height="30"> 
          <td class="board_bg_title" width="70" align="center">번호</td>
          <td class="board_bg_title" width="120" align="center">분야</td>
          <td class="board_bg_title" width="80" align="center">민원분류</td>
          <td class="board_bg_title" width="220" align="center">제목</td>
          <td class="board_bg_title" width="80" align="center">민원인</td>
          <td class="board_bg_title" width="70" align="center">신청일</td>
          <td class="board_bg_title" width="70" align="center">처리상태</td>
          <td class="board_bg_title" width="90" align="center">담당부서</td>
          <td class="board_bg_title" width="75" align="center">처리결과</td>
          <td class="board_bg_title" width="70" align="center">답변일</td>
        </tr>
        <%
			Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 1, 1);
			    
		    if( ResultVector.size() > 0){
				for (int i=0; i < ResultVector.size();i++){
					Hashtable h = (Hashtable)ResultVector.elementAt(i);
			
					String SUBJECT = (String)h.get("SUBJECT");	//제목
					if (SUBJECT.length() > 31){
						SUBJECT = SUBJECT.substring(0,31);
						SUBJECT += "...";
					}
					//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //글번호 계산 
					int listnum = (TotalRecordCount) - (i);	//글번호 계산(역순)
					String answer_date =(String)h.get("ANSWER_DATE");
		%>
        <tr height="30" > 
	      <td align="center"><%=listnum%></td>
		  <td align="center"><%=(String)h.get("CATEGORY") %></td>
          <td align="center"><%=(String)h.get("MINWON_GUBUN") %></td>
          <td style="padding-left:10;"><%=SUBJECT%></td>	
          <td align="center"><%=(String)h.get("NAME") %></td>
          <td align="center"><%=(String)h.get("CREATION_DATE") %></td>
          <td align="center"><%=(String)h.get("STATUS") %></td>
          <td align="center"><%=(String)h.get("BUSE_NAME") %></td>
          <td align="center"><%=(String)h.get("RESULT") %></td>
          <td align="center"><%=answer_date%></td> 
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
		System.out.println("[ERROR] 오류사항 확인필요");
	} finally {

	}
%>	