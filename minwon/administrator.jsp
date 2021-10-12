<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>
<% String pageNum = "7"; %>
<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %>
<%@ include file="include/top_menu01.jsp" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>
<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />

<%
		String KEY = request.getParameter("KEY");	//�˻���
	    if(KEY != null && !KEY.equals("")) {
	    	KEY = StringReplace.sqlFilter(KEY);		//������ ���͸�
	    }
		else{
			KEY="";
		}

		String TableName = " sh_minwon_admin ";
	    String SelectCondition = null;
	    String OrderCondition = null;
		String WhereCondition = null;

		int PAGE = 1;

		if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){
			PAGE = 1;
	    }else{
			PAGE = Integer.parseInt(request.getParameter("PAGE"));
	    }
		String midstr=FrontBoard.OnlyOne("Select Max(sh_no) from sh_minwon_admin");

		SelectCondition = " sh_no, sh_buseo, sh_name, sh_id, sh_pwd, sh_inuser, sh_mobile,";
		SelectCondition += " to_char(sh_indate, 'YYYY-MM-DD') AS sh_indate ";
	    OrderCondition  = " ORDER BY sh_no DESC ";
		WhereCondition = "where 1 = 1 ";

		if (KEY != null && !KEY.equals("")) {
			WhereCondition += " and sh_buseo like '%"+KEY+"%'";

		}
		int StartRecord = 0;
		int EndRecord   = 0;
		int DefaultListRecord = 10;
		int DefaultPageBlock = 10;

		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
//		out.println(TableName+"<br>");
//		out.println(SelectCondition);
//		out.println(TotalRecordCount);
		//out.print("TotalRecordCount : " + TotalRecordCount + "<br><br>");
		///////////////////////////////////////////////////////////////////////////

%>
<!-- �ο���������ڰ��� ���� -->
<head>
<script language="javascript">
<!--
	//���̵��ߺ�üũ

	function CheckID()  {


		var wint = (screen.height - 170) / 2;

		var winl = (screen.width - 340) / 2;

		winprops = 'height=230,width=362,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'

		winurl = 'check_id.jsp?return=sh_id&id='+f.sh_id.value;
		win = window.open(winurl, "idcheck", winprops)

		}

	//��� ���� ���� üũ
	function GoReg() {

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



		if (f.sh_han1.value.length == 0){
				alert("�޴�����ȣ�� �Էµ��� �ʾҽ��ϴ�.");
				f.sh_han1.focus();
				return;
		}else if(f.sh_han2.value.length == 0){
				alert("�޴�����ȣ�� �Էµ��� �ʾҽ��ϴ�.");
				f.sh_han2.focus();
				return;
		}else if(f.sh_han3.value.length == 0){
				alert("�޴�����ȣ�� �Էµ��� �ʾҽ��ϴ�.");
				f.sh_han3.focus();
				return;
		}
		if(!(f.sh_buseo.value == "�����" || f.sh_buseo.value == "�����" || f.sh_buseo.value == "�����Һ��ں�ȣ��" || f.sh_buseo.value == "�ع����ý�(�߾�ȸ)")){

			if(f.sh_admin_minwonall.checked){

				alert("�ο���Ȳ�� ����ǰ� �����Һ��ں�ȣ��, �ع����ý�(�߾�ȸ) �μ��� ����ϽǼ��ֽ��ϴ�.");

					return;

			}

		}

		f.action = "admin_reg.jsp";
		f.submit();

	}

	function goView(sh_no){
		f.sh_no.value=sh_no;
		f.action = "administrator_modify.jsp";
		f.submit();
	}

	function goDel(sh_no){
		f.sh_no.value=sh_no;
		if (confirm("�����Ͻðڽ��ϱ�?")) {
			f.action = "admin_delete_proc.jsp";
			f.submit();
		}
		else {
		alert("��ҵǾ����ϴ�!");
		}
	}
	//�˻�
	function form_check(){

		if (f.KEY.value == null || f.KEY.value == ""){
				alert("�˻�� �Է��ϼ���.");
				f.KEY.focus();
				return;
		}
		f.action = "administrator.jsp";
		f.submit();
	}

