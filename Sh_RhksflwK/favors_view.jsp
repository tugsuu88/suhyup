<%@ page
	import="java.util.*, util.*,java.text.SimpleDateFormat,javax.sql.*, javax.naming.*,java.sql.*"%>

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
<%@ include file="include/top_menu11.jsp"%>

<jsp:useBean id="FrontBoard" scope="session"
	class="Bean.Front.Common.FrontBoradType1" />

<%
	String thid = Converter.nullchk(request.getParameter("thid"));
	String PAGE = Converter.nullchk(request.getParameter("PAGE"));
	String favors_buseo = (String) session.getAttribute("buseo");
	int thididx = Integer.parseInt(thid);

	String TableName = " sh_chungtak ";
	String SelectCondition = "sg_publication, sg_name, sg_tel, ";
	SelectCondition += "ct_name, ct_job, ct_tel, ct_job, ct_zip, ct_addr1, ct_addr2, ct_corp, ct_corpaddr, ct_corpname, ";
	SelectCondition += "ct_name_c, ct_job_c, ct_tel_c, ct_job_c, ct_zip_c, ct_addr1_c, ct_addr2_c, ct_corp_c, ct_corpaddr_c, ct_corpname_c, ";
	SelectCondition += "ct_date, ct_place, ct_content, ct_reason, bh_yn, bh_place, etc, regdate, ";
	SelectCondition += "code, type, title, buseo, text1, result, junbuseo, ";
	SelectCondition += "to_char(time1, 'YYYY-MM-DD') AS time1, ";
	SelectCondition += "to_char(time2, 'YYYY-MM-DD') AS time2, to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date ";
	String WhereCondition = " where thid=" + thididx;
	String OrderCondition = "";
	//int TotalRecordCount = FrontBoard.TotalCount(TableName2, WhereCondition2);
	//out.println("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br><br>");
	Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 0, 0);

	//��û�� ����
	String sg_publication = "";
	String sg_name = "";
	String sg_tel = "";
	//ûŹ�� ����(�ʼ�)
	String ct_name = "";
	String ct_job = "";
	String ct_tel = "";
	String ct_zip = "";
	String ct_addr1 = "";
	String ct_addr2 = "";
	String ct_corp = "";
	String ct_corpaddr = "";
	String ct_corpname = "";
	//ûŹ�� ����(����)
	String ct_name_c = "";
	String ct_job_c = "";
	String ct_tel_c = "";
	String ct_zip_c = "";
	String ct_addr1_c = "";
	String ct_addr2_c = "";
	String ct_corp_c = "";
	String ct_corpaddr_c = "";
	String ct_corpname_c = "";
	//����ûŹ �Ǵ� ��ǰ�� ���� ����
	String ct_date = "";
	String ct_place = "";
	String ct_content = "";
	String ct_reason = "";
	//��ǰ�� ��ȯ���� �� ���(��ǰ�� ������ ���)
	String bh_yn = "";
	String bh_place = "";
	String etc = "";

	String type = "";
	String type1 = "";
	String code = "";
	String title = "";
	String buseo = "";
	// 	String text = "";
	String text1 = "";
	String result = "";
	String junbuseo = "";
	String time1 = "";
	String time2 = "";
	String abandon_date = "";

	String titleTxt = "";

	//out.println(ResultVector.size());

	if (ResultVector.size() > 0) {
		for (int i = 0; i < ResultVector.size(); i++) {
			Hashtable h = (Hashtable) ResultVector.elementAt(i);

			type = (("1".equals((String) h.get("TYPE"))) ? "�����Ű���" : "��3�ڽŰ���");
			type1 = (String) h.get("TYPE");

			System.out.println("type1 = " + type1);

			if ("1".equals(type1)) {
				titleTxt = "����ûŹ���� �� �Ǵ� ��ǰ���� ������ ��";
			} else {
				titleTxt = "�ǽŰ���(�Ű���� �ʼ�)";
			}

			code = (String) h.get("CODE");
			title = (String) h.get("TITLE");

			sg_publication = (String) h.get("SG_PUBLICATION");
			sg_name = (String) h.get("SG_NAME");
			sg_tel = (String) h.get("SG_TEL");

			ct_name = (String) h.get("CT_NAME");
			ct_job = (String) h.get("CT_JOB");
			ct_tel = (String) h.get("CT_TEL");
			ct_zip = (String) h.get("CT_ZIP");
			ct_addr1 = (String) h.get("CT_ADDR1");
			ct_addr2 = (String) h.get("CT_ADDR2");
			ct_corp = (String) h.get("CT_CORP");
			ct_corpaddr = (String) h.get("CT_CORPADDR");
			ct_corpname = (String) h.get("CT_CORPNAME");

			ct_name_c = (String) h.get("CT_NAME_C");
			ct_job_c = (String) h.get("CT_JOB_C");
			ct_tel_c = (String) h.get("CT_TEL_C");
			ct_zip_c = (String) h.get("CT_ZIP_C");
			ct_addr1_c = (String) h.get("CT_ADDR1_C");
			ct_addr2_c = (String) h.get("CT_ADDR2_C");
			ct_corp_c = (String) h.get("CT_CORP_C");
			ct_corpaddr_c = (String) h.get("CT_CORPADDR_C");
			ct_corpname_c = (String) h.get("CT_CORPNAME_C");

			ct_date = (String) h.get("CT_DATE");
			ct_place = (String) h.get("CT_PLACE");

			StringTokenizer stk = null;

			stk = new StringTokenizer(ct_place, "\r\n");
			ct_place = "";
			while (stk.hasMoreElements()) {
				ct_place += stk.nextToken();
				ct_place += "<br>";
			}

			ct_content = (String) h.get("CT_CONTENT");
			stk = new StringTokenizer(ct_content, "\r\n");
			ct_content = "";
			while (stk.hasMoreElements()) {
				ct_content += stk.nextToken();
				ct_content += "<br>";
			}
			ct_reason = (String) h.get("CT_REASON");
			stk = new StringTokenizer(ct_reason, "\r\n");
			ct_reason = "";
			while (stk.hasMoreElements()) {
				ct_reason += stk.nextToken();
				ct_reason += "<br>";
			}

			bh_yn = (("Y".equals((String) h.get("BH_YN"))) ? "��ȯ" : "�̹�ȯ");

			bh_place = (String) h.get("BH_PLACE");
			etc = (String) h.get("ETC");

			buseo = (String) h.get("BUSEO");
			text1 = (String) h.get("TEXT1");
			if (text1 == null)
				text1 = "";
			result = (String) h.get("RESULT");
			if (result == null)
				result = "";
			junbuseo = (String) h.get("JUNBUSEO");
			time1 = (String) h.get("TIME1");
			time2 = (String) h.get("TIME2");
			abandon_date = (String) h.get("ABANDON_DATE");
		}
	}

	TableName = " sh_chungtak_history ";
	SelectCondition = " sh_no, sh_chungtak_no, sh_buseo_from, sh_buseo_to, sh_status,";
	SelectCondition += "to_char(sh_indate, 'YYYY-MM-DD') AS sh_indate ";
	WhereCondition = " where sh_chungtak_no=" + thididx;
	OrderCondition = " order by sh_no asc";

	java.util.Date date = new java.util.Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	//�д� ����� ����� �Ҽ��� ����,�ٸ� �μ��� ��� ó����
	//�Ѱ����ڰ� �ƴҰ��, �ڵ尡 �亯�Ϸ�,��ø,�ݼ��� �ƴҰ��,�亯�� �ȴ� ���
	if (!favors_buseo.equals("all") && text1.equals("") && code.equals("��û")) {
		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;

		try {
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
			conn = ds.getConnection();

			String sql = "";
			if (favors_buseo.equals("�����") || favors_buseo.equals("�����")) {
				sql = "update sh_chungtak set code='����' where thid=?";
			} else {
				sql = "update sh_chungtak set code='ó����' where thid=?";
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

		var isstr = confirm("�亯�� �Ͻðڽ��ϱ�?");
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

			pbform.action="favors_view_ok.jsp";
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
			pbform.action="favors_send_ok.jsp";
			pbform.submit();
		}
	}
	function receive(){
		if(confirm("�ݼ��Ͻðڽ��ϱ�?")){
			pbform.action="favors_receive_ok.jsp";
			pbform.submit();
		}
	}
</script>
<!-- ������� ���� ���� -->
<form method=post name="pbform" action="" style="margin: 0px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="95" bgcolor="f4f4f4" style="padding-left: 25;">
				<table width="945" border="0" cellspacing="0" cellpadding="0"
					background="img/title_bg.gif">
					<tr>
						<td width="135">
							<table width="135" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="70" align="center" class="admin_subject">ûŹ������
										���� �Ű� ����</td>
								</tr>
							</table>
						</td>
						<td width="5"></td>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="60" class="adminsub_subject"
										style="padding-left: 25;">ûŹ������ ���� �ʿ���</td>
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
							ûŹ������ ���� �Ű� ���� <span class="result_text">�󼼺���</span></td>
						<td height="30" align="right" width="60"><a href="#"><img
								src="img/btn_print.gif" width="55" height="21"
								onClick="MM_openBrWindow('favors_print2.jsp?thididx=<%=thididx%>','','width=638,height=750')"
								border="0" alt="���"></a></td>
						<td height="30" align="right" width="60"><a
							href="favors.jsp?PAGE=<%=PAGE%>"><img src="img/btn_list.gif"
								width="55" height="21" border="0" alt="���"></a></td>
					</tr>
					<tr>
						<td height="2" class="result_line" colspan="3"></td>
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
												<td style="padding-left: 10;">��ȣ : <%=thid%></td>
												<td align="right" style="padding-right: 10;">ó������ : <%=code%></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td height="5" colspan="3"></td>
								</tr>
								<tr height="30">


									<td align="center" class="board_bg_title" valign="top"
										width="650">
										<div style="width: 100%; height: 470px; overflow-y: scroll;">
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0" class="read_outline">


												<!-- �Ű����� -->
												<tr>
													<td align="center" height="30" class="table_bg_title">�Ű�����</td>
												</tr>
												<tr>
													<td style="padding: 20 20 20 20;">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0" class="read_outline">
															<colgroup>
																<col style="width: 20%" />
																<col style="width: *" />
															</colgroup>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">����</th>
																<td style="text-align: left; padding-left: 10px;"><%=type%></td>
															</tr>
														</table>

													</td>
												</tr>
												<!-- //�Ű����� -->


												<!-- ����ûŹ�� �� �� �Ǵ� ��ǰ���� ������ ��& �ǽŰ���(�Ű���� �ʼ�) -->
												<tr>
													<td align="center" height="30" class="table_bg_title"><%=titleTxt%></td>
												</tr>
												<tr>
													<td style="padding: 20 20 20 20;">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0" class="read_outline">
															<colgroup>
																<col style="width: 20%" />
																<col style="width: *" />
															</colgroup>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">�̸�</th>
																<td style="text-align: left; padding-left: 10px;"><%=ct_name%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">����</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_job%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">����ó</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_tel%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">�ּ�</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_zip%>&nbsp;<%=ct_addr1%>
																	<%=ct_addr2%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">ûŹ�ڹ��θ�Ī</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_corp%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">ûŹ�ڹ��μ�����</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_corpaddr%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">ûŹ�ڹ��δ�ǥ����</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_corpname%></td>
															</tr>
														</table>

													</td>
												</tr>
												<!-- //����ûŹ�� �� �� �Ǵ� ��ǰ���� ������ �� -->

												<%
													if ("2".equals(type1)) {
												%>

												<!-- �ǽŰ���(�Ű���� ����) -->
												<tr>
													<td align="center" height="30" class="table_bg_title">�ǽŰ���(�Ű����
														����)</td>
												</tr>
												<tr>
													<td style="padding: 20 20 20 20;">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0" class="read_outline">
															<colgroup>
																<col style="width: 20%" />
																<col style="width: *" />
															</colgroup>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">�̸�</th>
																<td style="text-align: left; padding-left: 10px;"><%=ct_name_c%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">����</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_job_c%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">����ó</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_tel_c%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">�ּ�</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_zip_c%>&nbsp;<%=ct_addr1_c%>
																	<%=ct_addr2_c%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">ûŹ�ڹ��θ�Ī</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=ct_corp_c%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">ûŹ�ڹ��μ�����</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=ct_corpaddr_c%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">ûŹ�ڹ��δ�ǥ����</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=ct_corpname_c%></td>
															</tr>
														</table>

													</td>
												</tr>
												<!-- //�ǽŰ���(�Ű���� ����) -->
												<%
													}
												%>

												<!-- ����ûŹ �Ǵ� ��ǰ�� ���� ���� -->
												<tr>
													<td align="center" height="30" class="table_bg_title">����ûŹ
														�Ǵ� ��ǰ�� ���� ����</td>
												</tr>
												<tr>
													<td style="padding: 20 20 20 20;">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0" class="read_outline">
															<colgroup>
																<col style="width: 20%" />
																<col style="width: *" />
															</colgroup>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">ûŹ�Ͻ�</th>
																<td style="text-align: left; padding-left: 10px;"><%=ct_date%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">ûŹ���</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=ct_place%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">ûŹ����</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=ct_content%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">ûŹ�Ű�����</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=ct_reason%></td>
															</tr>
														</table>
													</td>
												</tr>
												<!-- //����ûŹ �Ǵ� ��ǰ�� ���� ���� -->

												<%
													if ("1".equals(type1)) {
												%>
												<!-- ��ǰ�� ��ȯ���� �� ���(��ǰ�� ������ ���) -->
												<tr>
													<td align="center" height="30" class="table_bg_title">��ǰ��
														��ȯ���� �� ���(��ǰ�� ������ ���)</td>
												</tr>
												<tr>
													<td style="padding: 20 20 20 20;">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0" class="read_outline">
															<colgroup>
																<col style="width: 20%" />
																<col style="width: *" />
															</colgroup>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">��ǰ��ȯ����</th>
																<td style="text-align: left; padding-left: 10px;"><%=bh_yn%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">��ǰ��ȯ���</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=bh_place%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">���</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=etc%></td>
															</tr>
														</table>
													</td>
												</tr>
												<!-- //��ǰ�� ��ȯ���� �� ���(��ǰ�� ������ ���) -->
												<%
													}
												%>

											</table>
										</div>
									</td>
									<td align="center" valign="top" width="5"></td>
									<td class="board_bg_title" width="295" valign="top"
										align="right">
										<!-- ������� �������� -->
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="read_outline" height="100%">
											<tr>
												<td height="30" style="padding-left: 10;"
													class="table_bg_title">ûŹ������ ���� ���� ��������</td>
											</tr>
											<tr>
												<td valign="top">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">Ư���ڵ�</td>
															<td><%=sg_publication%></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">��û��</td>
															<td><%=time1%></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">�ο���</td>
															<td><%=sg_name%> <a href="#"
																onClick="MM_openBrWindow('favors_popup.jsp?thididx=<%=thididx%>','','width=500,height=290')">[<u>������
																		����</u>]
															</a></td>
														</tr>
														<%
															if ("öȸ�Ϸ�".equals(code)) {
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
															<td height="30" style="padding-left: 10;" class="bluesky">���μ�</td>
															<!-- �� �����߿� �μ������� �����,�ع�������,��Ÿ �� ������ ����-->
															<!-- �۳����� ������� ��� , ����� ���Ѹ��� ���� �ִ°�-->
															<%
																if (buseo.equals("�����") || buseo.equals("�����")) {
															%>
															<td>
																<!-- �۳����� ������̸鼭 �α����� ����ڰ� ������� ���,�亯������ ���� ��� ��ø ���-->
																<%
																	if ((favors_buseo.equals("�����") || favors_buseo.equals("�����")) && text1.equals("")
																				&& !code.equals("öȸ�Ϸ�")) {
																%> 
																<select name="buseo">
																	<option value="">����</option>
																	<option value="�����">�����</option>
																	<option value="�����">�����</option>
																	<option value="�ع����ý�">�ع����ý�</option>
																	<option value="ICT������">ICT������</option>
																	<option value="�λ��ѹ���">�λ��ѹ���</option>
																	<option value="�����ú�">�����ú�</option>
																	<option value="���������">���������</option>
																	<option value="������ȹ��">������ȹ��</option>
																	<option value="��ȹ��">��ȹ��</option>
																	<option value="�뷮������ ����ȭ�������">�뷮������ ����ȭ�������</option>
																	<option value="��ü�޽Ļ����">��ü�޽Ļ����</option>
																	<option value="����ũ��������">����ũ��������</option>
																	<option value="��ī�ݵ�����(��ī)">��ī�ݵ�����(��ī)</option>
																	<option value="��ȣ������">��ȣ������</option>
																	<option value="�������������">�������������</option>
																	<option value="���������">���������</option>
																	<option value="��ǰ�����">��ǰ�����</option>
																	<option value="��Ź�������">��Ź�������</option>
																	<option value="�ɻ��">�ɻ��</option>
																	<!-- <option value="����������">����������</option> -->
																	<option value="���������ź���">���������ź���</option>
																	<option value="���Ű�����">���Ű�����</option>
																	<option value="������">������</option>
																	<option value="��ȯ�����">��ȯ�����</option>
																	<option value="������ȹ��">������ȹ��</option>
																	<option value="�̻�ȸ�繫��">�̻�ȸ�繫��</option>
																	<option value="�ڱݺ�">�ڱݺ�</option>
																	<option value="��������">��������</option>
																	<option value="����������">����������</option>
																	<option value="������ȣ����">������ȣ����</option>
																	<option value="���հ����">���հ����</option>
																	<option value="����ũ������">����ũ������</option>
																	<option value="�ڱݿ���">�ڱݿ���</option>
																	<!-- <option value="�ع�������">�ع�������</option> -->
																	<option value="���ǻ����">���ǻ����</option>
																	<option value="�ѹ���">�ѹ���</option>
																	<option value="ī������">ī������</option>
																	<option value="�ݵ�����">�ݵ�����</option>
																	<!-- <option value="�ؾ����ڱ�������">�ؾ����ڱ�������</option> -->
																	<option value="ȫ����">ȫ����</option>
																	<option value="ȸ��������">ȸ��������</option>
																	<!-- <option value="�������������">�������������</option> -->
																	<option value="���������">���������</option>
																	<option value="������å��">������å��</option>
																	<option value="��å�����">��å�����</option>
																	<option value="�����Һ��ں�ȣ��">�����Һ��ں�ȣ��</option>
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
																</select> 
																<a href="javascript:send();">
																	<img src="img/btn_transfer.gif" align="absmiddle" alt="��ø" border="0">
																</a> <!-- �۳����� ������̸鼭 �α����� ����ڰ� ������� ���,�亯������ �ִ� ��� �Ұ��μ� �̸��� ��Ÿ��-->
																<%
																	} else {
																%> <%=buseo%> <%
 	}
 %>
															</td>
															<!-- �۳����� �ع������� ���,����� �Ǵ� �ع����������Ѹ��� �����ִ°� -->
															<%
																} else if (buseo.equals("�����Һ��ں�ȣ��")) {
															%>
															<td>
																<!-- �۳����� �ع��������̸鼭 �α����� ����ڰ� �ع��������� ���,�亯������ ���� ��� ����Ƿ� �ݼ۹� Ÿ�μ��� ��ø���� -->
																<%
																	if (favors_buseo.equals("�����Һ��ں�ȣ��") && text1.equals("") && !code.equals("öȸ�Ϸ�")) {
																%> <select name="buseo">
																	<option value="">����</option>
																	<option value="�����">�����</option>
																	<option value="�����">�����</option>
																	<option value="�ع����ý�">�ع����ý�</option>
																	<option value="ICT������">ICT������</option>
																	<option value="�λ��ѹ���">�λ��ѹ���</option>
																	<option value="�����ú�">�����ú�</option>
																	<option value="���������">���������</option>
																	<option value="������ȹ��">������ȹ��</option>
																	<option value="��ȹ��">��ȹ��</option>
																	<option value="�뷮������ ����ȭ�������">�뷮������ ����ȭ�������</option>
																	<option value="��ü�޽Ļ����">��ü�޽Ļ����</option>
																	<option value="����ũ��������">����ũ��������</option>
																	<option value="��ī�ݵ�����(��ī)">��ī�ݵ�����(��ī)</option>
																	<option value="��ȣ������">��ȣ������</option>
																	<option value="�������������">�������������</option>
																	<option value="���������">���������</option>
																	<option value="��ǰ�����">��ǰ�����</option>
																	<option value="��Ź�������">��Ź�������</option>
																	<option value="�ɻ��">�ɻ��</option>
																	<!-- <option value="����������">����������</option> -->
																	<option value="���������ź���">���������ź���</option>
																	<option value="���Ű�����">���Ű�����</option>
																	<option value="������">������</option>
																	<option value="��ȯ�����">��ȯ�����</option>
																	<option value="������ȹ��">������ȹ��</option>
																	<option value="�̻�ȸ�繫��">�̻�ȸ�繫��</option>
																	<option value="�ڱݺ�">�ڱݺ�</option>
																	<option value="��������">��������</option>
																	<option value="����������">����������</option>
																	<option value="������ȣ����">������ȣ����</option>
																	<option value="���հ����">���հ����</option>
																	<option value="����ũ������">����ũ������</option>
																	<option value="�ڱݿ���">�ڱݿ���</option>
																	<!-- <option value="�ع�������">�ع�������</option> -->
																	<option value="���ǻ����">���ǻ����</option>
																	<option value="�ѹ���">�ѹ���</option>
																	<option value="ī������">ī������</option>
																	<option value="�ݵ�����">�ݵ�����</option>
																	<!-- <option value="�ؾ����ڱ�������">�ؾ����ڱ�������</option> -->
																	<option value="ȫ����">ȫ����</option>
																	<option value="ȸ��������">ȸ��������</option>
																	<!-- <option value="�������������">�������������</option> -->
																	<option value="���������">���������</option>
																	<option value="������å��">������å��</option>
																	<option value="��å�����">��å�����</option>
																	<option value="�����Һ��ں�ȣ��">�����Һ��ں�ȣ��</option>
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
															</select> 
															<a href="javascript:send();">
																<img src="img/btn_transfer.gif" align="absmiddle" alt="��ø" border="0"></a>
																
																<br> <br> ����Ƿ� <a href="javascript:receive();">
																<img src="img/btn_sendback.gif" align="absmiddle" border="0" alt="�ݼ�"></a> 
																<input type="hidden" name="buseo_to"
																value="<%="�����"%>"> <!-- �۳����� �ع��������̸鼭 �α����� ����ڰ� �ع������ �Ǵ� ������� ���,�亯������ �ִ� ��� �Ұ��μ� �̸��� ��Ÿ�� -->
																<%
																	} else {
																%> <%
 	if (junbuseo.equals("")) {
 %> <%=buseo%> <%
 	} else {
 %> <%=buseo%> <%
 	}
 %> <%
 	}
 %>
															</td>
															<!-- �۳����� �����,�ع�������� �ƴ� ���,�����,�ع�������,������ �μ����� �����ִ°� -->
															<%
																} else {
															%>
															<!-- �α����� ����� �ع������� ��� �Ұ��μ� �̸��� ��Ÿ��-->
															<%
																if (favors_buseo.equals("�����Һ��ں�ȣ��")) {
															%>
															<td><%=buseo%></td>
															<!-- �α����� ����� ������� ��� �Ұ��μ� �̸��� ��Ÿ��-->
															<%
																} else if (favors_buseo.equals("�����") || favors_buseo.equals("�����")) {
															%>
															<td>
																<%
																	if (junbuseo.equals("Y")) {
																%> <%=buseo%> <%
 	} else {
 %> <%=buseo%> <%
 	}
 %>
															</td>
															<!-- �α����� ����� �Ϲݺμ��� ��� �ݼ۱��-->
															<%
																} else {
															%>
															<!-- �亯�� �ȴ� ���-->
															<%
																if (text1.equals("")) {
															%>
															<!-- �۳����� �ع������� ���� ���-->
															<%
																if (junbuseo.equals("Y")) {
															%>
															<td>�����Һ��ں�ȣ������ 
																<a href="javascript:receive();">
																	<img src="img/btn_sendback.gif" align="absmiddle" border="0" alt="�ݼ�">
																</a>
															</td>
															<input type="hidden" name="buseo_to" value="<%="�����Һ��ں�ȣ��"%>">
															<!-- �۳����� ����ǿ� ���� ���-->
															<%
																} else {
															%>
															<td>����Ƿ� <a href="javascript:receive();"><img
																	src="img/btn_sendback.gif" align="absmiddle" border="0"
																	alt="�ݼ�"></a></td>
															<input type="hidden" name="buseo_to" value="<%="�����"%>">
															<%
																}
															%>
															<!-- �亯�� �� ���-->
															<%
																} else {
															%>
															<!-- �۳����� �ع������� ���� ���-->
															<%
																if (junbuseo.equals("Y")) {
															%>
															<td><%=buseo%></td>
															<!-- �۳����� ����ǿ� ���� ���-->
															<%
																} else {
															%>
															<td><%=buseo%></td>
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
															<input type="hidden" name="buseo_from" value="<%=buseo%>">
															<%
																//20080617 ���� ��
															%>
														</tr>

														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
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
							colspan="3"><textarea name="text1" cols="115" rows="8"
								wrap="physical"><%=text1%></textarea></td>
					</tr>
					<tr>
						<td colspan="4" height="1" bgcolor="ffffff"></td>
					</tr>
				</table>
				<table width="945" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="right">&nbsp;</td>
					</tr>
					<tr>
						<td align="right">
							<%
								if (favors_buseo.equals("�����") || favors_buseo.equals("�����")) {
							%> <a href="javascript:goReply(<%=thididx%>);"><img
								src="img/btn_reply.gif" width="55" height="21" alt="�亯"
								border="0"></a> <%
 	} else if (favors_buseo.equals(buseo) && !code.equals("öȸ�Ϸ�")) {
 %> <a href="javascript:goReply(<%=thididx%>);"><img
								src="img/btn_reply.gif" width="55" height="21" alt="�亯"
								border="0"></a> <%
 	}
 %>
						</td>
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
					%>
					<tr height="30" onMouseOver=this.style.backgroundColor=
						'F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'>
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
					<tr height="30" onMouseOver=this.style.backgroundColor=
						'F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'>
						<td colspan="5" align="center">��ϵ� �ڷᰡ �����ϴ�</td>
					</tr>
					<%
						}
					%>
				</table>
			</td>
		</tr>
	</table>
	<input type="hidden" name="thid" value="<%=thid%>"> <input
		type="hidden" name="PAGE" value="<%=PAGE%>"> <input
		type="hidden" name="sg_tel" value="<%=sg_tel%>">
</form>
<%@ include file="include/bottom.jsp"%>