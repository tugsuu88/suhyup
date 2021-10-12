<%
/*****************************************************************************
*Title			: chungtak_find_addr.jsp
*@author		: S.H.M
*@date			: 2017.02.10
*@Description	: 우편번호 검색
*@Copyright		: 
******************************************************************************
*수정일		*수정자		*수정사유
******************************************************************************/
%>

<%@ page import="java.util.*, java.text.*, Bean.Front.Common.*" %>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="session" class="Bean.Front.Common.FrontDbUtil"/>



<%

	try {

		String TableName = null;
		String SelectCondition = null;
	    String WhereCondition = null;
	    String OrderCondition = null;
		String zipcode = null;
	    String sido = null;
	    String gugun = null;
	    String dong = null;
	    String bunji = null;
	    String addr =  null;
		String addr1= "";
	    int PAGE = 0;                                   // default page value of PAGE;
	
	    Vector  ResultVector;
	
	    String SW = request.getParameter("SW");
		String SW_all = request.getParameter("SW_all");
		String where_con = request.getParameter("address_sel");
		String jusogubun = request.getParameter("jusogubun"); //주소구분 0:도로명주소 1:지번주소
		String sidoSelect = request.getParameter("sido");
		String gugunSelect = request.getParameter("gugun");
		String sn = request.getParameter("sn");
		String gusn = request.getParameter("gusn");
		
		String titleName = request.getParameter("titleName");
		
		String zipType = request.getParameter("zipType");
		
		
// 		System.out.println("SW = " +      SW);
// 		System.out.println("SW_all = " +      SW_all);
// 		System.out.println("where_con = " +      where_con);
// 		System.out.println("jusogubun = " +      jusogubun);
// 		System.out.println("sidoSelect = " +      sidoSelect);
// 		System.out.println("gugunSelect = " +      gugunSelect);
// 		System.out.println("sn = " +      sn);
// 		System.out.println("gusn = " +      gusn);
// 		System.out.println("titleName = " +      titleName);
		
		
		if(titleName==null){
			titleName="도로명주소 찾기 ";
		}
		
		if(sidoSelect==null){
			sidoSelect="서울특별시";
		}

		if(gugunSelect==null){
			gugunSelect="";
		}

		if(sn==null){
			sn="0";
		}

		if(gusn==null){
			gusn="0";
		}

		if(jusogubun==null){
			jusogubun="0";
		}

		String 	sTableName = " SH_ZIPCODE ";
		String	sSelectCondition = " DISTINCT gugun ";
		String	sWhereCondition  = " Where sido = '" + FrontDbUtil.ConvertTo8859(sidoSelect) + "'";
		String	sOrderCondition = "";
		
// 		System.out.println(sTableName);
// 		System.out.println(sSelectCondition);
// 		System.out.println(sWhereCondition);
// 		System.out.println(sOrderCondition);
		
		int sPAGE = 0;

		if (SW_all == null || SW_all.length() == 0) SW = "";

		if (SW_all != null && !SW_all.equals("")) {

			SW_all = SW_all.replaceAll("'", "");
			SW_all = SW_all.replaceAll("&", "");
			SW_all = SW_all.replaceAll("\'", "");
			SW_all = SW_all.replaceAll("<", "");
			SW_all = SW_all.replaceAll(">", "");
			SW_all = SW_all.replaceAll("-", "");
			SW_all = SW_all.replaceAll("%", "");
	
			
			TableName       = " SH_ZIPCODE ";
	
			SelectCondition = " zipcode, sido, gugun, dong, bunji ";
			WhereCondition  = " Where sido = '" + FrontDbUtil.ConvertTo8859(sidoSelect) + "'";

			if(!gugunSelect.equals("")) {
				WhereCondition  += " and gugun = '" + FrontDbUtil.ConvertTo8859(gugunSelect) + "'";
			}

			WhereCondition  += " and dong like '%" + FrontDbUtil.ConvertTo8859(SW_all) + "%' ";

			OrderCondition  = " Order by seq Asc";
		}
		
		
		
		

		//out.print("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br/><br/>");
%>

<%@ page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title><%=titleName %> &gt; 우편번호 찾기 &gt; 수협</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/js/public.js"></script>
<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript">
<!--
	//검색
	function goSearch() {

		if(pbform.SW.value == "") {
			alert("검색어를 입력하세요!");
			pbform.SW.focus();
			return;
		}

		document.pbform.address_sel.value = "0";
		document.pbform.sido.value = document.getElementById("sidoSelect").value;

		pbform.submit();
	}

	//검색
	function goSearch_all() {

		if(pbform.SW_all.value == "") {
			alert("검색어를 입력하세요!");
			pbform.SW_all.focus();
			return;
		}

		document.pbform.address_sel.value = "1";
		document.pbform.sido.value = document.getElementById("sidoSelect_all").value;
		document.pbform.sn.value = "<%=sn%>";
		document.pbform.jusogubun.value = "<%=jusogubun%>";
		document.pbform.gugun.value = document.getElementById("guSelect").value;
		
// 		alert(document.pbform.sido.value +" : "+ document.pbform.sn.value +" : "+ document.pbform.jusogubun.value +" : "+ document.pbform.gugun.value);

		pbform.submit();
	}

	//우편번호 선택
	function send_code(zipcode, address, zipType) {
// 		alert(zipcode +"="+ address +"="+ zipType);

		var zip1 = zipcode.substr(0,3);
		var zip2 = zipcode.substr(4,3);
		//alert(address);
		opener.input_zipcode(zip1,zip2,address,zipType);
		window.close();
	}

	function find_addr_onLoad(){
		if("<%=sidoSelect%>" != null) {
			var sn = <%=sn%>;
			var gusn = <%=gusn%>;
			var zipType = <%=zipType%>;
			document.pbform.sidoSelect_all.options[sn].selected  = "true";
			document.pbform.guSelect.options[gusn].selected  = "true";
			document.pbform.sn.value = sn;
			document.pbform.gusn.value = gusn;
			document.pbform.zipType.value = zipType;
		}
	}

	function guSelectList(sido,sn){
		document.pbform.sido.value = document.getElementById("sidoSelect_all").value;
		document.pbform.gugun.value = document.getElementById("guSelect").value;
		document.pbform.jusogubun.value = <%=jusogubun%>;
		document.pbform.sn.value = sn;

		pbform.submit();
	}

	function fnGuListClick(sn){
		
		document.pbform.gusn.value = sn;
	}

	function jusoGubun(flg){
		var titleName = "";
		if(flg=='0'){ 
			titleName = "도로명주소 찾기";
		}else if(flg=='1'){
			titleName = "지번주소 찾기";
		}
		document.pbform.titleName.value = titleName;
		document.pbform.sido.value = document.getElementById("sidoSelect_all").value;
		document.pbform.jusogubun.value = flg;

		document.pbform.submit();
	}

	function EnterDown(e){

		if(e.keyCode == 13){
			goSearch_all();
		}
	}

	function resizeWindowHeight(wValue, hValue) {
	    var popUpWinSize = document.getElementById("popUpWinHeight");
	    var windowHeight = popUpWinSize.offsetHeight + hValue;
		window.resizeTo(wValue, windowHeight);
	}
//-->
</script>
</head>

<body id="popup" onLoad="javascript:find_addr_onLoad();resizeWindowHeight(450,90);">
<form name="pbform" method="post" action="chungtak_find_addr.jsp">


<input type="hidden" name="MD" value="post" />
<input type="hidden" name="address_sel" value="0" />
<input type="hidden" name="jusogubun" value="0" />
<input type="hidden" name="sido" />
<input type="hidden" name="gugun" />
<input type="hidden" name="sn" />
<input type="hidden" name="gusn" />
<input type="hidden" name="titleName" />
<input type="hidden" name="zipType" />



	<!-- 400*500 -->
	<div id="popUpWinHeight" class="wrapPopup">
		<h1 class="dpNone">수협</h1>
		<h2><span class="zipcode">우편번호 찾기</span></h2>

		<!-- 도로명주소 찾기 -->
		<% if(jusogubun.equals("0")) { %>
			<div class="tabs_gray tab2 bdbNone">
				<ul>
				<li class="w50p"><a href="#" onClick="javascript:jusoGubun(0);">도로명주소 찾기</a></li>
				<li class="w50p current"><a href="#" onClick="javascript:jusoGubun(1);">지번주소 찾기</a></li>
				</ul>
			</div>
			<div class="innerBox">
				<h3 class="dpNone">도로명주소 찾기</h3>
				<p class="mgb20 pdt5">
					찾고자 하는 주소의 시, 도와 시,군,구를 선택하신 후<br />
					도로명을 입력하신 후 검색버튼을 눌러주세요.
					<span class="displayB colorBlue mgt10">예) 서울특별시 강남구 선택 후 역삼로 입력</span>
				</p>
				<table class="writeZipcode mgb20" summary="주소의 시 도, 시 군 구, 도로명 으로 우편번호 찾기">
					<caption>도로명주소 찾기</caption>
					<colgroup>
						<col style="width:70px;" />
						<col style="width:auto;" />
						<col style="width:70px;" />
						<col style="width:auto;" />
					</colgroup>
					<tr>
						<th scope="row">시 도</th>
						<td>
							<select id="sidoSelect_all" title="시, 도">
								<option value="서울특별시" onClick='javascript:guSelectList(this.value,0);'>서울특별시</option>
								<option value="인천광역시" onClick='javascript:guSelectList(this.value,1);'>인천광역시</option>
								<option value="경기도" onClick='javascript:guSelectList(this.value,2);'>경기도</option>             
								<option value="대전광역시" onClick='javascript:guSelectList(this.value,3);'>대전광역시</option>
								<option value="대구광역시" onClick='javascript:guSelectList(this.value,4);'>대구광역시</option>
								<option value="경상남도" onClick='javascript:guSelectList(this.value,5);'>경상남도</option>
								<option value="경상북도" onClick='javascript:guSelectList(this.value,6);'>경상북도</option>
								<option value="강원도" onClick='javascript:guSelectList(this.value,7);'>강원도</option>
								<option value="전라남도" onClick='javascript:guSelectList(this.value,8);'>전라남도</option>
								<option value="전라북도" onClick='javascript:guSelectList(this.value,9);'>전라북도</option>
								<option value="충청남도" onClick='javascript:guSelectList(this.value,10);'>충청남도</option>
								<option value="충청북도" onClick='javascript:guSelectList(this.value,11);'>충청북도</option>
								<option value="광주광역시" onClick='javascript:guSelectList(this.value,12);'>광주광역시</option>
								<option value="울산광역시" onClick='javascript:guSelectList(this.value,13);'>울산광역시</option> 
								<option value="부산광역시" onClick='javascript:guSelectList(this.value,14);'>부산광역시</option>
								<option value="세종특별자치시" onClick='javascript:guSelectList(this.value,15);'>세종특별자치시</option>
								<option value="제주특별자치도" onClick='javascript:guSelectList(this.value,16);'>제주특별자치도</option>
							</select>
						</td>
						<th scope="row">시 군 구</th>
						<td>
							<select id="guSelect" title="시, 군, 구">
			        		<%
			        			ResultVector = FrontBoard.list(sTableName, sSelectCondition, sWhereCondition, sOrderCondition, sPAGE, 1);
								
			        			if( ResultVector.size() > 0) {
									for (int i=0; i < ResultVector.size();i++){
										Hashtable h = (Hashtable)ResultVector.elementAt(i);
										gugun = (String) h.get("GUGUN");
							%>
								<option value='<%=gugun%>' onclick="javascript:fnGuListClick(<%=i%>);"><%=gugun%></option>
			                <%
			                		}
								}
							%>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">도로명</th>
						<td colspan="3">
							<input type="text" class="text" style="width:168px;" title="도로명" name="SW_all" onkeypress="javascript:if(event.keyCode==13){EnterDown(event)}" /><a href="javascript:goSearch_all();" class="btn_blue_s01 mgl10"><span>검색</span></a>
						</td>
					</tr>
				</table>

				<%
					ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 1);

					if( ResultVector.size() > 0) {
				%>
				<div class="boxScroll h140 pdt10">
					<p class="mgb15">* 검색 결과중 해당 주소를 클릭하시면 자동으로 입력됩니다.</p>
					<table class="listZipcode" summary="우편번호 검색 결과의 우편번호, 주소">
						<caption>우편번호 검색 결과</caption>
						<colgroup>
							<col style="width:70px;" />
							<col style="width:auto;" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="textC"><strong>우편번호</strong></th>
								<th scope="col" class="pdl10">주소</th>
							</tr>
						</thead>
						<tbody>
							<%		
									for (int i=0; i < ResultVector.size();i++) {
										Hashtable h = (Hashtable)ResultVector.elementAt(i);
										sido = (String) h.get("SIDO");
										gugun = (String) h.get("GUGUN");
										dong = (String) h.get("DONG");
										bunji = (String) h.get("BUNJI");
										addr = sido + " " + gugun + " " + dong + " " + bunji;
										addr1 = sido + " " + gugun + " " + dong + " " + bunji;;
										zipcode = (String) h.get("ZIPCODE");
							%>
							<tr>
								<td class="textC"><strong><%=zipcode%></strong></td>
								<td class="pdl10"><a href='javascript:send_code("<%=zipcode%>","<%=addr1%>","<%=zipType%>")'><%=addr%></a></td>
							</tr>
							<%
									}
							%>
						</tbody>
					</table>
				</div>
				<%
					}
				%>
				<% if( ResultVector.size() == 0){ %>
						<!-- 검색 결과가 없다면 아래의 div를 출력해 주세요. -->
						<div class="no_record">
							검색된 자료가 없습니다.
						</div>
				<% } %>
			</div>
		<% } %>
		<!--// 도로명주소 찾기 -->

		<!-- 지번주소 찾기 -->
		<% if(jusogubun.equals("1")){ %>
			<div class="tabs_gray tab2 bdbNone">
				<ul>
				<li class="w50p current"><a href="#" onClick="javascript:jusoGubun(0);">도로명주소 찾기</a></li>
				<li class="w50p"><a href="#" onClick="javascript:jusoGubun(1);">지번주소 찾기</a></li>
				</ul>
			</div>
			<div class="innerBox">
				<h3 class="dpNone">도로명주소 찾기</h3>
				<p class="mgb20 pdt5">
					찾고자 하는 주소의 시, 도와 시,군,구를 선택하신 후<br />
					동,읍,면,리를 입력하신 후 검색버튼을 눌러주세요.
					<span class="displayB colorBlue mgt10">예) 서울특별시 강남구 선택 후 역삼동 입력</span>
				</p>
				<table class="writeZipcode mgb20" summary="주소의 시 도, 시 군 구, 동,읍,면,리 으로 우편번호 찾기">
					<caption>도로명주소 찾기</caption>
					<colgroup>
						<col style="width:70px;" />
						<col style="width:auto;" />
						<col style="width:70px;" />
						<col style="width:auto;" />
					</colgroup>
					<tr>
						<th scope="row">시 도</th>
						<td>
							<select id="sidoSelect_all" title="시, 도">
								<option value='서울' onClick='javascript:guSelectList(this.value,0);'>서울</option>
								<option value='인천' onClick='javascript:guSelectList(this.value,1);'>인천</option>
								<option value='경기' onClick='javascript:guSelectList(this.value,2);'>경기</option>
								<option value='대전' onClick='javascript:guSelectList(this.value,3);'>대전</option>
								<option value='대구' onClick='javascript:guSelectList(this.value,4);'>대구</option>
								<option value='경남' onClick='javascript:guSelectList(this.value,5);'>경남</option>
								<option value='경북' onClick='javascript:guSelectList(this.value,6);'>경북</option>
								<option value='강원' onClick='javascript:guSelectList(this.value,7);'>강원</option>
								<option value='전남' onClick='javascript:guSelectList(this.value,8);'>전남</option>
								<option value='전북' onClick='javascript:guSelectList(this.value,9);'>전북</option>
								<option value='충남' onClick='javascript:guSelectList(this.value,10);'>충남</option>
								<option value='충북' onClick='javascript:guSelectList(this.value,11);'>충북</option>
								<option value='광주' onClick='javascript:guSelectList(this.value,12);'>광주</option>
								<option value='울산' onClick='javascript:guSelectList(this.value,13);'>울산</option> 
								<option value='부산' onClick='javascript:guSelectList(this.value,14);'>부산</option>
								<option value='제주' onClick='javascript:guSelectList(this.value,15);'>제주</option>
							</select>
						</td>
						<th scope="row">시 군 구</th>
						<td>
							<select id="guSelect" title="시, 군, 구">
			        		<%
			        			ResultVector = FrontBoard.list(sTableName, sSelectCondition, sWhereCondition, sOrderCondition, sPAGE, 1);
								
			        			if( ResultVector.size() > 0) {
									for (int i=0; i < ResultVector.size();i++){
										Hashtable h = (Hashtable)ResultVector.elementAt(i);
										gugun = (String) h.get("GUGUN");
							%>
								<option value='<%=gugun%>' onclick="javascript:fnGuListClick(<%=i%>);"><%=gugun%></option>
			                <%
			                		}
								}
							%>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">동,읍,면,리</th>
						<td colspan="3">
							<input type="text" class="text" style="width:168px;" title="동,읍,면,리명" name="SW_all" onkeypress="javascript:if(event.keyCode==13){EnterDown(event)}" /><a href="javascript:goSearch_all();" class="btn_blue_s01 mgl10"><span>검색</span></a>
						</td>
					</tr>
				</table>

				<%
					ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 1);

					if( ResultVector.size() > 0) {
				%>
				<div class="boxScroll h140 pdt10">
					<p class="mgb15">* 검색 결과중 해당 주소를 클릭하시면 자동으로 입력됩니다.</p>
					<table class="listZipcode" summary="우편번호 검색 결과의 우편번호, 주소">
						<caption>우편번호 검색 결과</caption>
						<colgroup>
							<col style="width:70px;" />
							<col style="width:auto;" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="textC"><strong>우편번호</strong></th>
								<th scope="col" class="pdl10">주소</th>
							</tr>
						</thead>
						<tbody>
							<%		
							
							System.out.println(ResultVector.size());
							
									for (int i=0; i < ResultVector.size();i++) {
										Hashtable h = (Hashtable)ResultVector.elementAt(i);
										sido = (String) h.get("SIDO");
										gugun = (String) h.get("GUGUN");
										dong = (String) h.get("DONG");
										bunji = (String) h.get("BUNJI");
										addr = sido + " " + gugun + " " + dong + " " + bunji;
										addr1 = sido + " " + gugun + " " + dong + " " + bunji;;
										zipcode = (String) h.get("ZIPCODE");
							%>
							<tr>
								<td class="textC"><strong><%=zipcode%></strong></td>
								<td class="pdl10"><a href='javascript:send_code("<%=zipcode%>","<%=addr1%>",<%=zipType%>)'><%=addr%></a></td>
							</tr>
							<%
									}
							%>
						</tbody>
					</table>
				</div>
				<%
					}
				%>
				<% if( ResultVector.size() == 0){ %>
						<!-- 검색 결과가 없다면 아래의 div를 출력해 주세요. -->
						<div class="no_record">
							검색된 자료가 없습니다.
						</div>
				<% } %>
			</div>
		<% } %>
		<!--// 지번주소 찾기 -->
		<div class="btnCenter">
			<a href="#" class="btn_blue_s01"><span>확인</span></a>
		</div>
	</div>
</form>
</body>
</html>
<% 
	} catch(Exception e) {
		out.println("chungtak_find_addr.jsp : " + e.getMessage());
	} finally {
		//
	}
%>