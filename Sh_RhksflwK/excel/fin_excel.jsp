<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>
<%
	String  filename = new String("���������������Ʈ.xls".getBytes(),"ISO8859_1"); 
	
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
		
		String cmd = request.getParameter("cmd");	//�˻���
	    String KEY = request.getParameter("KEY");	//�˻���
	    if(KEY != null && !KEY.equals("")) {
	    	KEY = StringReplace.sqlFilter(KEY);		//������ ���͸�
	    }
	    //out.println("KEY : " + KEY + "<br>");
	    String FIELD = request.getParameter("FIELD");	//�˻�����
	    String startday=request.getParameter("startday");
	    String endday=request.getParameter("endday");
	    String status=request.getParameter("status");
	    String buse_name=request.getParameter("buse_name");
		String result=request.getParameter("result");
				
		int PAGE = 1;
		
		///////////////////////////////////////////////////////////////////////////
	    String TableName = " sh_financetrouble ";
	    String SelectCondition = "";
	    String WhereCondition = "";
	    String OrderCondition = "";
		
		if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){
			PAGE = 1;
	    }else{
			PAGE = Integer.parseInt(request.getParameter("PAGE"));
	    } 

	    SelectCondition = " parcode,thid, name,title,publication,code,result,buseo,";
	    SelectCondition += "to_char(time1, 'YYYY-MM-DD') AS time1, to_char(time2, 'YYYY-MM-DD') AS time2 ";
	    OrderCondition  = " ORDER BY thid DESC";
	    WhereCondition=" where parcode=1 ";
	    
		if(!(finance_buseo.equals("�����") || finance_buseo.equals("�����")) &&  !finance_buseo.equals("�ع����ý�")){
	    	WhereCondition+=" and buseo='" + finance_buseo + "' ";
	    }
	    if(finance_buseo.equals("�ع����ý�")){
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
		
		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
		//out.print("TotalRecordCount : " + TotalRecordCount + "<br><br>");
		///////////////////////////////////////////////////////////////////////////
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td style="padding-left:25;" align="center"><font size="5">
      ������� ��������Ʈ</font></td>
  </tr>
  <tr> 
    <td style="padding:10 0 0 25;"> 
      <table width="945" border="1" cellspacing="0" cellpadding="0">
        <tr height="30"> 
          <td class="board_bg_title" width="70" align="center">��ȣ</td>
          <td class="board_bg_title" width="120" align="center">Ư���ڵ�</td>
          <td class="board_bg_title" width="300" align="center">����</td>
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
			
						String TITLE = (String)h.get("TITLE");	//����
						if (TITLE.length() > 31){
							TITLE = TITLE.substring(0,31);
							TITLE += "...";
						}
						//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //�۹�ȣ ��� 
						int listnum = (TotalRecordCount) - (i);	//�۹�ȣ ���(����)
						String time2=(String)h.get("TIME2");
		%>
        <tr height="30" > 
          <td align="center"><%=listnum %></td>
          <td align="center"><%="S" + (String)h.get("PUBLICATION")%></td>
          <td style="padding-left:10;">
          	<%=TITLE %>
          </td>
          <td align="center"><%=(String)h.get("NAME") %></td>
          <td align="center"><%=(String)h.get("TIME1") %></td>
          <td align="center"><%=(String)h.get("CODE") %></td>
          <td align="center"><%=(String)h.get("BUSEO") %></td>
          <td align="center"><%=(String)h.get("RESULT") %></td>
          <td align="center"><%=time2 %></td>
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
		e.printStackTrace();
		out.println("finance.jsp : " + e.getMessage());
	} finally {

	}
%>		




