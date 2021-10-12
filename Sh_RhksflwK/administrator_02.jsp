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

		String KEY = request.getParameter("KEY");	//검색어
	    if(KEY != null && !KEY.equals("")) {
	    	KEY = StringReplace.sqlFilter(KEY);		//금지어 필터링
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
		WhereCondition = "where 1 = 1 and sh_buseo = '회원조합' "; 

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
<!-- 민원정보담당자관리 설명 -->
<head>
<script language="javascript">
<!--//  -->
	//아이디중복체크

	function CheckID()  {


		var wint = (screen.height - 170) / 2;

		var winl = (screen.width - 340) / 2;

		winprops = 'height=230,width=362,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'

		winurl = 'check_id.jsp?return=sh_id&id='+f.sh_id.value;
		win = window.open(winurl, "idcheck", winprops)

		}

	//약관 동의 여부 체크
	function GoReg() {

		if(f.sh_johap.value == '') {
			alert("조합명을 선택해 주십시오");
			f.sh_johap.focus();
			return;
		}

		if (f.sh_name.value.length == 0) {alert("성명을 입력해 주십시오"); f.sh_name.focus(); return;}

		if(f.sh_gicwe.value == 'gicwe') {
			alert("직위를 선택해 주십시오");
			f.sh_gicwe.focus();
			return;
		}

		if(f.sh_gicgub.value == 'gicgub') {
			alert("직급를 선택해 주십시오");
			f.sh_gicgub.focus();
			return;
		}

		if (f.sh_id.value.length == 0) {alert("아이디를 입력해 주십시오"); f.sh_id.focus(); return;}

		if (f.sh_pwd.value.length == 0) {alert("비밀번호를 입력해 주십시오"); f.sh_pwd.focus(); return;}



		if (f.sh_han1.value.length == 0){
				alert("휴대폰번호가 입력되지 않았습니다.");
				f.sh_han1.focus();
				return;
		}else if(f.sh_han2.value.length == 0){
				alert("휴대폰번호가 입력되지 않았습니다.");
				f.sh_han2.focus();
				return;
		}else if(f.sh_han3.value.length == 0){
				alert("휴대폰번호가 입력되지 않았습니다.");
				f.sh_han3.focus();
				return;
		}
		if(!(f.sh_buseo.value == "감사실" || f.sh_buseo.value == "감사부" || f.sh_buseo.value == "금융소비자보호부" || f.sh_buseo.value == "준법감시실(중앙회)" || f.sh_buseo.value == "준법감시실(조합)")){

			if(f.sh_admin_minwonall.checked){

				alert("민원현황은 감사실, 감사부, 금융소비자보호부, 준법감시실(중앙회), 준법감시실(조합) 부서만 사용하실수있습니다.");

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
		if (confirm("삭제하시겠습니까?")) {
			f.action = "admin_delete_proc.jsp";
			f.submit();
		}
		else {
		alert("취소되었습니다!");
		}
	}
	//검색
	function form_check(){

		if (f.KEY.value == null || f.KEY.value == ""){
				alert("검색어를 입력하세요.");
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
	<input type="hidden" name="sh_buseo" value="회원조합" />
	<div class="list-header">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>민원정보<br> 담당자 관리</td>
				<td>부서별 담당자를 등록 및 관리합니다.</td>
			</tr>
		</table>
	</div>
	
	<!-- // 민원정보담당자관리 설명 -->
	<br>
	<div class="tbl-wrap">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td style="padding: 0 0 10 10;">
				<!-- 검색결과 -->
				<table width="960" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30">
							<img src="img/result.gif" align="absmiddle">
							검색결과 : <span class="result_text">총 <%=TotalRecordCount%>건</span>
						</td>
						<td height="30" align="right">
							<a href="excel/admin_excel.jsp"><img src="img/btn_excel.gif" width="66" height="21" alt="엑셀"border="0"></a>
						</td>
					</tr>
					<tr>
						<td height="2" class="result_line" colspan="2"></td>
					</tr>
				</table> <!-- // 검색결과 -->
			</td>
		</tr>
		<!-- 관리자 등록 -->
		<tr>
			<td style="padding-left: 25;"><img src="img/arrow.gif" width="13" height="16" align="absmiddle"> <span class="txt_title">관리자 등록</span></td>
		</tr>
		<tr>
			<td style="padding: 10 0 10 25;">
				<table border="0" cellspacing="0" cellpadding="0"
					class="table_outline">
					<tr>
						<td width="130" height="35" align="center" class="table_bg_title">관리담당자</td>
						<td style="padding-left: 25;" class="board_bg_contents">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="50" class="bluesky">조합명</td>
									<td>
									<select name="sh_johap" onChange="">
										<option value="">선택</option>
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
									<td width="60" class="bluesky">성명</td>
									<td>
										<input type="text" class="input01" size="15" name="sh_name" value="">
									</td>
									<td width="30">&nbsp;</td>
									<td width="40" class="bluesky">직위</td>
									<td>
										<select name="sh_gicwe" onChange="">
											<option value="gicwe">선택</option>
											<option value="직원">직원</option>
											<option value="대리">대리</option>
											<option value="과장">과장</option>
											<option value="차장">차장</option>
											<option value="팀장">팀장</option>
											<option value="부장/실장">부장/실장</option>
											<!-- -->
										</select>
									</td>
									<td width="30">&nbsp;</td>
									<td width="40" class="bluesky">직급</td>
									<td>
										<select name="sh_gicgub" onChange="">
											<option value="gicgub">선택</option>
											<option value="계약직">계약직</option>
											<option value="4급">4급</option>
											<option value="3급">3급</option>
											<option value="2급">2급</option>
											<option value="1급">1급</option>
											<option value="별급">별급</option>
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
						<td width="130" height="35" align="center" class="table_bg_title">관리계정</td>
						<td style="padding-left: 25;" class="board_bg_contents">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="50" class="bluesky">아이디</td>
									<td>
										<input type="text" class="input01" size="20" name="sh_id">
									</td>
									<td width="10">&nbsp;</td>
									<td width="20">
										<a href="javascript:CheckID();">
											<img src="img/mb_bt_check.gif" title="아이디체크" border="0" />
										</a>
									</td>
									<td width="20">&nbsp;</td>
									<td width="70" class="bluesky">패스워드</td>
									<td>
										<input type="password" class="input01" size="15" name="sh_pwd" value="">
									</td>
									<td width="20">&nbsp;</td>
									<td width="60" class="bluesky">핸드폰</td>
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
						<td width="130" height="35" align="center" class="table_bg_title">관리권한</td>
						<td style="padding-left: 25;" class="board_bg_contents">
							<table width="100%" border="0" cellspacing="5" cellpadding="0">
								<tr>
									<td width="120" class="bluesky">* 시스템 관리</td>
									<td>
										<table border="0" cellspacing="0" cellpadding="0">
											<colgroup>
												<col width="210px" />
												<col width="210px" />
												<col width="*" />
											</colgroup>
											<tr>
												<td class="black"><input type="checkbox" name="sh_admin_manager" value="Y"> 관리자 관리</td>
												<td class="black"><input type="checkbox" name="sh_admin_faq" value="Y"> FAQ</td>
												<td></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td width="120" class="bluesky">* 전자민원 관리</td>
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
												<td class="black"><input type="checkbox" name="sh_admin_minwonall" value="Y"> 민원접수현황</td>
												<td class="black"><input type="checkbox" name="sh_admin_buseo" value="Y"> 회원조합 민원관리</td>
												<td class="black"><input type="checkbox" name="sh_admin_upright" value="Y"> 청렴수협인상</td>
												<td class="black"><input type="checkbox" name="sh_admin_sms" value="Y">민원담당 SMS 관리</td>								
												<td class="black"><input type="checkbox" name="sh_admin_result" value="Y"> 민원처리결과 공시</td>												
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td width="120" class="bluesky">* 기타 관리</td>
									<td>
										<table border="0" cellspacing="0" cellpadding="0">
											<colgroup>
												<col width="210px" />
												<col width="210px" />
												<col width="*" />
											</colgroup>
											<tr>
												<td class="black"><input type="checkbox" name="sh_admin_jebo" value="Y"> 금융사고제보</td>
												<td class="black"><input type="checkbox" name="sh_admin_bujori" value="Y"> 금융부조리신고</td>
												<td class="black"><input type="checkbox" name="sh_admin_myunsei" value="Y"> 면세유류 부정유통 신고</td>
											</tr>
											<tr>
												<td class="black"><input type="checkbox" name="sh_admin_corruption" value="Y"> 행동강령 신고·상담센터</td>
												<td class="black"><input type="checkbox" name="sh_admin_favors" value="Y"> 청탁신고센터</td>
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
							<img src="img/btn_upload.gif" width="55" height="21" alt="등록" border="0">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<!--// 관리자 등록 -->
		<!-- 부서별 관리자 -->
		<tr>
			<td style="padding-left: 25;">
				<img src="img/arrow.gif" width="13" height="16" align="absmiddle">
				<span class="txt_title">부서별 관리자</span>
			</td>
		</tr>
		<tr>
			<td >
				<table border="0" cellspacing="0" cellpadding="0" class="tbl-list">
					<tr>
						<td class="board_bg_title" align="center">번호</td>
						<td class="board_bg_title"  align="center">조합명</td>
						<td class="board_bg_title"  align="center">관리자</td>
						<td class="board_bg_title"  align="center">아이디</td>
						<td class="board_bg_title"  align="center">패스워드</td>
						<td class="board_bg_title"  align="center">핸드폰</td>
						<td class="board_bg_title"  align="center">등록자</td>
						<td class="board_bg_title"  align="center">등록일</td>
						<td class="board_bg_title"  align="center">삭제</td>
					</tr>
					<%
					
						System.out.println("리스트=========");
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
							<img src="img/btn_delete.gif" width="55" height="21" alt="삭제" border="0">
						</td>
					</tr>
					<%	} %>
					<%	} %>
				</table>
				<br>
				<table cellpadding="0" cellspacing="0" border="0" class="search">
					<tr>

						<td class="cols02"><b>회원조합 조회</b>&nbsp;&nbsp;<input type="text"
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
