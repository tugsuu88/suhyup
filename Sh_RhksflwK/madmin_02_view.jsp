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
	/* 20180629 관리자 답변시 첨부파일 컬럼 */
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
// 			session.setAttribute("buseName", ("1".equals((String) h.get("BUPIN")) ? "수협중앙회-회원조합-자회사" : "수협은행"));
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
				replyTypeNm = "홈페이지";
			} else if ("2".equals(reply_type)) {
				replyTypeNm = "이메일";
			} else if ("3".equals(reply_type)) {
				replyTypeNm = "휴대폰";
			}

			fname = (String) h.get("FNAME");
			/* 20180314 관리자 답변시 첨부파일 컬럼 */
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
	//읽는 사람이 감사실 소속일 접수,다른 부서일 경우 처리중
	//총관리자가 아닐경우, 코드가 답변완료,이첩,반송이 아닐경우,답변을 안단 경우
	if (!finance_buseo.equals("all") && answer.equals("") && status.equals("신청")) {
		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
			conn = ds.getConnection();
			String sql = "";
			if (finance_buseo.equals("감사실") || finance_buseo.equals("감사부")) {
				sql = "update sh_minwon set status='접수' where mid=?";
			} else {
				sql = "update sh_minwon set status='처리중' where mid=?";
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
	
	ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 1);
// 	System.out.println("size : " + ResultVector.size());
	if(ResultVector.size() > 0){
		for (int i = 0; i < ResultVector.size(); i++) {
			Hashtable h = (Hashtable) ResultVector.elementAt(i);
			if(i == 0){
				session.setAttribute("shBuseoFrom", (String) h.get("SH_BUSEO_FROM"));
				session.setAttribute("buseName", ("감사실".equals((String) h.get("SH_BUSEO_FROM")) ? "수협중앙회-회원조합-자회사" : "수협은행"));
			}
		}
	}else{
	 	session.setAttribute("buseName", ("1".equals(bupin) ? "수협중앙회-회원조합-자회사" : "수협은행"));
	}
	
%>
<!--/********************************************위너다임 작업 시작 2008.03.13****************************************************/-->
<!-- <SCRIPT SRC="http://www.suhyup.co.kr/djemals/js/ax_wdigm/default.js"></SCRIPT> -->
<!--/********************************************위너다임 작업 끝 2008.03.13******************************************************/-->
<script language="javascript">
	function goReply(mid) {
		var form = document.createElement("form");

		var mText = document.pbform.answer.value;
		
		if (!pbform.answer.value) {
			alert("내용을 등록해 주세요");
			pbform.answer.focus();
			return;
		}
		if (pbform.answer.value.length >= 4001) {
			alert("글자수가 초과하였습니다. 4000자이내로 작성하여주세요.");
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
			alert("민원분류를 선택해주셔야 합니다");
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
			alert("처리결과를 선택해주셔야 합니다");
			return;
		}
		
		var isstr = confirm("답변을 하시겠습니까?");
		if (isstr) {
			/********************************************위너다임 작업 시작 2008.03.13****************************************************
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
			 ********************************************위너다임 작업 끝 2008.03.13******************************************************/
			 pbform.action = "madmin_02_view_ok.jsp";
			 pbform.encoding="multipart/form-data";
			 pbform.submit();
		}
	}
	function send() {		
		if (!pbform.buseo.value) {
			alert("이첩할 부서를 선택해주세요");
			pbform.buseo.focus();
			return;
		}
		if (confirm("이첩하시겠습니까?")) {
			pbform.action = "madmin_02_send_ok.jsp";
			pbform.submit();
		}
	}
	function receive() {
		if (confirm("반송하시겠습니까?")) {
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
<!-- 금융사고 제보 설명 -->
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
									<td height="70" align="center" class="admin_subject">부서별민원접수현황</td>
								</tr>
							</table>
						</td>
						<td width="5"></td>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="60" class="adminsub_subject"
										style="padding-left: 25;">부서별 민원접수현황입니다</td>
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
							민원내역 <span class="result_text">상세보기</span></td>
						<td height="30" align="right" width="60"><a href="#"><img
								src="img/btn_print.gif" width="55" height="21"
								onClick="MM_openBrWindow('minwon_03_print.jsp?thididx=<%=thididx%>&bupin=<%=bupin%>&yongup=<%=yongup%>','','width=638,height=630')"
								border="0" alt="출력"></a></td>
						<td height="30" align="right" width="60"><a
							href="madmin_02.jsp?PAGE=<%=PAGE%>"><img
								src="img/btn_list.gif" width="55" height="21" border="0"
								alt="목록"></a></td>
					</tr>
					<tr>
						<td height="2" class="result_line" colspan="4"></td>
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
												<td style="padding-left: 10;">번호 : <%=mid%></td>
												<td align="right" style="padding-right: 10;">처리상태 : <%=status%></td>
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
												<td style="padding: 20 20 20 20;">● 법인구분 : <%=(String) session.getAttribute("buseName")%><br />
													● 대상영업점 : <%=yongup%><br /> <br /> <%=content%>
												</td>
											</tr>
										</table>
									</td>
									<td align="center" valign="top" width="5"></td>
									<td class="board_bg_title" width="295" valign="top"
										align="right">
										<!-- 금융사고 제보정보 -->
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="read_outline" height="100%">
											<tr>
												<td height="30" style="padding-left: 10;"
													class="table_bg_title">민원접수	정보
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													첨부파일
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
															<td height="30" style="padding-left: 10;" class="bluesky">분야</td>
															<td><%=category%></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">신청일</td>
															<td><%=creation_date%></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">민원인</td>
															<td><%=name%> <a href="#"
																onClick="MM_openBrWindow('minwon_03_popup.jsp?thididx=<%=thididx%>&birthdate=<%=birthdate%>','','width=500,height=290')">[<u>상세정보
																		보기</u>]
															</a></td>
														</tr>
														<tr>
															<td colspan="2" height="1" bgcolor="#d9e8f3"></td>
														</tr>
														<tr>
															<td height="30" style="padding-left: 10;" class="bluesky">회신방식</td>
															<td><%=replyTypeNm%></td>
														</tr>
														<%
															if ("철회완료".equals(status)) {
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
															<td height="30" style="padding-left: 10;" class="bluesky">소관부서</td>
															<!-- 글 내용중에 부서권한은 감사실,준법감사실,기타 로 나누어 진다-->
															<!-- 글내용이 감사실일 경우 , 감사실 권한만이 볼수 있는것-->
															<%
																 if (buse_name.equals("감사실") || buse_name.equals("감사부")) {
															%>
															<td>
																<!-- 글내용이 감사실이면서 로그인한 사용자가 감사실인 사람,답변내용이 없는 경우 이첩 기능-->
																<%
																	if ((finance_buseo.equals("감사실") || finance_buseo.equals("감사부")) && answer.equals("") && !status.equals("철회완료")) {
																%> <select name="buseo">
																	<option value="">선택</option>
																	<option value="IT개발부">IT개발부</option>
																	<option value="정보보호본부">정보보호본부</option>
																	<!-- <option value="가공물류부">가공물류부</option> -->
																	<option value="감사실">감사실</option>
																	<option value="감사부">감사부</option><!-- 20170330 부서 신규추가 -->
																	<option value="ICT전략실">ICT전략실</option>
																	<option value="인사총무부">인사총무부</option>
																	<option value="경제기획부">경제기획부</option>
																	<option value="금융소비자보호부">금융소비자보호부</option>
																	<option value="공제보험부">공제보험부</option>
																	<option value="글로벌외환사업부">글로벌외환사업부</option>
																	<option value="전략기획부">전략기획부</option>
																	<option value="기획부">기획부</option>
																	<option value="노량진시장 현대화사업본부">노량진시장 현대화사업본부</option>
																	<option value="리스크관리본부">리스크관리본부</option>
																	<option value="리스크관리실">리스크관리실</option>
																	<option value="방카펀드사업부(방카)">방카펀드사업부(방카)</option>
																	<option value="방카펀드사업부(펀드)">방카펀드사업부(펀드)</option>
																	<!-- <option value="사업구조개편단">사업구조개편단</option> -->
																	<option value="상호금융부">상호금융부</option>
																	<!-- <option value="선원지원실">선원지원실</option> -->
																	<option value="준법감시실(조합)">준법감시실(조합)</option>
																	<option value="준법감시실(중앙회)">준법감시실(중앙회)</option>
																	<option value="수산경제연구원">수산경제연구원</option>
																	<option value="수산금융부">수산금융부</option>
																	<option value="디지털개발부">디지털개발부</option>
																	<option value="신탁사업본부">신탁사업본부</option>
																	<option value="심사부">심사부</option>
																	<!-- <option value="안전관리실">안전관리실</option> -->
																	<option value="어업정보통신본부">어업정보통신본부</option>
																	<option value="여신관리부">여신관리부</option>
																	<option value="기업금융부">기업금융부</option>
																	<option value="여신정책부">여신정책부</option>
																	<option value="연수원">연수원</option>
																	<option value="판매사업부">판매사업부</option>
																	<option value="이사회사무국">이사회사무국</option>
																	<option value="자금부">자금부</option>
																	<option value="자금운용부">자금운용부</option>
																	<option value="자재사업부">자재사업부</option>
																	<option value="정책보험부">정책보험부</option>
																	<option value="조합감사실">조합감사실</option>
																	<option value="개인금융부">개인금융부</option>
<!-- 																	<option value="준법감시실">준법감시실</option> --><!-- 준법감시실은 청탁관련 게시글만 볼수 있음!? -->
																	<!-- <option value="준법감시팀">준법감시팀</option> -->
																	<option value="총무부">총무부</option>
																	<option value="카드사업부">카드사업부</option>
																	<!-- <option value="해양투자금융센터">해양투자금융센터</option> -->
																	<option value="홍보실">홍보실</option>
																	<option value="회원지원부">회원지원부</option>
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
																%> <%=buse_name%> <%
 	}
 %>
															</td>
															<!-- 글내용이 준법감사실일 경우,감사실 또는 준법감시팀권한만이 볼수있는것 -->
															<%
																} else if (buse_name.equals("금융소비자보호부")) {
															%>
															<td>
																<!-- 글내용이 준법감시팀이면서 로그인한 사용자가 준법감시팀인 경우,답변내용이 없는 경우 감사실로 반송및 타부서로 이첩가능 -->
																<%
																	if (finance_buseo.equals("금융소비자보호부") && answer.equals("") && !status.equals("철회완료")) {
																%> <select name="buseo">
																	<option value="">선택</option>
																	<option value="감사실">감사실</option>
																	<option value="감사부">감사부</option>
																	<option value="ICT전략실">ICT전략실</option>
																	<option value="인사총무부">인사총무부</option>
																	<option value="개인금융부">개인금융부</option>
																	<option value="공제보험부">공제보험부</option>
																	<option value="전략기획부">전략기획부</option>
																	<option value="기획부">기획부</option>
																	<option value="노량진시장 현대화사업본부">노량진시장 현대화사업본부</option>
																	<option value="단체급식사업단">단체급식사업단</option>
																	<option value="리스크관리본부">리스크관리본부</option>
																	<option value="방카펀드사업부(펀드)">방카펀드사업부(펀드)</option>
																	<option value="상호금융부">상호금융부</option>
																	<option value="수산경제연구원">수산경제연구원</option>
																	<option value="수산금융부">수산금융부</option>
																	<!-- <option value="가공물류부">가공물류부</option> -->
																	<option value="신탁사업본부">신탁사업본부</option>
																	<option value="심사부">심사부</option>
																	<option value="어업정보통신본부">어업정보통신본부</option>
																	<option value="여신관리부">여신관리부</option>
																	<option value="연수원">연수원</option>
																	<option value="글로벌외환사업부">글로벌외환사업부</option>
																	<option value="경제기획부">경제기획부</option>
																	<option value="이사회사무국">이사회사무국</option>
																	<option value="자금부">자금부</option>
																	<option value="자재사업부">자재사업부</option>
																	<option value="IT개발부">IT개발부</option>
																	<option value="정보보호본부">정보보호본부</option>
																	<option value="조합감사실">조합감사실</option>
																	<option value="리스크관리실">리스크관리실</option>
																	<option value="자금운용부">자금운용부</option>
																	<!-- <option value="준법감시팀">준법감시팀</option> -->
																	<option value="판매사업부">판매사업부</option>
																	<option value="총무부">총무부</option>
																	<option value="카드사업부">카드사업부</option>
																	<!-- <option value="해양투자금융센터">해양투자금융센터</option> -->
																	<option value="홍보실">홍보실</option>
																	<option value="회원지원부">회원지원부</option>
																	<!-- <option value="사업구조개편단">사업구조개편단</option> -->
																	<option value="기업금융부">기업금융부</option>
																	<option value="여신정책부">여신정책부</option>
																	<option value="정책보험부">정책보험부</option>
																	<option value="금융소비자보호부">금융소비자보호부</option>
																	<option value="디지털개발부">디지털개발부</option>
																	<!-- <option value="선원지원실">선원지원실</option> -->
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
															</select> <a href="javascript:send();"> <img
																	src="img/btn_transfer.gif" align="absmiddle" alt="이첩"
																	border="0"></a> <br> <br> <%=(String) session.getAttribute("shBuseoFrom")%>
																<a href="javascript:receive();"> <img
																	src="img/btn_sendback.gif" align="absmiddle" border="0"
																	alt="반송"></a> <input type="hidden" name="buseo_to"
																value="<%=(String) session.getAttribute("shBuseoFrom")%>">
																<!-- 글내용이 준법감사실이면서 로그인한 사용자가 준법감사실 또는 감사실일 경우,답변내용이 있는 경우 소관부서 이름이 나타남 -->
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
															<!-- 글내용이 감사실,준법감사실이 아닌 경우,감사실,준법감시팀,동일한 부서만이 볼수있는것 -->
															<%
																} else if (buse_name.equals("준법감시실(중앙회)")) {
															%>
															<td>
																<%
																	if (finance_buseo.equals("준법감시실(중앙회)") && answer.equals("") && !status.equals("철회완료")) {
																%> <select name="buseo">
																	<option value="">선택</option>
																	<option value="감사실">감사실</option>
																	<option value="ICT전략실">ICT전략실</option>
																	<option value="인사총무부">인사총무부</option>
																	<option value="개인금융부">개인금융부</option>
																	<option value="공제보험부">공제보험부</option>
																	<option value="전략기획부">전략기획부</option>
																	<option value="기획부">기획부</option>
																	<option value="노량진시장 현대화사업본부">노량진시장 현대화사업본부</option>
																	<option value="단체급식사업단">단체급식사업단</option>
																	<option value="리스크관리본부">리스크관리본부</option>
																	<option value="방카펀드사업부(펀드)">방카펀드사업부(펀드)</option>
																	<option value="상호금융부">상호금융부</option>
																	<option value="수산경제연구원">수산경제연구원</option>
																	<option value="수산금융부">수산금융부</option>
																	<!-- <option value="가공물류부">가공물류부</option> -->
																	<option value="신탁사업본부">신탁사업본부</option>
																	<option value="심사부">심사부</option>
																	<option value="어업정보통신본부">어업정보통신본부</option>
																	<option value="여신관리부">여신관리부</option>
																	<option value="연수원">연수원</option>
																	<option value="글로벌외환사업부">글로벌외환사업부</option>
																	<option value="경제기획부">경제기획부</option>
																	<option value="이사회사무국">이사회사무국</option>
																	<option value="자금부">자금부</option>
																	<option value="자재사업부">자재사업부</option>
																	<option value="IT개발부">IT개발부</option>
																	<option value="정보보호본부">정보보호본부</option>
																	<option value="조합감사실">조합감사실</option>
																	<option value="리스크관리실">리스크관리실</option>
																	<option value="자금운용부">자금운용부</option>
																	<!-- <option value="준법감시팀">준법감시팀</option> -->
																	<option value="판매사업부">판매사업부</option>
																	<option value="총무부">총무부</option>
																	<option value="카드사업부">카드사업부</option>
																	<!-- <option value="해양투자금융센터">해양투자금융센터</option> -->
																	<option value="홍보실">홍보실</option>
																	<option value="회원지원부">회원지원부</option>
																<!-- 	<option value="사업구조개편단">사업구조개편단</option> -->
																	<option value="기업금융부">기업금융부</option>
																	<option value="여신정책부">여신정책부</option>
																	<option value="정책보험부">정책보험부</option>
																	<option value="금융소비자보호부">금융소비자보호부</option>
																	<option value="디지털개발부">디지털개발부</option>
																	<!-- <option value="선원지원실">선원지원실</option> -->
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
															</select> <a href="javascript:send();"><img
																	src="img/btn_transfer.gif" align="absmiddle" alt="이첩"
																	border="0"></a> <br> <br> <%=(String) session.getAttribute("shBuseoFrom")%>
																<a href="javascript:receive();"><img
																	src="img/btn_sendback.gif" align="absmiddle" border="0"
																	alt="반송"></a> <input type="hidden" name="buseo_to"
																value="<%=(String) session.getAttribute("shBuseoFrom")%>">
																<%
																	} else {
																%> <%=buse_name%> <%
 	}
 %>
															</td>
															<%
																} else if (buse_name.equals("준법감시실(조합)")) {
															%>
															<td>
																<%
																	if (finance_buseo.equals("준법감시실(조합)") && answer.equals("") && !status.equals("철회완료")) {
																%> <select name="buseo">
																	<option value="">선택</option>
																	<option value="감사실">감사실</option>
																	<option value="ICT전략실">ICT전략실</option>
																	<option value="인사총무부">인사총무부</option>
																	<option value="개인금융부">개인금융부</option>
																	<option value="공제보험부">공제보험부</option>
																	<option value="전략기획부">전략기획부</option>
																	<option value="기획부">기획부</option>
																	<option value="노량진시장 현대화사업본부">노량진시장 현대화사업본부</option>
																	<option value="단체급식사업단">단체급식사업단</option>
																	<option value="리스크관리본부">리스크관리본부</option>
																	<option value="방카펀드사업부(펀드)">방카펀드사업부(펀드)</option>
																	<option value="상호금융부">상호금융부</option>
																	<option value="수산경제연구원">수산경제연구원</option>
																	<option value="수산금융부">수산금융부</option>
																	<!-- <option value="가공물류부">가공물류부</option> -->
																	<option value="신탁사업본부">신탁사업본부</option>
																	<option value="심사부">심사부</option>
																	<option value="어업정보통신본부">어업정보통신본부</option>
																	<option value="여신관리부">여신관리부</option>
																	<option value="연수원">연수원</option>
																	<option value="글로벌외환사업부">글로벌외환사업부</option>
																	<option value="경제기획부">경제기획부</option>
																	<option value="이사회사무국">이사회사무국</option>
																	<option value="자금부">자금부</option>
																	<option value="자재사업부">자재사업부</option>
																	<option value="IT개발부">IT개발부</option>
																	<option value="정보보호본부">정보보호본부</option>
																	<option value="조합감사실">조합감사실</option>
																	<option value="리스크관리실">리스크관리실</option>
																	<option value="자금운용부">자금운용부</option>
																	<!-- <option value="준법감시팀">준법감시팀</option> -->
																	<option value="판매사업부">판매사업부</option>
																	<option value="총무부">총무부</option>
																	<option value="카드사업부">카드사업부</option>
																	<!-- <option value="해양투자금융센터">해양투자금융센터</option> -->
																	<option value="홍보실">홍보실</option>
																	<option value="회원지원부">회원지원부</option>
																	<!-- <option value="사업구조개편단">사업구조개편단</option> -->
																	<option value="기업금융부">기업금융부</option>
																	<option value="여신정책부">여신정책부</option>
																	<option value="정책보험부">정책보험부</option>
																	<option value="금융소비자보호부">금융소비자보호부</option>
																	<option value="디지털개발부">디지털개발부</option>
																	<!-- <option value="선원지원실">선원지원실</option> -->
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
															</select> <a href="javascript:send();"><img
																	src="img/btn_transfer.gif" align="absmiddle" alt="이첩"
																	border="0"></a> <br> <br> <%=(String) session.getAttribute("shBuseoFrom")%>
																<a href="javascript:receive();"><img
																	src="img/btn_sendback.gif" align="absmiddle" border="0"
																	alt="반송"></a> <input type="hidden" name="buseo_to"
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
															<!-- 로그인한 사람이 준법감시팀일 경우 소관부서 이름이 나타남-->
															<%
																if (finance_buseo.equals("금융소비자보호부")) {
															%>
															<td><%=buse_name%></td>
															<!-- 로그인한 사람이 감사실일 경우 소관부서 이름이 나타남-->
															<%
																} else if (finance_buseo.equals("감사실")) {
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
															<!-- 로그인한 사람이 일반부서일 경우 반송기능-->
															<%
																} else {
															%>
															<!-- 답변을 안단 경우-->
															<%
																if (answer.equals("")) {
															%>
															<!-- 글내용이 준법감사실에 속한 경우-->
															<%
																if (junbuseo.equals("Y")) {
															%>
															<td>금융소비자보호단으로 <a href="javascript:receive();"><img
																	src="img/btn_sendback.gif" align="absmiddle" border="0"
																	alt="반송"></a></td> 22
															<input type="text" name="buseo_to" value="<%="금융소비자보호부"%>" />
															<!-- 글내용이 감사실에 속한 경우-->
															<%
																} else {
															%>
															<td><%=(String) session.getAttribute("shBuseoFrom")%>
																<a href="javascript:receive();"><img
																	src="img/btn_sendback.gif" align="absmiddle" border="0"
																	alt="반송"></a></td>
															<input type="hidden" name="buseo_to"
																value="<%=(String) session.getAttribute("shBuseoFrom")%>" />
															<%
																}
															%>
															<!-- 답변을 단 경우-->
															<%
																} else {
															%>
															<!-- 글내용이 준법감시팀에 속한 경우-->
															<%
																if (junbuseo.equals("Y")) {
															%>
															<td><%=buse_name%></td>
															<!-- 글내용이 감사실에 속한 경우-->
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
							colspan="3"><textarea name="answer" cols="115" rows="8"
								wrap="physical"><%=answer%></textarea></td>
					</tr>
					<tr>
						<td colspan="4" height="1" bgcolor="ffffff"></td>
					</tr>
					<tr>
						<td width="130" height="35" align="center" class="table_bg_title">민원분류</td>
						<td style="padding-left: 25;" class="board_bg_contents"
							colspan="3">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="100" class="bluesky"><input type="radio"
										name="min_gubun" value="일반민원"
										<%if (minwon_gubun.equals("일반민원"))out.print("checked");%>>
										일반민원
									</td>
									<td width="100" class="bluesky"><input type="radio"
										name="min_gubun" value="단순질의"
										<%if (minwon_gubun.equals("단순질의"))out.print("checked");%>>
										단순질의
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="4" height="1" bgcolor="ffffff"></td>
					</tr>
					<tr>
						<td width="130" height="35" align="center" class="table_bg_title">처리결과</td>
						<td style="padding-left: 25;" class="board_bg_contents"
							colspan="3">
				
							<table width="100%" border="0" cellspacing="5" cellpadding="0">
								<tr>
									<td width="80" class="bluesky">* 해결</td>
									<td>
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="150" class="black"><input type="radio"
													name="result" value="조치/시정"
													<%if (result.equals("조치/시정"))out.print("checked");%>>
													조치/시정
												</td>
												<td>&nbsp;</td>
												<td class="black" width="150"><input type="radio"
													name="result" value="절차안내"
													<%if (result.equals("절차안내"))out.print("checked");%>>
													절차안내
												</td>
												<td>&nbsp;</td>
												<td class="black" width="150"><input type="radio"
													name="result" value="합의/조정"
													<%if (result.equals("합의/조정"))out.print("checked");%>>
													합의/조정
												</td>
												<td>&nbsp;</td>
												<td class="black"><input type="radio" name="result"
													value="설득이해"
													<%if (result.equals("설득이해"))out.print("checked");%>>
													설득이해
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td class="bluesky">* 조치불능</td>
									<td>
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="150" class="black"><input type="radio"
													name="result" value="법령/제도상불능"
													<%if (result.equals("법령/제도상불능"))out.print("checked");%>>
													법령/제도상불능
												</td>
												<td>&nbsp;</td>
												<td width="150" class="black"><input type="radio"
													name="result" value="내용불합리"
													<%if (result.equals("내용불합리"))out.print("checked");%>>
													내용불합리
												</td>
												<td>&nbsp;</td>
												<td width="150" class="black"><input type="radio"
													name="result" value="재정"
													<%if (result.equals("재정"))out.print("checked");%>>
													재정
												</td>
												<td>&nbsp;</td>
												<td class="black"><input type="radio" name="result"
													value="사실상이"
													<%if (result.equals("사실상이"))out.print("checked");%>>
													사실상이
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td class="bluesky">* 불문</td>
									<td>
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="150" class="black"><input type="radio"
													name="result" value="익명주소무"
													<%if (result.equals("익명주소무"))out.print("checked");%>>
													익명주소무
												</td>
												<td>&nbsp;</td>
												<td width="150" class="black"><input type="radio"
													name="result" value="사적분쟁"
													<%if (result.equals("사적분쟁"))out.print("checked");%>>
													사적분쟁
												</td>
												<td>&nbsp;</td>
												<td width="150" class="black"><input type="radio"
													name="result" value="소송/수사"
													<%if (result.equals("소송/수사"))out.print("checked");%>>
													소송/수사
												</td>
												<td>&nbsp;</td>
												<td class="black"><input type="radio" name="result"
													value="불문(민원아님)"
													<%if (result.equals("불문(민원아님)"))out.print("checked");%>>
													불문(민원아님)
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td class="bluesky">* 기타</td>
									<td>
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="150" class="black"><input type="radio"
													name="result" value="건의/검토"
													<%if (result.equals("건의/검토"))out.print("checked");%>>
													건의/검토
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- 20180629  추가 관리자 답변시 파일첨부 -->
					<tr>
						<td width="130" height="35" align="center" class="table_bg_title">첨부파일</td>
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
							if (finance_buseo.equals(buse_name) && !status.equals("철회완료")) {
							
						%>
						<td align="right">
							<a href="javascript:goReply(<%=thididx%>);">
								<img src="img/btn_reply.gif" width="55" height="21" alt="답변" border="0">
							</a>
							<!-- <input type="submit" value="답변"> -->
						</td>
						<%
							}
						%>
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
						<td colspan="5" align="center">등록된 자료가 없습니다</td>
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