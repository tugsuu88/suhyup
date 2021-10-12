<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>
<%
	String  filename = new String("FAQ리스트.xls".getBytes(),"ISO8859_1"); 
	
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

		String FIELD = Converter.nullchk(request.getParameter("FIELD"));	//검색구분
		String category = Converter.nullchk(request.getParameter("category"));


		int PAGE = 1;

		///////////////////////////////////////////////////////////////////////////
	    String TableName = " sh_minwon_faq ";
	    String SelectCondition = "";
	    String WhereCondition = "";
	    String OrderCondition = "";

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
		
	        
		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
		//out.print("TotalRecordCount : " + TotalRecordCount + "<br><br>");
		///////////////////////////////////////////////////////////////////////////
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td style="padding-left:25;" align="center"><font size="5">
      FAQ 리스트	</font></td>
  </tr>
 <tr>
 <td style="padding:10 0 0 25;"> 
      <table width="945" border="1" cellspacing="0" cellpadding="0">
 <tr height="30"> 
          <td class="board_bg_title" width="45" align="center">No</td>
          <td class="board_bg_title" width="150" align="center">분류코드</td>
          <td class="board_bg_title" width="450" align="center">제목</td>
          <td class="board_bg_title" width="50" align="center">조회수</td>
          <td class="board_bg_title" width="100" align="center">등록자</td>
          <td class="board_bg_title" width="150" align="center">등록일</td>
 </tr>
        <%
			Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 1, 1);
			    
		    if( ResultVector.size() > 0){
				for (int i=0; i < ResultVector.size();i++){
					Hashtable h = (Hashtable)ResultVector.elementAt(i);
			
					String SH_SUBJECT = (String)h.get("SH_SUBJECT");	//제목
					if (SH_SUBJECT.length() > 31){
						SH_SUBJECT = SH_SUBJECT.substring(0,31);
						SH_SUBJECT += "...";
					}
					//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //글번호 계산 
					//int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//글번호 계산(역순)
					//String answer_date =(String)h.get("ANSWER_DATE");
					int listnum = (TotalRecordCount) - (i);
		%>
       <tr height="30"   onMouseOver=this.style.backgroundColor='F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'> 
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
<% 
	} catch(Exception e) {
		System.out.println("[ERROR] 오류사항 확인필요");
	} finally {

	}
%>		
