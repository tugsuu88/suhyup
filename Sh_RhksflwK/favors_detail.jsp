<%@ page import="java.util.*, util.*,java.text.SimpleDateFormat"
	contentType="text/html;charset=euc-kr"%>

<%@ include file="include/admin_session.jsp"%>
<%@ include file="include/logincheck.jsp"%>
<%@ include file="include/top_login.jsp"%>
<%@ include file="include/top_menu11.jsp"%>

<jsp:useBean id="FrontBoard" scope="session"
	class="Bean.Front.Common.FrontBoradType1" />

<%
	String thid = Converter.nullchk(request.getParameter("thid"));
	String PAGE = Converter.nullchk(request.getParameter("PAGE"));
	int thididx=Integer.parseInt(thid);
	String finance_buseo=(String)session.getAttribute("buseo");
	
// 	String TableName = " sh_chungtak ";
// 	String SelectCondition = " sg_publication, code, title, sg_name, ct_content, text1, buseo, replyname, result, junbuseo, ";
// 	SelectCondition += "to_char(time1, 'YYYY-MM-DD') AS time1, ";
// 	SelectCondition += "to_char(time2, 'YYYY-MM-DD') AS time2 ";
// 	String WhereCondition = " where thid=" + thididx;
// 	String OrderCondition  = "";
	
	String TableName = " sh_chungtak ";
	String SelectCondition = "sg_publication, sg_name, sg_tel, ";
	SelectCondition += "ct_name, ct_job, ct_tel, ct_job, ct_zip, ct_addr1, ct_addr2, ct_corp, ct_corpaddr, ct_corpname, ";
	SelectCondition += "ct_name_c, ct_job_c, ct_tel_c, ct_job_c, ct_zip_c, ct_addr1_c, ct_addr2_c, ct_corp_c, ct_corpaddr_c, ct_corpname_c, ";
	SelectCondition += "ct_date, ct_place, ct_content, ct_reason, bh_yn, bh_place, etc, regdate, ";
	SelectCondition += "code, type, title, buseo, text1, result, junbuseo, ";
	SelectCondition += "to_char(time1, 'YYYY-MM-DD') AS time1, ";
	SelectCondition += "to_char(time2, 'YYYY-MM-DD') AS time2, to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date ";
	String WhereCondition = " where thid=" + thididx;
	String OrderCondition  = "";
	
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
		String buseo="";
