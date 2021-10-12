<%@ page import="java.util.*, util.*,java.text.SimpleDateFormat"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<%@ include file="include/admin_session.jsp"%>
<%@ include file="include/logincheck.jsp"%>
<%@ include file="include/top_login.jsp"%>
<%@ include file="include/top_menu0201.jsp"%>

<jsp:useBean id="FrontBoard" scope="session"
	class="Bean.Front.Common.FrontBoradType1" />

<%
	String mid = Converter.nullchk(request.getParameter("mid"));
	String PAGE = Converter.nullchk(request.getParameter("PAGE"));
	int thididx=Integer.parseInt(mid);
	String finance_buseo=(String)session.getAttribute("buseo");
	
	String TableName = " sh_minwon ";
	String SelectCondition = " minwon_gubun,status,subject,name,content,answer,buse_name,answer_fname,result,category,bupin,yongup,birthdate,fname, sh_fileno, sh_file_name,";
	SelectCondition += "junbuseo, fname,to_char(creation_date, 'YYYY-MM-DD  AM HH24:MI:SS') AS creation_date, ";
	SelectCondition += "to_char(answer_date, 'YYYY-MM-DD  AM HH24:MI:SS') AS answer_date ";
	String WhereCondition = " where mid=" + thididx;
	String OrderCondition  = "";
	//int TotalRecordCount = FrontBoard.TotalCount(TableName2, WhereCondition2);
	//out.println("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br><br>");
	Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 0, 0);
	
	String minwon_gubun="";
	String status="";
	String subject="";
	String name="";
	String answer_fname="";
	String content = "";
	String answer="";
	String buse_name="";
	String creation_date="";
	String answer_date="";
	String preresult="";
	String result="";
	String category = "";
	String junbuseo="";
	String fname = "";
	String sh_file_name = "";
	String bupin = "";		String yongup = "";		String birthdate = "";
