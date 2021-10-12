<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>

<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />
<%
	
	String no = request.getParameter("sh_no");
	if(no == null) no="0";
	int sh_no = Integer.parseInt(no);

	String sh_name = "";
	String sh_id = "";
	String sh_pwd = "";
	String sh_mobile = "";
	String sh_inuser = "";
	String sh_indate = "";
	String sh_buseo = "";
	String sh_gicwe = "";
	String sh_gicgub = "";

	String sh_admin_manager ="";

	String sh_admin_faq ="";

	String sh_admin_minwonall="";

	String sh_admin_buseo="";

	String sh_admin_result="";

	String sh_admin_jebo="";

	String sh_admin_bujori="";

	String sh_admin_myunsei="";

	String sh_admin_corruption="";
	
	String sh_admin_favors="";
	
	String sh_admin_upright = "";
	
	String sh_johap = "";
	
	String sh_admin_sms = "";

	String sh_tel_1 = "";
	String sh_tel_2 = "";
	String sh_tel_3 = "";
	
	
	
	
	try {

		DataSource ds = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		PreparedStatement pstmt=null;


		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();

		String sql = "";

		sql = " select sh_name, sh_id, sh_pwd,sh_mobile,sh_admin_manager,sh_admin_faq,sh_admin_minwonall,sh_admin_buseo,";

		sql +=" sh_admin_result, sh_admin_upright, sh_admin_jebo, sh_admin_bujori, sh_admin_myunsei, sh_admin_corruption, sh_admin_favors, sh_buseo, sh_gicwe, sh_gicgub, sh_johap, sh_admin_sms";

		sql +=" from sh_minwon_admin " ;

		sql += " where sh_no = '"+sh_no+"'";

		stmt=conn.createStatement();
		rs = stmt.executeQuery(sql);

		StringTokenizer token = new StringTokenizer(sh_mobile," ");
		
		
		if(rs.next()){
			sh_name = rs.getString("SH_NAME");
			if(sh_name == null) sh_name="";
			sh_id = rs.getString("SH_ID");
			if(sh_id == null) sh_id="";
			sh_pwd = rs.getString("SH_PWD");
			if(sh_pwd == null) { 
				sh_pwd = "";
			} else {
				sh_pwd= aes.aesDecode(sh_pwd);
			}

			sh_mobile = rs.getString("sh_mobile");
			if(sh_mobile == null) sh_mobile="";
			if (sh_mobile.indexOf("--",0) == -1 ){
			token = new StringTokenizer(sh_mobile,"-");
				while(token.hasMoreTokens()){
					sh_tel_1 = token.nextToken();
					sh_tel_2 = token.nextToken();
			   		sh_tel_3 = token.nextToken();
	    		}
			}
			
			sh_admin_manager = rs.getString("sh_admin_manager");
			
			if(sh_admin_manager == null) sh_admin_manager="";
			
			sh_admin_faq = rs.getString("sh_admin_faq");

			if(sh_admin_faq == null) sh_admin_faq="";

			sh_admin_minwonall = rs.getString("sh_admin_minwonall");

			if(sh_admin_minwonall == null) sh_admin_minwonall="";

			sh_admin_buseo = rs.getString("sh_admin_buseo");

			if(sh_admin_buseo == null) sh_admin_buseo="";

			sh_admin_result = rs.getString("sh_admin_result");

			if(sh_admin_result == null) sh_admin_result="";
			
			sh_admin_upright = rs.getString("sh_admin_upright");
			
			if(sh_admin_upright == null) sh_admin_upright="";
			
			sh_admin_jebo = rs.getString("sh_admin_jebo");

			if(sh_admin_jebo == null) sh_admin_jebo="";

			sh_admin_bujori = rs.getString("sh_admin_bujori");

			if(sh_admin_bujori == null) sh_admin_bujori="";

			sh_admin_myunsei = rs.getString("sh_admin_myunsei");

			if(sh_admin_myunsei == null) sh_admin_myunsei="";

			sh_admin_corruption = rs.getString("sh_admin_corruption");

			if(sh_admin_corruption == null) sh_admin_corruption="";
			
			sh_admin_favors = rs.getString("sh_admin_favors");

			if(sh_admin_favors == null) sh_admin_favors="";			
			

			sh_buseo = rs.getString("sh_buseo");

			if(sh_buseo == null) sh_buseo="";

			sh_gicwe = rs.getString("sh_gicwe");

			if(sh_gicwe == null) sh_gicwe="";

			sh_gicgub = rs.getString("sh_gicgub");

			if(sh_gicgub == null) sh_gicgub="";
			
			sh_johap = rs.getString("sh_johap");

			if(sh_johap == null) sh_johap="";
			
			sh_admin_sms = rs.getString("sh_admin_sms");

			if(sh_admin_sms == null) sh_admin_sms="";
			
			
		}

		rs.close();
		conn.close();

	}
	catch(Exception e){
		out.println(e.toString());
	}