//	 	String text = "";
		String text1 = "";
		String result = "";
		String junbuseo="";
		String time1="";
		String time2="";
		String abandon_date="";
		
		//답변
		String publication="";
		String replyname="";
		String text = "";
		String preresult="";
	
	//out.println(ResultVector.size());
	
	if( ResultVector.size() > 0){
		for (int i=0; i < ResultVector.size(); i++){
			Hashtable h = (Hashtable)ResultVector.elementAt(i);
			
			type = (("1".equals((String)h.get("TYPE"))) ? "자진신고용" : "제3자신고용");
			type1 = (String)h.get("TYPE");
			
			code = (String)h.get("CODE");
			title = (String)h.get("TITLE");
			
			sg_publication = (String)h.get("SG_PUBLICATION");
			sg_name = (String)h.get("SG_NAME");
			sg_tel = (String)h.get("SG_TEL");
			
			ct_name = (String)h.get("CT_NAME");
			ct_job = (String)h.get("CT_JOB");
			ct_tel = (String)h.get("CT_TEL");
			ct_zip = (String)h.get("CT_ZIP");
			ct_addr1 = (String)h.get("CT_ADDR1");
			ct_addr2 = (String)h.get("CT_ADDR2");
			ct_corp = (String)h.get("CT_CORP");
			ct_corpaddr = (String)h.get("CT_CORPADDR");
			ct_corpname = (String)h.get("CT_CORPNAME");
			
			ct_name_c = (String)h.get("CT_NAME_C");
			ct_job_c = (String)h.get("CT_JOB_C");
			ct_tel_c = (String)h.get("CT_TEL_C");
			ct_zip_c = (String)h.get("CT_ZIP_C");
			ct_addr1_c = (String)h.get("CT_ADDR1_C");
			ct_addr2_c = (String)h.get("CT_ADDR2_C");
			ct_corp_c = (String)h.get("CT_CORP_C");
			ct_corpaddr_c = (String)h.get("CT_CORPADDR_C");
			ct_corpname_c = (String)h.get("CT_CORPNAME_C");
			
			ct_date = (String)h.get("CT_DATE");
			ct_place = (String)h.get("CT_PLACE");
			
			StringTokenizer stk = null;
			
			stk = new StringTokenizer(ct_place, "\r\n");
			ct_place = "";
			while(stk.hasMoreElements()){
				ct_place += stk.nextToken();
				ct_place += "<br>";
			}
			
			ct_content = (String)h.get("CT_CONTENT");
			stk = new StringTokenizer(ct_content, "\r\n");
			ct_content = "";
			while(stk.hasMoreElements()){
				ct_content += stk.nextToken();
				ct_content += "<br>";
			}
			ct_reason = (String)h.get("CT_REASON");
			stk = new StringTokenizer(ct_reason, "\r\n");
			ct_reason = "";
			while(stk.hasMoreElements()){
				ct_reason += stk.nextToken();
				ct_reason += "<br>";
			}
			
			bh_yn = (("Y".equals((String)h.get("BH_YN"))) ? "반환" : "미반환");
			
			bh_place = (String)h.get("BH_PLACE");
			etc = (String)h.get("ETC");
			
			buseo = (String)h.get("BUSEO");
			text1 = (String)h.get("TEXT1");
			if(text1 == null) text1 = "";
			result = (String)h.get("RESULT");
			if(result == null) result = "";
			junbuseo = (String)h.get("JUNBUSEO");
			time1 = (String)h.get("TIME1");
			time2 = (String)h.get("TIME2");
			abandon_date = (String)h.get("ABANDON_DATE");
			
			
			
			time1=(String)h.get("TIME1");
			time2=(String)h.get("TIME2");
			result=(String)h.get("RESULT");
			junbuseo=(String)h.get("JUNBUSEO");
			
			
			if(result.equals("조치/시정") || result.equals("절차안내") || result.equals("합의/조정") || result.equals("설득이해")  ){
				preresult="해결";
			}
			else if(result.equals("법령/제도상불능") || result.equals("내용불합리") || result.equals("재정") || result.equals("사실상이") ){
				preresult="조치불능";
			}
			else if(result.equals("익명주소무") || result.equals("사적분쟁") || result.equals("소송/수사") || result.equals("불문(민원아님)") ){
				preresult="불문";
			}
			else if(result.equals("건의/검토")){
				preresult="기타";
			}
		}
	}
	
	TableName = " sh_chungtak_history ";
	SelectCondition = " sh_no, sh_chungtak_no, sh_buseo_from, sh_buseo_to, sh_status,";
	SelectCondition += "to_char(sh_indate, 'YYYY-MM-DD') AS sh_indate ";
	WhereCondition = " where sh_chungtak_no=" + thididx;
	OrderCondition  = " order by sh_no asc";
	//int TotalRecordCount = FrontBoard.TotalCount(TableName2, WhereCondition2);
	//out.println("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br><br>");
	
	Date date = new Date();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
%>
<!-- 청탁금지법 위반 신고 제보 설명 -->
<script language="JavaScript">
<!--
	function MM_openBrWindow(theURL,winName,features) { //v2.0
	  window.open(theURL,winName,features);
	}
	function goView(thid,PAGE){
		pbform.action = "favors_view.jsp";
		pbform.submit();
	}
	
//-->
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
									<td height="70" align="center" class="admin_subject">청탁금지법
										위반 신고</td>
								</tr>
							</table>
						</td>
						<td width="5"></td>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="60" class="adminsub_subject"
										style="padding-left: 25;">청탁금지법 위반 신고 내용</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- // 청탁금지법 위반 신고 제보 설명 -->



	<br>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td style="padding: 0 0 10 10;">
				<!-- 검색결과 -->
				<table width="965" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30"><img src="img/result.gif" align="absmiddle">
							청탁금지법 위반 신고 제보 <span class="result_text">상세보기</span></td>
						<!-- 추가 -->
						<%if(finance_buseo.equals(buseo)){%>
						<td height="30" align="right"><a href="javascript:goView();"><img
								src="img/btn_adjust.gif" width="55" height="21" alt="수정"
								border="0"></a></td>
						<%} %>
						<td height="30" align="right" width="60"><a href="#"><img
								src="img/btn_print.gif" width="55" height="21"
								onClick="MM_openBrWindow('favors_print.jsp?thididx=<%=thididx%>','','width=638,height=630')"
								border="0" alt="출력"></a></td>
						<td height="30" align="right" width="60"><a
							href="favors.jsp?PAGE=<%=PAGE %>"><img src="img/btn_list.gif"
								width="55" height="21" border="0" alt="목록"></a></td>
					</tr>
					<tr>
						<td height="2" class="result_line" colspan="4"></td>
					</tr>
				</table> <!-- // 검색결과 -->
			</td>
		</tr>


		<!-- 민원접수현황 뷰페이지-->
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
												<td style="padding-left: 10;">번호 : <%=thid %></td>
												<td align="right" style="padding-right: 10;">처리상태 : <%=code %></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td colspan="3" height="5"></td>
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
																<td style="text-align: left; padding-left: 10px;"><%=type %></td>
															</tr>
														</table>

													</td>
												</tr>
												<!-- //신고형식 -->


												<!-- 부정청탁을 한 자 또는 금품등을 제공한 자 -->
												<tr>
													<td align="center" height="30" class="table_bg_title">부정청탁을
														한 자 또는 금품등을 제공한 자(필수)</td>
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
																<td style="text-align: left; padding-left: 10px;"><%=ct_name %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">직업</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_job %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">연락처</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_tel %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">주소</th>
																<td style="text-align: left; padding-left: 10px">[
																	<%=ct_zip %> ]<%=ct_addr1 %> <%=ct_addr2 %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁자법인명칭</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_corp %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁자법인소재지</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_corpaddr %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁자법인대표성명</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_corpname %></td>
															</tr>
														</table>

													</td>
												</tr>
												<!-- //부정청탁을 한 자 또는 금품등을 제공한 자(필수) -->

