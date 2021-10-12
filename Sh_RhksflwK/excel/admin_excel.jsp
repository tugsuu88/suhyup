<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>
<%
	String  filename = new String("관리자리스트.xls".getBytes(),"ISO8859_1"); 
	
	response.setContentType("application/vnd.ms-excel;charset=euc-kr");
    response.setHeader("Content-disposition","attachment;filename="+ filename +"");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	request.setCharacterEncoding("KSC5601");
%>
<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="session" class="Bean.Front.Common.FrontDbUtil"/>
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />

<%
	String finance_buseo=Converter.nullchk((String)session.getAttribute("buseo"));
	try 
	{	      
		///////////////////////////////////////////////////////////////////////////
		String TableName = " sh_minwon_admin ";
	    String SelectCondition = null;
	    String OrderCondition = null;
		
		SelectCondition = " sh_no, sh_buseo, sh_name, sh_id, sh_pwd, sh_inuser, to_char(sh_indate, 'YYYY-MM-DD') AS sh_indate ";
	    OrderCondition  = " ORDER BY sh_no DESC ";
		
		int TotalRecordCount = FrontBoard.TotalCount(TableName, "");


%>

<table width="100%" border="1" cellspacing="0" cellpadding="0">
  <tr> 
    <td style="padding-left:25;" align="center"><font size="5">
      관리자 리스트</font></td>
  </tr>
  <tr> 
    <td style="padding:10 0 0 25;"> 
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr height="30"> 
          <td class="board_bg_title" width="45" align="center">번호</td>
          <td class="board_bg_title" width="150" align="center">부서</td>
          <td class="board_bg_title" width="100" align="center">관리자</td>
          <td class="board_bg_title" width="150" align="center">아이디</td>
          <td class="board_bg_title" width="150" align="center">패스워드</td>
          <td class="board_bg_title" width="100" align="center">등록자</td>
          <td class="board_bg_title" width="150" align="center">등록일</td>
        </tr>
        <%
        	
        	
			Vector ResultVector = FrontBoard.list(TableName, SelectCondition, "", OrderCondition, 1, 1);
        	
        	String sh_pwd = "";
		    if( ResultVector.size() > 0){
				for (int i=0; i < ResultVector.size();i++){
					Hashtable h = (Hashtable)ResultVector.elementAt(i);
			
					//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //글번호 계산 
					int listnum = (TotalRecordCount) - (i);	//글번호 계산(역순)
					sh_pwd = (String)h.get("SH_PWD");
					sh_pwd = aes.aesDecode(sh_pwd);

		%>
        <tr height="30" > 
	      <td align="center"><%=listnum%></td>
		  <td align="center"><%=(String)h.get("SH_BUSEO") %></td>
          <td align="center"><%=(String)h.get("SH_NAME") %></td>
          <td style="padding-left:10;"><%=(String)h.get("SH_ID") %></td>	
          <td align="center"><%=sh_pwd%></td>
          <td align="center"><%=(String)h.get("SH_INUSER") %></td>
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
    </td>
  </tr>
</table>
<% 
	} catch(Exception e) {
		System.out.println("[ERROR] 오류사항 확인필요");
	} finally {

	}
%>	