<%@ page import="java.util.*, util.*,java.text.SimpleDateFormat" contentType="text/html;charset=euc-kr"%>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %> 
<%@ include file="include/top_menu04.jsp" %>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>

<%
	String thid = Converter.nullchk(request.getParameter("thid"));
	String PAGE = Converter.nullchk(request.getParameter("PAGE"));
	int thididx=Integer.parseInt(thid);
	String finance_buseo=(String)session.getAttribute("buseo");
	
	String TableName = " sh_financetrouble ";
	String SelectCondition = " publication,code,title,name,text,text1,buseo,replyname,result,junbuseo, ";
	SelectCondition += "to_char(time1, 'YYYY-MM-DD') AS time1, ";
	SelectCondition += "to_char(time2, 'YYYY-MM-DD') AS time2 ";
	String WhereCondition = " where thid=" + thididx;
	String OrderCondition  = "";
	//int TotalRecordCount = FrontBoard.TotalCount(TableName2, WhereCondition2);
	//out.println("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br><br>");
	Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 0, 0);
	
	String publication="";
	String code="";
	String title="";
	String name="";
	String replyname="";
	String text = "";
	String text1="";
	String buseo="";
	String time1="";
	String time2="";
	String preresult="";
	String result="";
	String junbuseo="";
	
	//out.println(ResultVector.size());
	
	if( ResultVector.size() > 0){
		for (int i=0; i < ResultVector.size(); i++){
			Hashtable h = (Hashtable)ResultVector.elementAt(i);
			
			publication=(String)h.get("PUBLICATION");
			code=(String)h.get("CODE");
			title=(String)h.get("TITLE");
			name=(String)h.get("NAME");
			replyname=(String)h.get("REPLYNAME");
			text=(String)h.get("TEXT");
			text1=(String)h.get("TEXT1");
			buseo=(String)h.get("BUSEO");
			
			StringTokenizer stk = new StringTokenizer(text, "\r\n");
			text="";
			while(stk.hasMoreElements()){
				text += stk.nextToken();
				text += "<br>";
			}
			StringTokenizer stk1 = new StringTokenizer(text1, "\r\n");
			text1="";
			while(stk1.hasMoreElements()){
				text1 += stk1.nextToken();
				text1 += "<br>";
			}
			time1=(String)h.get("TIME1");
			time2=(String)h.get("TIME2");
			result=(String)h.get("RESULT");
			junbuseo=(String)h.get("JUNBUSEO");
			
			if(result.equals("��ġ/����") || result.equals("�����ȳ�") || result.equals("����/����") || result.equals("��������")  ){
				preresult="�ذ�";
			}
			else if(result.equals("����/������Ҵ�") || result.equals("������ո�") || result.equals("����") || result.equals("��ǻ���") ){
				preresult="��ġ�Ҵ�";
			}
			else if(result.equals("�͸��ּҹ�") || result.equals("��������") || result.equals("�Ҽ�/����") || result.equals("�ҹ�(�ο��ƴ�)") ){
				preresult="�ҹ�";
			}
			else if(result.equals("����/����")){
				preresult="��Ÿ";
			}
		}
	}
	
	TableName = " sh_finance_history ";
	SelectCondition = " sh_no,sh_finance_no,sh_buseo_from,sh_buseo_to,sh_status,";
	SelectCondition += "to_char(sh_indate, 'YYYY-MM-DD') AS sh_indate ";
	WhereCondition = " where sh_finance_no=" + thididx;
	OrderCondition  = " order by sh_no asc";
	//int TotalRecordCount = FrontBoard.TotalCount(TableName2, WhereCondition2);
	//out.println("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br><br>");
	
	Date date = new Date();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
%>
<!-- ������� ���� ���� -->
<script language="JavaScript">
<!--
	function MM_openBrWindow(theURL,winName,features) { //v2.0
	  window.open(theURL,winName,features);
	}
	function goView(thid,PAGE){
		pbform.action = "finance_view.jsp";
		pbform.submit();
	}
	
