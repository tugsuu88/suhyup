<%@ page import="java.util.*, util.*,java.text.SimpleDateFormat,javax.sql.*, javax.naming.*,java.sql.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	response.setContentType("text/html; charset=euc-kr");
%>

<%@ include file="include/admin_session.jsp"%>
<%@ include file="include/logincheck.jsp"%>
<%@ include file="include/top_login.jsp"%>
<%@ include file="include/top_menu0202.jsp"%>
<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1" />
<%
	String mid = Converter.nullchk(request.getParameter("mid"));
	String PAGE = Converter.nullchk(request.getParameter("PAGE"));
	String finance_buseo = (String) session.getAttribute("buseo");
	
	int thididx = Integer.parseInt(mid);
	String TableName = " sh_minwon ";
	String SelectCondition = " minwon_gubun,category,subject,name,buse_name,content,answer,result,status,junbuseo,reply_type,fname,sh_file_name,mobile,bupin,yongup,birthdate,";
	SelectCondition += "to_char(creation_date, 'YYYY-MM-DD  AM HH24:MI:SS') AS creation_date, ";
	SelectCondition += "to_char(answer_date, 'YYYY-MM-DD  AM HH24:MI:SS') AS answer_date, to_char(abandon_date, 'YYYY-MM-DD  AM HH24:MI:SS') AS abandon_date ";
	String WhereCondition = " where mid=" + thididx;
	
	String OrderCondition = "";
	//int TotalRecordCount = FrontBoard.TotalCount(TableName2, WhereCondition2);
	//out.println("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br><br>");
	Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 0, 0);
	String minwon_gubun = "";
	String category = "";
	String subject = "";
	String name = "";
	
	String buse_name = "";
 	String johap_name = "";

	String content = "";
	String answer = "";
	String result = "";
	String creation_date = "";
	String answer_date = "";
	String abandon_date = "";
	String status = "";
	String junbuseo = "";

	String reply_type = "";
	String replyTypeNm = "";

	String fname = "";
	/* 20180629 ������ �亯�� ÷������ �÷� */
	String sh_file_name = "";
	String mobile = "";

	String bupin = "";
	// 	String bupinNm = "";

	String yongup = "";

	String birthdate = "";
	if (ResultVector.size() > 0) {
		for (int i = 0; i < ResultVector.size(); i++) {
			Hashtable h = (Hashtable) ResultVector.elementAt(i);
			minwon_gubun = (String) h.get("MINWON_GUBUN");
			status = (String) h.get("STATUS");
			category = (String) h.get("CATEGORY");
			subject = (String) h.get("SUBJECT");
			name = (String) h.get("NAME");
			buse_name = (String) h.get("BUSE_NAME");
			content = (String) h.get("CONTENT");
			mobile = (String) h.get("MOBILE");
			
			bupin = (String) h.get("BUPIN");
// 			session.setAttribute("buseName", ("1".equals((String) h.get("BUPIN")) ? "�����߾�ȸ-ȸ������-��ȸ��" : "��������"));
// 			System.out.println("bupin_02_view ::: " + bupin);
			
			yongup = (String) h.get("YONGUP");
			birthdate = (String) h.get("BIRTHDATE");

			StringTokenizer stk = new StringTokenizer(content, "\r\n");
			content = "";
			while (stk.hasMoreElements()) {
				content += stk.nextToken();
				content += "<br>";
			}
			
			answer = (String) h.get("ANSWER");
			result = (String) h.get("RESULT");
			creation_date = (String) h.get("CREATION_DATE");
			answer_date = (String) h.get("ANSWER_DATE");
			abandon_date = (String) h.get("ABANDON_DATE");
			junbuseo = (String) h.get("JUNBUSEO");

			reply_type = (String) h.get("REPLY_TYPE");
			if ("1".equals(reply_type)) {
				replyTypeNm = "Ȩ������";
			} else if ("2".equals(reply_type)) {
				replyTypeNm = "�̸���";
			} else if ("3".equals(reply_type)) {
				replyTypeNm = "�޴���";
			}

			fname = (String) h.get("FNAME");
			/* 20180314 ������ �亯�� ÷������ �÷� */
			sh_file_name = (String) h.get("SH_FILE_NAME");
		}
	}
	if (answer == null)
		answer = "";
	if (result == null)
		result = "";

	if (bupin == null)
		bupin = "";

	if (yongup == null)
		yongup = "";

	if (birthdate == null)
		birthdate = "";

	TableName = " sh_minwon_history ";
	SelectCondition = " sh_no,sh_minwon_no,sh_buseo_from,sh_buseo_to,sh_status,";
	SelectCondition += "to_char(sh_indate, 'YYYY-MM-DD  AM HH24:MI:SS') AS sh_indate ";
	WhereCondition = " where sh_minwon_no=" + thididx;
	OrderCondition = " order by sh_no asc";
	java.util.Date date = new java.util.Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	//�д� ����� ����� �Ҽ��� ����,�ٸ� �μ��� ��� ó����
	//�Ѱ����ڰ� �ƴҰ��, �ڵ尡 �亯�Ϸ�,��ø,�ݼ��� �ƴҰ��,�亯�� �ȴ� ���
	if (!finance_buseo.equals("all") && answer.equals("") && status.equals("��û")) {
		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
			conn = ds.getConnection();
			String sql = "";
			if (finance_buseo.equals("�����") || finance_buseo.equals("�����")) {
				sql = "update sh_minwon set status='����' where mid=?";
			} else {
				sql = "update sh_minwon set status='ó����' where mid=?";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, thididx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("[ERROR] �������� Ȯ���ʿ�");
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null)
				conn.close();
		}
	}
	
	ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 1);
