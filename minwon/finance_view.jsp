<%@ page import="java.util.*, util.*,java.text.SimpleDateFormat,javax.sql.*, javax.naming.*,java.sql.*" contentType="text/html;charset=euc-kr"%>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %>
<%@ include file="include/top_menu04.jsp" %>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>

<%
	String thid = Converter.nullchk(request.getParameter("thid"));
	String PAGE = Converter.nullchk(request.getParameter("PAGE"));
	String finance_buseo=(String)session.getAttribute("buseo");
	int thididx=Integer.parseInt(thid);

	String TableName = " sh_financetrouble ";
	String SelectCondition = " publication,code,title,name,buseo,text,text1,result,junbuseo,tel,";
	SelectCondition += "to_char(time1, 'YYYY-MM-DD') AS time1, ";
	SelectCondition += "to_char(time2, 'YYYY-MM-DD') AS time2, to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date ";
	String WhereCondition = " where thid=" + thididx;
	String OrderCondition  = "";
	//int TotalRecordCount = FrontBoard.TotalCount(TableName2, WhereCondition2);
	//out.println("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br><br>");
	Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 0, 0);

	String publication="";
	String code="";
	String title="";
	String name="";
	String buseo="";
	String text = "";
	String text1 = "";
	String result = "";
	String junbuseo="";
	String time1="";
	String time2="";
	String abandon_date="";
	String tel = "";

	//out.println(ResultVector.size());

	if( ResultVector.size() > 0){
		for (int i=0; i < ResultVector.size(); i++){
			Hashtable h = (Hashtable)ResultVector.elementAt(i);

			publication=(String)h.get("PUBLICATION");
			code=(String)h.get("CODE");
			title=(String)h.get("TITLE");
			name=(String)h.get("NAME");
			buseo=(String)h.get("BUSEO");
			text=(String)h.get("TEXT");
			tel=(String)h.get("TEL");
			StringTokenizer stk = new StringTokenizer(text, "\r\n");
			text = "";
			while(stk.hasMoreElements()){
				text += stk.nextToken();
				text += "<br>";
			}
			text1=(String)h.get("TEXT1");
			result=(String)h.get("RESULT");
			junbuseo=(String)h.get("JUNBUSEO");
			time1=(String)h.get("TIME1");
			time2=(String)h.get("TIME2");
			abandon_date=(String)h.get("ABANDON_DATE");
		}
	}
	if(text1==null) text1="";
	if(result==null) result="";

	TableName = " sh_finance_history ";
	SelectCondition = " sh_no,sh_finance_no,sh_buseo_from,sh_buseo_to,sh_status,";
	SelectCondition += "to_char(sh_indate, 'YYYY-MM-DD') AS sh_indate ";
	WhereCondition = " where sh_finance_no=" + thididx;
	OrderCondition  = " order by sh_no asc";

	java.util.Date date = new java.util.Date();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");

	//�д� ����� ����� �Ҽ��� ����,�ٸ� �μ��� ��� ó����
	//�Ѱ����ڰ� �ƴҰ��, �ڵ尡 �亯�Ϸ�,��ø,�ݼ��� �ƴҰ��,�亯�� �ȴ� ���
	if(!finance_buseo.equals("all") && text1.equals("") && code.equals("��û")){
		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt=null;

		try{
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
			conn = ds.getConnection();

			String sql = "";
			if(finance_buseo.equals("�����")){
				sql="update sh_financetrouble set code='����' where thid=?";
			}
			else{
				sql="update sh_financetrouble set code='ó����' where thid=?";
			}
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,thididx);
			pstmt.executeUpdate();
		}catch (Exception e){
			e.printStackTrace();
		}
		finally{
			if(pstmt!=null){
				pstmt.close();
			}
			if(conn!=null)	conn.close();
		}
	}