//-->
</script>
</head>
<form name="f" method=post action="">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
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
            <span class="result_text">�� <%=TotalRecordCount%>��</span></td>
          <td height="30" align="right"><a href="excel/admin_excel.jsp"><img src="img/btn_excel.gif" width="66" height="21" alt="����" border="0"></a></td>
        </tr>
        <tr>
          <td height="2" class="result_line" colspan="2"></td>
        </tr>
      </table>
      <!-- // �˻���� -->
    </td>
  </tr>
  <!-- ������ ��� -->
  <tr>
    <td style="padding-left:25;"><img src="img/arrow.gif" width="13" height="16" align="absmiddle">
      <span class="txt_title">������ ���</span></td>
  </tr>
  <tr>
    <td style="padding:10 0 10 25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0" class="table_outline">
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">���������</td>
          <td style="padding-left:25;" class="board_bg_contents">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="50" class="bluesky">�μ�</td>
                <td>
                  <select name="sh_buseo" onChange="">
                    <option value="buseo">����</option>
					<option value="�����" >�����</option>
					<option value="�����" >�����</option>
					<option value="ICT������" >ICT������</option>
					<option value="�λ��ѹ���" >�λ��ѹ���</option>
					<option value="���α�����" >���α�����</option>
					<option value="���������" >���������</option>
					<option value="������ȹ��" >������ȹ��</option>
					<option value="��ȹ��" >��ȹ��</option>
					<option value="�뷮������ ����ȭ�������" >�뷮������ ����ȭ�������</option>
					<option value="��ü�޽Ļ����" >��ü�޽Ļ����</option>
					<option value="����ũ��������" >����ũ��������</option>
					<option value="��ī�ݵ�����(�ݵ�)" >��ī�ݵ�����(�ݵ�)</option>
					<option value="��ȣ������" >��ȣ������</option>
					<option value="�������������" >�������������</option>
					<option value="���������" >���������</option>
					<!-- <option value="����������" >����������</option> -->
					<option value="��Ź�������" >��Ź�������</option>
					<option value="�ɻ��" >�ɻ��</option>
					<option value="���������ź���" >���������ź���</option>
					<option value="���Ű�����" >���Ű�����</option>
					<option value="������" >������</option>
					<option value="�۷ι���ȯ�����" >�۷ι���ȯ�����</option>
					<option value="������ȹ��" >������ȹ��</option>
					<option value="�̻�ȸ�繫��" >�̻�ȸ�繫��</option>
					<option value="�ڱݺ�" >�ڱݺ�</option>
					<option value="��������" >��������</option>
					<option value="IT���ߺ�" >IT���ߺ�</option>
					<option value="������ȣ����" >������ȣ����</option>
					<option value="���հ����" >���հ����</option>
					<option value="����ũ������" >����ũ������</option>
					<option value="�ڱݿ���" >�ڱݿ���</option>
					<!-- <option value="�ع�������" >�ع�������</option> -->
					<option value="�ǸŻ����" >�ǸŻ����</option>
					<option value="�ѹ���" >�ѹ���</option>
					<option value="ī������" >ī������</option>
					<!-- <option value="�ؾ����ڱ�������" >�ؾ����ڱ�������</option> -->
					<option value="ȫ����" >ȫ����</option>
					<option value="ȸ��������" >ȸ��������</option>
					<!-- <option value="������������" >������������</option> -->
					<option value="���������" >���������</option>
					<option value="������å��" >������å��</option>
					<option value="��å�����" >��å�����</option>
					<option value="�����Һ��ں�ȣ��" >�����Һ��ں�ȣ��</option>
					<option value="�����а��ߺ�" >�����а��ߺ�</option>
					<!-- <option value="����������" >����������</option> -->
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
                </td>
                <td width="70">&nbsp;</td>
                <td width="60" class="bluesky">����</td>
                <td>
                  <input type="text" class="input01" size="15" name="sh_name" value="">
                </td>
                <td width="30">&nbsp;</td>
                <td width="40" class="bluesky">����</td>
                <td>
                  <select name="sh_gicwe" onChange="">
                    <option value="gicwe">����</option>
                    <option value="����" >����</option>
                    <option value="�븮" >�븮</option>
                    <option value="����" >����</option>
                    <option value="����" >����</option>
                    <option value="����" >����</option>
                    <option value="����/����" >����/����</option>
                    <!-- -->
                  </select>
                </td>
                <td width="30">&nbsp;</td>
                <td width="40" class="bluesky">����</td>
                <td>
                  <select name="sh_gicgub" onChange="">
                    <option value="gicgub">����</option>
                    <option value="�����" >�����</option>
                    <option value="4��" >4��</option>
                    <option value="3��" >3��</option>
                    <option value="2��" >2��</option>
                    <option value="1��" >1��</option>
                    <option value="����" >����</option>
                    <!-- -->
                  </select>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td colspan="2" height="1" bgcolor="ffffff"></td>
        </tr>
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">��������</td>
          <td style="padding-left:25;" class="board_bg_contents">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="50" class="bluesky">���̵�</td>
                <td>
                  <input type="text" class="input01" size="20" name="sh_id">

                </td>

				<td width="10">&nbsp;</td>
                <td width="20"><a href="javascript:CheckID();"><img src="img/mb_bt_check.gif" title="���̵�üũ" border="0" /></a></td>

				<td width="20">&nbsp;</td>
                <td width="60" class="bluesky">�н�����</td>
                <td>
                  <input type="password" class="input01" size="15" name="sh_pwd" value="">
                </td>
				<td width="20">&nbsp;</td>
				<td width="60" class="bluesky">�ڵ���</td>
                <td>
                  <input type="text" class="input01" size="5" name="sh_han1" value="">
				   <span class="sp_txt">-</span>
				  <input type="text" class="input01" size="6" name="sh_han2" value="">
				   <span class="sp_txt">-</span>
				  <input type="text" class="input01" size="6" name="sh_han3" value="">
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td colspan="2" height="1" bgcolor="ffffff"></td>
        </tr>
        <tr>
          <td width="130" height="35" align="center" class="table_bg_title">��������</td>
          <td style="padding-left:25;" class="board_bg_contents">
            <table width="100%" border="0" cellspacing="5" cellpadding="0">
              <tr>
                <td width="100" class="bluesky"> * �ý��� ����</td>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_manager" value="Y">
                        ������ ����</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="checkbox" name="sh_admin_faq" value="Y">
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
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_minwonall" value="Y">
                        �ο�������Ȳ</td>
                      <td>&nbsp;</td>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_buseo" value="Y">
                        �μ��� �ο�����</td>
                      <td>&nbsp;</td>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_result" value="Y">
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
                        <input type="checkbox" name="sh_admin_jebo" value="Y">
                        �����������</td>
                      <td>&nbsp;</td>
                      <td width="150" class="black">
                        <input type="checkbox" name="sh_admin_bujori" value="Y">
                        �����������Ű�</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="checkbox" name="sh_admin_myunsei" value="Y">
                        �鼼���� �������� �Ű�</td>
                      <td>&nbsp;</td>
                      <td class="black">
                        <input type="checkbox" name="sh_admin_corruption" value="Y">
                        �ൿ���� �Ű���㼾��</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
     <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="right" height="10"></td>
        </tr>
        <tr>
          <td align="right"><a href="javascript:GoReg();"><img src="img/btn_upload.gif" width="55" height="21" alt="���" border="0"></td>
        </tr>
      </table>
    </td>
  </tr>
  <!--// ������ ��� -->
  <!-- �μ��� ������ -->
  <tr>
    <td style="padding-left:25;"><img src="img/arrow.gif" width="13" height="16" align="absmiddle">
      <span class="txt_title">�μ��� ������</span></td>
  </tr>
  <tr>
    <td style="padding:10 0 0 25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="17%"/>
			<col width="11%"/>
			<col width="11%"/>
			<col width="11%"/>
			<col width="12%"/>
			<col width="11%"/>
			<col width="11%"/>
			<col width="11%"/>
		</colgroup>
        <tr>
          <td colspan="9" height="2" class="board_topline"></td>
        </tr>
        <tr height="30">
          <td class="board_bg_title" width="45" align="center">��ȣ</td>
          <td class="board_bg_title" width="150" align="center">�μ�</td>
          <td class="board_bg_title" width="100" align="center">������</td>
          <td class="board_bg_title" width="150" align="center">���̵�</td>
          <td class="board_bg_title" width="150" align="center">�н�����</td>
		   <td class="board_bg_title" width="150" align="center">�ڵ���</td>
          <td class="board_bg_title" width="100" align="center">�����</td>
          <td class="board_bg_title" width="150" align="center">�����</td>
          <td class="board_bg_title" width="100" align="center">����</td>
        </tr>
        <tr>
          <td colspan="9" height="1" class="board_line"></td>
        </tr>
	<%
		Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);

		String sh_no = "";
	    String sh_buseo = "";
		String sh_name = "";
		String sh_id = "";
		String sh_pwd = "";
		String sh_inuser = "";
		String sh_indate = "";
		String sh_mobile = "";

		if( ResultVector.size() > 0){
			for (int i=0; i < ResultVector.size();i++){

				Hashtable h = (Hashtable)ResultVector.elementAt(i);

				sh_no = (String)h.get("SH_NO");
				sh_buseo = (String)h.get("SH_BUSEO");
				sh_name = (String)h.get("SH_NAME");
				sh_id = (String)h.get("SH_ID");
				sh_pwd = (String)h.get("SH_PWD");
				sh_pwd = aes.aesDecode(sh_pwd);  
				sh_inuser = (String)h.get("SH_INUSER");
				sh_indate = (String)h.get("SH_INDATE");
				sh_mobile = (String)h.get("SH_MOBILE");

				int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));

	%>
        <tr height="30"  onMouseOver=this.style.backgroundColor='F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'>
          <td align="center"><%=listnum%></td>
          <td align="center"><%=sh_buseo%></td>
          <td align="center"><a href="javascript:goView('<%=sh_no%>')"><%=sh_name%></td>
          <td align="center"><%=sh_id%></td>
          <td align="center"><%=sh_pwd%></td>
		  <td align="center"><%=sh_mobile%></td>
          <td align="center"><%=sh_inuser%></td>
          <td align="center"><%=sh_indate%></td>
          <td align="center"><a href="javascript:goDel('<%=sh_no%>')"><img src="img/btn_delete.gif" width="55" height="21" alt="����" border="0"></td>
        </tr>
		<%	} %>
	<%	} %>
        <tr>
          <td colspan="9" class="board_line2" height="1"></td>
        </tr>
      </table>
	  <table cellpadding="0" cellspacing="0" border="0" class="search">
			<tr>
				<td class="cols01"></td>
			</tr>
			<tr>

				<td class="cols02">
					<b>�μ���ȸ</b>&nbsp;&nbsp;<input type="text" name="KEY" class="inputKey" size="15" value="<%=KEY%>">
					<a href="javascript:form_check();"><input type="image" src="../pub_img/btT01Search.gif" class="btSearch"/></a>
				</td>
				<td class="cols03" align="right" width="700">
					<% if(TotalRecordCount > 0) { %>
						<%=FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock, "administrator.jsp?PAGE=","<img src=img/board_prev.gif width=13 height=13 align=absmiddle border=0>","<img src=img/board_next.gif width=13 height=13 align=absmiddle border=0>")%>
					<% } %>
				</td>
			</tr>
			</table>

    </td>
  </tr>
</table>
<input type="hidden" name="sh_no" value="<%=sh_no%>">
</FORM>
<%@ include file="include/bottom.jsp" %>