//-->
</script>
<form method=post name="pbform" action="" style="margin:0px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="95" bgcolor="f4f4f4"  style="padding-left:25;"> 
      <table width="945" border="0" cellspacing="0" cellpadding="0" background="img/title_bg.gif">
        <tr> 
          <td width="135"> 
            <table width="135" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="70" align="center" class="admin_subject">������� ����</td>
              </tr>
            </table>
          </td>
          <td width="5"></td>
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="60" class="adminsub_subject" style="padding-left:25;">������ 
                  �� �繫�ҳ� ���� �������� ���������� �����Ͽ� ������ �δ��� ������ �����ν� <br>
                  ���� �Ǵ� ���� �ս��� �ʷ��ϰų� ���������� �����ϰ� �� ����� �ִ� ������ ���Ͽ� ������ �����ް� �ֽ��ϴ�..</td>
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
      <table width="965" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30"><img src="img/result.gif" align="absmiddle"> ������� ���� <span class="result_text">�󼼺���</span></td>
		  <!-- �߰� -->
          <%if(finance_buseo.equals(buseo)){%>
          <td height="30" align="right"><a href="javascript:goView();"><img src="img/btn_adjust.gif" width="55" height="21" alt="����" border="0"></a></td>
          <%} %>
          <td height="30" align="right" width="60"><a href="#"><img src="img/btn_print.gif" width="55" height="21" onClick="MM_openBrWindow('finance_print.jsp?thididx=<%=thididx%>','','width=638,height=630')" border="0" alt="���"></a></td>
          <td height="30" align="right" width="60"><a href="finance.jsp?PAGE=<%=PAGE %>"><img src="img/btn_list.gif" width="55" height="21" border="0" alt="���"></a></td>
        </tr>
        <tr> 
          <td height="2" class="result_line" colspan="4"></td>
        </tr>
      </table>
      <!-- // �˻���� -->
    </td>
  </tr>
  <!-- �ο�������Ȳ ��������-->
  <tr> 
    <td style="padding:10 0 0 25;"> 
      <table width="945" border="0" cellspacing="0" cellpadding="0" class="table_outline">
        <tr> 
          <td style="padding:5 5 5 5;"> 
            <table cellpadding="0" cellspacing="0" border="0">
              <tr height="30" bgcolor="a8cae5"> 
                <td colspan="3"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td style="padding-left:10;">��ȣ : <%=thid%></td>
                      <td align="right" style="padding-right:10;">ó������ : <%=code%></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td height="5"></td>
              </tr>
              <tr height="30"> 
                <td align="center" class="board_bg_title" valign="top" width="650"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="read_outline">
                    <tr> 
                      <td align="center" height="30" class="table_bg_title"><%=title%></td>
                    </tr>
                    <tr> 
                      <td style="padding:20 20 20 20;">
                      <%=text%>
                      </td>
                    </tr>
                  </table>
                </td>
                <td align="center" valign="top" width="5"></td>
                <td class="board_bg_title" width="295" valign="top" align="right"> 
                  <!-- ������� �������� -->
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="read_outline" height="100%">
                    <tr> 
                      <td height="30" style="padding-left:10;" class="table_bg_title">������� 
                        ���� ��������</td>
                    </tr>
                    <tr> 
                      <td valign="top"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">Ư���ڵ�</td>
                            <td><%=publication%></td>
                          </tr>
                          <tr> 
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">��û��</td>
                            <td><%=time1%></td>
                          </tr>
                          <tr> 
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">�ο���</td>
                            <td><%=name%> <a href="#" onClick="MM_openBrWindow('finan_popup.jsp?thididx=<%=thididx%>','','width=500,height=290')">[<u>������ 
                              ����</u>]</a></td>
                          </tr>
                          <tr> 
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">���μ�</td>
							<!-- �߰� -->
               				<%if(junbuseo.equals("") || junbuseo==null) {%>
                            	<td> <%=buseo %></td>
                            <%}else{ %>
                            	<td> <%=buseo %></td>
                            <%} %>
                            	<input type="hidden" name="buseo" value="<%=buseo %>">
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <!-- // ������� ���� ����-->
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br>
      <table width="945" border="0" cellspacing="0" cellpadding="0" class="table_outline">
        <tr> 
          <td style="padding:5 5 5 5;"> 
            <table cellpadding="0" cellspacing="0" border="0">
              <tr> 
                <td height="5"></td>
              </tr>
              <tr height="30"> 
                <td align="center" class="board_bg_title" valign="top" width="650"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="read_outline">
                    <tr> 
                      <td align="center" height="30" class="table_bg_title">�亯����</td>
                    </tr>
                    <tr> 
                      <td style="padding:20 20 20 20;">
                      <%=text1%>
                      </td>
                    </tr>
                  </table>
                </td>
                <td align="center" class="board_bg_title" valign="top" width="5"></td>
                <td class="board_bg_title" width="295" valign="top" align="right"> 
                  <!-- �ο��������� -->
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="read_outline" height="100%">
                    <tr> 
                      <td height="30" style="padding-left:10;" class="table_bg_title">������� 
                        ���� ó�� ����</td>
                    </tr>
                    <tr> 
                      <td valign="top"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">Ư���ڵ�</td>
                            <td><%=publication%></td>
                          </tr>
                          <tr> 
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>
<!--                          
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">ó�����</td>
                            <td><%=preresult%> &gt; <%=result%></td>
                          </tr>
