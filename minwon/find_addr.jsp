<%

/*****************************************************************************

*Title			: zip_search.jsp

*@author		: K.H.S

*@date			: 2007-10

*@Description	: 우편번호 검색

*@Copyright		: 

******************************************************************************

*수정일		*수정자		*수정사유

******************************************************************************/

%>



<%@ page import="java.util.*, java.text.*, Bean.Front.Common.*"  contentType="text/html;charset=euc-kr"%>

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
		
		String sidoSelect = request.getParameter("sido");

	

	    if (SW == null || SW.length() == 0) SW = "";

	    if (SW != null && !SW.equals("")){

			SW = SW.replaceAll("'", "");

			SW = SW.replaceAll("&", "");

			SW = SW.replaceAll("\'", "");

			SW = SW.replaceAll("<", "");

			SW = SW.replaceAll(">", "");

			SW = SW.replaceAll("-", "");

			SW = SW.replaceAll("%", "");

			TableName       = " SH_ZIPCODE ";

			SelectCondition = " zipcode, sido, gugun, dong, bunji ";

			

		

			WhereCondition  = " Where sido = '" + FrontDbUtil.ConvertTo8859(sidoSelect) + "'";
			
			WhereCondition  += " and dong like '%" + FrontDbUtil.ConvertTo8859(SW) + "%'";
			

			OrderCondition  = " Order by seq Asc";

		}



		if (SW_all == null || SW_all.length() == 0) SW = "";

	    if (SW_all != null && !SW_all.equals("")){

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

			WhereCondition  += " and dong = '" + FrontDbUtil.ConvertTo8859(SW_all) + "' ";

			

			

			OrderCondition  = " Order by seq Asc";

		}

		//out.print("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br/><br/>");

%>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>

<title>수협 - 바다사랑 고객사랑</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/member.css' />

<style>

		body {

			background:none;

		}

		#add_d {

			height:170px;

			overflow:auto;

		    scrollbar-face-color:#F8F8F8;

		    scrollbar-highlight-color:#D3D3D3;

		    scrollbar-shadow-color:#D3D3D3;

		    scrollbar-3dlight-color:#FFFFFF;

		    scrollbar-darkshadow-color:#FFFFFF;

		    scrollbar-arrow-color:#8b9ea6; 

		    scrollbar-track-color:#DDDDDD;

		}

		}

		#add_t {

			width:345px;

			margin-top:10px;

			background:url(/member/images/pt_bg_ad.gif) no-repeat 0 0;

		}

		#add_t caption {

			text-align:left;

			padding-bottom:3px;

		}

		#add_t thead th{

			padding-top:6px;

			height:25px;

			border-bottom:1px solid #EAEAEA;

		}

		#add_t tbody th, #add_t tbody td {

			height:25px;

			padding:0;

			border-bottom:1px solid #EAEAEA;

		}

		#add_t tbody th {

			width:70px;

		}

		.no_record {

			border:1px solid #EAEAEA;

			border-top:0;	

			height:170px;

		}

</style>



<script language="javascript">

