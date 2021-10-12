<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>
<%
	String  filename = new String("FAQ����Ʈ.xls".getBytes(),"ISO8859_1"); 
	
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

		String FIELD = Converter.nullchk(request.getParameter("FIELD"));	//�˻�����
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
      FAQ ����Ʈ	</font></td>
  </tr>
 <tr>
 <td style="padding:10 0 0 25;"> 
      <table width="945" border="1" cellspacing="0" cellpadding="0">
 <tr height="30"> 
          <td class="board_bg_title" width="45" align="center">No</td>
          <td class="board_bg_title" width="150" align="center">�з��ڵ�</td>
          <td class="board_bg_title" width="450" align="center">����</td>
          <td class="board_bg_title" width="50" align="center">��ȸ��</td>
          <td class="board_bg_title" width="100" align="center">�����</td>
          <td class="board_bg_title" width="150" align="center">�����</td>
 </tr>
        <%
			Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 1, 1);
			    
		    if( ResultVector.size() > 0){
				for (int i=0; i < ResultVector.size();i++){
					Hashtable h = (Hashtable)ResultVector.elementAt(i);
			
					String SH_SUBJECT = (String)h.get("SH_SUBJECT");	//����
					if (SH_SUBJECT.length() > 31){
						SH_SUBJECT = SH_SUBJECT.substring(0,31);
						SH_SUBJECT += "...";
					}
					//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //�۹�ȣ ��� 
					//int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//�۹�ȣ ���(����)
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
						<td class="no" align="center" colspan="9">��� �ڷᰡ �����ϴ�.</td>
					</tr>
			<% 
				} 
			%>
      </table>
<% 
	} catch(Exception e) {
		System.out.println("[ERROR] �������� Ȯ���ʿ�");
	} finally {

	}
%>		