%>
<!--/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************/-->
<!-- <SCRIPT SRC="http://www.suhyup.co.kr/supervisor/js/ax_wdigm/default.js"></SCRIPT> -->
<!--/********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/-->
<script language="javascript">
	function goReply(thid){
		var mText  = document.pbform.text1.value;
		if(!pbform.text1.value){
			alert("������ ����� �ּ���");
			pbform.text1.focus();
			return;
		}

		var isstr=confirm("�亯�� �Ͻðڽ��ϱ�?");
		if(isstr){

			/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************
			try{
				if(UsingRemote == true){
					if(!beScan('',mText,'')){
					return;
					}
				}
			}
			catch (e){
				var objRtn = objAX.beScanner(policy, '','', this.location, mText, '');
				if(objRtn == 0){
					return;
				}else{
					return;
				}
			}
			********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/

			pbform.action="finance_view_ok.jsp";
			pbform.submit();
		}
	}
	function send(){
		if(!pbform.buseo.value){
			alert("��ø�� �μ��� �������ּ���");
			pbform.buseo.focus();
			return;
		}
		if(confirm("��ø�Ͻðڽ��ϱ�?")){
			pbform.action="send_ok.jsp";
			pbform.submit();
		}
	}
	function receive(){
		if(confirm("�ݼ��Ͻðڽ��ϱ�?")){
			pbform.action="receive_ok.jsp";
			pbform.submit();
		}
	}
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
                  ���� �Ǵ� ������ �ս��� �ʷ��ϰų� ���������� �����ϰ� �� ����� �ִ� ������ ���Ͽ� ������ �����ް� �ֽ��ϴ�..</td>
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
          <td height="30"><img src="img/result.gif" align="absmiddle"> ������� ����
            <span class="result_text">�󼼺���</span></td>
          <td height="30" align="right" width="60"><a href="#"><img src="img/btn_print.gif" width="55" height="21" onClick="MM_openBrWindow('finance_print2.jsp?thididx=<%=thididx%>','','width=638,height=630')" border="0" alt="���"></a></td>
          <td height="30" align="right" width="60"><a href="finance.jsp?PAGE=<%=PAGE %>"><img src="img/btn_list.gif" width="55" height="21" border="0" alt="���"></a></td>
        </tr>
        <tr>
          <td height="2" class="result_line" colspan="3"></td>
        </tr>
      </table>
      <!-- // �˻���� -->
    </td>
  </tr>
  <!-- ������� ���� ��������-->
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
                      <td style="padding-left:10;">��ȣ : <%=thid %></td>
                      <td align="right" style="padding-right:10;">ó������ : <%=code %></td>
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
                      <td align="center" height="30" class="table_bg_title"><%=title %></td>
                    </tr>
                    <tr>
                      <td style="padding:20 20 20 20;">
                      <%=text %>
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
                            <td><%=publication %></td>
                          </tr>
                          <tr>
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>
                          <tr>
                            <td height="30" style="padding-left:10;" class="bluesky">��û��</td>
                            <td><%=time1 %></td>
                          </tr>
                          <tr>
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>
                          <tr>
                            <td height="30" style="padding-left:10;" class="bluesky">�ο���</td>
                            <td><%=name %> <a href="#" onClick="MM_openBrWindow('finan_popup.jsp?thididx=<%=thididx%>','','width=500,height=290')">[<u>������
                              ����</u>]</a></td>
                          </tr>
						  <%if("öȸ�Ϸ�".equals(code)){%>
						  <tr>
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>
                          <tr>
                            <td height="30" style="padding-left:10;" class="bluesky">öȸ����</td>
                            <td><%=abandon_date%></td>
                          </tr>
                          <%} %>
                          <tr>
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>                          <tr>
                            <td height="30" style="padding-left:10;" class="bluesky">���μ�</td>
                            <!-- �� �����߿� �μ������� �����,�ع�������,��Ÿ �� ������ ����-->
                            <!-- �۳����� ������� ��� , ����� ���Ѹ��� ���� �ִ°�-->
                            <%if(buseo.equals("�����")){%>
                            <td>
                            	<!-- �۳����� ������̸鼭 �α����� ����ڰ� ������� ���,�亯������ ���� ��� ��ø ���-->
                            	<%if(finance_buseo.equals("�����") && text1.equals("") && !code.equals("öȸ�Ϸ�")){ %>
                            	<select name="buseo">
									<option value="">����</option>
									<option value="buseo">����</option>
									<option value="������ȣ����">������ȣ����</option>
									<!-- <option value="����������">����������</option> -->
									<option value="�����">�����</option>
									<option value="ICT������">ICT������</option>
									<option value="�λ��ѹ���">�λ��ѹ���</option>
									<option value="������ȹ��">������ȹ��</option>
									<option value="�����Һ��ں�ȣ��">�����Һ��ں�ȣ��</option>
									<option value="���������">���������</option>
									<option value="�۷ι���ȯ�����">�۷ι���ȯ�����</option>
									<option value="������ȹ��">������ȹ��</option>
									<option value="��ȹ��">��ȹ��</option>
									<option value="�뷮������ ����ȭ�������">�뷮������ ����ȭ�������</option>
									<option value="����ũ��������">����ũ��������</option>
									<option value="����ũ������">����ũ������</option>
									<option value="��ī�ݵ�����(��ī)">��ī�ݵ�����(��ī)</option>
									<option value="��ī�ݵ�����(�ݵ�)">��ī�ݵ�����(�ݵ�)</option>
									<!-- <option value="�������������">�������������</option> -->
									<option value="��ȣ������">��ȣ������</option>
									<!-- <option value="����������">����������</option> -->
									<option value="�ع����ý�(����)">�ع����ý�(����)</option>
									<option value="�ع����ý�(�߾�ȸ)">�ع����ý�(�߾�ȸ)</option>
									<option value="�������������">�������������</option>
									<option value="���������">���������</option>
									<option value="�����а��ߺ�">�����а��ߺ�</option>
									<option value="��Ź�������">��Ź�������</option>
									<option value="�ɻ��">�ɻ��</option>
									<!-- <option value="����������">����������</option> -->
									<option value="���������ź���">���������ź���</option>
									<option value="���Ű�����">���Ű�����</option>
									<option value="���������">���������</option>
									<option value="������å��">������å��</option>
									<option value="������">������</option>
									<option value="�ǸŻ����">�ǸŻ����</option>
									<option value="�̻�ȸ�繫��">�̻�ȸ�繫��</option>
									<option value="�ڱݺ�">�ڱݺ�</option>
									<option value="�ڱݿ���">�ڱݿ���</option>
									<option value="��������">��������</option>
									<option value="������ȣ����">������ȣ����</option>
									<option value="��å�����">��å�����</option>
									<option value="���հ����">���հ����</option>
									<option value="���α�����">���α�����</option>
									<option value="�ع����ý�">�ع����ý�</option>
									<!-- <option value="�ع�������">�ع�������</option> -->
									<option value="�ѹ���">�ѹ���</option>
									<option value="ī������">ī������</option>
									<!-- <option value="�ؾ����ڱ�������">�ؾ����ڱ�������</option> -->
									<option value="ȫ����">ȫ����</option>
									<option value="ȸ��������">ȸ��������</option>
									
									<option value="IB�������">IB�������</option>
									<option value="IT������">IT������</option>
									<option value="�泲��������">�泲��������</option>
									<option value="�濵������">�濵������</option>
									<option value="�����и����ú�">�����и����ú�</option>
									<option value="������������">������������</option>
									<option value="���������">���������</option>
									<option value="����������">����������</option>
									<option value="��������">��������</option>
									<option value="������������">������������</option>
									<option value="�ع����ý�">�ع����ý�</option>
									<option value="���Ӱ濵������">���Ӱ濵������</option>
									
									<!-- 
									<option value="�����" >�����</option>
									<option value="ICT������" >ICT������</option>
									<option value="�λ��ѹ���" >�λ��ѹ���</option>
									<option value="�����ú�" >�����ú�</option>
									<option value="���������" >���������</option>
									<option value="������ȹ��" >������ȹ��</option>
									<option value="��ȹ��" >��ȹ��</option>
									<option value="�뷮������ ����ȭ�������" >�뷮������ ����ȭ�������</option>
									<option value="��ü�޽Ļ����" >��ü�޽Ļ����</option>
									<option value="����ũ��������" >����ũ��������</option>
									<option value="��ī�ݵ�����(��ī)" >��ī�ݵ�����(��ī)</option>
									<option value="��ȣ������" >��ȣ������</option>
									<option value="�������������" >�������������</option>
									<option value="���������" >���������</option>
									<option value="��ǰ�����" >��ǰ�����</option>
									<option value="��Ź�������" >��Ź�������</option>
									<option value="�ɻ��" >�ɻ��</option>
									<option value="����������" >����������</option>
									<option value="���������ź���" >���������ź���</option>
									<option value="���Ű�����" >���Ű�����</option>
									<option value="������" >������</option>
									<option value="��ȯ�����" >��ȯ�����</option>
									<option value="������ȹ��" >������ȹ��</option>
									<option value="�̻�ȸ�繫��" >�̻�ȸ�繫��</option>
									<option value="�ڱݺ�" >�ڱݺ�</option>
									<option value="��������" >��������</option>
									<option value="����������" >����������</option>
									<option value="������ȣ����" >������ȣ����</option>
									<option value="���հ����" >���հ����</option>
									<option value="����ũ������" >����ũ������</option>
									<option value="�ڱݿ���" >�ڱݿ���</option>
									<option value="�ع�������" >�ع�������</option>
									<option value="���ǻ����" >���ǻ����</option>
									<option value="�ѹ���" >�ѹ���</option>
									<option value="ī������" >ī������</option>
									<option value="�ݵ�����" >�ݵ�����</option>
									<option value="�ؾ����ڱ�������" >�ؾ����ڱ�������</option>
									<option value="ȫ����" >ȫ����</option>
									<option value="ȸ��������" >ȸ��������</option>
									<option value="�������������" >�������������</option>
									<option value="���������" >���������</option>
									<option value="������å��" >������å��</option>
									<option value="��å�����" >��å�����</option>
									<option value="�����Һ��ں�ȣ��" >�����Һ��ں�ȣ��</option>
									<option value="�ع����ý�(�߾�ȸ)" >�ع����ý�(�߾�ȸ)</option>
									<option value="�ع����ý�(����)" >�ع����ý�(����)</option>
									 -->
		                        </select>
                              <a href="javascript:send();"><img src="img/btn_transfer.gif" align="absmiddle" alt="��ø" border="0"></a>
                              <!-- �۳����� ������̸鼭 �α����� ����ڰ� ������� ���,�亯������ �ִ� ��� �Ұ��μ� �̸��� ��Ÿ��-->
                              <%}else{ %>
                              	<%=buseo %>
                              <%} %>
                            </td>
                            <!-- �۳����� �ع������� ���,����� �Ǵ� �ع����������Ѹ��� �����ִ°� -->
                            <%}else if(buseo.equals("�����Һ��ں�ȣ��")){%>
                            <td>
                            	<!-- �۳����� �ع��������̸鼭 �α����� ����ڰ� �ع��������� ���,�亯������ ���� ��� ����Ƿ� �ݼ۹� Ÿ�μ��� ��ø���� -->
                            	<%if(finance_buseo.equals("�����Һ��ں�ȣ��") && text1.equals("") && !code.equals("öȸ�Ϸ�")){ %>
                            	<select name="buseo">
		                          <option value="">����</option>
						                    <option value="�����" >�����</option>
                                <option value="ICT������" >ICT������</option>
                                <option value="�λ��ѹ���" >�λ��ѹ���</option>
                                <option value="�����ú�" >�����ú�</option>
                                <option value="���������" >���������</option>
                                <option value="������ȹ��" >������ȹ��</option>
                                <option value="��ȹ��" >��ȹ��</option>
                                <option value="�뷮������ ����ȭ�������" >�뷮������ ����ȭ�������</option>
                                <option value="��ü�޽Ļ����" >��ü�޽Ļ����</option>
                                <option value="����ũ��������" >����ũ��������</option>
                                <option value="��ī�ݵ�����(��ī)" >��ī�ݵ�����(��ī)</option>
                                <option value="��ȣ������" >��ȣ������</option>
                                <option value="�������������" >�������������</option>
                                <option value="���������" >���������</option>
                                <option value="��ǰ�����" >��ǰ�����</option>
                                <option value="��Ź�������" >��Ź�������</option>
                                <option value="�ɻ��" >�ɻ��</option>
                                <!-- <option value="����������" >����������</option> -->
                                <option value="���������ź���" >���������ź���</option>
                                <option value="���Ű�����" >���Ű�����</option>
                                <option value="������" >������</option>
                                <option value="��ȯ�����" >��ȯ�����</option>
                                <option value="������ȹ��" >������ȹ��</option>
                                <option value="�̻�ȸ�繫��" >�̻�ȸ�繫��</option>
                                <option value="�ڱݺ�" >�ڱݺ�</option>
                                <option value="��������" >��������</option>
                                <option value="����������" >����������</option>
                                <option value="������ȣ����" >������ȣ����</option>
                                <option value="���հ����" >���հ����</option>
                                <option value="����ũ������" >����ũ������</option>
                                <option value="�ڱݿ���" >�ڱݿ���</option>
                                <!-- <option value="�ع�������" >�ع�������</option> -->
                                <option value="���ǻ����" >���ǻ����</option>
                                <option value="�ѹ���" >�ѹ���</option>
                                <option value="ī������" >ī������</option>
                                <option value="�ݵ�����" >�ݵ�����</option>
                               <!--  <option value="�ؾ����ڱ�������" >�ؾ����ڱ�������</option> -->
                                <option value="ȫ����" >ȫ����</option>
                                <option value="ȸ��������" >ȸ��������</option>
                                <!-- <option value="�������������" >�������������</option> -->
                                <option value="���������" >���������</option>
                                <option value="������å��" >������å��</option>
                                <option value="��å�����" >��å�����</option>
                                <option value="�����Һ��ں�ȣ��" >�����Һ��ں�ȣ��</option>								
								<option value="�ع����ý�(�߾�ȸ)" >�ع����ý�(�߾�ȸ)</option>
                                <option value="�ع����ý�(����)" >�ع����ý�(����)</option>
                                
                                <option value="IB�������">IB�������</option>
								<option value="IT������">IT������</option>
								<option value="�泲��������">�泲��������</option>
								<option value="�濵������">�濵������</option>
								<option value="�����и����ú�">�����и����ú�</option>
								<option value="������������">������������</option>
								<option value="���������">���������</option>
								<option value="����������">����������</option>
								<option value="��������">��������</option>
								<option value="������������">������������</option>
								<option value="�ع����ý�">�ع����ý�</option>
								<option value="���Ӱ濵������">���Ӱ濵������</option>
		                        </select>
		                        <a href="javascript:send();"><img src="img/btn_transfer.gif" align="absmiddle" alt="��ø" border="0"></a>
		                        <br><br>
                              	����Ƿ� <a href="javascript:receive();"><img src="img/btn_sendback.gif" align="absmiddle" border="0" alt="�ݼ�" ></a>

                              	<input type="hidden" name="buseo_to" value="<%="�����" %>">
		                        <!-- �۳����� �ع��������̸鼭 �α����� ����ڰ� �ع������ �Ǵ� ������� ���,�亯������ �ִ� ��� �Ұ��μ� �̸��� ��Ÿ�� -->
		                        <%}else{%>
		                        	<%if(junbuseo.equals("")){%>
		                        		<%=buseo %>
		                        	<%}else{%>
		                        		<%=buseo %>
		                        	<%} %>
		                        <%} %>
                            </td>
                            <!-- �۳����� �����,�ع�������� �ƴ� ���,�����,�ع�������,������ �μ����� �����ִ°� -->
                            <%}else{ %>
                            	<!-- �α����� ����� �ع������� ��� �Ұ��μ� �̸��� ��Ÿ��-->
                            	<%if(finance_buseo.equals("�����Һ��ں�ȣ��")){ %>
                            		<td><%=buseo %></td>
                            	<!-- �α����� ����� ������� ��� �Ұ��μ� �̸��� ��Ÿ��-->
                            	<%}else if(finance_buseo.equals("�����")){ %>
                            		<td>
                            			<%if(junbuseo.equals("Y")){ %>
                            				<%=buseo %>
                            			<%}else{ %>
                            				<%=buseo %>
                            			<%} %>
                            		</td>
                            	<!-- �α����� ����� �Ϲݺμ��� ��� �ݼ۱��-->
                            	<%}else{ %>
                            		<!-- �亯�� �ȴ� ���-->
                            		<%if(text1.equals("")){%>
                            			<!-- �۳����� �ع������� ���� ���-->
                            			<%if(junbuseo.equals("Y")){ %>
                           					<td> �����Һ��ں�ȣ������ <a href="javascript:receive();"><img src="img/btn_sendback.gif" align="absmiddle" border="0" alt="�ݼ�" ></a></td>
                           					<input type="hidden" name="buseo_to" value="<%="�����Һ��ں�ȣ��" %>">
                           				<!-- �۳����� ����ǿ� ���� ���-->
                           				<%}else{ %>
                           					<td> ����Ƿ� <a href="javascript:receive();"><img src="img/btn_sendback.gif" align="absmiddle" border="0" alt="�ݼ�" ></a></td>
                           					<input type="hidden" name="buseo_to" value="<%="�����" %>">
                           				<%} %>
                           			<!-- �亯�� �� ���-->
                            		<%}else{ %>
                            			<!-- �۳����� �ع������� ���� ���-->
                            			<%if(junbuseo.equals("Y")){ %>
                           					<td> <%=buseo %></td>
                           				<!-- �۳����� ����ǿ� ���� ���-->
                           				<%}else{ %>
                           					<td> <%=buseo %></td>
                           				<%} %>
                            		<%} %>
                            	<%} %>

                            <%} %>
                            <input type="hidden" name="buseo_from" value="<%=buseo %>">
                            <%//20080617 ���� ��%>
                          </tr>









                          <tr>
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
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
      <!-- // ������� ���� ��������-->
      <!-- ������� ���� ���ôޱ� ������-->
      <table width="945" border="0" cellspacing="0" cellpadding="0" class="table_outline">
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">�ۼ���</td>
          <td style="padding-left:25;" class="bluesky" width="540"><%=(String)session.getAttribute("name") %></td>
          <td class="table_bg_title" width="110" align="center">�ۼ���</td>
          <td style="padding-left:25;" width="165" class="bluesky"><%=sdf.format(date) %></td>
        </tr>
        <tr>
          <td colspan="4" height="1" bgcolor="ffffff"></td>
        </tr>
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">������</td>
          <td style="padding-left:25;" class="board_bg_contents" colspan="3">
            <textarea name="text1" cols="115" rows="8" wrap="physical"><%=text1 %></textarea>
          </td>
        </tr>
        <tr>
          <td colspan="4" height="1" bgcolor="ffffff"></td>
        </tr>
        <!--
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">ó�����</td>
          <td style="padding-left:25;" class="board_bg_contents" colspan="3">
            <table width="100%" border="0" cellspacing="5" cellpadding="0">
              <tr>
                <td width="80" class="bluesky"> * �ذ�</td>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="150" class="black">
                        <input type="radio" name="result" value="��ġ/����" <%if(result.equals("��ġ/����")) out.print("checked"); %>>
                        ��ġ/����</td>
                      <td>&nbsp;</td>
                      <td class="black" width="150">
                        <input type="radio" name="result" value="�����ȳ�" <%if(result.equals("�����ȳ�")) out.print("checked"); %>>
                        �����ȳ�</td>
                      <td>&nbsp;</td>
                      <td class="black" width="150">
                        <input type="radio" name="result" value="����/����" <%if(result.equals("����/����")) out.print("checked"); %>>
                        ����/����</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="radio" name="result" value="��������" <%if(result.equals("��������")) out.print("checked"); %>>
                        ��������</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="bluesky">* ��ġ�Ҵ�</td>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="150" class="black">
                        <input type="radio" name="result" value="����/������Ҵ�" <%if(result.equals("����/������Ҵ�")) out.print("checked"); %>>
                        ����/������Ҵ�</td>
                      <td>&nbsp;</td>
                      <td width="150" class="black">
                        <input type="radio" name="result" value="������ո�" <%if(result.equals("������ո�")) out.print("checked"); %>>
                        ������ո�</td>
                      <td>&nbsp;</td>
                      <td width="150" class="black">
                        <input type="radio" name="result" value="����" <%if(result.equals("����")) out.print("checked"); %>>
                        ����</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="radio" name="result" value="��ǻ���" <%if(result.equals("��ǻ���")) out.print("checked"); %>>
                        ��ǻ���</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="bluesky">* �ҹ�</td>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="150" class="black">
                        <input type="radio" name="result" value="�͸��ּҹ�" <%if(result.equals("�͸��ּҹ�")) out.print("checked"); %>>
                        �͸��ּҹ�</td>
                      <td>&nbsp;</td>
                      <td width="150" class="black">
                        <input type="radio" name="result" value="��������" <%if(result.equals("��������")) out.print("checked"); %>>
                        ��������</td>
                      <td>&nbsp;</td>
                      <td width="150" class="black">
                        <input type="radio" name="result" value="�Ҽ�/����" <%if(result.equals("�Ҽ�/����")) out.print("checked"); %>>
                        �Ҽ�/����</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="radio" name="result" value="�ҹ�(�ο��ƴ�)" <%if(result.equals("�ҹ�(�ο��ƴ�)")) out.print("checked"); %>>
                        �ҹ�(�ο��ƴ�)</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="bluesky">* ��Ÿ</td>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="150" class="black">
                        <input type="radio" name="result" value="����/����" <%if(result.equals("����/����")) out.print("checked"); %>>
                        ����/����</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        -->
      </table>
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="right">&nbsp;</td>
        </tr>
        <tr>
          <td align="right">
          <%if(finance_buseo.equals(buseo) && !code.equals("öȸ�Ϸ�")){ %>
          	<a href="javascript:goReply(<%=thididx %>);"><img src="img/btn_reply.gif" width="55" height="21" alt="�亯" border="0"></a>
          <%} %>
          </td>
        </tr>
      </table>
      <br>
      <!-- // ������� ���� ���ôޱ� ������-->
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
<input type="hidden" name="tel" value="<%=tel%>">
</form>
<%@ include file="include/bottom.jsp" %>