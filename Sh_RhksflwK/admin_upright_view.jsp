<%@ page import="java.util.*, util.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1" />
<jsp:useBean id="FrontDbUtil" scope="session" class="Bean.Front.Common.FrontDbUtil" />

<%@ include file="include/admin_session.jsp"%>
<%@ include file="include/logincheck.jsp"%>
<%@ include file="include/top_login.jsp"%>
<%@ include file="include/top_menu0203.jsp"%>

<%
	String idx = Converter.nullchk(request.getParameter("index"));
	int index = Integer.parseInt(idx);
	
	String TableName = " UPRIGHT_MEMBER ";
	String SelectCondition = null;
	String WhereCondition = null;
	String OrderCondition = null;
	
	SelectCondition = " CINDEX, to_char(INS_DATE, 'YYYYMMDD') as INS_DATE , CMEM_NM, GMEM_NM, GJOHAP, GFILE_NAME, GCOMENT, GGENDER, CGUBUN, CMOBILE_NUM, GRANK, GPOSITION ";
	OrderCondition  = "";
	WhereCondition  = " WHERE CINDEX =" + index;
	
	Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 0, 0);
	
	String indx = "";
	String ins_date = "";
	String cMemNm = "";
	String gMemNm = "";
	String gJohap = "";
	String gFileName = "";
	String gComent = "";
	String gGender = "";
	String cGubun = "";
	String cMobileNum = "";
	String gRank = "";
	String gPosition = "";
	if (ResultVector.size() > 0) {
		for (int i = 0; i < ResultVector.size(); i++) {
			Hashtable h = (Hashtable) ResultVector.elementAt(i);
			System.out.println("!!!"+h);
			
			indx = (String)h.get("CINDEX");
			ins_date = (String) h.get("INS_DATE");
			cMemNm = (String) h.get("CMEM_NM");
			gMemNm = (String) h.get("GMEM_NM");
			gJohap = (String) h.get("GJOHAP");
			gFileName = (String) h.get("GFILE_NAME");
			gComent = (String) h.get("GCOMENT");
			gGender = (String) h.get("GGENDER");
			cGubun = (String) h.get("CGUBUN");
			cMobileNum = (String) h.get("CMOBILE_NUM");
			gRank = (String) h.get("GRANK");
			gPosition = (String) h.get("GPOSITION");
		}
	}
	
%>
<script type="text/javascript">
	function goDel(index) {
		if (confirm("�����Ͻðڽ��ϱ�?")) {
			pbform.cIndex.value = index;
			pbform.action = "admin_upright_del_proc.jsp";
			pbform.submit();
		}
			else {
			alert("��ҵǾ����ϴ�!");
		}
	}
	
	function DownloadPopup(index) {
		pbform.cIndex.value = index;
		var wint = (screen.height - 245) / 2;
		var winl = (screen.width - 300) / 2;
		winprops = 'height=245,width=300,top=' + wint + ',left=' + winl	+ ',status=no,scrollbars=no,resize=no'
		winurl = 'include/upright_file_popup.jsp?index=' + index;
		win = window.open(winurl, "file_popup1", winprops)
	}
	
</script>


<form method=post name="pbform" action="">
	<input type="hidden" name="cmd" value="">
	<input type="hidden" name="cIndex" value="">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="95" bgcolor="f4f4f4" style="padding-left: 25;">
				<table width="945" border="0" cellspacing="0" cellpadding="0" background="img/title_bg.gif">
					<tbody>
						<tr>
							<td width="135">
								<table width="135" border="0" cellspacing="0" cellpadding="0">
									<tbody><tr>
										<td height="70" align="center" class="admin_subject">û�ż����λ�</td>
									</tr>
								</tbody></table>
							</td>
							<td width="5"></td>
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tbody><tr>
										<td height="60" class="adminsub_subject" style="padding-left: 25;">û�ż����λ��Դϴ�</td>
									</tr>
								</tbody></table>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</table>
	
	<table width="945" border="0" cellspacing="0" cellpadding="0" class="table_outline">
		<tbody>
			<tr>
				<td style="padding: 5 5 5 5;">
					<table cellpadding="0" cellspacing="0" border="0">
						<tbody>
							<tr>
								<td height="5"></td>
							</tr>
							<tr height="30">
								<td align="center" class="board_bg_title" valign="top" width="530">
									<table width="100%" border="0" cellspacing="0" cellpadding="0" class="read_outline left">
										<colgroup>
											<col style="width:20%;">
											<col style="width:80%;">
										</colgroup>
										<tbody>
											<tr>
												<th>��ȣ</th>
												<td><%=indx %></td>
											</tr>	
											<tr>
												<th>��õ����</th>
												<td class="le_tit">
													<div class="le_tit_scroll">	
														<%=gComent %>
													</div>
												</td>
											</tr>	
										</tbody>
									</table>
								</td>
								<td align="center" class="board_bg_title" valign="top" width="5"></td>
								<td class="board_bg_title" width="410" valign="top" align="right">
									<table width="100%" border="0" cellspacing="0" cellpadding="0" class="read_outline left">
										<colgroup>
											<col style="width:33.33%;">
											<col style="width:33.33%;">
											<col style="width:33.33%;">
										</colgroup>
										<tbody>
											<tr>
												<th>÷������</th>
												<% if(gFileName != null) { %>
													<td colspan="2">
														<a href="javascript:DownloadPopup('<%=index%>');">
													<img src="/pub_img/icon_file01.gif" alt="����÷��" /><%=gFileName%>
												</a>
													</td>
												<% } else { %>
													<td colspan="2"></td>
												<% } %>
												
											</tr>	
											<tr>
												<th>��������</th>
												<td  colspan="2"><%=ins_date %></td>
											</tr>	
											<tr>
									            <td scope="row" rowspan="3" class="bg_le">��õ�ϴ� ���</td>
									            <td scope="row"  colspan="2">����:<%=cMemNm %></td>
									        </tr>
									        <tr>
									        	<td scope="row"  colspan="2">��õ�� ����:<%=cGubun %></td>
									        </tr>
									        <tr>
									        	<td scope="row"  colspan="2">��ȭ(�޴���)��ȣ:<%=cMobileNum %></td>
									        </tr>
									        <tr>
									            <td scope="row" rowspan="3" class="bg_le">��õ�޴� ���</td>
									            <td scope="row">���� :<%=gMemNm %></td>
									            <td scope="row">���� :<%=gGender %></td>
									        </tr>
									        <tr>
									        	<td scope="row"  colspan="2">���ո� :<%=gJohap %></td>
									        </tr>
									        <tr>
									        	<td scope="row">����: <%=gRank %></td>
									        	<td scope="row">����: <%=gPosition %></td>
									        </tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
		<td align="right">
			<a href="javascript:goDel('<%=indx%>');">
				<img src="img/btn_delete.gif" width="55" height="21" border="0" alt="����">
			</a>
		</td>
	</table>
	
	
</form>