%>

<%@ include file="include/top_login.jsp" %>
<%@ include file="include/top_menu0102.jsp" %>
<!-- �ο���������ڰ��� ���� -->
<head>
<script language="javascript">
	$(document).ready(function() { 
		alert("�ε� �Ϸ�"); 
		//selectBuseo
	});
<!--
	//��� ���� ���� üũ
	function GoReg(sh_no){
		//goCk();
		if(f.sh_johap.value == '') {
			alert("�μ��� ������ �ֽʽÿ�");
			f.sh_johap.focus();
			return;
		}
		if (f.sh_name.value.length == 0) {alert("������ �Է��� �ֽʽÿ�"); f.sh_name.focus(); return;}
		if(f.sh_gicwe.value == 'gicwe') {
			alert("������ ������ �ֽʽÿ�");
			f.sh_gicwe.focus();
			return;
		}
		if(f.sh_gicgub.value == 'gicgub') {
			alert("���޸� ������ �ֽʽÿ�");
			f.sh_gicgub.focus();
			return;
		}
		if (f.sh_id.value.length == 0) {alert("���̵� �Է��� �ֽʽÿ�"); f.sh_id.focus(); return;}
		if (f.sh_pwd.value.length == 0) {alert("��й�ȣ�� �Է��� �ֽʽÿ�"); f.sh_pwd.focus(); return;}
		f.sh_no.value=sh_no;
		f.action = "admin_update_proc.jsp";
		f.submit();
	}

	function goCk() {

		if(f.sh_buseo.value == 'buseo') {
			alert("�μ��� ������ �ֽʽÿ�");
			f.sh_buseo.focus();
			return;
		}

		if (f.sh_name.value.length == 0) {alert("������ �Է��� �ֽʽÿ�"); f.sh_name.focus(); return;}

		if(f.sh_gicwe.value == 'gicwe') {
			alert("������ ������ �ֽʽÿ�");
			f.sh_gicwe.focus();
			return;
		}

		if(f.sh_gicgub.value == 'gicgub') {
			alert("���޸� ������ �ֽʽÿ�");
			f.sh_gicgub.focus();
			return;
		}

		if (f.sh_id.value.length == 0) {alert("���̵� �Է��� �ֽʽÿ�"); f.sh_id.focus(); return;}

		if (f.sh_pwd.value.length == 0) {alert("��й�ȣ�� �Է��� �ֽʽÿ�"); f.sh_pwd.focus(); return;}
	}
//-->

