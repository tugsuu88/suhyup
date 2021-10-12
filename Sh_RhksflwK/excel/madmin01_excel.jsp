<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>
<%
	String  filename = new String("�μ����ο���Ȳ����Ʈ.xls".getBytes(),"ISO8859_1"); 
	
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
		String cmd = Converter.nullchk(request.getParameter("cmd"));	//�˻���
	    String KEY = Converter.nullchk(request.getParameter("KEY"));	//�˻���
	    if(KEY != null && !KEY.equals("")) {
	    	KEY = StringReplace.sqlFilter(KEY);		//������ ���͸�
	    }
	    //out.println("KEY : " + KEY + "<br>");
	    String FIELD = Converter.nullchk(request.getParameter("FIELD"));	//�˻�����
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
		
	    if(!(finance_buseo.equals("�����") || finance_buseo.equals("�����")) &&  !finance_buseo.equals("�ع����ý�")){
	    	WhereCondition+=" and buseo='" + finance_buseo + "' ";
	    }
	    if(finance_buseo.equals("�ع����ý�")){
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
      �μ��� �ο���Ȳ ����Ʈ</font></td>
  </tr>
  <tr> 
    <td style="padding:10 0 0 25;"> 
      <table width="945" border="1" cellspacing="0" cellpadding="0">
        <tr height="30"> 
          <td class="board_bg_title" width="70" align="center">��ȣ</td>
          <td class="board_bg_title" width="120" align="center">�о�</td>
          <td class="board_bg_title" width="80" align="center">�ο��з�</td>
          <td class="board_bg_title" width="220" align="center">����</td>
          <td class="board_bg_title" width="80" align="center">�ο���</td>
          <td class="board_bg_title" width="70" align="center">��û��</td>
          <td class="board_bg_title" width="70" align="center">ó������</td>
          <td class="board_bg_title" width="90" align="center">���μ�</td>
          <td class="board_bg_title" width="75" align="center">ó�����</td>
          <td class="board_bg_title" width="70" align="center">�亯��</td>
        </tr>
        <%
			Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 1, 1);
			    
		    if( ResultVector.size() > 0){
				for (int i=0; i < ResultVector.size();i++){
					Hashtable h = (Hashtable)ResultVector.elementAt(i);
			
					String SUBJECT = (String)h.get("SUBJECT");	//����
					if (SUBJECT.length() > 31){
						SUBJECT = SUBJECT.substring(0,31);
						SUBJECT += "...";
					}
					//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //�۹�ȣ ��� 
					int listnum = (TotalRecordCount) - (i);	//�۹�ȣ ���(����)
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
						<td class="no" align="center" colspan="9">��� �ڷᰡ �����ϴ�.</td>
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
		System.out.println("[ERROR] �������� Ȯ���ʿ�");
	} finally {

	}
%>	