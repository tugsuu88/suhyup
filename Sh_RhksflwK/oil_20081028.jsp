<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %> 
<%@ include file="include/top_menu06.jsp" %>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="session" class="Bean.Front.Common.FrontDbUtil"/>

<%
	String ListPage = Converter.nullchk(request.getParameter("ListPage"));
	//String pageNum = request.getParameter("pageNum");
	String myPage = request.getRequestURI();
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
	    SelectCondition += "to_char(time1, 'YYYY-MM-DD') AS time1, to_char(time2, 'YYYY-MM-DD') AS time2 ";
	    OrderCondition  = " ORDER BY thid DESC";
	    WhereCondition=" where parcode=3 ";
	   
		if(!finance_buseo.equals("�����") &&  !finance_buseo.equals("�ع����ý�")){
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
	
		int StartRecord = 0;
		int EndRecord   = 0;
		int DefaultListRecord = 10;
		int DefaultPageBlock = 10;
	        
		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
		//out.print("TotalRecordCount : " + TotalRecordCount + "<br><br>");
		///////////////////////////////////////////////////////////////////////////
%>
<script language="javascript" src="js/common.js"></script>
<script language="javascript">
<!--
	function GoReg(){
		if(!pbform.startday.value){
			if(pbform.endday.value){
				alert("�������� �־��ּ���");
				pbform.startday.focus();
				return;
			}
		}
		if(pbform.startday.value){
			if(!pbform.endday.value){
				alert("�������� �־��ּ���");
				pbform.endday.focus();
				return;
			}
		}
		
		if(!compareDt(pbform.startday.value, pbform.endday.value)){
          alert("�������� �������� ���� �� �����ϴ�.");
		  return;
		}
		
		if(!pbform.startday.value && !pbform.buse_name.value && !pbform.status.value && !pbform.result.value ){
			/*
			if(!pbform.FIELD.value){
				alert("��ȸ������ ���ּ���");
				pbform.FIELD.focus();
				return;
			}
			*/
			if(!pbform.KEY.value){
				alert("�˻�� �����ּ���");
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
		pbform.action = "oil_view_20081028.jsp";
		pbform.submit();
	}
	function goDetailView(thid,PAGE){
		pbform.thid.value=thid;
		pbform.PAGE.value=PAGE;
		pbform.action = "oil_detail.jsp";
		pbform.submit();
	}

//-->
</script>
<!-- ������� ���� ���� -->
<form method=post name="pbform" action="" style="margin:0px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="95" bgcolor="f4f4f4"  style="padding-left:25;"> 
      <table width="945" border="0" cellspacing="0" cellpadding="0" background="img/title_bg.gif">
        <tr> 
          <td width="135"> 
            <table width="135" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="70" align="center" class="admin_subject">�鼼����<br>��������Ű�</td>
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
                      <td width="60" class="bluesky">��û��</td>
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
                      <td width="60" class="bluesky">ó������</td>
                      <td width="50"> 
                        <select name="status">
                          <option value="">����</option>
                          <option value="��û"<%if(status.equals("��û")) { %>selected<% } %>>��û</option>
                          <option value="����"<%if(status.equals("����")) { %>selected<% } %>>����</option>
                          <option value="��ø"<%if(status.equals("��ø")) { %>selected<% } %>>��ø</option>
                          <option value="�ݼ�"<%if(status.equals("�ݼ�")) { %>selected<% } %>>�ݼ�</option>
                          <option value="ó����"<%if(status.equals("ó����")) { %>selected<% } %>>ó����</option>
                          <option value="�亯�Ϸ�"<%if(status.equals("�亯�Ϸ�")) { %>selected<% } %>>�亯�Ϸ�</option>
                          <option value="�ο�öȸ"<%if(status.equals("�ο�öȸ")) { %>selected<% } %>>�ο�öȸ</option>
                          <!-- -->
                        </select>
                      </td>
                      <td width="15">&nbsp;</td>
                      <td width="60" class="bluesky">ó�����</td>
                      <td> 
                        <select name="result">
                        <option value="">����</option>
						  <option value="��ġ/����"<%if(result.equals("��ġ/����")) { %>selected<% } %>>��ġ/����</option>
						  <option value="�����ȳ�"<%if(result.equals("�����ȳ�")) { %>selected<% } %>>�����ȳ�</option>
						  <option value="����/����"<%if(result.equals("����/����")) { %>selected<% } %>>����/����</option>
						  <option value="��������"<%if(result.equals("��������")) { %>selected<% } %>>��������</option>
						  <option value="����/������Ҵ�"<%if(result.equals("����/������Ҵ�")) { %>selected<% } %>>����/������Ҵ�</option>
						  <option value="������ո�"<%if(result.equals("������ո�")) { %>selected<% } %>>������ո�</option>
						  <option value="����"<%if(result.equals("����")) { %>selected<% } %>>����</option>
						  <option value="��ǻ���"<%if(result.equals("��ǻ���")) { %>selected<% } %>>��ǻ���</option>
						  <option value="��������"<%if(result.equals("��������")) { %>selected<% } %>>��������</option>
						  <option value="�Ҽ�/����"<%if(result.equals("�Ҽ�/����")) { %>selected<% } %>>�Ҽ�/����</option>
						  <option value="�ҹ�(�ο��ƴ�)"<%if(result.equals("�ҹ�(�ο��ƴ�)")) { %>selected<% } %>>�ҹ�(�ο��ƴ�)</option>
						  <option value="����/����"<%if(result.equals("����/����")) { %>selected<% } %>>����/����</option>
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
                      <td width="60" class="bluesky">���μ�</td>
                      <td width="100"> 
                        <select name="buse_name">
                          <option value="">����</option>
						  <option value="���ͻ����"<%if(buse_name.equals("���ͻ����")) { %>selected<% } %>>���ͻ����</option>
						  <option value="�����"<%if(buse_name.equals("�����")) { %>selected<% } %>>�����</option>
						  <option value="���ΰ�����"<%if(buse_name.equals("���ΰ�����")) { %>selected<% } %>>���ΰ�����</option>
						  <option value="���ΰ�����(���ڱ���)"<%if(buse_name.equals("���ΰ�����(���ڱ���)")) { %>selected<% } %>>���ΰ�����(���ڱ���)</option>
						  <option value="IT������"<%if(buse_name.equals("IT������")) { %>selected<% } %>>IT������</option>
						  <option value="�濵������"<%if(buse_name.equals("�濵������")) { %>selected<% } %>>�濵������</option>
						  <option value="������ȹ��"<%if(buse_name.equals("������ȹ��")) { %>selected<% } %>>������ȹ��</option>
						  <option value="���������"<%if(buse_name.equals("���������")) { %>selected<% } %>>���������</option>
						  <option value="������ȹ��"<%if(buse_name.equals("������ȹ��")) { %>selected<% } %>>������ȹ��</option>
						  <option value="���������"<%if(buse_name.equals("���������")) { %>selected<% } %>>���������</option>
						  <option value="��ȹ������"<%if(buse_name.equals("��ȹ������")) { %>selected<% } %>>��ȹ������</option>
						  <option value="�뷮������ ����ȭ�������"<%if(buse_name.equals("�뷮������ ����ȭ�������")) { %>selected<% } %>>�뷮������ ����ȭ�������</option>
						  <option value="��ü�޽Ļ����"<%if(buse_name.equals("��ü�޽Ļ����")) { %>selected<% } %>>��ü�޽Ļ����</option>
						  <option value="����ũ��������"<%if(buse_name.equals("����ũ��������")) { %>selected<% } %>>����ũ��������</option>
						  <option value="�ٴٸ�Ʈ�����"<%if(buse_name.equals("�ٴٸ�Ʈ�����")) { %>selected<% } %>>�ٴٸ�Ʈ�����</option>
						  <option value="��ȣ������"<%if(buse_name.equals("��ȣ������")) { %>selected<% } %>>��ȣ������</option>
						  <option value="���Ż����"<%if(buse_name.equals("���Ż����")) { %>selected<% } %>>���Ż����</option>
						  <option value="�������������"<%if(buse_name.equals("�������������")) { %>selected<% } %>>�������������</option>
						  <option value="���������"<%if(buse_name.equals("���������")) { %>selected<% } %>>���������</option>
						  <option value="��Ź�������"<%if(buse_name.equals("��Ź�������")) { %>selected<% } %>>��Ź�������</option>
						  <option value="�ɻ��"<%if(buse_name.equals("�ɻ��")) { %>selected<% } %>>�ɻ��</option>
						  <option value="����������"<%if(buse_name.equals("����������")) { %>selected<% } %>>����������</option>
						  <option value="���������ź���"<%if(buse_name.equals("���������ź���")) { %>selected<% } %>>���������ź���</option>
						  <option value="���Ű�����"<%if(buse_name.equals("���Ű�����")) { %>selected<% } %>>���Ű�����</option>
						  <option value="������"<%if(buse_name.equals("������")) { %>selected<% } %>>������</option>
						  <option value="��ȯ�����"<%if(buse_name.equals("��ȯ�����")) { %>selected<% } %>>��ȯ�����</option>
						  <option value="��������"<%if(buse_name.equals("��������")) { %>selected<% } %>>��������</option>
						  <option value="�ڱݺ�"<%if(buse_name.equals("�ڱݺ�")) { %>selected<% } %>>�ڱݺ�</option>
						  <option value="��������"<%if(buse_name.equals("��������")) { %>selected<% } %>>��������</option>
						  <option value="���������ý�"<%if(buse_name.equals("���������ý�")) { %>selected<% } %>>���������ý�</option>
						  <option value="����������"<%if(buse_name.equals("����������")) { %>selected<% } %>>����������</option>
						  <option value="���հ����"<%if(buse_name.equals("���հ����")) { %>selected<% } %>>���հ����</option>
						  <option value="���ձ�������ũ������"<%if(buse_name.equals("���ձ�������ũ������")) { %>selected<% } %>>���ձ�������ũ������</option>
						  <option value="�����ڱݺ�"<%if(buse_name.equals("�����ڱݺ�")) { %>selected<% } %>>�����ڱݺ�</option>
						  <option value="�ع����ý�"<%if(buse_name.equals("�ع����ý�")) { %>selected<% } %>>�ع����ý�</option>
						  <option value="ī������"<%if(buse_name.equals("ī������")) { %>selected<% } %>>ī������</option>
						  <option value="Ư�ǻ����"<%if(buse_name.equals("Ư�ǻ����")) { %>selected<% } %>>Ư�ǻ����</option>
						  <option value="�ǸŻ����"<%if(buse_name.equals("�ǸŻ����")) { %>selected<% } %>>�ǸŻ����</option>
						  <option value="�ؾ����ڱ�����"<%if(buse_name.equals("�ؾ����ڱ�����")) { %>selected<% } %>>�ؾ����ڱ�����</option>
						  <option value="ȫ����"<%if(buse_name.equals("ȫ����")) { %>selected<% } %>>ȫ����</option>
						  <option value="ȸ��������"<%if(buse_name.equals("ȸ��������")) { %>selected<% } %>>ȸ��������</option>
						  <option value="FS�����"<%if(buse_name.equals("FS�����")) { %>selected<% } %>>FS�����</option>
						  <option value="���ǻ����"<%if(buse_name.equals("���ǻ����")) { %>selected<% } %>>���ǻ����</option>
                          <!-- -->
                        </select>
                      </td>
                      <td width="20">&nbsp;</td>
                      <td width="60" class="bluesky">��ȸ����</td>
                      <td width="70"> 
                        <select name="FIELD">
                          <option value="">����</option>
						  <option value="title">����</option>
						  <option value="text">����</option>
  						  <option value="name">�ο���</option>
                          <!-- -->
                        </select>
                      </td>
                      <td> 
                        <input type="text" class="input01" size="48" name="KEY" value="<%=KEY%>">
                      </td>
                      <td width="15">&nbsp;</td>
                      <td width="42"><a href="javascript:GoReg();"><img src="img/btn_search.gif" width="38" height="17" border="0" alt="�˻�"></a></td>
                      <td width="40"><a href="javascript:pbform.reset();"><img src="img/btn_refresh.gif" width="48" height="17" border="0" alt="�ʱ�ȭ"></a></td>
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
<!-- // ������� ���� ���� -->
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td style="padding:0 0 10 10 ;"> 
      <!-- �˻���� -->
      <table width="960" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30"><img src="img/result.gif" align="absmiddle"> �˻���� : 
            <span class="result_text">�� <%=TotalRecordCount %>��</span></td>
          <td height="30" align="right"><a href="excel/oil_excel.jsp?cmd=<%=cmd%>&KEY=<%=KEY%>&FIELD=<%=FIELD%>&startday=<%=startday%>&endday=<%=endday%>&status=<%=status%>&buse_name=<%=buse_name%>&result=<%=result%>"><img src="img/btn_excel.gif" width="66" height="21" alt="����" border="0"></a></td>
        </tr>
        <tr> 
          <td height="2" class="result_line" colspan="2"></td>
        </tr>
      </table>
      <!-- // �˻���� -->
    </td>
  </tr>
  <!-- ����Ʈ -->
  <tr> 
    <td style="padding-left:25;"><img src="img/arrow.gif" width="13" height="16" align="absmiddle"> 
      ������� ����</td>
  </tr>
  <tr> 
    <td style="padding:10 0 0 25;"> 
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="10" height="2" class="board_topline"></td>
        </tr>
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
        <tr> 
          <td colspan="10" height="1" class="board_line"></td>
        </tr>
        <%
				Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);
			    
			    if( ResultVector.size() > 0){
					for (int i=0; i < ResultVector.size();i++){
						Hashtable h = (Hashtable)ResultVector.elementAt(i);
			
						String TITLE = (String)h.get("TITLE");	//����
						if (TITLE.length() > 31){
							TITLE = TITLE.substring(0,31);
							TITLE += "...";
						}
						//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //�۹�ȣ ��� 
						int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//�۹�ȣ ���(����)
						String time2=(String)h.get("TIME2");
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
          <td align="center"><%=(String)h.get("CODE") %></td>
          <td align="center"><%=(String)h.get("BUSEO") %></td>
          <td align="center"><%=(String)h.get("RESULT") %></td>
          <td align="center"><%=time2 %></td>
        </tr>
        <tr> 
          <td colspan="9" class="board_line2" height="1"></td>
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
      <br>
      <!-- // ����Ʈ -->
      <!-- ������ �ѹ��� -->
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td align="center">
          	<% if(TotalRecordCount > 0) { %>
			<%=FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock, "oil.jsp?KEY="+KEY+"&cmd=" + cmd + "&FIELD=" + FIELD + "&startday=" + startday + "&endday=" + endday + "&status=" + status + "&buse_name=" + buse_name + "&PAGE=","<img src=img/board_prev.gif width=13 height=13 align=absmiddle border=0>","<img src=img/board_next.gif width=13 height=13 align=absmiddle border=0>")%>
			<% } %>
          </td>
        </tr>
      </table>
      <!-- ������ �ѹ��� -->
    </td>
  </tr>
</table>
<input type="hidden" name="cmd">
<input type="hidden" name="thid">
<input type="hidden" name="PAGE">
</form>
<%@ include file="include/bottom.jsp" %>
<% 
	} catch(Exception e) {
		out.println("oil.jsp : " + e.getMessage());
	} finally {

	}
%>		