</script>
<form method=post name="f" action="">
<input type="hidden" name="sh_no" value="<%=sh_no%>">
<input type="hidden" name="sh_buseo" value="<%=sh_buseo%>">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="95" bgcolor="f4f4f4"  style="padding-left:25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0" background="img/title_bg.gif">
        <tr>
          <td width="135">
            <table width="135" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="70" align="center" class="admin_subject">�ο�����<br>
                  ����� ����</td>
              </tr>
            </table>
          </td>
          <td width="5"></td>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="60" class="adminsub_subject" style="padding-left:25;">�μ���
                  ����ڸ� ��� �� �����մϴ�.</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<!-- // �ο���������ڰ��� ���� -->
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td style="padding:0 0 10 10 ;">
      <!-- �˻���� -->
      <table width="960" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30"><img src="img/result.gif" align="absmiddle"> �˻���� :
            <span class="result_text">�� 5��</span></td>
        </tr>
        <tr>
          <td height="2" class="result_line" colspan="2"></td>
        </tr>
      </table>
      <!-- // �˻���� -->
    </td>
  </tr>
  <!-- ������ ���� -->
  <tr>
    <td style="padding-left:25;"><img src="img/arrow.gif" width="13" height="16" align="absmiddle">
      <span class="txt_title">������ ����</span></td>
  </tr>
  <tr>
    <td style="padding:10 0 10 25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="2" colspan="4" class="board_topline"></td>
        </tr>
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">���������</td>
          <td style="padding-left:25;">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="50" class="bluesky">���ո�</td>
                <td width="140">
                  
                  <select name="sh_johap" onChange="">
                    <option value="">����</option>
						<%	
							Vector  ResultVector;
						
							String TableNameBuseo = " sh_johap ";
							String SelectCondition1 = "JOHAP_NAME";
							String WhereCondition1 = "where 1 = 1 ";
							String OrderCondition1 = "";
							
							ResultVector = FrontBoard.list(TableNameBuseo, SelectCondition1, WhereCondition1, OrderCondition1, 1, 0, 100);
												
						    String sh_johap_nm = "";
					
							if( ResultVector.size() > 0){
								for (int i=0; i < ResultVector.size();i++){
					
									Hashtable h = (Hashtable)ResultVector.elementAt(i);
														
									sh_johap_nm = (String)h.get("JOHAP_NAME");
									
						%>
						
						<%if(sh_johap.equals(sh_johap_nm)){ %>
							<option value="<%=sh_johap_nm%>" selected id="selectBuseo">
						<% } else { %>
							<option value="<%=sh_johap_nm%>" id="selectBuseo">
						<% } %>
							<%=sh_johap_nm%>
						</option>
						
							<% } %>
						<% } %>
                     
				  </select>
                </td>
                
                <td width="20">&nbsp;</td>
                <td width="60" class="bluesky">����</td>
                <td width="100">
                  <input type="text" class="input01" size="15" name="sh_name" value="<%=sh_name%>">
                </td>
                <td width="20">&nbsp;</td>
                <td width="80" class="bluesky">����</td>
                <td width="130">
                  <select name="sh_gicwe" onChange="">
                    <option value="gicwe">����</option>
                    <option value="����" <%if(sh_gicwe.equals("����")) { %>selected<% } %>>����</option>
                    <option value="�븮" <%if(sh_gicwe.equals("�븮")) { %>selected<% } %>>�븮</option>
                    <option value="����" <%if(sh_gicwe.equals("����")) { %>selected<% } %>>����</option>
                    <option value="����" <%if(sh_gicwe.equals("����")) { %>selected<% } %>>����</option>
                    <option value="����" <%if(sh_gicwe.equals("����")) { %>selected<% } %>>����</option>
                    <option value="����/����" <%if(sh_gicwe.equals("����/����")) { %>selected<% } %>>����/����</option>
                    <!-- -->
                  </select>
                </td>
                <td width="20">&nbsp;</td>
                <td width="40" class="bluesky">����</td>
                <td width="100">
                  <select name="sh_gicgub" onChange="">
                    <option value="gicgub">����</option>
                    <option value="�����" <%if(sh_gicgub.equals("�����")) { %>selected<% } %>>�����</option>
                    <option value="4��" <%if(sh_gicgub.equals("4��")) { %>selected<% } %>>4��</option>
                    <option value="3��" <%if(sh_gicgub.equals("3��")) { %>selected<% } %>>3��</option>
                    <option value="2��" <%if(sh_gicgub.equals("2��")) { %>selected<% } %>>2��</option>
                    <option value="1��" <%if(sh_gicgub.equals("1��")) { %>selected<% } %>>1��</option>
                    <option value="����" <%if(sh_gicgub.equals("����")) { %>selected<% } %>>����</option>
                    <!-- -->
                  </select>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="1" colspan="4" class="board_line"></td>
        </tr>
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">��������</td>
          <td style="padding-left:25;">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="50" class="bluesky">���̵�</td>
                <td width="140">
                  <input type="text" class="input01" size="15" name="sh_id" value="<%=sh_id%>" readonly>
                </td>
                <td width="20">&nbsp;</td>
                <td width="60" class="bluesky">�н�����</td>
                <td width="100">
                  <input type="password" class="input01" size="12" name="sh_pwd" maxlength="20" value="<%=sh_pwd%>">
                </td>
				<td width="60" class="bluesky">�ڵ���</td>
                <td>
                  <input type="text" class="input01" size="5" name="sh_han1" value="<%=sh_tel_1%>">
				   <span class="sp_txt">-</span>
				  <input type="text" class="input01" size="6" name="sh_han2" value="<%=sh_tel_2%>">
				   <span class="sp_txt">-</span>
				  <input type="text" class="input01" size="6" name="sh_han3" value="<%=sh_tel_3%>">
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="1" colspan="4" class="board_line"></td>
        </tr>
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">��������</td>
          <td style="padding-left:25;">
            <table width="100%" border="0" cellspacing="5" cellpadding="0">
              <tr>
                <td width="100" class="bluesky"> * �ý��� ����</td>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_manager" value="Y"<%if(sh_admin_manager.equals("Y")){ %>checked<% } %>>
                        ������ ����</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="checkbox" name="sh_admin_faq" value="Y"<%if(sh_admin_faq.equals("Y")){ %>checked<% } %>>
                        FAQ</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="bluesky">* ���ڹο� ����</td>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="130" class="black">
                        <input type="checkbox" name="sh_admin_minwonall" value="Y"<%if(sh_admin_minwonall.equals("Y")){ %>checked<% } %>>
                        �ο�������Ȳ</td>
                      <td>&nbsp;</td>
                      <td width="160" class="black">
                        <input type="checkbox" name="sh_admin_buseo" value="Y"<%if(sh_admin_buseo.equals("Y")){ %>checked<% } %>>
                         ȸ������ �ο�����</td>
                      <td>&nbsp;</td>
                       <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_upright" value="Y"<%if(sh_admin_upright.equals("Y")){ %>checked<% } %>>
                        û�ż����λ�</td>                      
                        <td width="165" class="black">
                        <input type="checkbox" name="sh_admin_sms" value="Y"<%if(sh_admin_sms.equals("Y")){ %>checked<% } %>>
                     �ο���� SMS ����</td>
                     	 <td width="160" class="black">
                        <input type="checkbox" name="sh_admin_result" value="Y"<%if(sh_admin_result.equals("Y")){ %>checked<% } %>>
                        �ο�ó����� ����</td>
                     </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="bluesky">* ��Ÿ ����</td>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_jebo" value="Y"<%if(sh_admin_jebo.equals("Y")){ %>checked<% } %>>
                        �����������</td>
                      <td>&nbsp;</td>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_bujori" value="Y"<%if(sh_admin_bujori.equals("Y")){ %>checked<% } %>>
                        �����������Ű�</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="checkbox" name="sh_admin_myunsei" value="Y"<%if(sh_admin_myunsei.equals("Y")){ %>checked<% } %>>
                        �鼼���� �������� �Ű�</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="checkbox" name="sh_admin_corruption" value="Y"<%if(sh_admin_corruption.equals("Y")){ %>checked<% } %>>
                         �ൿ���� �Ű�����㼾��</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="checkbox" name="sh_admin_favors" value="Y"<%if(sh_admin_favors.equals("Y")){ %>checked<% } %>>
                         ûŹ�Ű�����</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="1" colspan="4" class="board_line"></td>
        </tr>
      </table>
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="right" height="10" colspan="3"></td>
        </tr>
        <tr>
          <td><a href="administrator_02.jsp"><img src="img/btn_list.gif" width="55" height="21" alt="���" border="0"></a></td>
          <td align="right"><a href="javascript:GoReg('<%=sh_no%>');"><img src="img/btn_adjust.gif" width="55" height="21" alt="����" border="0">
            <a href="administrator_02.jsp"><img src="img/btn_cancle.gif" width="55" height="21" border="0" alt="���"></td>
        </tr>
      </table>
      <br>
    </td>
  </tr>
  <!--// ������ ����  -->
</table>
</form>
<%@ include file="include/bottom.jsp" %>