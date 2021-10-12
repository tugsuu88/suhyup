<%@ page import="java.util.*, util.*,java.text.SimpleDateFormat"%>


<%@ page contentType="text/html;charset=euc-kr"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	response.setContentType("text/html; charset=euc-kr");
%>


<jsp:useBean id="FrontBoard" scope="session"
	class="Bean.Front.Common.FrontBoradType1" />

<%
	String mid = request.getParameter("thididx");
	if (mid == null)
		mid = "0";
	int sh_mid = Integer.parseInt(mid);
	String PAGE = request.getParameter("PAGE");

	System.out.println("mid = " + mid);
	System.out.println("sh_mid = " + sh_mid);
	System.out.println("PAGE = " + PAGE);

	//out.println(sh_mid);

	// 	String TableName = " sh_chungtak ";
	// 	String SelectCondition = " sg_name, title, sg_publication, sg_addr1, sg_addr2, sg_tel, code, buseo, result, ct_content, ";
	// 		   SelectCondition += " to_char(time1, 'YYYY-MM-DD') AS time1, text1 ";
	// 	String WhereCondition = " where thid=" + sh_mid;
	// 	String OrderCondition = "";

	String TableName = " sh_chungtak ";
	String SelectCondition = "sg_publication, sg_name, sg_tel, sg_addr1, sg_addr2, ";
	SelectCondition += "ct_name, ct_job, ct_tel, ct_job, ct_zip, ct_addr1, ct_addr2, ct_corp, ct_corpaddr, ct_corpname, ";
	SelectCondition += "ct_name_c, ct_job_c, ct_tel_c, ct_job_c, ct_zip_c, ct_addr1_c, ct_addr2_c, ct_corp_c, ct_corpaddr_c, ct_corpname_c, ";
	SelectCondition += "ct_date, ct_place, ct_content, ct_reason, bh_yn, bh_place, etc, regdate, ";
	SelectCondition += "code, type, title, buseo, text1, result, junbuseo, ";
	SelectCondition += "to_char(time1, 'YYYY-MM-DD') AS time1, ";
	SelectCondition += "to_char(time2, 'YYYY-MM-DD') AS time2, to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date ";
	String WhereCondition = " where thid=" + sh_mid;
	String OrderCondition = "";

	Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 0, 0);

	//신청자 정보
	String sg_publication = "";
	String sg_name = "";
	String sg_tel = "";
	String sg_addr1 = "";
	String sg_addr2 = "";
	String address = "";
	//청탁자 정보(필수)
	String ct_name = "";
	String ct_job = "";
	String ct_tel = "";
	String ct_zip = "";
	String ct_addr1 = "";
	String ct_addr2 = "";
	String ct_corp = "";
	String ct_corpaddr = "";
	String ct_corpname = "";
	//청탁자 정보(선택)
	String ct_name_c = "";
	String ct_job_c = "";
	String ct_tel_c = "";
	String ct_zip_c = "";
	String ct_addr1_c = "";
	String ct_addr2_c = "";
	String ct_corp_c = "";
	String ct_corpaddr_c = "";
	String ct_corpname_c = "";
	//부정청탁 또는 금품등 수수 내용
	String ct_date = "";
	String ct_place = "";
	String ct_content = "";
	String ct_reason = "";
	//금품등 반환여부 및 방법(금품등 수수의 경우)
	String bh_yn = "";
	String bh_place = "";
	String etc = "";

	String type = "";
	String type1 = "";

	String code = "";
	String title = "";
	String buseo = "";
	String text1 = "";
	String result = "";
	String junbuseo = "";
	String time1 = "";
	String time2 = "";
	String abandon_date = "";

	String titleTxt = "";

	if (ResultVector.size() > 0) {
		for (int i = 0; i < ResultVector.size(); i++) {
			Hashtable h = (Hashtable) ResultVector.elementAt(i);

			type = (("1".equals((String) h.get("TYPE"))) ? "자진신고용" : "제3자신고용");
			type1 = (String) h.get("TYPE");

			if ("1".equals(type1)) {
				titleTxt = "부정청탁을한 자 또는 금품등을 제공한 자";
			} else {
				titleTxt = "피신고자(신고대상 필수)";
			}

			code = (String) h.get("CODE");
			title = (String) h.get("TITLE");

			sg_publication = (String) h.get("SG_PUBLICATION");
			sg_name = (String) h.get("SG_NAME");
			sg_tel = (String) h.get("SG_TEL");
			sg_addr1 = (String) h.get("SG_ADDR1");
			sg_addr2 = (String) h.get("SG_ADDR2");
			address = sg_addr1 + "&nbsp;" + sg_addr2;

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

			bh_yn = (("Y".equals((String) h.get("BH_YN"))) ? "반환" : "미반환");

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
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<LINK href="img/style.css" type=text/css rel=stylesheet>
<script language="javascript">
<!--
	function GoPt() {
		window.print();

	}
//-->
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0"
	scroll=yes>
	<table width="620" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td background="img/popup_print_top.gif" height="80"
				style="padding: 48 0 0 26" valign="top">
				<table width="576" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="white"><%=title%></td>
						<td align="right" width="55"><a href="javascript:GoPt();"><img
								src="img/btn_print.gif" align="absmiddle" alt="출력" border="0"></td>
					</tr>
				</table>
			</td>
		</tr>

		<tr>
			<td background="img/popup_print_bg.gif" align="center">
				<table width="592" border="0" cellspacing="0" cellpadding="0">

					<!-- 신고형식 -->
					<tr>
						<td height="8"></td>
					</tr>
					<tr>
						<td>
							<table width="592" border="0" cellspacing="0" cellpadding="0"
								class="read_outline">
								<tr>
									<td height="30" style="padding-left: 10;"
										class="table_bg_title">신고형식</td>
								</tr>
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="read_outline">
											<colgroup>
												<col style="width: 20%" />
												<col style="width: *" />
											</colgroup>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">형식</th>
												<td style="text-align: left; padding-left: 10px;"><%=type%></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- //신고형식 -->

					<!-- 민원접수정보 테이블 시작-->
					<tr>
						<td height="8"></td>
					</tr>
					<tr>
						<td height="30" style="padding-left: 10;" class="table_bg_title">민원접수정보</td>
					</tr>
					<tr>
						<td valign="top">
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								class="read_outline">
								<tr align="center">
									<th height="30" class="bluesky" width="90">민원인</th>
									<th width="1" bgcolor="d9e8f3"></th>
									<th width="90" class="bluesky">신청일</th>
									<th width="1" bgcolor="d9e8f3"></th>
									<th width="90" class="bluesky">특수코드</th>
									<th width="1" bgcolor="d9e8f3"></th>
									<th width="90" class="bluesky">담당부서</th>
									<th width="1" bgcolor="d9e8f3"></th>
									<th width="90" class="bluesky">처리상태</th>
<!-- 									<th width="1" bgcolor="d9e8f3"></th> -->
<!-- 									<th width="100" class="bluesky">처리결과</th> -->
								</tr>
								<tr>
									<td colspan="15" height="1" bgcolor="#d9e8f3"></td>
								</tr>
								<tr align="center">
									<td height="30"><%=sg_name%></td>
									<td width="1" bgcolor="d9e8f3"></td>
									<td><%=time1%></td>
									<td width="1" bgcolor="d9e8f3"></td>
									<td><%=sg_publication%></td>
									<td width="1" bgcolor="d9e8f3"></td>
									<td><%=buseo%></td>
									<td width="1" bgcolor="d9e8f3"></td>
									<td><%=code%></td>
<!-- 									<td width="1" bgcolor="d9e8f3"></td> -->
<%-- 									<td><%=result%></td> --%>
								</tr>
							</table>
						</td>
					</tr>
					<!--  민원접수정보 테이블 끝-->

					<!-- 민원인 상세정보 -->
					<tr>
						<td height="8"></td>
					</tr>
					<tr>
						<td>
							<table width="592" border="0" cellspacing="0" cellpadding="0"
								class="read_outline">
								<tr>
									<td height="30" style="padding-left: 10;"
										class="table_bg_title">민원인 상세정보</td>
								</tr>
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="read_outline">
											<colgroup>
												<col style="width: 20%" />
												<col style="width: *" />
											</colgroup>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">이름</th>
												<td style="text-align: left; padding-left: 10px;"><%=ct_name%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">주소</th>
												<td style="text-align: left; padding-left: 10px"><%=address%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">연락처</th>
												<td style="text-align: left; padding-left: 10px"><%=sg_tel%></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- //민원인 상세정보 -->

					<!-- 부정청탁을 한 자 또는 금품등을 제공한 자& 피신고자(신고대상 필수) -->
					<tr>
						<td height="8"></td>
					</tr>
					<tr>
						<td>
							<table width="592" border="0" cellspacing="0" cellpadding="0"
								class="read_outline">
								<tr>
									<td height="30" style="padding-left: 10;"
										class="table_bg_title"><%=titleTxt%></td>
								</tr>
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="read_outline">
											<colgroup>
												<col style="width: 20%" />
												<col style="width: *" />
											</colgroup>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">이름</th>
												<td style="text-align: left; padding-left: 10px;"><%=ct_name%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">직업</th>
												<td style="text-align: left; padding-left: 10px"><%=ct_job%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">연락처</th>
												<td style="text-align: left; padding-left: 10px"><%=ct_tel%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">주소</th>
												<td style="text-align: left; padding-left: 10px">[&nbsp;<%=ct_zip%>&nbsp;]&nbsp;<%=ct_addr1%>&nbsp;<%=ct_addr2%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁자법인명칭</th>
												<td style="text-align: left; padding-left: 10px"><%=ct_corp%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁자법인소재지</th>
												<td style="text-align: left; padding-left: 10px"><%=ct_corpaddr%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁자법인대표성명</th>
												<td style="text-align: left; padding-left: 10px"><%=ct_corpname%></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- 부정청탁을 한 자 또는 금품등을 제공한 자(필수) -->

					<%
						if ("2".equals(type1)) {
					%>
					<!-- 피신고자(신고대상 선택) -->
					<tr>
						<td height="8"></td>
					</tr>
					<tr>
						<td>
							<table width="592" border="0" cellspacing="0" cellpadding="0"
								class="read_outline">
								<tr>
									<td height="30" style="padding-left: 10;"
										class="table_bg_title">피신고자(신고대상 선택)</td>
								</tr>
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="read_outline">
											<colgroup>
												<col style="width: 20%" />
												<col style="width: *" />
											</colgroup>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">이름</th>
												<td style="text-align: left; padding-left: 10px;"><%=ct_name_c%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">직업</th>
												<td style="text-align: left; padding-left: 10px"><%=ct_job_c%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">연락처</th>
												<td style="text-align: left; padding-left: 10px"><%=ct_tel_c%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">주소</th>
												<td style="text-align: left; padding-left: 10px">[&nbsp;<%=ct_zip_c%>&nbsp;]&nbsp;<%=ct_addr1_c%>&nbsp;<%=ct_addr2_c%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁자법인명칭</th>
												<td style="text-align: left; padding-left: 10px"><%=ct_corp_c%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁자법인소재지</th>
												<td style="text-align: left; padding-left: 10px"><%=ct_corpaddr_c%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁자법인대표성명</th>
												<td style="text-align: left; padding-left: 10px"><%=ct_corpname_c%></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- 피신고자(신고대상 선택) -->
					<%
						}
					%>

					<!-- 부정청탁 또는 금품등 수수 내용 -->
					<tr>
						<td height="8"></td>
					</tr>
					<tr>
						<td>
							<table width="592" border="0" cellspacing="0" cellpadding="0"
								class="read_outline">
								<tr>
									<td height="30" style="padding-left: 10;"
										class="table_bg_title">부정청탁 또는 금품등 수수 내용</td>
								</tr>
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="read_outline">
											<colgroup>
												<col style="width: 20%" />
												<col style="width: *" />
											</colgroup>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">청탁일시</th>
												<td style="text-align: left; padding-left: 10px;"><%=ct_date%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁장소</th>
												<td style="text-align: left; padding-left: 10px"><%=ct_place%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁내용</th>
												<td style="text-align: left; padding-left: 10px"><%=ct_content%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁신고이유</th>
												<td style="text-align: left; padding-left: 10px"><%=ct_reason%></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- //부정청탁 또는 금품등 수수 내용 -->

					<%
						if ("1".equals(type1)) {
					%>
					<!-- 금품등 반환여부 및 방법(금품등 수수의 경우) -->
					<tr>
						<td height="8"></td>
					</tr>
					<tr>
						<td>
							<table width="592" border="0" cellspacing="0" cellpadding="0"
								class="read_outline">
								<tr>
									<td height="30" style="padding-left: 10;"
										class="table_bg_title">금품등 반환여부 및 방법(금품등 수수의 경우)</td>
								</tr>
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="read_outline">
											<colgroup>
												<col style="width: 20%" />
												<col style="width: *" />
											</colgroup>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">금품반환여부</th>
												<td style="text-align: left; padding-left: 10px;"><%=bh_yn%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">금품반환장소</th>
												<td style="text-align: left; padding-left: 10px"><%=bh_place%></td>
											</tr>
											<tr>
												<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
											</tr>
											<tr>
												<th class="bluesky"
													style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">비고</th>
												<td style="text-align: left; padding-left: 10px"><%=etc%></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- //금품등 반환여부 및 방법(금품등 수수의 경우) -->
					<%
						}
					%>

				</table>
			</td>
		</tr>

		<tr>
			<td><img src="img/popup_print_bottom.gif" width="620"
				height="20"></td>
		</tr>
		<tr>
			<td bgcolor="e5e5e5" align="center" height="40"><img
				src="img/popup_close.gif" width="67" height="18"
				onClick="javascript:window.close();" style="cursor: hand" alt="닫기"></td>
		</tr>
	</table>
</body>
</html>
