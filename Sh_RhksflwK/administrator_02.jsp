<%@ page import="java.util.*, util.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1" />
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil" />
<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo" />
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />

<%@ include file="include/admin_session.jsp"%>
<%@ include file="include/logincheck.jsp"%>
<%@ include file="include/top_login.jsp"%>
<%@ include file="include/top_menu0102.jsp"%>


<!-- SH_PWD -->

<% String pageNum = "7"; %>

<%
		
		Vector  ResultVector;

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

		SelectCondition = " sh_no, sh_johap, sh_name, sh_id, sh_pwd, sh_inuser, sh_mobile, ";
		SelectCondition += " to_char(sh_indate, 'YYYY-MM-DD') AS sh_indate ";
	    OrderCondition  = " ORDER BY sh_no DESC ";
		WhereCondition = "where 1 = 1 and sh_buseo = 'ȸ������' "; 

		if (KEY != null && !KEY.equals("")) {
			WhereCondition += " and sh_johap like '%"+KEY+"%'"; 

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
<!--//  -->
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

		if(f.sh_johap.value == '') {
			alert("���ո��� ������ �ֽʽÿ�");
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
		if(!(f.sh_buseo.value == "�����" || f.sh_buseo.value == "�����" || f.sh_buseo.value == "�����Һ��ں�ȣ��" || f.sh_buseo.value == "�ع����ý�(�߾�ȸ)" || f.sh_buseo.value == "�ع����ý�(����)")){

			if(f.sh_admin_minwonall.checked){

				alert("�ο���Ȳ�� �����, �����, �����Һ��ں�ȣ��, �ع����ý�(�߾�ȸ), �ع����ý�(����) �μ��� ����ϽǼ��ֽ��ϴ�.");

					return;

			}

		}

		f.action = "admin_reg.jsp";
		f.submit();

	}

	function goView(sh_no){
		f.sh_no.value=sh_no;
		f.action = "administrator_02_modify.jsp";
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


</script>
</head>
<form name="f" method=post action="">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<input type="hidden" name="sh_buseo" value="ȸ������" />
	<div class="list-header">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>�ο�����<br> ����� ����</td>
				<td>�μ��� ����ڸ� ��� �� �����մϴ�.</td>
			</tr>
		</table>
	</div>
	
	<!-- // �ο���������ڰ��� ���� -->
	<br>
	<div class="tbl-wrap">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td style="padding: 0 0 10 10;">
				<!-- �˻���� -->
				<table width="960" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30">
							<img src="img/result.gif" align="absmiddle">
							�˻���� : <span class="result_text">�� <%=TotalRecordCount%>��</span>
						</td>
						<td height="30" align="right">
							<a href="excel/admin_excel.jsp"><img src="img/btn_excel.gif" width="66" height="21" alt="����"border="0"></a>
						</td>
					</tr>
					<tr>
						<td height="2" class="result_line" colspan="2"></td>
					</tr>
				</table> <!-- // �˻���� -->
			</td>
		</tr>
		<!-- ������ ��� -->
		<tr>
			<td style="padding-left: 25;"><img src="img/arrow.gif" width="13" height="16" align="absmiddle"> <span class="txt_title">������ ���</span></td>
		</tr>
		<tr>
			<td style="padding: 10 0 10 25;">
				<table border="0" cellspacing="0" cellpadding="0"
					class="table_outline">
					<tr>
						<td width="130" height="35" align="center" class="table_bg_title">���������</td>
						<td style="padding-left: 25;" class="board_bg_contents">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="50" class="bluesky">���ո�</td>
									<td>
									<select name="sh_johap" onChange="">
										<option value="">����</option>
											<%
												String TableNameBuseo = " sh_johap ";
												String SelectCondition1 = "JOHAP_NAME";
												String WhereCondition1 = "where 1 = 1 ";
												String OrderCondition1 = "";
												
												ResultVector = FrontBoard.list(TableNameBuseo, SelectCondition1, WhereCondition1, OrderCondition1, PAGE, 0, 100);
										
												String sh_johap_nm = "";
										
												if( ResultVector.size() > 0){
													for (int i=0; i < ResultVector.size();i++){
										
														Hashtable h = (Hashtable)ResultVector.elementAt(i);										
														
														sh_johap_nm = (String)h.get("JOHAP_NAME");
										
											%>
											
											
											<option value="<%=sh_johap_nm%>"><%=sh_johap_nm%></option>
												<% } %>
											<% } %>
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
											<option value="����">����</option>
											<option value="�븮">�븮</option>
											<option value="����">����</option>
											<option value="����">����</option>
											<option value="����">����</option>
											<option value="����/����">����/����</option>
											<!-- -->
										</select>
									</td>
									<td width="30">&nbsp;</td>
									<td width="40" class="bluesky">����</td>
									<td>
										<select name="sh_gicgub" onChange="">
											<option value="gicgub">����</option>
											<option value="�����">�����</option>
											<option value="4��">4��</option>
											<option value="3��">3��</option>
											<option value="2��">2��</option>
											<option value="1��">1��</option>
											<option value="����">����</option>
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
						<td style="padding-left: 25;" class="board_bg_contents">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="50" class="bluesky">���̵�</td>
									<td>
										<input type="text" class="input01" size="20" name="sh_id">
									</td>
									<td width="10">&nbsp;</td>
									<td width="20">
										<a href="javascript:CheckID();">
											<img src="img/mb_bt_check.gif" title="���̵�üũ" border="0" />
										</a>
									</td>
									<td width="20">&nbsp;</td>
									<td width="70" class="bluesky">�н�����</td>
									<td>
										<input type="password" class="input01" size="15" name="sh_pwd" value="">
									</td>
									<td width="20">&nbsp;</td>
									<td width="60" class="bluesky">�ڵ���</td>
									<td>
										<input type="text" class="input01" size="5" name="sh_han1" value="" maxlength="4"> <span class="sp_txt">-</span>
										<input type="text" class="input01" size="6" name="sh_han2" value="" maxlength="4"> <span class="sp_txt">-</span>
										<input type="text" class="input01" size="6" name="sh_han3" value="" maxlength="4">
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
						<td style="padding-left: 25;" class="board_bg_contents">
							<table width="100%" border="0" cellspacing="5" cellpadding="0">
								<tr>
									<td width="120" class="bluesky">* �ý��� ����</td>
									<td>
										<table border="0" cellspacing="0" cellpadding="0">
											<colgroup>
												<col width="210px" />
												<col width="210px" />
												<col width="*" />
											</colgroup>
											<tr>
												<td class="black"><input type="checkbox" name="sh_admin_manager" value="Y"> ������ ����</td>
												<td class="black"><input type="checkbox" name="sh_admin_faq" value="Y"> FAQ</td>
												<td></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td width="120" class="bluesky">* ���ڹο� ����</td>
									<td>
										<table border="0" cellspacing="0" cellpadding="0">
											<colgroup>
												<col width="130px" />
												<col width="160px" />
												<col width="130px" />
												<col width="130px" />
												<col width="130px" />
											</colgroup>
											<tr>
												<td class="black"><input type="checkbox" name="sh_admin_minwonall" value="Y"> �ο�������Ȳ</td>
												<td class="black"><input type="checkbox" name="sh_admin_buseo" value="Y"> ȸ������ �ο�����</td>
												<td class="black"><input type="checkbox" name="sh_admin_upright" value="Y"> û�ż����λ�</td>
												<td class="black"><input type="checkbox" name="sh_admin_sms" value="Y">�ο���� SMS ����</td>								
												<td class="black"><input type="checkbox" name="sh_admin_result" value="Y"> �ο�ó����� ����</td>												
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td width="120" class="bluesky">* ��Ÿ ����</td>
									<td>
										<table border="0" cellspacing="0" cellpadding="0">
											<colgroup>
												<col width="210px" />
												<col width="210px" />
												<col width="*" />
											</colgroup>
											<tr>
												<td class="black"><input type="checkbox" name="sh_admin_jebo" value="Y"> �����������</td>
												<td class="black"><input type="checkbox" name="sh_admin_bujori" value="Y"> �����������Ű�</td>
												<td class="black"><input type="checkbox" name="sh_admin_myunsei" value="Y"> �鼼���� �������� �Ű�</td>
											</tr>
											<tr>
												<td class="black"><input type="checkbox" name="sh_admin_corruption" value="Y"> �ൿ���� �Ű���㼾��</td>
												<td class="black"><input type="checkbox" name="sh_admin_favors" value="Y"> ûŹ�Ű���</td>
												<td></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>

				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="right" height="10"></td>
					</tr>
					<tr>
						<td align="right"><a href="javascript:GoReg();">
							<img src="img/btn_upload.gif" width="55" height="21" alt="���" border="0">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<!--// ������ ��� -->
		<!-- �μ��� ������ -->
		<tr>
			<td style="padding-left: 25;">
				<img src="img/arrow.gif" width="13" height="16" align="absmiddle">
				<span class="txt_title">�μ��� ������</span>
			</td>
		</tr>
		<tr>
			<td >
				<table border="0" cellspacing="0" cellpadding="0" class="tbl-list">
					<tr>
						<td class="board_bg_title" align="center">��ȣ</td>
						<td class="board_bg_title"  align="center">���ո�</td>
						<td class="board_bg_title"  align="center">������</td>
						<td class="board_bg_title"  align="center">���̵�</td>
						<td class="board_bg_title"  align="center">�н�����</td>
						<td class="board_bg_title"  align="center">�ڵ���</td>
						<td class="board_bg_title"  align="center">�����</td>
						<td class="board_bg_title"  align="center">�����</td>
						<td class="board_bg_title"  align="center">����</td>
					</tr>
					<%
					
						System.out.println("����Ʈ=========");
						System.out.println("TableName----"+TableName);
						System.out.println("SelectCondition----"+SelectCondition);
						System.out.println("WhereCondition----"+WhereCondition);
						System.out.println("OrderCondition----"+OrderCondition);
						System.out.println("PAGE----"+PAGE);
						System.out.println("DefaultListRecord----"+DefaultListRecord);
					
						ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);
				
						String sh_no = "";
					    String sh_johap = "";
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
								sh_johap = (String)h.get("SH_JOHAP");
								sh_name = (String)h.get("SH_NAME");
								sh_id = (String)h.get("SH_ID");
								sh_pwd = (String)h.get("SH_PWD");
								sh_pwd = aes.aesDecode(sh_pwd);
								sh_inuser = (String)h.get("SH_INUSER");
								sh_indate = (String)h.get("SH_INDATE");
								sh_mobile = (String)h.get("SH_MOBILE");
								
								int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));
				
					%>
					<tr>
						<td align="center"><%=listnum%></td>
						<td align="center"><%=sh_johap%></td>
						<td align="center"><a href="javascript:goView('<%=sh_no%>')"><%=sh_name%></td>
						<td align="center"><%=sh_id%></td>
						<td align="center"><%=sh_pwd%></td>
						<td align="center"><%=sh_mobile%></td>
						<td align="center"><%=sh_inuser%></td>
						<td align="center"><%=sh_indate%></td>
						<td align="center"><a href="javascript:goDel('<%=sh_no%>')">
							<img src="img/btn_delete.gif" width="55" height="21" alt="����" border="0">
						</td>
					</tr>
					<%	} %>
					<%	} %>
				</table>
				<br>
				<table cellpadding="0" cellspacing="0" border="0" class="search">
					<tr>

						<td class="cols02"><b>ȸ������ ��ȸ</b>&nbsp;&nbsp;<input type="text"
							name="KEY" class="inputKey" size="15" value="<%=KEY%>">
							<a href="javascript:form_check();">
								<input type="image" src="../pub_img/btT01Search.gif" class="btSearch" />
							</a>
						</td>
						<td class="cols03" align="right" width="700">
							<% if(TotalRecordCount > 0) { %> <%=FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock, "administrator.jsp?PAGE=","<img src=img/board_prev.gif width=13 height=13 align=absmiddle border=0>","<img src=img/board_next.gif width=13 height=13 align=absmiddle border=0>")%>
							<% } %>
						</td>
					</tr>
				</table>

			</td>
		</tr>
	</table>
	</div>
	<input type="hidden" name="sh_no" value="<%=sh_no%>">
</FORM>
<%@ include file="include/bottom.jsp"%>