// 	String bupinNm = "";
	
	//out.println(ResultVector.size());
	
	if( ResultVector.size() > 0){
		for (int i=0; i < ResultVector.size(); i++){
			Hashtable h = (Hashtable)ResultVector.elementAt(i);
			
			minwon_gubun=(String)h.get("MINWON_GUBUN");
			status=(String)h.get("STATUS");
			subject=(String)h.get("SUBJECT");
			name=(String)h.get("NAME");
			answer_fname=(String)h.get("ANSWER_FNAME");
			content=(String)h.get("CONTENT");
			answer=(String)h.get("ANSWER");
			buse_name=(String)h.get("BUSE_NAME");
			category =(String)h.get("CATEGORY");
			
			bupin = (String)h.get("BUPIN");
						yongup=(String)h.get("YONGUP");						birthdate=(String)h.get("BIRTHDATE");
			StringTokenizer stk = new StringTokenizer(content, "\r\n");
			content="";
			while(stk.hasMoreElements()){
				content += stk.nextToken();
				answer = answer.replaceAll("\'", "'");
				answer = answer.replaceAll("&amp;", "&");
				answer = answer.replaceAll("&quot;'", "\'");
				answer = answer.replaceAll("&lt;", "<");
				answer = answer.replaceAll("&gt;", ">");
				answer = answer.replaceAll("\n\r", "<br>");
				content += "<br>";
			}
			StringTokenizer stk1 = new StringTokenizer(answer, "\r\n");
			answer="";
			while(stk1.hasMoreElements()){
				answer += stk1.nextToken();
				answer = answer.replaceAll("\'", "'");
				answer = answer.replaceAll("&amp;", "&");
				answer = answer.replaceAll("&quot;'", "\'");
				answer = answer.replaceAll("&lt;", "<");
				answer = answer.replaceAll("&gt;", ">");
				answer = answer.replaceAll("\n\r", "<br>");
				answer += "<br>";
			}
			creation_date=(String)h.get("CREATION_DATE");
			answer_date=(String)h.get("ANSWER_DATE");
			result=(String)h.get("RESULT");
			junbuseo=(String)h.get("JUNBUSEO");
			fname=(String)h.get("FNAME");
			/* 20180314 �߰�  ������ �亯 - ÷������ ���� �÷� */
			sh_file_name = (String) h.get("SH_FILE_NAME");
			
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

	TableName = " sh_minwon_history ";
	SelectCondition = " sh_no,sh_minwon_no,sh_buseo_from,sh_buseo_to,sh_status,";
	SelectCondition += "to_char(sh_indate, 'YYYY-MM-DD  AM HH24:MI:SS') AS sh_indate ";
	WhereCondition = " where sh_minwon_no=" + thididx;
	OrderCondition  = " order by sh_no asc";
	//int TotalRecordCount = FrontBoard.TotalCount(TableName2, WhereCondition2);
	//out.println("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br><br>");
	
	ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 1);
// 	System.out.println("size : " + ResultVector.size());
	if(ResultVector.size() > 0){
		for (int i = 0; i < ResultVector.size(); i++) {
			Hashtable h = (Hashtable) ResultVector.elementAt(i);
			if(i == 0){
// 				System.out.println("SH_BUSEO_FROM : " + (String) h.get("SH_BUSEO_FROM"));
				session.setAttribute("shBuseoFrom", (String) h.get("SH_BUSEO_FROM"));
				session.setAttribute("buseName", ("�����".equals((String) h.get("SH_BUSEO_FROM")) ? "�����߾�ȸ-ȸ������-��ȸ��" : "��������"));
			}
		}
	}else{
	 	session.setAttribute("buseName", ("1".equals(bupin) ? "�����߾�ȸ-ȸ������-��ȸ��" : "��������"));
	}
	
	Date date = new Date();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
%>
<!-- ������� ���� ���� -->
<script language="JavaScript">
<!--
	function MM_openBrWindow(theURL,winName,features) { //v2.0
	  window.open(theURL,winName,features);
	}
	function goView(mid,PAGE){
		pbform.action = "madmin_01_view.jsp";
		pbform.submit();
	}
	
	/* 20180314 �ο����� ÷���� ���� �ٿ�ε� */
	function DownloadPopup(mid){
		pbform.mid.value=mid;
		var wint = (screen.height - 245) / 2;
		var winl = (screen.width - 300) / 2;
		winprops = 'height=245,width=300,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'
		winurl = '../minwon/file_popup.jsp?mid='+mid;
		win = window.open(winurl, "file_popup1", winprops)
	}

//-->
	/* 20180314 �����ڰ� ÷���� ���� �ٿ�ε� */
	function DownloadPopup1(mid){
		pbform.mid.value=mid;

		var wint = (screen.height - 245) / 2;

		var winl = (screen.width - 300) / 2;

		winprops = 'height=245,width=300,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'

		winurl = 'include/file_popup1.jsp?mid='+mid;

		win = window.open(winurl, "file_popup1", winprops)

	}


</script>
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
									<td height="70" align="center" class="admin_subject">�ο�������Ȳ</td>
								</tr>
							</table>
						</td>
						<td width="5"></td>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="60" class="adminsub_subject"
										style="padding-left: 25;">�ο�������Ȳ�Դϴ�</td>
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
						<%if(finance_buseo.equals("�����") || finance_buseo.equals("�����")){%>
						<td height="30" align="right"><a href="javascript:goView();"><img
								src="img/btn_adjust.gif" width="55" height="21" alt="����"
								border="0"></a></td>
						<%} else if(finance_buseo.equals(buse_name)){%>
						<td height="30" align="right"><a href="javascript:goView();"><img
								src="img/btn_adjust.gif" width="55" height="21" alt="����"
								border="0"></a></td>
						<%} %>
						<td height="30" align="right" width="60"><a href="#"><img
								src="img/btn_print.gif" width="55" height="21"
								onClick="MM_openBrWindow('minwon_03_print.jsp?thididx=<%=thididx%>&yongup=<%=yongup%>','','width=638,height=630')"
								border="0" alt="���"></a></td>
						<td height="30" align="right" width="60"><a
							href="madmin_01.jsp?PAGE=<%=PAGE %>"><img
								src="img/btn_list.gif" width="55" height="21" border="0"
								alt="���"></a></td>
					</tr>
					<tr>
						<td height="2" class="result_line" colspan="4"></td>
					</tr>
				</table> <!-- // �˻���� -->
			</td>
		</tr>
		<!-- �ο�������Ȳ ��������-->
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
												<td style="padding: 20 20 20 20;">�� ���α��� : <%=(String)session.getAttribute("buseName") %><br />
													�� ��󿵾��� : <%=yongup %><br />
												<br /> <%=content%>
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
													class="table_bg_title">�ο�����
													����
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<br>
													÷������
													<%if(fname==null || fname.equals("")){%> <%}else{%> 
													<a href="javascript:DownloadPopup('<%=mid%>');">
														<img src="img/file_icon.gif" border="0" align="absmiddle">
														<%=fname%>
													</a>
													<% } %>
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
															<td height="30" style="padding-left: 10;" class="bluesky">���μ�</td>
															<!-- �߰� -->
															<%if(junbuseo.equals("") || junbuseo==null) {%>
															<td><%=buse_name %></td>
															<%}else{ %>
															<td><%=buse_name %></td>
															<%} %>
															<input type="hidden" name="buse_name"
																value="<%=buse_name %>">
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
				</table> <br>
				<table width="945" border="0" cellspacing="0" cellpadding="0"
					class="table_outline">
					<tr>
						<td style="padding: 5 5 5 5;">
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td height="5"></td>
								</tr>
								<tr height="30">
									<td align="center" class="board_bg_title" valign="top"
										width="650">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="read_outline">
											<tr>
												<td align="center" height="30" class="table_bg_title">�亯����</td>
											</tr>
											<tr>
												<td style="padding: 20 20 20 20;"><%=answer%></td>
											</tr>
										</table>
									</td>
									<td align="center" class="board_bg_title" valign="top"
										width="5"></td>
									<td class="board_bg_title" width="295" valign="top"
										align="right">
										<!-- �ο��������� -->
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="read_outline" height="100%">
											<tr>
												<td height="30" style="padding-left: 10;"
													class="table_bg_title">�ο�����/ó�� ��� ����</td>
											</tr>
											<tr>
												<td valign="top">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">�ο��з�</td>
															<td><%=minwon_gubun%></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">ó�����</td>
															<td><%=preresult%> &gt; <%=result%></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">ó������</td>
															<td><%=answer_date%></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<!-- 20180314 �����ڰ� ÷���� ���� �ٿ�ε� --> 
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">÷������</td>
															<td>
																<a href="javascript:DownloadPopup1('<%=mid%>');">
																	<img src="img/file_icon.gif" alt="����÷��" />
																<%=sh_file_name %>
																</a>
															</td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">���μ�</td>
															<td><%=buse_name%></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">�����</td>
															<td><%=answer_fname%></td>
														</tr>
													</table>
												</td>
											</tr>
										</table> <!-- // �ο��������� -->
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table> <br> <!-- // �ο�������Ȳ ��������-->
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
					<%ResultVector = FrontBoard.list(TableName, SelectCondition,WhereCondition, OrderCondition, 0, 1);%>
					<%if (ResultVector.size() > 0) {%>
					<%for (int i = 0; i < ResultVector.size(); i++) {%>
					<%Hashtable h = (Hashtable)ResultVector.elementAt(i);%>
					<tr>
						<td align="center"><%=i + 1%></td>
						<td align="center"><%=(String)h.get("SH_BUSEO_FROM") %></td>
						<td align="center"><%=(String)h.get("SH_BUSEO_TO") %></td>
						<td style="padding-left: 10;" align="center"><%=(String)h.get("SH_INDATE") %></td>
						<td align="center"><%=(String)h.get("SH_STATUS") %></td>
					</tr>
					<tr>
						<td colspan="10" class="board_line2" height="1"></td>
					</tr>
					<%}%>
					<%} else {%>
					<tr>
						<td colspan="5" align="center">��ϵ� �ڷᰡ �����ϴ�</td>
					</tr>
					<%}%>
				</table>
			</td>
		</tr>
	</table>
	<input type="hidden" name="mid" value="<%=mid %>" > 
	<input type="hidden" name="PAGE" value="<%=PAGE %>" />
</form>
<%@ include file="include/bottom.jsp"%>
