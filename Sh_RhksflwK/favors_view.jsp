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

	//신청자 정보
	String sg_publication = "";
	String sg_name = "";
	String sg_tel = "";
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

			type = (("1".equals((String) h.get("TYPE"))) ? "자진신고용" : "제3자신고용");
			type1 = (String) h.get("TYPE");

			System.out.println("type1 = " + type1);

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

	TableName = " sh_chungtak_history ";
	SelectCondition = " sh_no, sh_chungtak_no, sh_buseo_from, sh_buseo_to, sh_status,";
	SelectCondition += "to_char(sh_indate, 'YYYY-MM-DD') AS sh_indate ";
	WhereCondition = " where sh_chungtak_no=" + thididx;
	OrderCondition = " order by sh_no asc";

	java.util.Date date = new java.util.Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	//읽는 사람이 감사실 소속일 접수,다른 부서일 경우 처리중
	//총관리자가 아닐경우, 코드가 답변완료,이첩,반송이 아닐경우,답변을 안단 경우
	if (!favors_buseo.equals("all") && text1.equals("") && code.equals("신청")) {
		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;

		try {
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
			conn = ds.getConnection();

			String sql = "";
			if (favors_buseo.equals("감사실") || favors_buseo.equals("감사부")) {
				sql = "update sh_chungtak set code='접수' where thid=?";
			} else {
				sql = "update sh_chungtak set code='처리중' where thid=?";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, thididx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("[ERROR] 오류사항 확인필요");
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null)
				conn.close();
		}
	}
%>
<!--/********************************************위너다임 작업 시작 2008.03.13****************************************************/-->
<!-- <SCRIPT SRC="http://www.suhyup.co.kr/supervisor/js/ax_wdigm/default.js"></SCRIPT> -->
<!--/********************************************위너다임 작업 끝 2008.03.13******************************************************/-->
<script language="javascript">
	function goReply(thid){
		var mText  = document.pbform.text1.value;
		if(!pbform.text1.value){
			alert("내용을 등록해 주세요");
			pbform.text1.focus();
			return;
		}

		var isstr = confirm("답변을 하시겠습니까?");
		if(isstr){

			/********************************************위너다임 작업 시작 2008.03.13****************************************************
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
			********************************************위너다임 작업 끝 2008.03.13******************************************************/

			pbform.action="favors_view_ok.jsp";
			pbform.submit();
		}
	}
	function send(){
		if(!pbform.buseo.value){
			alert("이첩할 부서를 선택해주세요");
			pbform.buseo.focus();
			return;
		}
		if(confirm("이첩하시겠습니까?")){
			pbform.action="favors_send_ok.jsp";
			pbform.submit();
		}
	}
	function receive(){
		if(confirm("반송하시겠습니까?")){
			pbform.action="favors_receive_ok.jsp";
			pbform.submit();
		}
	}
