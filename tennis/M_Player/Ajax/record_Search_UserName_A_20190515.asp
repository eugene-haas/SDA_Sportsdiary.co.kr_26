<!--#include file="../Library/ajax_config.asp"-->
<%
	Dim Search_NewTeamGbName, fnd_KeyWord 
	Dim iType : iType =  2  'iType 2 ��ȸ 
	Search_NewTeamGbName = Request("Search_NewTeamGbName") '�μ� 
	fnd_KeyWord 	= Request("fnd_KeyWord") '������ �˻� 
	PlayerIDX = Request("PlayerIDX") '����IDX�� 
	NowPage = Request("ipagenum")  '���� ������ 
  'iType: 1  ������count , 2: ��ȸ  , NowPage ����������,  PagePerData �� ȭ�鿡 ����� count,  BlockPage �������� ǥ�õ� count , TeamGb	 �μ�, KEYWORD �˻�Ű���� 
  LSQL = " EXEC Search_TennisRPing_log_RankingList_New '"&iType&"' ,'"&NowPage&"', 10, 10, '"&Search_NewTeamGbName&"', '"&fnd_keyWord&"'"
	Set LRs = DBCon4.Execute(LSQL)
	If Not(LRs.Eof or LRs.Bof) then 
	    Do until LRs.Eof 
%> 
         <!-- ������ �˻� �˾�â �˻� List  --> 
		    <button class="m_searchPopup__listname" onclick="javascript:view_list('<%= LRs("username")%>');">
        <!--<button  class="m_searchPopup__listname [ _overLayer__close ]" onclick="javascript:fn_list3('<%= LRs("username")%>')">-->
			       <%= LRs("username")%>   <!-- ���� �̸� --> 
			  </button> 
 <%
		  LRs.MoveNext 
		Loop
	 End if 
	 LRs.close()
	 DBClose4()
 %>