<!--

	//검색

	function goSearch() {

		if(pbform.SW.value == ""){

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

		if(pbform.SW_all.value == ""){

			alert("검색어를 입력하세요!");

			pbform.SW_all.focus();

			return;

		}

		document.pbform.address_sel.value = "1";
		document.pbform.sido.value = document.getElementById("sidoSelect_all").value;
		pbform.submit();

	}

	

	//우편번호 선택

	function send_code(zipcode, address) {

		var zip1 = zipcode.substr(0,3);

		var zip2 = zipcode.substr(4,3);

		//alert(address);

		opener.input_zipcode(zip1,zip2,address);

		window.close();

	}

//-->

</script>



</head>



<body id="popup" >

<form name="pbform" method="post" action="find_addr.jsp">

	<input type="hidden" name="MD" value="post">

	<input type="hidden" name="address_sel" value="0">
    
    <input type="hidden" name="sido">

<table cellspacing="0" align="center" id="cwt">

<tr>

	<td>

	<p class="title"><img src="images/address_title.gif" /></p>

	<p class="comment">찾고자 하는 주소를 입력하신 후 검색버튼을 눌러주세요</p>

	<p class="input clear">

		<label for="sidoSelect_all">동.읍.면.리</label>
        

		<select id="sidoSelect_all" style="width:80px;">
        		<option value="서울">서울</option>
                <option value="서울특별시">서울특별시</option>
                <option value="인천">인천</option>
                <option value="인천광역시">인천광역시</option>
                <option value="경기">경기</option>
                <option value="경기도">경기도</option>                
                <option value="대전">대전</option>
                <option value="대전광역시">대전광역시</option>
                <option value="대구">대구</option>
                <option value="대구광역시">대구광역시</option>
                <option value="경남">경남</option>
                <option value="경상남도">경상남도</option>
                <option value="경북">경북</option>
                <option value="경상북도">경상북도</option>
                <option value="강원">강원</option>
                <option value="강원도">강원도</option>
                <option value="전남">전남</option>
                <option value="전라남도">전라남도</option>
                <option value="전북">전북</option>
                <option value="전라북도">전라북도</option>
                <option value="충남">충남</option>
                <option value="충청남도">충청남도</option>
                <option value="충북">충북</option>
                <option value="충청북도">충청북도</option>
                <option value="광주">광주</option>
                <option value="광주광역시">광주광역시</option>
                <option value="울산">울산</option>
                <option value="울산광역시">울산광역시</option> 
                <option value="부산">부산</option>
                <option value="부산광역시">부산광역시</option>
                <option value="세종특별자치시">세종특별자치시</option>
                <option value="제주">제주</option>
                <option value="제주특별자치도">제주특별자치도</option>

        </select>
        <input type="text" class="typeText" style="width:100px;" name="SW_all"/>

		<a href="javascript:goSearch_all();"><img src="../images/btT01Search.gif" title="검색" alt="검색" style="margin-top:5px;" /></a>

	</p>

	<p class="input clear">

	&nbsp;&nbsp;&nbsp;&nbsp;검색된 결과가 없는 경우 아래 검색을 이용해 주십시오.	

	</p>

	<p class="input clear">

		<label for="sidoSelect">동.읍.면.리</label>
		<select id="sidoSelect" style="width:80px;">
        		<option value="서울">서울</option>
                <option value="서울특별시">서울특별시</option>
                <option value="인천">인천</option>
                <option value="인천광역시">인천광역시</option>
                <option value="경기">경기</option>
                <option value="경기도">경기도</option>                
                <option value="대전">대전</option>
                <option value="대전광역시">대전광역시</option>
                <option value="대구">대구</option>
                <option value="대구광역시">대구광역시</option>
                <option value="경남">경남</option>
                <option value="경상남도">경상남도</option>
                <option value="경북">경북</option>
                <option value="경상북도">경상북도</option>
                <option value="강원">강원</option>
                <option value="강원도">강원도</option>
                <option value="전남">전남</option>
                <option value="전라남도">전라남도</option>
                <option value="전북">전북</option>
                <option value="전라북도">전라북도</option>
                <option value="충남">충남</option>
                <option value="충청남도">충청남도</option>
                <option value="충북">충북</option>
                <option value="충청북도">충청북도</option>
                <option value="광주">광주</option>
                <option value="광주광역시">광주광역시</option>
                <option value="울산">울산</option>
                <option value="울산광역시">울산광역시</option> 
                <option value="부산">부산</option>
                <option value="부산광역시">부산광역시</option>
                <option value="세종특별자치시">세종특별자치시</option>
                <option value="제주">제주</option>
                <option value="제주특별자치도">제주특별자치도</option>
        </select>
		<input type="text" class="typeText" style="width:100px;" name="SW"/>

		<a href="javascript:goSearch();"><img src="../images/btT01Search.gif" alt="검색" title="검색" style="margin-top:5px;" /></a>

	</p>



							<%

								ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 1);

								if( ResultVector.size() > 0){

							%>

								<div id="add_d">

									<table cellspacing="0" id="add_t">

									<caption>*검색 결과중 해당 주소를 클릭하시면 자동으로 입력됩니다.</caption>

									<thead>

									<tr>

										<th>우편번호</th>

										<th>주소</th>

									</tr>

									</thead>

									<tbody>

							<%		

									for (int i=0; i < ResultVector.size();i++){

										Hashtable h = (Hashtable)ResultVector.elementAt(i);

										sido = (String) h.get("SIDO");

										gugun = (String) h.get("GUGUN");

										dong = (String) h.get("DONG");

										bunji = (String) h.get("BUNJI");

										addr = sido + " " + gugun + " " + dong + " " + bunji;

										addr1 = 

sido + " " + gugun + " " + dong;

										zipcode = (String) h.get("ZIPCODE");

							%>

								<tr>

									<th><%=zipcode%></th>

									<td><a href='javascript:send_code("<%=zipcode%>","<%=addr1%>")'><%=addr%></a></td>

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

<!-- -->

	<p class="btn"><img src="../pub_img/btT01Confirm.gif"  title="확인"></p>

	</td>

</tr>

</table>

</form>

</body>

</html>



<% 

	} catch(Exception e) {

		out.println("zip_search.jsp : " + e.getMessage());

	} finally {



	}

%> 