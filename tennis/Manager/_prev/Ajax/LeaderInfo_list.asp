<!--#include file="../Library/config.asp"-->
<%
	'지도자리스트 조회
		
	dim BlockPage   : BlockPage 	= 10	'페이지
	dim B_PSize   	: B_PSize 		= 20	'페이지내 보여지는 목록카운트

	dim TotCount, TotPage
	dim CSearch, CSearch2, CSearch3, CSearch4, CSearch5, CSearch6, CSearch7
	dim FndData, CStrPG, CStrTP
	
	dim currPage   		: currPage  		= fInject(Request("currPage"))
	dim fnd_SEX   		: fnd_SEX 			= fInject(Request("fnd_SEX"))	
	dim fnd_User		: fnd_User 			= fInject(Request("fnd_User"))
	dim fnd_Team		: fnd_Team			= fInject(Request("fnd_Team"))
	dim fnd_REG			: fnd_REG			= fInject(Request("fnd_REG"))
	dim SDate			: SDate				= fInject(Request("SDate"))
	dim EDate			: EDate				= fInject(Request("EDate"))
	
'	response.Write currPage		
'	response.End()
	
	dim cnt			: cnt = 0			'카운트			
	dim CSQL, CRs

	IF Len(currPage) = 0 Then currPage = 1
	
	'기간선택
	IF SDate <> "" AND EDate <> "" Then
		CSearch5 = " AND DateDiff(d, '"&SDate&"',  L.WriteDate)>=0 AND DateDiff(d,  L.WriteDate, '"&EDate&"')>=0 "
	ElseIF SDate <> "" AND EDate = "" Then
		CSearch5 = " AND DateDiff(d,  L.WriteDate, '"&SDate&"')=0 "
	ElseIF SDate = "" AND EDate <> "" Then
		CSearch5 = " AND DateDiff(d, '"&EDate&"',  L.WriteDate)=0 "
	Else
	End IF
	
'	IF fnd_EnterType <> "" Then CSearch = " AND L.EnterType = '"&fnd_EnterType&"'"
	IF fnd_SEX <> "" Then CSearch2 = " AND L.SEX = '"&fnd_SEX&"'"
	IF fnd_User <> "" Then	CSearch3 = " AND L.UserName Like '%"&fnd_User&"%' "
	IF fnd_REG <> "" Then	CSearch4 = " AND L.NowRegYN ='"&fnd_REG&"' "
	
	'팀소속조회 시 SQL
	IF fnd_Team <> "" Then 
		CSearch7 = "			inner join [Sportsdiary].[dbo].[tblTeamInfo] T on L.Team = T.Team "
		CSearch7 = CSearch7 & " 	AND T.DelYN = 'N' "
		CSearch7 = CSearch7 & " 	AND T.SportsGb = '"&Request.Cookies("SportsGb")&"' "
		CSearch7 = CSearch7 & " 	AND T.NowRegYN = 'Y' "
		CSearch7 = CSearch7 & " 	AND T.TeamNm like '%"&fnd_Team&"%'"
	Else
		CSearch7 = CSearch7 & " left join [Sportsdiary].[dbo].[tblTeamInfo] T on L.Team = T.Team "
		CSearch7 = CSearch7 & " 	AND T.DelYN = 'N' "
		CSearch7 = CSearch7 & " 	AND T.SportsGb = '"&Request.Cookies("SportsGb")&"' "
		CSearch7 = CSearch7 & " 	AND T.NowRegYN = 'Y' "
	End IF	
	
	
	CSQL = " 		SELECT COUNT(*) "
	CSQL = CSQL & "		,CEILING(CAST(COUNT(*) AS FLOAT)/"&B_PSize&") " 
	CSQL = CSQL & " FROM [Sportsdiary].[dbo].[tblLeader] L " &CSearch7	
	CSQL = CSQL & "	WHERE L.DelYN = 'N' " 
	CSQL = CSQL & "		AND L.SportsGb = '"&Request.Cookies("SportsGb")&"' " &CSearch2&CSearch3&CSearch4&CSearch5
'	response.Write CSQL
	SET CRs = Dbcon.Execute(CSQL)	
		TotalCount = formatnumber(CRs(0),0)
		TotalPage = CRs(1)
	
	CStrTP = "<div><span>전체 : "&TotalCount&",</span>&nbsp;&nbsp;&nbsp;"
	CStrTP = CStrTP & "<span>"&currPage &" page / " & TotalPage & " pages"
	CStrTP = CStrTP & "</span></div>"
	
	response.Write CStrTP
	
	CSQL = "		SELECT TOP "&currPage * B_PSize 
	CSQL = CSQL & "		T.TeamNm "
	CSQL = CSQL & "		,T.Team Team "
	CSQL = CSQL & "		,T.sido "
	CSQL = CSQL & "		,[SportsDiary].[dbo].[FN_SidoName] (T.sido, '"&Request.Cookies("SportsGb")&"') SidoNm "
	CSQL = CSQL & "		,L.UserName "
	CSQL = CSQL & "		,L.UserPhone "
	CSQL = CSQL & "		,L.LeaderTypeNm "
	CSQL = CSQL & "		,L.Birthday"
	CSQL = CSQL & "		,CASE L.Sex WHEN 'Man' THEN '남' WHEN 'WoMan' THEN '여' END Sex "
	CSQL = CSQL & "		,L.PersonNum "
	CSQL = CSQL & "		,CONVERT(CHAR(10), CONVERT(DATE, L.WriteDate), 102) WriteDt "
	CSQL = CSQL & "		,L.Address "
	CSQL = CSQL & "		,L.AddressDtl "
	CSQL = CSQL & "		,L.NowRegYN "
	CSQL = CSQL & "		,L.PKIndCodeNm "
	CSQL = CSQL & "	FROM [Sportsdiary].[dbo].[tblLeader] L "&CSearch7
	CSQL = CSQL & "	WHERE L.DelYN = 'N' "
	CSQL = CSQL & "		AND L.SportsGb = '"&Request.Cookies("SportsGb")&"' "&CSearch2&CSearch3&CSearch4&CSearch5
	CSQL = CSQL & "	ORDER BY L.WriteDate DESC, L.UserName	 "
				