<%
											if("2".equals(type1)){
%>
												<!-- 부정청탁을 한 자 또는 금품등을 제공한 자(선택) -->
												<tr>
													<td align="center" height="30" class="table_bg_title">부정청탁을
														한 자 또는 금품등을 제공한 자(선택)</td>
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
																<td style="text-align: left; padding-left: 10px;"><%=ct_name_c %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">직업</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_job_c %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">연락처</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_tel_c %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">주소</th>
																<td style="text-align: left; padding-left: 10px">[
																	<%=ct_zip_c %> ] <%=ct_addr1_c %> <%=ct_addr2_c %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁자법인명칭</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_corp_c %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁자법인소재지</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_corpaddr_c %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁자법인대표성명</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_corpname_c %></td>
															</tr>
														</table>

													</td>
												</tr>
												<!-- //부정청탁을 한 자 또는 금품등을 제공한 자(선택) -->
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
																<td style="text-align: left; padding-left: 10px;"><%=ct_date %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁장소</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_place %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁내용</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_content %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">청탁신고이유</th>
																<td style="text-align: left; padding-left: 10px"><%=ct_reason %></td>
															</tr>
														</table>
													</td>
												</tr>
												<!-- //부정청탁 또는 금품등 수수 내용 -->
<%
											if("1".equals(type1)){
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
																<td style="text-align: left; padding-left: 10px;"><%=bh_yn %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">금품반환장소</th>
																<td style="text-align: left; padding-left: 10px"><%=bh_place %></td>
															</tr>
															<tr>
																<td height="1" bgcolor="#d9e8f3" colspan="2"></td>
															</tr>
															<tr>
																<th class="bluesky"
																	style="text-align: left; padding-left: 10px; border-right: 1px solid #d9e8f3"">비고</th>
																<td style="text-align: left; padding-left: 10px"><%=etc %></td>
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


									<td align="center" class="board_bg_title" valign="top"
										width="5"></td>
									<td class="board_bg_title" width="295" valign="top"
										align="right">
										<!-- 민원접수정보 -->
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="read_outline" height="100%">
											<tr>
												<td height="30" style="padding-left: 10;"
													class="table_bg_title">청탁금지법 위반 신고 제보 처리 내역</td>
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
														<!--                          
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">처리결과</td>
                            <td><%=preresult%> &gt; <%=result%></td>
                          </tr>
-->
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">처리일자</td>
															<td><%=time2%></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">담당부서</td>
															<td><%=buseo%></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<!--
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">담당자</td>
                            <td><%=replyname%></td>
                          </tr>
-->
													</table>
												</td>
											</tr>
										</table> <!-- // 민원접수정보 -->
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
												<td align="center" height="30" class="table_bg_title">답변내역</td>
											</tr>
											<tr>
												<td style="padding: 20 20 20 20;"><%=text1%></td>
											</tr>
										</table>
									</td>

								</tr>
							</table>
						</td>
					</tr>
				</table> <br> <!-- // 민원접수현황 뷰페이지-->
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
					<%ResultVector = FrontBoard.list(TableName, SelectCondition,WhereCondition, OrderCondition, 0, 1);%>
					<%if (ResultVector.size() > 0) {%>
					<%for (int i = 0; i < ResultVector.size(); i++) {%>
					<%Hashtable h = (Hashtable)ResultVector.elementAt(i);%>
					<tr height="30" onMouseOver=this.style.backgroundColor=
						'F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'>
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
					<tr height="30" onMouseOver=this.style.backgroundColor=
						'F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'>
						<td colspan="5" align="center">등록된 자료가 없습니다</td>
					</tr>
					<%}%>
				</table>
			</td>
		</tr>
	</table>
	<input type="hidden" name="thid" value="<%=thid %>"> <input
		type="hidden" name="PAGE" value="<%=PAGE%>">
</form>
<%@ include file="include/bottom.jsp"%>
