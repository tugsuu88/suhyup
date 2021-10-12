<%@ page import="java.util.*, util.*,java.text.SimpleDateFormat" contentType="text/html;charset=euc-kr"%>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %> 
<%@ include file="include/top_menu04.jsp" %>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>

<%
	String thid = Converter.nullchk(request.getParameter("thid"));
	String PAGE = Converter.nullchk(request.getParameter("PAGE"));
	int thididx=Integer.parseInt(thid);
	String finance_buseo=(String)session.getAttribute("buseo");
	
	String TableName = " sh_financetrouble ";
	String SelectCondition = " publication,code,title,name,text,text1,buseo,replyname,result,junbuseo, ";
	SelectCondition += "to_char(time1, 'YYYY-MM-DD') AS time1, ";
	SelectCondition += "to_char(time2, 'YYYY-MM-DD') AS time2 ";
	String WhereCondition = " where thid=" + thididx;
	String OrderCondition  = "";
	//int TotalRecordCount = FrontBoard.TotalCount(TableName2, WhereCondition2);
	//out.println("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br><br>");
	Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 0, 0);
	
	String publication="";
	String code="";
	String title="";
	String name="";
	String replyname="";
	String text = "";
	String text1="";
	String buseo="";
	String time1="";
	String time2="";
	String preresult="";
	String result="";
	String junbuseo="";
	
	//out.println(ResultVector.size());
	
	if( ResultVector.size() > 0){
		for (int i=0; i < ResultVector.size(); i++){
			Hashtable h = (Hashtable)ResultVector.elementAt(i);
			
			publication=(String)h.get("PUBLICATION");
			code=(String)h.get("CODE");
			title=(String)h.get("TITLE");
			name=(String)h.get("NAME");
			replyname=(String)h.get("REPLYNAME");
			text=(String)h.get("TEXT");
			text1=(String)h.get("TEXT1");
			buseo=(String)h.get("BUSEO");
			
			StringTokenizer stk = new StringTokenizer(text, "\r\n");
			text="";
			while(stk.hasMoreElements()){
				text += stk.nextToken();
				text += "<br>";
			}
			StringTokenizer stk1 = new StringTokenizer(text1, "\r\n");
			text1="";
			while(stk1.hasMoreElements()){
				text1 += stk1.nextToken();
				text1 += "<br>";
			}
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
	
	TableName = " sh_finance_history ";
	SelectCondition = " sh_no,sh_finance_no,sh_buseo_from,sh_buseo_to,sh_status,";
	SelectCondition += "to_char(sh_indate, 'YYYY-MM-DD') AS sh_indate ";
	WhereCondition = " where sh_finance_no=" + thididx;
	OrderCondition  = " order by sh_no asc";
	//int TotalRecordCount = FrontBoard.TotalCount(TableName2, WhereCondition2);
	//out.println("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br><br>");
	
	Date date = new Date();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
%>
<!-- 금융사고 제보 설명 -->
<script language="JavaScript">
<!--
	function MM_openBrWindow(theURL,winName,features) { //v2.0
	  window.open(theURL,winName,features);
	}
	function goView(thid,PAGE){
		pbform.action = "finance_view.jsp";
		pbform.submit();
	}
	
//-->
</script>
<form method=post name="pbform" action="" style="margin:0px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="95" bgcolor="f4f4f4"  style="padding-left:25;"> 
      <table width="945" border="0" cellspacing="0" cellpadding="0" background="img/title_bg.gif">
        <tr> 
          <td width="135"> 
            <table width="135" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="70" align="center" class="admin_subject">금융사고 제보</td>
              </tr>
            </table>
          </td>
          <td width="5"></td>
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="60" class="adminsub_subject" style="padding-left:25;">수협의 
                  각 사무소나 수협 임직원이 금융업무와 관련하여 위법· 부당한 행위를 함으로써 <br>
                  수협 또는 고객께 손실을 초래하거나 금융질서를 문란하게 할 우려가 있는 행위에 대하여 정보를 수집받고 있습니다..</td>
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
    <td style="padding:0 0 10 10 ;"> 
      <!-- 검색결과 -->
      <table width="965" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30"><img src="img/result.gif" align="absmiddle"> 금융사고 제보 <span class="result_text">상세보기</span></td>
		  <!-- 추가 -->
          <%if(finance_buseo.equals(buseo)){%>
          <td height="30" align="right"><a href="javascript:goView();"><img src="img/btn_adjust.gif" width="55" height="21" alt="수정" border="0"></a></td>
          <%} %>
          <td height="30" align="right" width="60"><a href="#"><img src="img/btn_print.gif" width="55" height="21" onClick="MM_openBrWindow('finance_print.jsp?thididx=<%=thididx%>','','width=638,height=630')" border="0" alt="출력"></a></td>
          <td height="30" align="right" width="60"><a href="finance.jsp?PAGE=<%=PAGE %>"><img src="img/btn_list.gif" width="55" height="21" border="0" alt="목록"></a></td>
        </tr>
        <tr> 
          <td height="2" class="result_line" colspan="4"></td>
        </tr>
      </table>
      <!-- // 검색결과 -->
    </td>
  </tr>
  <!-- 민원접수현황 뷰페이지-->
  <tr> 
    <td style="padding:10 0 0 25;"> 
      <table width="945" border="0" cellspacing="0" cellpadding="0" class="table_outline">
        <tr> 
          <td style="padding:5 5 5 5;"> 
            <table cellpadding="0" cellspacing="0" border="0">
              <tr height="30" bgcolor="a8cae5"> 
                <td colspan="3"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td style="padding-left:10;">번호 : <%=thid%></td>
                      <td align="right" style="padding-right:10;">처리상태 : <%=code%></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td height="5"></td>
              </tr>
              <tr height="30"> 
                <td align="center" class="board_bg_title" valign="top" width="650"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="read_outline">
                    <tr> 
                      <td align="center" height="30" class="table_bg_title"><%=title%></td>
                    </tr>
                    <tr> 
                      <td style="padding:20 20 20 20;">
                      <%=text%>
                      </td>
                    </tr>
                  </table>
                </td>
                <td align="center" valign="top" width="5"></td>
                <td class="board_bg_title" width="295" valign="top" align="right"> 
                  <!-- 금융사고 제보정보 -->
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="read_outline" height="100%">
                    <tr> 
                      <td height="30" style="padding-left:10;" class="table_bg_title">금융사고 
                        제보 접수정보</td>
                    </tr>
                    <tr> 
                      <td valign="top"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">특수코드</td>
                            <td><%=publication%></td>
                          </tr>
                          <tr> 
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">신청일</td>
                            <td><%=time1%></td>
                          </tr>
                          <tr> 
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">민원인</td>
                            <td><%=name%> <a href="#" onClick="MM_openBrWindow('finan_popup.jsp?thididx=<%=thididx%>','','width=500,height=290')">[<u>상세정보 
                              보기</u>]</a></td>
                          </tr>
                          <tr> 
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">담당부서</td>
							<!-- 추가 -->
               				<%if(junbuseo.equals("") || junbuseo==null) {%>
                            	<td> <%=buseo %></td>
                            <%}else{ %>
                            	<td> <%=buseo %></td>
                            <%} %>
                            	<input type="hidden" name="buseo" value="<%=buseo %>">
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <!-- // 금융사고 제보 정보-->
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br>
      <table width="945" border="0" cellspacing="0" cellpadding="0" class="table_outline">
        <tr> 
          <td style="padding:5 5 5 5;"> 
            <table cellpadding="0" cellspacing="0" border="0">
              <tr> 
                <td height="5"></td>
              </tr>
              <tr height="30"> 
                <td align="center" class="board_bg_title" valign="top" width="650"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="read_outline">
                    <tr> 
                      <td align="center" height="30" class="table_bg_title">답변내역</td>
                    </tr>
                    <tr> 
                      <td style="padding:20 20 20 20;">
                      <%=text1%>
                      </td>
                    </tr>
                  </table>
                </td>
                <td align="center" class="board_bg_title" valign="top" width="5"></td>
                <td class="board_bg_title" width="295" valign="top" align="right"> 
                  <!-- 민원접수정보 -->
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="read_outline" height="100%">
                    <tr> 
                      <td height="30" style="padding-left:10;" class="table_bg_title">금융사고 
                        제보 처리 내역</td>
                    </tr>
                    <tr> 
                      <td valign="top"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">특수코드</td>
                            <td><%=publication%></td>
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
                            <td height="30" style="padding-left:10;" class="bluesky">처리일자</td>
                            <td><%=time2%></td>
                          </tr>
                          <tr> 
                            <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                          </tr>
                          <tr> 
                            <td height="30" style="padding-left:10;" class="bluesky">담당부서</td>
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
                  </table>
                  <!-- // 민원접수정보 -->
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br>
      <!-- // 민원접수현황 뷰페이지-->
    </td>
  </tr>
</table>
<!--부서간 이첩내역이력관리 리스트 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td style="padding-left:25;"><img src="img/arrow.gif" width="13" height="16" align="absmiddle"> 
      <span class="txt_title">부서간 이첩내역 이력관리</span></td>
  </tr>
  <tr> 
    <td style="padding:10 0 0 25;"> 
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
        <tr height="30"  onMouseOver=this.style.backgroundColor='F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'> 
          <td align="center"><%=i + 1%></td>
          <td align="center"><%=(String)h.get("SH_BUSEO_FROM") %></td>
          <td align="center"><%=(String)h.get("SH_BUSEO_TO") %></td>
          <td style="padding-left:10;" align="center"><%=(String)h.get("SH_INDATE") %></td>
          <td align="center"><%=(String)h.get("SH_STATUS") %></td>
        </tr>
        <tr> 
          <td colspan="10" class="board_line2" height="1"></td>
        </tr>
	<%}%>
<%} else {%>
		<tr height="30"  onMouseOver=this.style.backgroundColor='F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'>
			<td colspan="5" align="center">등록된 자료가 없습니다</td>
		</tr>
<%}%>
      </table>
    </td>
  </tr>
</table>
<input type="hidden" name="thid" value="<%=thid %>">
<input type="hidden" name="PAGE" value="<%=PAGE%>">
</form>
<%@ include file="include/bottom.jsp" %>