-->                          
                          <tr> 
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">ó������</td>
                            <td><%=time2%></td>
                          </tr>
                          <tr> 
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">���μ�</td>
                            <td><%=buseo%></td>
                          </tr>
                          <tr> 
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>
<!--
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">�����</td>
                            <td><%=replyname%></td>
                          </tr>
-->                          
                        </table>
                      </td>
                    </tr>
                  </table>
                  <!-- // �ο��������� -->
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br>
      <!-- // �ο�������Ȳ ��������-->
    </td>
  </tr>
</table>
<!--�μ��� ��ø�����̷°��� ����Ʈ -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td style="padding-left:25;"><img src="img/arrow.gif" width="13" height="16" align="absmiddle"> 
      <span class="txt_title">�μ��� ��ø���� �̷°���</span></td>
  </tr>
  <tr> 
    <td style="padding:10 0 0 25;"> 
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="10" height="2" class="board_topline"></td>
        </tr>
        <tr height="30"> 
          <td class="board_bg_title" width="70" align="center">NO</td>
          <td class="board_bg_title" align="center">~����</td>
          <td class="board_bg_title" align="center">~��</td>
          <td class="board_bg_title" align="center">��ø����</td>
          <td class="board_bg_title" align="center">ó������</td>
        </tr>
        <tr> 
          <td colspan="10" height="1" class="board_line"></td>
        </tr>
<%ResultVector = FrontBoard.list(TableName, SelectCondition,WhereCondition, OrderCondition, 0, 1);%>
<%if (ResultVector.size() > 0) {%>
	<%for (int i = 0; i < ResultVector.size(); i++) {%>
		<%Hashtable h = (Hashtable)ResultVector.elementAt(i);%>
        <tr height="30"  onMouseOver=this.style.backgroundColor='F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'> 
          <td align="center"><%=i + 1%></td>
          <td align="center"><%=(String)h.get("SH_BUSEO_FROM") %></td>
          <td align="center"><%=(String)h.get("SH_BUSEO_TO") %></td>
          <td style="padding-left:10;" align="center"><%=(String)h.get("SH_INDATE") %></td>
          <td align="center"><%=(String)h.get("SH_STATUS") %></td>
        </tr>
        <tr> 
          <td colspan="10" class="board_line2" height="1"></td>
        </tr>
	<%}%>
<%} else {%>
		<tr height="30"  onMouseOver=this.style.backgroundColor='F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'>
			<td colspan="5" align="center">��ϵ� �ڷᰡ �����ϴ�</td>
		</tr>
<%}%>
      </table>
    </td>
  </tr>
</table>
<input type="hidden" name="thid" value="<%=thid %>">
<input type="hidden" name="PAGE" value="<%=PAGE%>">
</form>
<%@ include file="include/bottom.jsp" %>