// 	System.out.println("size : " + ResultVector.size());
	if(ResultVector.size() > 0){
		for (int i = 0; i < ResultVector.size(); i++) {
			Hashtable h = (Hashtable) ResultVector.elementAt(i);
			if(i == 0){
				session.setAttribute("shBuseoFrom", (String) h.get("SH_BUSEO_FROM"));
				session.setAttribute("buseName", ("�����".equals((String) h.get("SH_BUSEO_FROM")) ? "�����߾�ȸ-ȸ������-��ȸ��" : "��������"));
			}
		}
	}else{
	 	session.setAttribute("buseName", ("1".equals(bupin) ? "�����߾�ȸ-ȸ������-��ȸ��" : "��������"));
	}
	
%>
<!--/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************/-->
<!-- <SCRIPT SRC="http://www.suhyup.co.kr/djemals/js/ax_wdigm/default.js"></SCRIPT> -->
<!--/********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/-->
<script language="javascript">
	function goReply(mid) {
		var form = document.createElement("form");

		var mText = document.pbform.answer.value;
		
		if (!pbform.answer.value) {
			alert("������ ����� �ּ���");
			pbform.answer.focus();
			return;
		}
		if (pbform.answer.value.length >= 4001) {
			alert("���ڼ��� �ʰ��Ͽ����ϴ�. 4000���̳��� �ۼ��Ͽ��ּ���.");
			pbform.answer.focus();
			return;
		}
		var istrue = false;
		for (i = 0; i < pbform.min_gubun.length; i++) {
			if (pbform.min_gubun[i].checked) {
				istrue = true;
				break;
			}
		}
		if (!istrue) {
			alert("�ο��з��� �������ּž� �մϴ�");
			return;
		}
		var istrue = false;
		for (i = 0; i < pbform.result.length; i++) {
			if (pbform.result[i].checked) {
				istrue = true;
				break;
			}
		}
		if (!istrue) {
			alert("ó������� �������ּž� �մϴ�");
			return;
		}
		
		var isstr = confirm("�亯�� �Ͻðڽ��ϱ�?");
		if (isstr) {
			/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************
				try{
					if(UsingRemote == true){
						if(!beScan('',mText,'')){
							return;
						}
					}
				}catch (e){
					var objRtn = objAX.beScanner(policy, '','', this.location, mText, '');
						if(objRtn == 0){
							return;
						}else{
							return;
						}
				}
			 ********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/
			 pbform.action = "madmin_02_view_ok.jsp";
			 pbform.encoding="multipart/form-data";
			 pbform.submit();
		}
	}
	function send() {		
		if (!pbform.buseo.value) {
			alert("��ø�� �μ��� �������ּ���");
			pbform.buseo.focus();
			return;
		}
		if (confirm("��ø�Ͻðڽ��ϱ�?")) {
			pbform.action = "madmin_02_send_ok.jsp";
			pbform.submit();
		}
	}
	function receive() {
		if (confirm("�ݼ��Ͻðڽ��ϱ�?")) {
			pbform.action = "madmin_02_receive_ok.jsp";
			pbform.submit();
		}
	}
	function DownloadPopup(mid) {
		pbform.mid.value = mid;
		var wint = (screen.height - 245) / 2;
		var winl = (screen.width - 300) / 2;
		winprops = 'height=245,width=300,top=' + wint + ',left=' + winl
				+ ',status=no,scrollbars=no,resize=no'
		winurl = 'include/file_popup1.jsp?mid=' + mid;
		win = window.open(winurl, "file_popup1", winprops)
	}
</script>
<!-- ������� ���� ���� -->
<form method="post" name="pbform" action="" style="margin: 0px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="95" bgcolor="f4f4f4" style="padding-left: 25;">
				<table width="945" border="0" cellspacing="0" cellpadding="0"
					background="img/title_bg.gif">
					<tr>
						<td width="135">
							<table width="135" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="70" align="center" class="admin_subject">�μ����ο�������Ȳ</td>
								</tr>
							</table>
						</td>
						<td width="5"></td>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="60" class="adminsub_subject"
										style="padding-left: 25;">�μ��� �ο�������Ȳ�Դϴ�</td>
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
			<td style="padding: 0 0 10 10;">
				<!-- �˻���� -->
				<table width="965" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30"><img src="img/result.gif" align="absmiddle">
							�ο����� <span class="result_text">�󼼺���</span></td>
						<td height="30" align="right" width="60"><a href="#"><img
								src="img/btn_print.gif" width="55" height="21"
								onClick="MM_openBrWindow('minwon_03_print.jsp?thididx=<%=thididx%>&bupin=<%=bupin%>&yongup=<%=yongup%>','','width=638,height=630')"
								border="0" alt="���"></a></td>
						<td height="30" align="right" width="60"><a
							href="madmin_02.jsp?PAGE=<%=PAGE%>"><img
								src="img/btn_list.gif" width="55" height="21" border="0"
								alt="���"></a></td>
					</tr>
					<tr>
						<td height="2" class="result_line" colspan="4"></td>
					</tr>
				</table> <!-- // �˻���� -->
			</td>
		</tr>
		<!-- ������� ���� ��������-->
		<tr>
			<td style="padding: 10 0 0 25;">
				<table width="945" border="0" cellspacing="0" cellpadding="0"
					class="table_outline">
					<tr>
						<td style="padding: 5 5 5 5;">
							<table cellpadding="0" cellspacing="0" border="0">
								<tr height="30" bgcolor="a8cae5">
									<td colspan="3">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td style="padding-left: 10;">��ȣ : <%=mid%></td>
												<td align="right" style="padding-right: 10;">ó������ : <%=status%></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td height="5"></td>
								</tr>
								<tr height="30">
									<td align="center" class="board_bg_title" valign="top"
										width="650">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="read_outline">
											<tr>
												<td align="center" height="30" class="table_bg_title"><%=subject%></td>
											</tr>
											<tr>
												<td style="padding: 20 20 20 20;">�� ���α��� : <%=(String) session.getAttribute("buseName")%><br />
													�� ��󿵾��� : <%=yongup%><br /> <br /> <%=content%>
												</td>
											</tr>
										</table>
									</td>
									<td align="center" valign="top" width="5"></td>
									<td class="board_bg_title" width="295" valign="top"
										align="right">
										<!-- ������� �������� -->
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="read_outline" height="100%">
											<tr>
												<td height="30" style="padding-left: 10;"
													class="table_bg_title">�ο�����	����
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													÷������
													<%
														if (fname == null || fname.equals("")) {
													%>
													<%
 														} else {
 													%> <a href="javascript:DownloadPopup('<%=mid%>');">
	 														<img src="img/file_icon.gif" border="0" align="absmiddle"> <%=fname %>
	 													</a>
													<%
														}
													%>
												</td>
											</tr>
											<tr>
												<td valign="top">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<colgroup>
															<col width="90px;" />
															<col width="*"/>
														</colgroup>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">�о�</td>
															<td><%=category%></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">��û��</td>
															<td><%=creation_date%></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">�ο���</td>
															<td><%=name%> <a href="#"
																onClick="MM_openBrWindow('minwon_03_popup.jsp?thididx=<%=thididx%>&birthdate=<%=birthdate%>','','width=500,height=290')">[<u>������
																		����</u>]
															</a></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">ȸ�Ź��</td>
															<td><%=replyTypeNm%></td>
														</tr>
														<%
															if ("öȸ�Ϸ�".equals(status)) {
														%>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">öȸ����</td>
															<td><%=abandon_date%></td>
														</tr>
														<%
															}
														%>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">�Ұ��μ�</td>
															<!-- �� �����߿� �μ������� �����,�ع������,��Ÿ �� ������ ����-->
															<!-- �۳����� ������� ��� , ����� ���Ѹ��� ���� �ִ°�-->
															<%
																 if (buse_name.equals("�����") || buse_name.equals("�����")) {
															%>
															<td>
																<!-- �۳����� ������̸鼭 �α����� ����ڰ� ������� ���,�亯������ ���� ��� ��ø ���-->
																<%
																	if ((finance_buseo.equals("�����") || finance_buseo.equals("�����")) && answer.equals("") && !status.equals("öȸ�Ϸ�")) {
																%> <select name="buseo">
																	<option value="">����</option>
																	<option value="IT���ߺ�">IT���ߺ�</option>
																	<option value="������ȣ����">������ȣ����</option>
																	<!-- <option value="����������">����������</option> -->
																	<option value="�����">�����</option>
																	<option value="�����">�����</option><!-- 20170330 �μ� �ű��߰� -->
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
																	<!-- <option value="������������">������������</option> -->
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
																	<option value="��å�����">��å�����</option>
																	<option value="���հ����">���հ����</option>
																	<option value="���α�����">���α�����</option>
<!-- 																	<option value="�ع����ý�">�ع����ý�</option> --><!-- �ع����ý��� ûŹ���� �Խñ۸� ���� ����!? -->
																	<!-- <option value="�ع�������">�ع�������</option> -->
																	<option value="�ѹ���">�ѹ���</option>
																	<option value="ī������">ī������</option>
																	<!-- <option value="�ؾ����ڱ�������">�ؾ����ڱ�������</option> -->
																	<option value="ȫ����">ȫ����</option>
																	<option value="ȸ��������">ȸ��������</option>
																	<option value="���Ű�������" >���Ű�������</option>
																	<option value="������ȣ��" >������ȣ��</option>
																	
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
															
															<a href="javascript:send();">
																<img src="img/btn_transfer.gif" align="absmiddle" alt="��ø" border="0">
															</a> <!-- �۳����� ������̸鼭 �α����� ����ڰ� ������� ���,�亯������ �ִ� ��� �Ұ��μ� �̸��� ��Ÿ��-->
																<%
																	} else {
																%> <%=buse_name%> <%
 	}
 %>
															</td>
															<!-- �۳����� �ع�������� ���,����� �Ǵ� �ع����������Ѹ��� �����ִ°� -->
															<%
																} else if (buse_name.equals("�����Һ��ں�ȣ��")) {
															%>
															<td>
																<!-- �۳����� �ع��������̸鼭 �α����� ����ڰ� �ع��������� ���,�亯������ ���� ��� ����Ƿ� �ݼ۹� Ÿ�μ��� ��ø���� -->
																<%
																	if (finance_buseo.equals("�����Һ��ں�ȣ��") && answer.equals("") && !status.equals("öȸ�Ϸ�")) {
																%> <select name="buseo">
																	<option value="">����</option>
																	<option value="�����">�����</option>
																	<option value="�����">�����</option>
																	<option value="ICT������">ICT������</option>
																	<option value="�λ��ѹ���">�λ��ѹ���</option>
																	<option value="���α�����">���α�����</option>
																	<option value="���������">���������</option>
																	<option value="������ȹ��">������ȹ��</option>
																	<option value="��ȹ��">��ȹ��</option>
																	<option value="�뷮������ ����ȭ�������">�뷮������ ����ȭ�������</option>
																	<option value="��ü�޽Ļ����">��ü�޽Ļ����</option>
																	<option value="����ũ��������">����ũ��������</option>
																	<option value="��ī�ݵ�����(�ݵ�)">��ī�ݵ�����(�ݵ�)</option>
																	<option value="��ȣ������">��ȣ������</option>
																	<option value="�������������">�������������</option>
																	<option value="���������">���������</option>
																	<!-- <option value="����������">����������</option> -->
																	<option value="��Ź�������">��Ź�������</option>
																	<option value="�ɻ��">�ɻ��</option>
																	<option value="���������ź���">���������ź���</option>
																	<option value="���Ű�����">���Ű�����</option>
																	<option value="������">������</option>
																	<option value="�۷ι���ȯ�����">�۷ι���ȯ�����</option>
																	<option value="������ȹ��">������ȹ��</option>
																	<option value="�̻�ȸ�繫��">�̻�ȸ�繫��</option>
																	<option value="�ڱݺ�">�ڱݺ�</option>
																	<option value="��������">��������</option>
																	<option value="IT���ߺ�">IT���ߺ�</option>
																	<option value="������ȣ����">������ȣ����</option>
																	<option value="���հ����">���հ����</option>
																	<option value="����ũ������">����ũ������</option>
																	<option value="�ڱݿ���">�ڱݿ���</option>
																	<!-- <option value="�ع�������">�ع�������</option> -->
																	<option value="�ǸŻ����">�ǸŻ����</option>
																	<option value="�ѹ���">�ѹ���</option>
																	<option value="ī������">ī������</option>
																	<!-- <option value="�ؾ����ڱ�������">�ؾ����ڱ�������</option> -->
																	<option value="ȫ����">ȫ����</option>
																	<option value="ȸ��������">ȸ��������</option>
																	<!-- <option value="������������">������������</option> -->
																	<option value="���������">���������</option>
																	<option value="������å��">������å��</option>
																	<option value="��å�����">��å�����</option>
																	<option value="�����Һ��ں�ȣ��">�����Һ��ں�ȣ��</option>
																	<option value="�����а��ߺ�">�����а��ߺ�</option>
																	<!-- <option value="����������">����������</option> -->
																	<option value="�ع����ý�(�߾�ȸ)">�ع����ý�(�߾�ȸ)</option>
																	<option value="�ع����ý�(����)">�ع����ý�(����)</option>
																	<option value="���Ű�������" >���Ű�������</option>
																	<option value="������ȣ��" >������ȣ��</option>
																	
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
															</select> <a href="javascript:send();"> <img
																	src="img/btn_transfer.gif" align="absmiddle" alt="��ø"
																	border="0"></a> <br> <br> <%=(String) session.getAttribute("shBuseoFrom")%>
																<a href="javascript:receive();"> <img
																	src="img/btn_sendback.gif" align="absmiddle" border="0"
																	alt="�ݼ�"></a> <input type="hidden" name="buseo_to"
																value="<%=(String) session.getAttribute("shBuseoFrom")%>">
																<!-- �۳����� �ع�������̸鼭 �α����� ����ڰ� �ع������ �Ǵ� ������� ���,�亯������ �ִ� ��� �Ұ��μ� �̸��� ��Ÿ�� -->
																<%
																	} else {
																%> <%
																 	if (junbuseo.equals("Y")) {
																 %> <%=buse_name%> <%
																 	} else {
																 %> <%=buse_name%> <%
																 	}
																 %> <%
																 	}
																 %>
															</td>
															<!-- �۳����� �����,�ع�������� �ƴ� ���,�����,�ع�������,������ �μ����� �����ִ°� -->
															<%
																} else if (buse_name.equals("�ع����ý�(�߾�ȸ)")) {
															%>
															<td>
																<%
																	if (finance_buseo.equals("�ع����ý�(�߾�ȸ)") && answer.equals("") && !status.equals("öȸ�Ϸ�")) {
																%> <select name="buseo">
																	<option value="">����</option>
																	<option value="�����">�����</option>
																	<option value="ICT������">ICT������</option>
																	<option value="�λ��ѹ���">�λ��ѹ���</option>
																	<option value="���α�����">���α�����</option>
																	<option value="���������">���������</option>
																	<option value="������ȹ��">������ȹ��</option>
																	<option value="��ȹ��">��ȹ��</option>
																	<option value="�뷮������ ����ȭ�������">�뷮������ ����ȭ�������</option>
																	<option value="��ü�޽Ļ����">��ü�޽Ļ����</option>
																	<option value="����ũ��������">����ũ��������</option>
																	<option value="��ī�ݵ�����(�ݵ�)">��ī�ݵ�����(�ݵ�)</option>
																	<option value="��ȣ������">��ȣ������</option>
																	<option value="�������������">�������������</option>
																	<option value="���������">���������</option>
																	<!-- <option value="����������">����������</option> -->
																	<option value="��Ź�������">��Ź�������</option>
																	<option value="�ɻ��">�ɻ��</option>
																	<option value="���������ź���">���������ź���</option>
																	<option value="���Ű�����">���Ű�����</option>
																	<option value="������">������</option>
																	<option value="�۷ι���ȯ�����">�۷ι���ȯ�����</option>
																	<option value="������ȹ��">������ȹ��</option>
																	<option value="�̻�ȸ�繫��">�̻�ȸ�繫��</option>
																	<option value="�ڱݺ�">�ڱݺ�</option>
																	<option value="��������">��������</option>
																	<option value="IT���ߺ�">IT���ߺ�</option>
																	<option value="������ȣ����">������ȣ����</option>
																	<option value="���հ����">���հ����</option>
																	<option value="����ũ������">����ũ������</option>
																	<option value="�ڱݿ���">�ڱݿ���</option>
																	<!-- <option value="�ع�������">�ع�������</option> -->
																	<option value="�ǸŻ����">�ǸŻ����</option>
																	<option value="�ѹ���">�ѹ���</option>
																	<option value="ī������">ī������</option>
																	<!-- <option value="�ؾ����ڱ�������">�ؾ����ڱ�������</option> -->
																	<option value="ȫ����">ȫ����</option>
																	<option value="ȸ��������">ȸ��������</option>
																<!-- 	<option value="������������">������������</option> -->
																	<option value="���������">���������</option>
																	<option value="������å��">������å��</option>
																	<option value="��å�����">��å�����</option>
																	<option value="�����Һ��ں�ȣ��">�����Һ��ں�ȣ��</option>
																	<option value="�����а��ߺ�">�����а��ߺ�</option>
																	<!-- <option value="����������">����������</option> -->
																	<option value="�ع����ý�(�߾�ȸ)">�ع����ý�(�߾�ȸ)</option>
																	<option value="�ع����ý�(����)">�ع����ý�(����)</option>
																	<option value="���Ű�������" >���Ű�������</option>
																	<option value="������ȣ��" >������ȣ��</option>
																	
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
															</select> <a href="javascript:send();"><img
																	src="img/btn_transfer.gif" align="absmiddle" alt="��ø"
																	border="0"></a> <br> <br> <%=(String) session.getAttribute("shBuseoFrom")%>
																<a href="javascript:receive();"><img
																	src="img/btn_sendback.gif" align="absmiddle" border="0"
																	alt="�ݼ�"></a> <input type="hidden" name="buseo_to"
																value="<%=(String) session.getAttribute("shBuseoFrom")%>">
																<%
																	} else {
																%> <%=buse_name%> <%
 	}
 %>
															</td>
															<%
																} else if (buse_name.equals("�ع����ý�(����)")) {
															%>
															<td>
																<%
																	if (finance_buseo.equals("�ع����ý�(����)") && answer.equals("") && !status.equals("öȸ�Ϸ�")) {
																%> <select name="buseo">
																	<option value="">����</option>
																	<option value="�����">�����</option>
																	<option value="ICT������">ICT������</option>
																	<option value="�λ��ѹ���">�λ��ѹ���</option>
																	<option value="���α�����">���α�����</option>
																	<option value="���������">���������</option>
																	<option value="������ȹ��">������ȹ��</option>
																	<option value="��ȹ��">��ȹ��</option>
																	<option value="�뷮������ ����ȭ�������">�뷮������ ����ȭ�������</option>
																	<option value="��ü�޽Ļ����">��ü�޽Ļ����</option>
																	<option value="����ũ��������">����ũ��������</option>
																	<option value="��ī�ݵ�����(�ݵ�)">��ī�ݵ�����(�ݵ�)</option>
																	<option value="��ȣ������">��ȣ������</option>
																	<option value="�������������">�������������</option>
																	<option value="���������">���������</option>
																	<!-- <option value="����������">����������</option> -->
																	<option value="��Ź�������">��Ź�������</option>
																	<option value="�ɻ��">�ɻ��</option>
																	<option value="���������ź���">���������ź���</option>
																	<option value="���Ű�����">���Ű�����</option>
																	<option value="������">������</option>
																	<option value="�۷ι���ȯ�����">�۷ι���ȯ�����</option>
																	<option value="������ȹ��">������ȹ��</option>
																	<option value="�̻�ȸ�繫��">�̻�ȸ�繫��</option>
																	<option value="�ڱݺ�">�ڱݺ�</option>
																	<option value="��������">��������</option>
																	<option value="IT���ߺ�">IT���ߺ�</option>
																	<option value="������ȣ����">������ȣ����</option>
																	<option value="���հ����">���հ����</option>
																	<option value="����ũ������">����ũ������</option>
																	<option value="�ڱݿ���">�ڱݿ���</option>
																	<!-- <option value="�ع�������">�ع�������</option> -->
																	<option value="�ǸŻ����">�ǸŻ����</option>
																	<option value="�ѹ���">�ѹ���</option>
																	<option value="ī������">ī������</option>
																	<!-- <option value="�ؾ����ڱ�������">�ؾ����ڱ�������</option> -->
																	<option value="ȫ����">ȫ����</option>
																	<option value="ȸ��������">ȸ��������</option>
																	<!-- <option value="������������">������������</option> -->
																	<option value="���������">���������</option>
																	<option value="������å��">������å��</option>
																	<option value="��å�����">��å�����</option>
																	<option value="�����Һ��ں�ȣ��">�����Һ��ں�ȣ��</option>
																	<option value="�����а��ߺ�">�����а��ߺ�</option>
																	<!-- <option value="����������">����������</option> -->
																	<option value="�ع����ý�(�߾�ȸ)">�ع����ý�(�߾�ȸ)</option>
																	<option value="�ع����ý�(����)">�ع����ý�(����)</option>
																	<option value="���Ű�������" >���Ű�������</option>
																	<option value="������ȣ��" >������ȣ��</option>	
																	
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
															</select> <a href="javascript:send();"><img
																	src="img/btn_transfer.gif" align="absmiddle" alt="��ø"
																	border="0"></a> <br> <br> <%=(String) session.getAttribute("shBuseoFrom")%>
																<a href="javascript:receive();"><img
																	src="img/btn_sendback.gif" align="absmiddle" border="0"
																	alt="�ݼ�"></a> <input type="hidden" name="buseo_to"
																value="<%=(String) session.getAttribute("shBuseoFrom")%>">
																<%
																	} else {
																%> <%=buse_name%> <%
 	}
 %>
															</td>
															<%
																} else {
															%>
															<!-- �α����� ����� �ع��������� ��� �Ұ��μ� �̸��� ��Ÿ��-->
															<%
																if (finance_buseo.equals("�����Һ��ں�ȣ��")) {
															%>
															<td><%=buse_name%></td>
															<!-- �α����� ����� ������� ��� �Ұ��μ� �̸��� ��Ÿ��-->
															<%
																} else if (finance_buseo.equals("�����")) {
															%>
															<td>
																<%
																	if (junbuseo.equals("Y")) {
																%> <%=buse_name%> <%
 	} else {
 %> <%=buse_name%> <%
 	}
 %>
															</td>
															<!-- �α����� ����� �Ϲݺμ��� ��� �ݼ۱��-->
															<%
																} else {
															%>
															<!-- �亯�� �ȴ� ���-->
															<%
																if (answer.equals("")) {
															%>
															<!-- �۳����� �ع�����ǿ� ���� ���-->
															<%
																if (junbuseo.equals("Y")) {
															%>
															<td>�����Һ��ں�ȣ������ <a href="javascript:receive();"><img
																	src="img/btn_sendback.gif" align="absmiddle" border="0"
																	alt="�ݼ�"></a></td> 22
															<input type="text" name="buseo_to" value="<%="�����Һ��ں�ȣ��"%>" />
															<!-- �۳����� ����ǿ� ���� ���-->
															<%
																} else {
															%>
															<td><%=(String) session.getAttribute("shBuseoFrom")%>
																<a href="javascript:receive();"><img
																	src="img/btn_sendback.gif" align="absmiddle" border="0"
																	alt="�ݼ�"></a></td>
															<input type="hidden" name="buseo_to"
																value="<%=(String) session.getAttribute("shBuseoFrom")%>" />
															<%
																}
															%>
															<!-- �亯�� �� ���-->
															<%
																} else {
															%>
															<!-- �۳����� �ع��������� ���� ���-->
															<%
																if (junbuseo.equals("Y")) {
															%>
															<td><%=buse_name%></td>
															<!-- �۳����� ����ǿ� ���� ���-->
															<%
																} else {
															%>
															<td><%=buse_name%></td>
															<%
																}
															%>
															<%
																}
															%>
															<%
																}
															%>
															<%
																}
															%>
															<input type="hidden" name="buseo_from"
																value="<%=buse_name%>" />
														</tr>
													</table>
												</td>
											</tr>
										</table> <!-- // ������� ���� ����-->
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table> <br> <!-- // ������� ���� ��������--> <!-- ������� ���� ���ôޱ� ������-->
				<table width="945" border="0" cellspacing="0" cellpadding="0"
					class="table_outline">
					<tr>
						<td width="130" height="35" align="center" class="table_bg_title">�ۼ���</td>
						<td style="padding-left: 25;" class="bluesky" width="540"><%=(String) session.getAttribute("name")%></td>
						<td class="table_bg_title" width="110" align="center">�ۼ���</td>
						<td style="padding-left: 25;" width="165" class="bluesky"><%=sdf.format(date)%></td>
					</tr>
					<tr>
						<td colspan="4" height="1" bgcolor="ffffff"></td>
					</tr>
					<tr>
						<td width="130" height="35" align="center" class="table_bg_title">������</td>
						<td style="padding-left: 25;" class="board_bg_contents"
							colspan="3"><textarea name="answer" cols="115" rows="8"
								wrap="physical"><%=answer%></textarea></td>
					</tr>
					<tr>
						<td colspan="4" height="1" bgcolor="ffffff"></td>
					</tr>
					<tr>
						<td width="130" height="35" align="center" class="table_bg_title">�ο��з�</td>
						<td style="padding-left: 25;" class="board_bg_contents"
							colspan="3">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="100" class="bluesky"><input type="radio"
										name="min_gubun" value="�Ϲݹο�"
										<%if (minwon_gubun.equals("�Ϲݹο�"))out.print("checked");%>>
										�Ϲݹο�
									</td>
									<td width="100" class="bluesky"><input type="radio"
										name="min_gubun" value="�ܼ�����"
										<%if (minwon_gubun.equals("�ܼ�����"))out.print("checked");%>>
										�ܼ�����
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="4" height="1" bgcolor="ffffff"></td>
					</tr>
					<tr>
						<td width="130" height="35" align="center" class="table_bg_title">ó�����</td>
						<td style="padding-left: 25;" class="board_bg_contents"
							colspan="3">
				
							<table width="100%" border="0" cellspacing="5" cellpadding="0">
								<tr>
									<td width="80" class="bluesky">* �ذ�</td>
									<td>
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="150" class="black"><input type="radio"
													name="result" value="��ġ/����"
													<%if (result.equals("��ġ/����"))out.print("checked");%>>
													��ġ/����
												</td>
												<td>&nbsp;</td>
												<td class="black" width="150"><input type="radio"
													name="result" value="�����ȳ�"
													<%if (result.equals("�����ȳ�"))out.print("checked");%>>
													�����ȳ�
												</td>
												<td>&nbsp;</td>
												<td class="black" width="150"><input type="radio"
													name="result" value="����/����"
													<%if (result.equals("����/����"))out.print("checked");%>>
													����/����
												</td>
												<td>&nbsp;</td>
												<td class="black"><input type="radio" name="result"
													value="��������"
													<%if (result.equals("��������"))out.print("checked");%>>
													��������
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td class="bluesky">* ��ġ�Ҵ�</td>
									<td>
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="150" class="black"><input type="radio"
													name="result" value="����/������Ҵ�"
													<%if (result.equals("����/������Ҵ�"))out.print("checked");%>>
													����/������Ҵ�
												</td>
												<td>&nbsp;</td>
												<td width="150" class="black"><input type="radio"
													name="result" value="������ո�"
													<%if (result.equals("������ո�"))out.print("checked");%>>
													������ո�
												</td>
												<td>&nbsp;</td>
												<td width="150" class="black"><input type="radio"
													name="result" value="����"
													<%if (result.equals("����"))out.print("checked");%>>
													����
												</td>
												<td>&nbsp;</td>
												<td class="black"><input type="radio" name="result"
													value="��ǻ���"
													<%if (result.equals("��ǻ���"))out.print("checked");%>>
													��ǻ���
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td class="bluesky">* �ҹ�</td>
									<td>
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="150" class="black"><input type="radio"
													name="result" value="�͸��ּҹ�"
													<%if (result.equals("�͸��ּҹ�"))out.print("checked");%>>
													�͸��ּҹ�
												</td>
												<td>&nbsp;</td>
												<td width="150" class="black"><input type="radio"
													name="result" value="��������"
													<%if (result.equals("��������"))out.print("checked");%>>
													��������
												</td>
												<td>&nbsp;</td>
												<td width="150" class="black"><input type="radio"
													name="result" value="�Ҽ�/����"
													<%if (result.equals("�Ҽ�/����"))out.print("checked");%>>
													�Ҽ�/����
												</td>
												<td>&nbsp;</td>
												<td class="black"><input type="radio" name="result"
													value="�ҹ�(�ο��ƴ�)"
													<%if (result.equals("�ҹ�(�ο��ƴ�)"))out.print("checked");%>>
													�ҹ�(�ο��ƴ�)
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td class="bluesky">* ��Ÿ</td>
									<td>
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="150" class="black"><input type="radio"
													name="result" value="����/����"
													<%if (result.equals("����/����"))out.print("checked");%>>
													����/����
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- 20180629  �߰� ������ �亯�� ����÷�� -->
					<tr>
						<td width="130" height="35" align="center" class="table_bg_title">÷������</td>
						<td>
                  			<input type="file" class="typeText file" size="70" name="file1" value="" onChange="uploadFile_Change( this.value )">
               			</td>
					</tr>
				</table>
				<table width="945" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="right">&nbsp;</td>
					</tr>
					<tr>
						<%
							if (finance_buseo.equals(buse_name) && !status.equals("öȸ�Ϸ�")) {
							
						%>
						<td align="right">
							<a href="javascript:goReply(<%=thididx%>);">
								<img src="img/btn_reply.gif" width="55" height="21" alt="�亯" border="0">
							</a>
							<!-- <input type="submit" value="�亯"> -->
						</td>
						<%
							}
						%>
					</tr>
				</table> <br> <!-- // ������� ���� ���ôޱ� ������-->
			</td>
		</tr>
	</table>
	<!--�μ��� ��ø�����̷°��� ����Ʈ -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td style="padding-left: 25;"><img src="img/arrow.gif"
				width="13" height="16" align="absmiddle"> <span
				class="txt_title">�μ��� ��ø���� �̷°���</span></td>
		</tr>
		<tr>
			<td style="padding: 10 0 0 25;">
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
					<%
						ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 1);
					%>
					<%
						if (ResultVector.size() > 0) {
					%>
					<%
						for (int i = 0; i < ResultVector.size(); i++) {
					%>
					<%
						Hashtable h = (Hashtable) ResultVector.elementAt(i);
								session.setAttribute("sh_buseo_from", (String) h.get("SH_BUSEO_FROM"));
					%>
					<tr>
						<td align="center"><%=i + 1%></td>
						<td align="center"><%=(String) h.get("SH_BUSEO_FROM")%></td>
						<td align="center"><%=(String) h.get("SH_BUSEO_TO")%></td>
						<td style="padding-left: 10;" align="center"><%=(String) h.get("SH_INDATE")%></td>
						<td align="center"><%=(String) h.get("SH_STATUS")%></td>
					</tr>
					<tr>
						<td colspan="10" class="board_line2" height="1"></td>
					</tr>
					<%
						}
					%>
					<%
						} else {
					%>
					<tr>
						<td colspan="5" align="center">��ϵ� �ڷᰡ �����ϴ�</td>
					</tr>
					<%
						}
					%>
				</table>
			</td>
		</tr>
	</table>
	<input type="hidden" id="mid" name="mid" value="<%=mid%>"> 
	<input type="hidden" id="mid1" name="mid1" value="<%=mid%>">
	<input type="hidden" name="PAGE" value="<%=PAGE%>"> 
	<input type="hidden" name="mobile" value="<%=mobile%>">
</form>
<%@ include file="include/bottom.jsp"%>