'	response.Write CSQL
				
	SET CRs = Dbcon.Execute(CSQL)
	
	FndData = "			 <table class='table-list member-info'>"
	FndData = FndData & "	<thead>"
	FndData = FndData & "		<tr>"
	FndData = FndData & "			<th>번호</th>"
	FndData = FndData & "			<th>이름</th>"
	FndData = FndData & "			<th>생년월일</th>"
	FndData = FndData & "			<th>성별</th>"	
	FndData = FndData & "			<th>지역</th>"
	FndData = FndData & "			<th>소속</th>"	
	FndData = FndData & "			<th>구분</th>"		
	FndData = FndData & "			<th>팀코드</th>"	
	FndData = FndData & "			<th>구분</th>"
	FndData = FndData & "			<th>Phone</th>"
	FndData = FndData & "			<th>체육인번호</th>"
	FndData = FndData & "			<th>주소</th>"
	FndData = FndData & "			<th>상세주소</th>"
	FndData = FndData & "			<th>등록일</th>"
	FndData = FndData & "		</tr>"
	FndData = FndData & "	</thead>"
	FndData = FndData & "	<tbody>"
	
	If Not(CRs.Eof Or CRs.Bof) Then 

		CRs.Move (currPage - 1) * B_PSize
		
		Do Until CRs.eof

			cnt = cnt + 1
			
			FndData = FndData & "<tr>"
			FndData = FndData & "	<td>"&totalcount - (currPage - 1) * B_Psize - cnt+1&"</td>"
			FndData = FndData & "	<td>"&CRs("UserName")&"</td>"
			FndData = FndData & "	<td>"&CRs("Birthday")&"</td>"
			FndData = FndData & "	<td>"&CRs("Sex")&"</td>"					
			FndData = FndData & "	<td>"&CRs("SidoNm")&"</td>"			
			FndData = FndData & "	<td>"&CRs("TeamNm")&"</td>"			
			FndData = FndData & "	<td>"&CRs("PKIndCodeNm")&"</td>"	
			FndData = FndData & "	<td>"&CRs("Team")&"</td>"
			FndData = FndData & "	<td>"&CRs("LeaderTypeNm")&"</td>"
			FndData = FndData & "	<td>"&CRs("UserPhone")&"</td>"
			FndData = FndData & "	<td>"&CRs("PersonNum")&"</td>"
			FndData = FndData & "	<td>"&CRs("Address")&"</td>"
			FndData = FndData & "	<td>"&CRs("AddressDtl")&"</td>"
			FndData = FndData & "	<td>"&CRs("WriteDt")&"</td>"
			FndData = FndData & "</tr>"

			CRs.movenext
		Loop	

	End IF	
	
	FndData = FndData & "	</tbody>"
	FndData = FndData & "</table>"
	
		CRs.Close
	SET CRs = Nothing
		
	response.Write FndData
	
	
	dim intTemp

	CStrPG = CStrPG & " <div class='bullet-wrap'>"
	CStrPG = CStrPG & " <div class='board-bullet pagination'>"
	
	intTemp = Int((currPage - 1) / BlockPage) * BlockPage + 1
	
	If intTemp = 1 Then
		
	Else 
		CStrPG = CStrPG & "<li class='prev'> <a href=""javascript:chk_Submit('"&intTemp - BlockPage&"');"" class='prev'><img src='../images/board/board-l-arrow@3x.png' alt='이전페이지'></a></li> "
	End If	
	
	dim intLoop : intLoop = 1
	
	Do Until intLoop > BlockPage Or intTemp > TotalPage
	
		If CInt(intTemp) = CInt(currPage) Then
			CStrPG = CStrPG & "<li> <a href='#' class=""on"">"&intTemp&"</a> </li>" 
		Else
			CStrPG = CStrPG & "<li> <a href=""javascript:chk_Submit('"&intTemp&"');"">"&intTemp&"</a> </li>"
		End If
		
		intTemp = intTemp + 1
		intLoop = intLoop + 1
	Loop
	
	IF intTemp > TotalPage Then

	Else
		CStrPG = CStrPG & "<li class='next'><a href=""javascript:chk_Submit('"&intTemp&"');"" class='next'><img src='../images/board/board-r-arrow@3x.png' alt='다음페이지'></a></li>"
	End IF	
  
    CStrPG = CStrPG & "</div>"
    CStrPG = CStrPG & "</div>"
	
	response.Write CStrPG

	
	DBClose()

	
%>