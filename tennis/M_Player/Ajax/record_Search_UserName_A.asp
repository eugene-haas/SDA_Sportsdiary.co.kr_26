<!--#include file="../Library/ajax_config.asp"-->
<%
	Dim Search_NewTeamGbName, fnd_KeyWord 
	Dim iType : iType =  2  'iType 2 조회 
	Search_NewTeamGbName = Request("Search_NewTeamGbName") '부서 
	fnd_KeyWord 	= Request("fnd_KeyWord") '선수명 검색 
	PlayerIDX = Request("PlayerIDX") '선수IDX값 
	NowPage = Request("ipagenum")  '현재 페이지 
  'iType: 1  페이지count , 2: 조회  , NowPage 현재페이지,  PagePerData 한 화면에 출력할 count,  BlockPage 페이지엥 표시될 count , TeamGb	 부서, KEYWORD 검색키워드 
  LSQL = " EXEC Search_TennisRPing_log_RankingList_New01 '"&iType&"' ,'"&NowPage&"', 30, 30, '"&Search_NewTeamGbName&"', '"&fnd_keyWord&"', '"&PlayerIDX&"'"
	Set LRs = DBCon4.Execute(LSQL)
	If Not(LRs.Eof or LRs.Bof) then 
	    Do until LRs.Eof 
%> 
         <!-- 선수명 검색 팝업창 검색 List  --> 
		    <button class="m_searchPopup__listname" onclick="javascript:view_list('<%= LRs("username")%>','<%= LRs("PlayerIDX")%>');">
        <!--<button  class="m_searchPopup__listname [ _overLayer__close ]" onclick="javascript:fn_list3('<%= LRs("username")%>')">-->
             <%= LRs("username")%>  ( <%= LRs("TeamNm")%> )<!-- 선수 이름 --> 
             <span class="icon__search_add"><img src="http://img.sportsdiary.co.kr/images/SD/icon/search_add_@3x.png"></span>
			  </button> 
 <%
		  LRs.MoveNext 
		Loop
	 End if 
   %>

<%
	 LRs.close()
	 DBClose4()
 %>