</script>
<!-- 금융사고 제보 설명 -->
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
									<td height="70" align="center" class="admin_subject">청탁금지법
										위반 신고 제보</td>
								</tr>
							</table>
						</td>
						<td width="5"></td>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="60" class="adminsub_subject"
										style="padding-left: 25;">청탁금지법 내용 필요함</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- // 금융사고 제보 설명 -->
	<br>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td style="padding: 0 0 10 10;">
				<!-- 검색결과 -->
				<table width="965" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30"><img src="img/result.gif" align="absmiddle">
							청탁금지법 위반 신고 제보 <span class="result_text">상세보기</span></td>
						<td height="30" align="right" width="60"><a href="#"><img
								src="img/btn_print.gif" width="55" height="21"
								onClick="MM_openBrWindow('favors_print2.jsp?thididx=<%=thididx%>','','width=638,height=750')"
								border="0" alt="출력"></a></td>
						<td height="30" align="right" width="60"><a
							href="favors.jsp?PAGE=<%=PAGE%>"><img src="img/btn_list.gif"
								width="55" height="21" border="0" alt="목록"></a></td>
					</tr>
					<tr>
						<td height="2" class="result_line" colspan="3"></td>
					</tr>
				</table> <!-- // 검색결과 -->
			</td>
		</tr>
		<!-- 금융사고 제보 뷰페이지-->


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
												<td style="padding-left: 10;">번호 : <%=thid%></td>
												<td align="right" style="padding-right: 10;">처리상태 : <%=code%></td>
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


												<!-- 신고형식 -->
												<tr>
													<td align="center" height="30" class="table_bg_title">신고형식</td>
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
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">형식</th>
																<td style="text-align: left; padding-left: 10px;"><%=type%></td>
															</tr>
														</table>

													</td>
												</tr>
												<!-- //신고형식 -->


												<!-- 부정청탁을 한 자 또는 금품등을 제공한 자& 피신고자(신고대상 필수) -->
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
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">이름</th>
																<td style="text-align: left; padding-left: 10px;"><%=ct_name%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">직업</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_job%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">연락처</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_tel%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">주소</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_zip%>&nbsp;<%=ct_addr1%>
																	<%=ct_addr2%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">청탁자법인명칭</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_corp%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">청탁자법인소재지</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_corpaddr%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">청탁자법인대표성명</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_corpname%></td>
															</tr>
														</table>

													</td>
												</tr>
												<!-- //부정청탁을 한 자 또는 금품등을 제공한 자 -->

												<%
													if ("2".equals(type1)) {
												%>

												<!-- 피신고자(신고대상 선택) -->
												<tr>
													<td align="center" height="30" class="table_bg_title">피신고자(신고대상
														선택)</td>
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
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">이름</th>
																<td style="text-align: left; padding-left: 10px;"><%=ct_name_c%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">직업</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_job_c%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">연락처</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_tel_c%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">주소</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_zip_c%>&nbsp;<%=ct_addr1_c%>
																	<%=ct_addr2_c%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">청탁자법인명칭</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=ct_corp_c%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">청탁자법인소재지</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=ct_corpaddr_c%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">청탁자법인대표성명</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=ct_corpname_c%></td>
															</tr>
														</table>

													</td>
												</tr>
												<!-- //피신고자(신고대상 선택) -->
												<%
													}
												%>

												<!-- 부정청탁 또는 금품등 수수 내용 -->
												<tr>
													<td align="center" height="30" class="table_bg_title">부정청탁
														또는 금품등 수수 내용</td>
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
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">청탁일시</th>
																<td style="text-align: left; padding-left: 10px;"><%=ct_date%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">청탁장소</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=ct_place%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">청탁내용</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=ct_content%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">청탁신고이유</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=ct_reason%></td>
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
													<td align="center" height="30" class="table_bg_title">금품등
														반환여부 및 방법(금품등 수수의 경우)</td>
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
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">금품반환여부</th>
																<td style="text-align: left; padding-left: 10px;"><%=bh_yn%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">금품반환장소</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=bh_place%></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3">비고</th>
																<td
																	style="text-align: left; padding-left: 10px; word-break: break-all;"><%=etc%></td>
															</tr>
														</table>
													</td>
												</tr>
												<!-- //금품등 반환여부 및 방법(금품등 수수의 경우) -->
												<%
													}
												%>

											</table>
										</div>
									</td>
									<td align="center" valign="top" width="5"></td>
									<td class="board_bg_title" width="295" valign="top"
										align="right">
										<!-- 금융사고 제보정보 -->
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="read_outline" height="100%">
											<tr>
												<td height="30" style="padding-left: 10;"
													class="table_bg_title">청탁금지법 위반 제보 접수정보</td>
											</tr>
											<tr>
												<td valign="top">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">특수코드</td>
															<td><%=sg_publication%></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">신청일</td>
															<td><%=time1%></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">민원인</td>
															<td><%=sg_name%> <a href="#"
																onClick="MM_openBrWindow('favors_popup.jsp?thididx=<%=thididx%>','','width=500,height=290')">[<u>상세정보
																		보기</u>]
															</a></td>
														</tr>
														<%
															if ("철회완료".equals(code)) {
														%>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">철회일자</td>
															<td><%=abandon_date%></td>
														</tr>
														<%
															}
														%>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">담당부서</td>
															<!-- 글 내용중에 부서권한은 감사실,준법감시팀,기타 로 나누어 진다-->
															<!-- 글내용이 감사실일 경우 , 감사실 권한만이 볼수 있는것-->
															<%
																if (buseo.equals("감사실") || buseo.equals("감사부")) {
															%>
															<td>
																<!-- 글내용이 감사실이면서 로그인한 사용자가 감사실인 사람,답변내용이 없는 경우 이첩 기능-->
																<%
																	if ((favors_buseo.equals("감사실") || favors_buseo.equals("감사부")) && text1.equals("")
																				&& !code.equals("철회완료")) {
																%> 
																<select name="buseo">
																	<option value="">선택</option>
																	<option value="감사실">감사실</option>
																	<option value="감사부">감사부</option>
																	<option value="준법감시실">준법감시실</option>
																	<option value="ICT전략실">ICT전략실</option>
																	<option value="인사총무부">인사총무부</option>
																	<option value="마케팅부">마케팅부</option>
																	<option value="공제보험부">공제보험부</option>
																	<option value="전략기획부">전략기획부</option>
																	<option value="기획부">기획부</option>
																	<option value="노량진시장 현대화사업본부">노량진시장 현대화사업본부</option>
																	<option value="단체급식사업단">단체급식사업단</option>
																	<option value="리스크관리본부">리스크관리본부</option>
																	<option value="방카펀드사업부(방카)">방카펀드사업부(방카)</option>
																	<option value="상호금융부">상호금융부</option>
																	<option value="수산경제연구원">수산경제연구원</option>
																	<option value="수산금융부">수산금융부</option>
																	<option value="식품사업부">식품사업부</option>
																	<option value="신탁사업본부">신탁사업본부</option>
																	<option value="심사부">심사부</option>
																	<!-- <option value="안전관리실">안전관리실</option> -->
																	<option value="어업정보통신본부">어업정보통신본부</option>
																	<option value="여신관리부">여신관리부</option>
																	<option value="연수원">연수원</option>
																	<option value="외환사업팀">외환사업팀</option>
																	<option value="경제기획부">경제기획부</option>
																	<option value="이사회사무국">이사회사무국</option>
																	<option value="자금부">자금부</option>
																	<option value="자재사업부">자재사업부</option>
																	<option value="전산정보부">전산정보부</option>
																	<option value="정보보호본부">정보보호본부</option>
																	<option value="조합감사실">조합감사실</option>
																	<option value="리스크관리실">리스크관리실</option>
																	<option value="자금운용부">자금운용부</option>
																	<!-- <option value="준법감시팀">준법감시팀</option> -->
																	<option value="직판사업단">직판사업단</option>
																	<option value="총무부">총무부</option>
																	<option value="카드사업부">카드사업부</option>
																	<option value="펀드사업팀">펀드사업팀</option>
																	<!-- <option value="해양투자금융센터">해양투자금융센터</option> -->
																	<option value="홍보실">홍보실</option>
																	<option value="회원지원부">회원지원부</option>
																	<!-- <option value="사업구조개편단">사업구조개편단</option> -->
																	<option value="기업금융부">기업금융부</option>
																	<option value="여신정책부">여신정책부</option>
																	<option value="정책보험부">정책보험부</option>
																	<option value="금융소비자보호부">금융소비자보호부</option>
																	<option value="준법감시실(중앙회)">준법감시실(중앙회)</option>
																	<option value="준법감시실(조합)">준법감시실(조합)</option>
																	<option value="여신관리센터" >여신관리센터</option>
																	<option value="정보보호단" >정보보호단</option>
																	
																	<option value="IB사업본부">IB사업본부</option>
																	<option value="IT지원부">IT지원부</option>
																	<option value="경남지역본부">경남지역본부</option>
																	<option value="경영전략실">경영전략실</option>
																	<option value="디지털마케팅부">디지털마케팅부</option>
																	<option value="디지털전략부">디지털전략부</option>
																	<option value="무역사업단">무역사업단</option>
																	<option value="어촌지원부">어촌지원부</option>
																	<option value="유통사업부">유통사업부</option>
																	<option value="전남지역본부">전남지역본부</option>
																	<option value="준법감시실">준법감시실</option>
																	<option value="지속경영추진부">지속경영추진부</option>
																</select> 
																<a href="javascript:send();">
																	<img src="img/btn_transfer.gif" align="absmiddle" alt="이첩" border="0">
																</a> <!-- 글내용이 감사실이면서 로그인한 사용자가 감사실인 사람,답변내용이 있는 경우 소관부서 이름이 나타남-->
																<%
																	} else {
																%> <%=buseo%> <%
 	}
 %>
															</td>
															<!-- 글내용이 준법감시팀 경우,감사실 또는 준법감시팀권한만이 볼수있는것 -->
															<%
																} else if (buseo.equals("금융소비자보호부")) {
															%>
															<td>
																<!-- 글내용이 준법감시팀이면서 로그인한 사용자가 준법감시팀인 경우,답변내용이 없는 경우 감사실로 반송및 타부서로 이첩가능 -->
																<%
																	if (favors_buseo.equals("금융소비자보호부") && text1.equals("") && !code.equals("철회완료")) {
																%> <select name="buseo">
																	<option value="">선택</option>
																	<option value="감사실">감사실</option>
																	<option value="감사부">감사부</option>
																	<option value="준법감시실">준법감시실</option>
																	<option value="ICT전략실">ICT전략실</option>
																	<option value="인사총무부">인사총무부</option>
																	<option value="마케팅부">마케팅부</option>
																	<option value="공제보험부">공제보험부</option>
																	<option value="전략기획부">전략기획부</option>
																	<option value="기획부">기획부</option>
																	<option value="노량진시장 현대화사업본부">노량진시장 현대화사업본부</option>
																	<option value="단체급식사업단">단체급식사업단</option>
																	<option value="리스크관리본부">리스크관리본부</option>
																	<option value="방카펀드사업부(방카)">방카펀드사업부(방카)</option>
																	<option value="상호금융부">상호금융부</option>
																	<option value="수산경제연구원">수산경제연구원</option>
																	<option value="수산금융부">수산금융부</option>
																	<option value="식품사업부">식품사업부</option>
																	<option value="신탁사업본부">신탁사업본부</option>
																	<option value="심사부">심사부</option>
																	<!-- <option value="안전관리실">안전관리실</option> -->
																	<option value="어업정보통신본부">어업정보통신본부</option>
																	<option value="여신관리부">여신관리부</option>
																	<option value="연수원">연수원</option>
																	<option value="외환사업팀">외환사업팀</option>
																	<option value="경제기획부">경제기획부</option>
																	<option value="이사회사무국">이사회사무국</option>
																	<option value="자금부">자금부</option>
																	<option value="자재사업부">자재사업부</option>
																	<option value="전산정보부">전산정보부</option>
																	<option value="정보보호본부">정보보호본부</option>
																	<option value="조합감사실">조합감사실</option>
																	<option value="리스크관리실">리스크관리실</option>
																	<option value="자금운용부">자금운용부</option>
																	<!-- <option value="준법감시팀">준법감시팀</option> -->
																	<option value="직판사업단">직판사업단</option>
																	<option value="총무부">총무부</option>
																	<option value="카드사업부">카드사업부</option>
																	<option value="펀드사업팀">펀드사업팀</option>
																	<!-- <option value="해양투자금융센터">해양투자금융센터</option> -->
																	<option value="홍보실">홍보실</option>
																	<option value="회원지원부">회원지원부</option>
																	<!-- <option value="사업구조개편단">사업구조개편단</option> -->
																	<option value="기업금융부">기업금융부</option>
																	<option value="여신정책부">여신정책부</option>
																	<option value="정책보험부">정책보험부</option>
																	<option value="금융소비자보호부">금융소비자보호부</option>
																	<option value="준법감시실(중앙회)">준법감시실(중앙회)</option>
																	<option value="준법감시실(조합)">준법감시실(조합)</option>
																	<option value="여신관리센터" >여신관리센터</option>
																	<option value="정보보호단" >정보보호단</option>
																	
																	<option value="IB사업본부">IB사업본부</option>
																	<option value="IT지원부">IT지원부</option>
																	<option value="경남지역본부">경남지역본부</option>
																	<option value="경영전략실">경영전략실</option>
																	<option value="디지털마케팅부">디지털마케팅부</option>
																	<option value="디지털전략부">디지털전략부</option>
																	<option value="무역사업단">무역사업단</option>
																	<option value="어촌지원부">어촌지원부</option>
																	<option value="유통사업부">유통사업부</option>
																	<option value="전남지역본부">전남지역본부</option>
																	<option value="준법감시실">준법감시실</option>
																	<option value="지속경영추진부">지속경영추진부</option>
															</select> 
															<a href="javascript:send();">
																<img src="img/btn_transfer.gif" align="absmiddle" alt="이첩" border="0"></a>
																
																<br> <br> 감사실로 <a href="javascript:receive();">
																<img src="img/btn_sendback.gif" align="absmiddle" border="0" alt="반송"></a> 
																<input type="hidden" name="buseo_to"
																value="<%="감사실"%>"> <!-- 글내용이 준법감시팀이면서 로그인한 사용자가 준법감사실 또는 감사실일 경우,답변내용이 있는 경우 소관부서 이름이 나타남 -->
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
															<!-- 글내용이 감사실,준법감사실이 아닌 경우,감사실,준법감시팀,동일한 부서만이 볼수있는것 -->
															<%
																} else {
															%>
															<!-- 로그인한 사람이 준법감시팀 경우 소관부서 이름이 나타남-->
															<%
																if (favors_buseo.equals("금융소비자보호부")) {
															%>
															<td><%=buseo%></td>
															<!-- 로그인한 사람이 감사실일 경우 소관부서 이름이 나타남-->
															<%
																} else if (favors_buseo.equals("감사실") || favors_buseo.equals("감사부")) {
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
															<!-- 로그인한 사람이 일반부서일 경우 반송기능-->
															<%
																} else {
															%>
															<!-- 답변을 안단 경우-->
															<%
																if (text1.equals("")) {
															%>
															<!-- 글내용이 준법감시팀 속한 경우-->
															<%
																if (junbuseo.equals("Y")) {
															%>
															<td>금융소비자보호단으로 
																<a href="javascript:receive();">
																	<img src="img/btn_sendback.gif" align="absmiddle" border="0" alt="반송">
																</a>
															</td>
															<input type="hidden" name="buseo_to" value="<%="금융소비자보호부"%>">
															<!-- 글내용이 감사실에 속한 경우-->
															<%
																} else {
															%>
															<td>감사실로 <a href="javascript:receive();"><img
																	src="img/btn_sendback.gif" align="absmiddle" border="0"
																	alt="반송"></a></td>
															<input type="hidden" name="buseo_to" value="<%="감사실"%>">
															<%
																}
															%>
															<!-- 답변을 단 경우-->
															<%
																} else {
															%>
															<!-- 글내용이 준법감시팀 속한 경우-->
															<%
																if (junbuseo.equals("Y")) {
															%>
															<td><%=buseo%></td>
															<!-- 글내용이 감사실에 속한 경우-->
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
																//20080617 수정 끝
															%>
														</tr>

														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
													</table>
												</td>
											</tr>
										</table> <!-- // 금융사고 제보 정보-->
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table> <br> <!-- // 금융사고 제보 뷰페이지--> <!-- 금융사고 제보 리플달기 쓰기폼-->
				<table width="945" border="0" cellspacing="0" cellpadding="0"
					class="table_outline">
					<tr>
						<td width="130" height="35" align="center" class="table_bg_title">작성자</td>
						<td style="padding-left: 25;" class="bluesky" width="540"><%=(String) session.getAttribute("name")%></td>
						<td class="table_bg_title" width="110" align="center">작성일</td>
						<td style="padding-left: 25;" width="165" class="bluesky"><%=sdf.format(date)%></td>
					</tr>
					<tr>
						<td colspan="4" height="1" bgcolor="ffffff"></td>
					</tr>
					<tr>
						<td width="130" height="35" align="center" class="table_bg_title">내용등록</td>
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
								if (favors_buseo.equals("감사실") || favors_buseo.equals("감사부")) {
							%> <a href="javascript:goReply(<%=thididx%>);"><img
								src="img/btn_reply.gif" width="55" height="21" alt="답변"
								border="0"></a> <%
 	} else if (favors_buseo.equals(buseo) && !code.equals("철회완료")) {
 %> <a href="javascript:goReply(<%=thididx%>);"><img
								src="img/btn_reply.gif" width="55" height="21" alt="답변"
								border="0"></a> <%
 	}
 %>
						</td>
					</tr>
				</table> <br> <!-- // 금융사고 제보 리플달기 쓰기폼-->
			</td>
		</tr>
	</table>
	<!--부서간 이첩내역이력관리 리스트 -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td style="padding-left: 25;"><img src="img/arrow.gif"
				width="13" height="16" align="absmiddle"> <span
				class="txt_title">부서간 이첩내역 이력관리</span></td>
		</tr>
		<tr>
			<td style="padding: 10 0 0 25;">
				<table width="945" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="10" height="2" class="board_topline"></td>
					</tr>
					<tr height="30">
						<td class="board_bg_title" width="70" align="center">NO</td>
						<td class="board_bg_title" align="center">~에서</td>
						<td class="board_bg_title" align="center">~로</td>
						<td class="board_bg_title" align="center">이첩일자</td>
						<td class="board_bg_title" align="center">처리상태</td>
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
						<td colspan="5" align="center">등록된 자료가 없습니다</td>
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
