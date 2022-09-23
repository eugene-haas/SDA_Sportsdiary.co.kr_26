<!-- #include virtual="/pub/class/json2.asp" -->
<%
'			Call game.Set("gtitle", "Korea Masters 2017" )
'			Call game.Set("gevent", "MS" )
'			Call game.Set("gno", "R64 - #29" )
'			Call game.Set("gdate", "Now " & year(date) )
'			Call game.Set("gcourtno", 5 )
'			Call game.Set("umpire", "Ho Hee Shen (SGP)" )
'			Call game.Set("servicejudge", "Deepak Thapa (NEP)" )
'			Call game.Set("starttime", "20:28" )
'			Call game.Set("endtime", "21:25" )
'
'			stime = Date() & " " & game.starttime & ":00"
'			etime = Date() & " " & game.endtime & ":00"
'			duration = DateDiff("n", stime, etime)
'			Call game.Set("gduration", duration )
'
'
'
'			Call teamL.Set("p1", "KO Joon Hyung" )
'			Call teamL.Set("p2", "KO Joon Hyung2" )
'			Call teamL.Set("nation", "Korea" )
'			Call teamL.Set("set1", "25" )
'			Call teamL.Set("set2", "14" )
'			Call teamL.Set("set3", "16" )
'
'
'
'			Call teamR.Set("p1", "LU Guangzu" )
'			Call teamR.Set("p2", "LU Guangzu2" )
'			Call teamR.Set("nation", "China" )
'			Call teamR.Set("set1", "5" )
'			Call teamR.Set("set2", "4" )
'			Call teamR.Set("set3", "6" )







'############################################################
DEC_GameLevelDtlIDX = 1185
DEC_TeamGameNum = 2
DEC_GameNum = 1



	'기본정보
		titleSQL = "(select top 1 gametitlename from tblGameTitle where gametitleidx = CCC.GameTitleIDX ) as gametitle "
		LSQL = " SELECT "& titleSQL &", CCC.GameTitleIDX, CCC.GameLevelDtlIDX, CCC.TeamGameNum, CCC.GameNum, CCC.TeamGb, CCC.Level, CCC.LTourneyGroupIDX , CCC.RTourneyGroupIDX,"
		LSQL = LSQL & " 	CCC.TeamGbNM, CCC.LevelNM, CCC.GameTypeNM,"
		LSQL = LSQL & " 	CCC.LResult, CCC.LResultType, CCC.LResultNM, CCC.LJumsu, CCC.LResultDtl,"
		LSQL = LSQL & " 	CCC.RResult, CCC.RResultType, CCC.RResultNM, CCC.RJumsu, CCC.RResultDtl,"
		LSQL = LSQL & " 	CCC.GameStatus, CCC.[ROUND] AS GameRound, CCC.Sex,"
		LSQL = LSQL & " 	CCC.TempNum, CCC.TurnNum, CCC.GroupGameGb,"
		LSQL = LSQL & " 	CCC.LPlayer1, CCC.LPlayer2, CCC.Rplayer1, CCC.Rplayer2, CCC.LTeam1, CCC.LTeam2, CCC.RTeam1, CCC.RTeam2, CCC.StadiumNum, CCC.StadiumIDX,"
		LSQL = LSQL & " 	CCC.GameDay, CCC.LevelJooNum, CCC.LevelDtlJooNum, CCC.LevelDtlName, dbo.FN_NameSch(CCC.StadiumIDX, 'StadiumIDX') AS StadiumName, PlayLevelType, LevelJooName,"
		LSQL = LSQL & " 	CCC.Win_TourneyGroupIDX, CCC.LGroupJumsu, CCC.RGroupJumsu, CCC.LDtlJumsu, CCC.RDtlJumsu, CCC.MaxPoint, "			

		LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(CCC.Sex, 'PubCode') AS SexName,"
		LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(CCC.PlayType, 'PubCode') AS PlayTypeName,"
		LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(CCC.TeamGb, 'TeamGb') AS TeamGbName,"
		LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(CCC.Level, 'Level') AS LevelName,"
		LSQL = LSQL & " CCC.LevelJooNum AS LevelJooNumDtl,"
		LSQL = LSQL & " LPlayerIDX1, LPlayerIDX2, RPlayerIDX1, RPlayerIDX2"

		LSQL = LSQL & " FROM "
		LSQL = LSQL & " ("
		LSQL = LSQL & " 	SELECT "
		LSQL = LSQL & " 	BBB.GameTitleIDX, BBB.GameLevelDtlIDX, BBB.TeamGameNum, BBB.GameNum, BBB.TeamGb, BBB.Level, BBB.LTourneyGroupIDX , BBB.RTourneyGroupIDX,"
		LSQL = LSQL & " 	BBB.TeamGbNM, BBB.LevelNM, BBB.GameTypeNM,"
		LSQL = LSQL & " 	BBB.LResult, BBB.LResultType, BBB.LResultNM, BBB.LJumsu, BBB.LResultDtl,"
		LSQL = LSQL & " 	BBB.RResult, BBB.RResultType, BBB.RResultNM, BBB.RJumsu, BBB.RResultDtl,"			
		LSQL = LSQL & " 	BBB.GameStatus, BBB.[ROUND], BBB.Sex,"
		LSQL = LSQL & " 	ROW_NUMBER() OVER(ORDER BY CONVERT(BIGINT,ISNULL(BBB.TurnNum,'0')), CONVERT(BIGINT,ISNULL(BBB.TeamGameNum,'0')) ASC, CONVERT(BIGINT,ISNULL(BBB.GameNum,'0'))) AS TempNum, TurnNum, PlayLevelType, GroupGameGb, StadiumNum, StadiumIDX,"
		LSQL = LSQL & " 	GameDay, LevelJooNum, LevelDtlJooNum, LevelDtlName, LevelJooName, BBB.PlayType,"
		LSQL = LSQL & " 	LPlayer1, LPlayer2, Rplayer1, Rplayer2, LTeam1, LTeam2, RTeam1, RTeam2,"
		LSQL = LSQL & " 	LPlayerIDX1, LPlayerIDX2, RPlayerIDX1, RPlayerIDX2,"
		LSQL = LSQL & " 	BBB.Win_TourneyGroupIDX, BBB.LGroupJumsu, BBB.RGroupJumsu, BBB.LDtlJumsu, BBB.RDtlJumsu, BBB.MaxPoint "			
		LSQL = LSQL & " 	FROM"
		LSQL = LSQL & " 	("
		LSQL = LSQL & " 		SELECT AA.GameTitleIDX, AA.GameLevelDtlIDX, AA.TeamGameNum, AA.GameNum, AA.TeamGb, AA.Level, AA.LTourneyGroupIDX , AA.RTourneyGroupIDX,"
		LSQL = LSQL & " 		AA.TeamGbNM, AA.LevelNM, AA.GameTypeNM,"
		LSQL = LSQL & " 		AA.LResult, AA.LResultType, AA.LResultNM, AA.LJumsu,"
		LSQL = LSQL & " 		AA.RResult, AA.RResultType, AA.RResultNM, AA.RJumsu,"
		LSQL = LSQL & " 		AA.GameStatus, AA.[ROUND], AA.Sex, AA.TurnNum, AA.PlayLevelType, AA.PlayType, AA.GroupGameGb, AA.StadiumNum, AA.StadiumIDX, AA.GameDay, AA.LevelJooNum, AA.LevelDtlJooNum, AA.LevelDtlName, AA.LevelJooName, AA.MaxPoint, AA.LResultDtl, AA.RResultDtl,"
		LSQL = LSQL & " 		AA.TourneyGroupIDX AS Win_TourneyGroupIDX, AA.LGroupJumsu, AA.RGroupJumsu, AA.LDtlJumsu, AA.RDtlJumsu,"
		LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',LPlayers) > 0 THEN LEFT(LPlayers,CHARINDEX('|',LPlayers)-1) ELSE LPlayers END  AS LPlayer1, "
		LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',LPlayerIDXs) > 0 THEN LEFT(LPlayerIDXs,CHARINDEX('|',LPlayerIDXs)-1) ELSE LPlayerIDXs END  AS LPlayerIDX1, "
		LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',LPlayers) > 0 THEN RIGHT(LPlayers,CHARINDEX('|',REVERSE(LPlayers))-1) ELSE '' END  AS LPlayer2, "
		LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',LPlayerIDXs) > 0 THEN RIGHT(LPlayerIDXs,CHARINDEX('|',REVERSE(LPlayerIDXs))-1) ELSE '' END  AS LPlayerIDX2, "
		LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',RPlayers) > 0 THEN LEFT(RPlayers,CHARINDEX('|',RPlayers)-1) ELSE RPlayers END AS RPlayer1, "
		LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',RPlayerIDXs) > 0 THEN LEFT(RPlayerIDXs,CHARINDEX('|',RPlayerIDXs)-1) ELSE RPlayerIDXs END AS RPlayerIDX1, "
		LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',RPlayers) > 0 THEN RIGHT(RPlayers,CHARINDEX('|',REVERSE(RPlayers))-1) ELSE '' END  AS RPlayer2, "
		LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',RPlayerIDXs) > 0 THEN RIGHT(RPlayerIDXs,CHARINDEX('|',REVERSE(RPlayerIDXs))-1) ELSE '' END  AS RPlayerIDX2, "
		LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',LTeams) > 0 THEN LEFT(LTeams,CHARINDEX('|',LTeams)-1) ELSE LTeams END AS LTeam1, "
		LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',LTeams) > 0 THEN RIGHT(LTeams,CHARINDEX('|',REVERSE(LTeams))-1) ELSE '' END AS LTeam2, "
		LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',RTeams) > 0 THEN LEFT(RTeams,CHARINDEX('|',RTeams)-1) ELSE RTeams END AS RTeam1, "
		LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',RTeams) > 0 THEN RIGHT(RTeams,CHARINDEX('|',REVERSE(RTeams))-1) ELSE '' END AS RTeam2"
		LSQL = LSQL & " 		FROM"
		LSQL = LSQL & " 		("
		LSQL = LSQL & " 		    SELECT A.GameTitleIDX, A.GameLevelDtlIDX, A.TeamGameNum, A.GameNum, A.TeamGb, A.Level, CONVERT(VARCHAR(10),A.TourneyGroupIDX) AS LTourneyGroupIDX, CONVERT(VARCHAR(10),B.TourneyGroupIDX) AS RTourneyGroupIDX, "
		LSQL = LSQL & " 		    KoreaBadminton.dbo.FN_NameSch(A.TeamGb,'TeamGb') AS TeamGbNM, KoreaBadminton.dbo.FN_NameSch(A.Level,'Level') AS LevelNM,"
		LSQL = LSQL & " 		    KoreaBadminton.dbo.FN_NameSch(D.PlayType,'PubCode') AS GameTypeNM,"
		LSQL = LSQL & " 		    E.Result AS LResult, E.ResultDtl AS LResultDtl, dbo.FN_NameSch(E.Result, 'PubType') AS LResultType, dbo.FN_NameSch(E.Result, 'PubCode') AS LResultNM, E.Jumsu AS LJumsu,"
		LSQL = LSQL & " 		    F.Result AS RResult, F.ResultDtl AS RResultDtl, dbo.FN_NameSch(F.Result, 'PubType') AS RResultType, dbo.FN_NameSch(F.Result, 'PubCode') AS RResultNM, F.Jumsu AS RJumsu,"
		LSQL = LSQL & " 		    E.Result, dbo.FN_NameSch(E.Result, 'PubType') AS ResultType, dbo.FN_NameSch(E.Result, 'PubCode') AS ResultNM, E.Jumsu,"
		LSQL = LSQL & " 		    KoreaBadminton.dbo.FN_GameStatus(A.GameLevelDtlidx, A.TeamGameNum, A.GameNum) AS GameStatus, A.[ROUND], C.PlayLevelType, A.ORDERBY, dbo.FN_NameSch(D.Sex, 'PubCode') AS Sex,"
		LSQL = LSQL & " 		    A.TurnNum, D.GroupGameGb, A.StadiumNum, A.StadiumIDX, A.GameDay, D.LevelJooNum, D.PlayType, C.LevelJooNum AS LevelDtlJooNum, C.LevelDtlName, dbo.FN_NameSch(D.LevelJooName,'Pubcode') AS LevelJooName, C.MaxPoint,"
		LSQL = LSQL & " 				KoreaBadminton.dbo.FN_WinGroupIDX(A.GameLevelDtlidx, A.TeamGameNum, A.GameNum) AS TourneyGroupIDX,"
		LSQL = LSQL & " 				KoreaBadminton.dbo.FN_GroupJumsu(A.GameLevelDtlidx, A.TeamGameNum, A.GameNum, A.TourneyGroupIDX) AS LGroupJumsu, "
		LSQL = LSQL & " 				KoreaBadminton.dbo.FN_GroupJumsu(A.GameLevelDtlidx, A.TeamGameNum, A.GameNum, B.TourneyGroupIDX) AS RGroupJumsu, "
		LSQL = LSQL & " 				KoreaBadminton.dbo.FN_1GameWinPoint(A.GameLevelDtlidx, A.TourneyGroupIDX, A.TeamGameNum, A.GameNum) AS LDtlJumsu, "
		LSQL = LSQL & " 				KoreaBadminton.dbo.FN_1GameWinPoint(A.GameLevelDtlidx, B.TourneyGroupIDX, A.TeamGameNum, A.GameNum) AS RDtlJumsu "

		LSQL = LSQL & " 		    ,STUFF(("
		LSQL = LSQL & " 		    		SELECT  DISTINCT (  "
		LSQL = LSQL & " 		    			SELECT  '|'   + UserName "
		LSQL = LSQL & " 		    			FROM    KoreaBadminton.dbo.tblTourneyPlayer  "
		LSQL = LSQL & " 		    			WHERE   TourneyGroupIDX    = AAA.TourneyGroupIDX  "

		LSQL = LSQL & " 						AND GameLevelDtlidx = AAA.GameLevelDtlidx"
		LSQL = LSQL & " 						AND DelYN = 'N'"

		LSQL = LSQL & " 		    			FOR XML PATH('')  "
		LSQL = LSQL & " 		    			)  "
		LSQL = LSQL & " 		    		FROM    KoreaBadminton.dbo.tblTourneyPlayer AAA  "
		LSQL = LSQL & " 		    		WHERE AAA.GameLevelDtlidx = A.GameLevelDtlidx"
		LSQL = LSQL & " 		    		AND AAA.TourneyGroupIDX = A.TourneyGroupIDX"

		LSQL = LSQL & " 					AND DelYN = 'N'"

		LSQL = LSQL & " 		    		),1,1,'') AS LPlayers"

		LSQL = LSQL & " 		    ,STUFF(("
		LSQL = LSQL & " 		    		SELECT  DISTINCT (  "
		LSQL = LSQL & " 		    			SELECT  '|'   + CONVERT(VARCHAR(10),MemberIDX) "
		LSQL = LSQL & " 		    			FROM    KoreaBadminton.dbo.tblTourneyPlayer  "
		LSQL = LSQL & " 		    			WHERE   TourneyGroupIDX    = AAA.TourneyGroupIDX  "

		LSQL = LSQL & " 						AND GameLevelDtlidx = AAA.GameLevelDtlidx"
		LSQL = LSQL & " 						AND DelYN = 'N'"

		LSQL = LSQL & " 		    			FOR XML PATH('')  "
		LSQL = LSQL & " 		    			)  "
		LSQL = LSQL & " 		    		FROM    KoreaBadminton.dbo.tblTourneyPlayer AAA  "
		LSQL = LSQL & " 		    		WHERE AAA.GameLevelDtlidx = A.GameLevelDtlidx"
		LSQL = LSQL & " 		    		AND AAA.TourneyGroupIDX = A.TourneyGroupIDX"

		LSQL = LSQL & " 					AND DelYN = 'N'"

		LSQL = LSQL & " 		    		),1,1,'') AS LPlayerIDXs"

		LSQL = LSQL & " 		    ,STUFF(("
		LSQL = LSQL & " 		    		SELECT  DISTINCT (  "
		LSQL = LSQL & " 		    			SELECT  '|'   + UserName "
		LSQL = LSQL & " 		    			FROM    KoreaBadminton.dbo.tblTourneyPlayer  "
		LSQL = LSQL & " 		    			WHERE   TourneyGroupIDX    = AAA.TourneyGroupIDX  "

		LSQL = LSQL & " 						AND GameLevelDtlidx = AAA.GameLevelDtlidx"
		LSQL = LSQL & " 						AND DelYN = 'N'"

		LSQL = LSQL & " 		    			FOR XML PATH('')  "
		LSQL = LSQL & " 		    			)  "
		LSQL = LSQL & " 		    		FROM    KoreaBadminton.dbo.tblTourneyPlayer AAA  "
		LSQL = LSQL & " 		    		WHERE AAA.GameLevelDtlidx = A.GameLevelDtlidx"
		LSQL = LSQL & " 		    		AND AAA.TourneyGroupIDX = B.TourneyGroupIDX"

		LSQL = LSQL & " 					AND DelYN = 'N'"

		LSQL = LSQL & " 		    		),1,1,'') AS RPlayers"

		LSQL = LSQL & " 		    ,STUFF(("
		LSQL = LSQL & " 		    		SELECT  DISTINCT (  "
		LSQL = LSQL & " 		    			SELECT  '|'   + CONVERT(VARCHAR(10),MemberIDX) "
		LSQL = LSQL & " 		    			FROM    KoreaBadminton.dbo.tblTourneyPlayer  "
		LSQL = LSQL & " 		    			WHERE   TourneyGroupIDX    = AAA.TourneyGroupIDX  "

		LSQL = LSQL & " 						AND GameLevelDtlidx = AAA.GameLevelDtlidx"
		LSQL = LSQL & " 						AND DelYN = 'N'"

		LSQL = LSQL & " 		    			FOR XML PATH('')  "
		LSQL = LSQL & " 		    			)  "
		LSQL = LSQL & " 		    		FROM    KoreaBadminton.dbo.tblTourneyPlayer AAA  "
		LSQL = LSQL & " 		    		WHERE AAA.GameLevelDtlidx = A.GameLevelDtlidx"
		LSQL = LSQL & " 		    		AND AAA.TourneyGroupIDX = B.TourneyGroupIDX"

		LSQL = LSQL & " 					AND DelYN = 'N'"

		LSQL = LSQL & " 		    		),1,1,'') AS RPlayerIDXs"

		LSQL = LSQL & " "
		LSQL = LSQL & " 		    ,STUFF((		"
		LSQL = LSQL & " 		    		SELECT  DISTINCT (  "
		LSQL = LSQL & " 		    			SELECT  '|'   + dbo.FN_NameSch(Team,'Team')"
		LSQL = LSQL & " 		    			FROM    KoreaBadminton.dbo.tblTourneyPlayer " 
		LSQL = LSQL & " 		    			WHERE   TourneyGroupIDX    = AAA.TourneyGroupIDX  "

		LSQL = LSQL & " 						AND GameLevelDtlidx = AAA.GameLevelDtlidx"
		LSQL = LSQL & " 						AND DelYN = 'N'"

		LSQL = LSQL & " 		    			FOR XML PATH('')  "
		LSQL = LSQL & " 		    			)  "
		LSQL = LSQL & " 		    		FROM    KoreaBadminton.dbo.tblTourneyPlayer AAA  "
		LSQL = LSQL & " 		    		WHERE AAA.GameLevelDtlidx = A.GameLevelDtlidx"
		LSQL = LSQL & " 		    		AND AAA.TourneyGroupIDX = A.TourneyGroupIDX"

		LSQL = LSQL & " 					AND DelYN = 'N'"

		LSQL = LSQL & " 		    		),1,1,'') AS LTeams"
		LSQL = LSQL & " 		    ,STUFF((		"
		LSQL = LSQL & " 		    		SELECT  DISTINCT (  "
		LSQL = LSQL & " 		    			SELECT  '|'   + dbo.FN_NameSch(Team,'Team')"
		LSQL = LSQL & " 		    			FROM    KoreaBadminton.dbo.tblTourneyPlayer  "
		LSQL = LSQL & " 		    			WHERE   TourneyGroupIDX    = AAA.TourneyGroupIDX  "

		LSQL = LSQL & " 						AND GameLevelDtlidx = AAA.GameLevelDtlidx"
		LSQL = LSQL & " 						AND DelYN = 'N'"

		LSQL = LSQL & " 		    			FOR XML PATH('')  "
		LSQL = LSQL & " 		    			)  "
		LSQL = LSQL & " 		    		FROM    KoreaBadminton.dbo.tblTourneyPlayer AAA  "
		LSQL = LSQL & " 		    		WHERE AAA.GameLevelDtlidx = A.GameLevelDtlidx"
		LSQL = LSQL & " 		    		AND AAA.TourneyGroupIDX = B.TourneyGroupIDX"

		LSQL = LSQL & " 					AND DelYN = 'N'"

		LSQL = LSQL & " 		    		),1,1,'') AS RTeams"
		LSQL = LSQL & " "
		LSQL = LSQL & " 		    FROM tblTourney A"
		LSQL = LSQL & " 		    INNER JOIN tblTourney B ON B.GameLevelDtlidx = A.GameLevelDtlidx AND B.TeamGameNum = A.TeamGameNum AND B.GameNum = A.GameNum"
		LSQL = LSQL & " 		    INNER JOIN tblGameLevelDtl C ON C.GameLevelDtlidx = A.GameLevelDtlidx"
		LSQL = LSQL & " 		    INNER JOIN tblGameLevel D ON D.GameLevelidx = C.GameLevelidx"
		LSQL = LSQL & " 		    	LEFT JOIN ("
		LSQL = LSQL & " 		    		SELECT GameLevelDtlidx, TeamGameNum, GameNum, TourneyGroupIDX, Result, ResultDtl, Jumsu"
		LSQL = LSQL & " 		    		FROM KoreaBadminton.dbo.tblGameResult"
		LSQL = LSQL & " 		    		WHERE DelYN = 'N'"
		LSQL = LSQL & " 		    		GROUP BY GameLevelDtlidx, TeamGameNum, GameNum, TourneyGroupIDX, Result, ResultDtl, Jumsu"
		LSQL = LSQL & " 		    		) AS E ON E.GameLevelDtlidx = A.GameLevelDtlidx AND E.TeamGameNum = A.TeamGameNum AND E.GameNum = A.GameNum AND E.TourneyGroupIDX = A.TourneyGroupIDX    "
		LSQL = LSQL & " 		    	LEFT JOIN ("
		LSQL = LSQL & " 		    		SELECT GameLevelDtlidx, TeamGameNum, GameNum, TourneyGroupIDX, Result, ResultDtl, Jumsu"
		LSQL = LSQL & " 		    		FROM KoreaBadminton.dbo.tblGameResult"
		LSQL = LSQL & " 		    		WHERE DelYN = 'N'"
		LSQL = LSQL & " 		    		GROUP BY GameLevelDtlidx, TeamGameNum, GameNum, TourneyGroupIDX, Result, ResultDtl, Jumsu"
		LSQL = LSQL & " 		    		) AS F ON F.GameLevelDtlidx = B.GameLevelDtlidx AND F.TeamGameNum = B.TeamGameNum AND F.GameNum = B.GameNum AND F.TourneyGroupIDX = B.TourneyGroupIDX    "			
		LSQL = LSQL & " 		    	LEFT JOIN ("
		LSQL = LSQL & " 		    		SELECT GameLevelDtlidx, TeamGameNum, GameNum "
		LSQL = LSQL & " 		    		FROM KoreaBadminton.dbo.tblGameSign"
		LSQL = LSQL & " 		    		WHERE DelYN = 'N' "
		LSQL = LSQL & " 		    		) AS G ON G.GameLevelDtlidx = A.GameLevelDtlidx AND G.TeamGameNum = A.TeamGameNum AND G.GameNum = A.GameNum  "			          
		LSQL = LSQL & " 		    WHERE A.DelYN = 'N'"
		LSQL = LSQL & " 		    AND B.DelYN = 'N'"
		LSQL = LSQL & " 		    AND C.DelYN = 'N'"
		LSQL = LSQL & " 		    AND D.DelYN = 'N'"
		LSQL = LSQL & " 		    AND A.ORDERBY < B.ORDERBY"
		LSQL = LSQL & " 			AND A.GameLevelDtlidx = '" & DEC_GameLevelDtlIDX & "'"
		LSQL = LSQL & " 		    AND A.TeamGameNum = '" & DEC_TeamGameNum & "'"
		LSQL = LSQL & " 		    AND A.GameNum = '" & DEC_GameNum & "'"
		LSQL = LSQL & " 		) AS AA"
		LSQL = LSQL & " 		WHERE GameLevelDtlIDX IS NOT NULL"
		LSQL = LSQL & " 	) AS BBB"
		LSQL = LSQL & " ) AS CCC"
		LSQL = LSQL & " WHERE CCC.GameLevelDtlIDX IS NOT NULL"       
		Set rs = db.ExecSQLReturnRS(LSQL , null, ConStr)
	'기본정보
'Call rsdrow(rs)
'Response.end

	If Not rs.EOF Then 

		rsloopcnt = Rs.Fields.Count-1
		ReDim fieldarr(rsloopcnt)
		For i = 0 To rsloopcnt
			  fieldarr(i) = Rs.Fields(i).name
		Next
	
		arrRS = rs.getrows()
	End If
	Set rs = Nothing

	Set game = JSON.Parse("{}")
	Set tpoint1 = JSON.Parse("{}")
	Set tpoint2 = JSON.Parse("{}")

	If IsArray(arrRS) Then

	For ar = LBound(arrRS, 2) To UBound(arrRS, 2) 
			For i=0 To rsloopcnt
				Call game.Set( fieldarr(i),  arrRS( i ,ar) )
			Next 
	Next
	End if

	SQL = "SELECT ISNULL(SUM(SetPoint1),0) AS SetPoint1,		"
	SQL = SQL & "    ISNULL(SUM(SetPoint2),0) AS SetPoint2,	"
	SQL = SQL & "    ISNULL(SUM(SetPoint3),0) AS SetPoint3,	"
	SQL = SQL & "    ISNULL(SUM(SetPoint4),0) AS SetPoint4,	"
	SQL = SQL & "    ISNULL(SUM(SetPoint5),0) AS SetPoint5	"
	SQL = SQL & "    FROM	"
	SQL = SQL & "     (		"
	SQL = SQL & "     SELECT CASE WHEN SetNum = '1' THEN Jumsu ELSE 0 END AS SetPoint1,	"
	SQL = SQL & "     CASE WHEN SetNum = '2' THEN Jumsu ELSE 0 END AS SetPoint2,	"
	SQL = SQL & "     CASE WHEN SetNum = '3' THEN Jumsu ELSE 0 END AS SetPoint3,	"
	SQL = SQL & "     CASE WHEN SetNum = '4' THEN Jumsu ELSE 0 END AS SetPoint4,	"
	SQL = SQL & "     CASE WHEN SetNum = '5' THEN Jumsu ELSE 0 END AS SetPoint5	"
	SQL = SQL & "     FROM KoreaBadminton.dbo.tblTourney A	"
	SQL = SQL & "     LEFT JOIN KoreaBadminton.dbo.tblGameResultDtl B ON B.TourneyGroupIDX = A.TourneyGroupIDX AND B.GameLevelDtlidx = A.GameLevelDtlidx AND B.TeamGameNum = A.TeamGameNum AND B.GameNum = A.GameNum	"
	SQL = SQL & "     WHERE A.DelYN = 'N'	"
	SQL = SQL & "     AND B.DelYN = 'N'	"
	SQL = SQL & "     AND B.GameLevelDtlidx = '" & DEC_GameLevelDtlIDX & "'	"
	SQL = SQL & "     AND B.TeamGameNum = '" & DEC_TeamGameNum & "'	"
	SQL = SQL & "     AND B.GameNum = '" & DEC_GameNum & "'	"

	SQLL = SQL & "     AND B.TourneyGroupIDX = '" & game.LTourneyGroupIDX & "'	 ) as c"
	Set rs = db.ExecSQLReturnRS(SQLL , null, ConStr)

	If Not rs.EOF Then 
		rsloopcnt = Rs.Fields.Count-1
		ReDim fieldarr(rsloopcnt)
		For i = 0 To rsloopcnt
			  fieldarr(i) = Rs.Fields(i).name
		Next
		arrRS = rs.getrows()
	End If
	Set rs = Nothing

	If IsArray(arrRS) Then
	For ar = LBound(arrRS, 2) To UBound(arrRS, 2) 
			For i=0 To rsloopcnt
				Call tpoint1.Set( fieldarr(i),  arrRS( i ,ar) )
			Next 
	Next
	End if

	SQLR = SQL & "     AND B.TourneyGroupIDX = '" & game.RTourneyGroupIDX & "' ) as c	"
	Set rs = db.ExecSQLReturnRS(SQLR , null, ConStr)

	If Not rs.EOF Then 
		rsloopcnt = Rs.Fields.Count-1
		ReDim fieldarr(rsloopcnt)
		For i = 0 To rsloopcnt
			  fieldarr(i) = Rs.Fields(i).name
		Next
		arrRS = rs.getrows()
	End If
	Set rs = Nothing

	If IsArray(arrRS) Then
	For ar = LBound(arrRS, 2) To UBound(arrRS, 2) 
			For i=0 To rsloopcnt
				Call tpoint2.Set( fieldarr(i),  arrRS( i ,ar) )
			Next 
	Next
	End if

'/////////////////@@@@@@@@@@@@@

	'//기록 항목 
		SQL =  "SELECT CASE WHEN AAAA.TourneyGroupIDx = '"& game.LTourneyGroupIDX &"' AND AAAA.ServerIDX = '"& game.LPlayerIDX1 &"' THEN Nu_Jumsu ELSE '' END AS LPoint_1, dbo.FN_NameSch('"& game.LPlayerIDX1 &"','MemberIDX'),	"
		SQL = SQL & "CASE WHEN AAAA.TourneyGroupIDx = '"& game.LTourneyGroupIDX &"' AND AAAA.ServerIDX = '"& game.LPlayerIDX2 &"' THEN Nu_Jumsu ELSE '' END AS LPoint_2, dbo.FN_NameSch('"& game.LPlayerIDX2 &"','MemberIDX'),	"
		SQL = SQL & "CASE WHEN AAAA.TourneyGroupIDx = '"& game.RTourneyGroupIDX &"' AND AAAA.ServerIDX = '"& game.RPlayerIDX1 &"' THEN Nu_Jumsu ELSE '' END AS RPoint_1,dbo.FN_NameSch('"& game.RPlayerIDX1 &"','MemberIDX'),	"
		SQL = SQL & "CASE WHEN AAAA.TourneyGroupIDx = '"& game.RTourneyGroupIDX &"' AND AAAA.ServerIDX = '"& game.RPlayerIDX2 &"' THEN Nu_Jumsu ELSE '' END AS RPoint_2, dbo.FN_NameSch('"& game.RPlayerIDX2 &"','MemberIDX'),	"
		SQL = SQL & "AAAA.RecieveMemberIDX, AAAA.ServeMemberIDX, dbo.FN_NameSch(ServerIDX,'MemberIDX'), TourneyGroupIDx, RecieveMemberIDX,  SetNum	"
		SQL = SQL & "FROM	"
		SQL = SQL & "	(	"
		SQL = SQL & "	SELECT AAA.ServerIDX, dbo.FN_NameSch(AAA.ServerIDX,'MemberIDX') AS ServerName, AAA.GameResultDtlIDx,	"
		SQL = SQL & "	AAA.NU_JumSu, AAA.TourneyGroupIDX, AAA.RecieveMemberIDX, AAA.ServeMemberIDX, AAA.SetNum	"
		SQL = SQL & "	FROM 	"
		SQL = SQL & "		(	"
		SQL = SQL & "         SELECT AA.NextServeMemberIDX AS ServerIDX,	"
		SQL = SQL & "			   AA.NU_JumSu, AA.TourneyGroupIDX, AA.GameResultDtlIDx, AA.RecieveMemberIDX, AA.ServeMemberIDX, AA.SetNum	"
		SQL = SQL & "		FROM	"
		SQL = SQL & "			(	"
		SQL = SQL & "			SELECT B.TourneyGroupIDX, CONVERT(VARCHAR(8),SUM(CONVERT(INT,B.Jumsu))) AS NU_JumSu, B.GameResultDtlIDx,	"
		SQL = SQL & "			CASE WHEN B.TourneyGroupIDX = B.ServeTourneyGroupIDX THEN 'S' ELSE 'R' END AS STRWIN,	"
		SQL = SQL & "			dbo.FN_NameSch(B.Pst_MemberIDX_LL,'MemberIDX') AS MemberNameLL, B.Pst_MemberIDX_LL,	"
		SQL = SQL & "			dbo.FN_NameSch(B.Pst_MemberIDX_LR,'MemberIDX') AS MemberNameLR, B.Pst_MemberIDX_LR,	"
		SQL = SQL & "			dbo.FN_NameSch(B.Pst_MemberIDX_RL,'MemberIDX') AS MemberNameRL, B.Pst_MemberIDX_RL,	"
		SQL = SQL & "			dbo.FN_NameSch(B.Pst_MemberIDX_RR,'MemberIDX') AS MemberNameRR, B.Pst_MemberIDX_RR,	"
		SQL = SQL & "			B.ServeMemberIDX, B.RecieveMemberIDX, B.Pst_TourneyGroupIDX_L, B.Pst_TourneyGroupIDX_R, B.NextServeMemberIDX, A.SetNum	"
		SQL = SQL & "			FROM KoreaBadminton.dbo.tblGameResultDtl A	"
		SQL = SQL & "			INNER JOIN KoreaBadminton.dbo.tblGameResultDtl B ON B.GameLevelDtlidx = A.GameLevelDtlidx AND B.TeamGameNum = A.TeamGameNum AND B.GameNum = A.Gamenum AND B.GameResultDtlIDx >= A.GameResultDtlIDx  AND A.TourneyGroupIDX = B.TourneyGroupIDX "
		SQL = SQL & "			WHERE A.DelYN = 'N'	"
		SQL = SQL & "			AND B.DelYN = 'N'	"
		SQL = SQL & "			AND A.GameLevelDtlidx = '" & DEC_GameLevelDtlIDX & "' AND A.TeamGameNum = '" & DEC_TeamGameNum & "' AND A.GameNum = '" & DEC_GameNum & "'"
		
		SQL = SQL & " 			AND A.SetNum IN ('1','2','3')	"
		
		SQL = SQL & "			GROUP BY B.TourneyGroupIDX, B.GameResultDtlIDx, B.Pst_MemberIDX_LL, B.Pst_MemberIDX_LR, 	"
		SQL = SQL & "            B.Pst_MemberIDX_RR, B.Pst_MemberIDX_RL, B.ServeTourneyGroupIDX, B.ServeMemberIDX, B.RecieveMemberIDX, B.ServeMemberIDX, B.RecieveMemberIDX, B.Pst_TourneyGroupIDX_L, B.Pst_TourneyGroupIDX_R, B.NextServeMemberIDX, A.SetNum	"
		SQL = SQL & "			) AS AA	"
		SQL = SQL & "		) AS AAA	"
		SQL = SQL & "	) AS AAAA	"
		SQL = SQL & "	ORDER BY AAAA.SetNum, AAAA.GameResultDtlIDx	"
		Set rs = db.ExecSQLReturnRS(SQL , null, ConStr)
	'//기록 항목 
Call rsdrow(rs)
'테스트로 찍어봄.. .지우자.



	'//기록 항목 
		SQL =  "SELECT CASE WHEN AAAA.TourneyGroupIDx = '"& game.LTourneyGroupIDX &"' AND AAAA.ServerIDX = '"& game.LPlayerIDX1 &"' THEN Nu_Jumsu ELSE '' END AS LPoint_1, dbo.FN_NameSch('"& game.LPlayerIDX1 &"','MemberIDX'),	"
		SQL = SQL & "CASE WHEN AAAA.TourneyGroupIDx = '"& game.LTourneyGroupIDX &"' AND AAAA.ServerIDX = '"& game.LPlayerIDX2 &"' THEN Nu_Jumsu ELSE '' END AS LPoint_2, dbo.FN_NameSch('"& game.LPlayerIDX2 &"','MemberIDX'),	"
		SQL = SQL & "CASE WHEN AAAA.TourneyGroupIDx = '"& game.RTourneyGroupIDX &"' AND AAAA.ServerIDX = '"& game.RPlayerIDX1 &"' THEN Nu_Jumsu ELSE '' END AS RPoint_1,dbo.FN_NameSch('"& game.RPlayerIDX1 &"','MemberIDX'),	"
		SQL = SQL & "CASE WHEN AAAA.TourneyGroupIDx = '"& game.RTourneyGroupIDX &"' AND AAAA.ServerIDX = '"& game.RPlayerIDX2 &"' THEN Nu_Jumsu ELSE '' END AS RPoint_2, dbo.FN_NameSch('"& game.RPlayerIDX2 &"','MemberIDX'),	"
		SQL = SQL & "AAAA.RecieveMemberIDX, AAAA.ServeMemberIDX, dbo.FN_NameSch(ServerIDX,'MemberIDX'), TourneyGroupIDx, RecieveMemberIDX,  SetNum	"
		SQL = SQL & "FROM	"
		SQL = SQL & "	(	"
		SQL = SQL & "	SELECT AAA.ServerIDX, dbo.FN_NameSch(AAA.ServerIDX,'MemberIDX') AS ServerName, AAA.GameResultDtlIDx,	"
		SQL = SQL & "	AAA.NU_JumSu, AAA.TourneyGroupIDX, AAA.RecieveMemberIDX, AAA.ServeMemberIDX, AAA.SetNum	"
		SQL = SQL & "	FROM 	"
		SQL = SQL & "		(	"
		SQL = SQL & "         SELECT AA.NextServeMemberIDX AS ServerIDX,	"
		SQL = SQL & "			   AA.NU_JumSu, AA.TourneyGroupIDX, AA.GameResultDtlIDx, AA.RecieveMemberIDX, AA.ServeMemberIDX, AA.SetNum	"
		SQL = SQL & "		FROM	"
		SQL = SQL & "			(	"
		SQL = SQL & "			SELECT B.TourneyGroupIDX, CONVERT(VARCHAR(8),SUM(CONVERT(INT,B.Jumsu))) AS NU_JumSu, B.GameResultDtlIDx,	"
		SQL = SQL & "			CASE WHEN B.TourneyGroupIDX = B.ServeTourneyGroupIDX THEN 'S' ELSE 'R' END AS STRWIN,	"
		SQL = SQL & "			dbo.FN_NameSch(B.Pst_MemberIDX_LL,'MemberIDX') AS MemberNameLL, B.Pst_MemberIDX_LL,	"
		SQL = SQL & "			dbo.FN_NameSch(B.Pst_MemberIDX_LR,'MemberIDX') AS MemberNameLR, B.Pst_MemberIDX_LR,	"
		SQL = SQL & "			dbo.FN_NameSch(B.Pst_MemberIDX_RL,'MemberIDX') AS MemberNameRL, B.Pst_MemberIDX_RL,	"
		SQL = SQL & "			dbo.FN_NameSch(B.Pst_MemberIDX_RR,'MemberIDX') AS MemberNameRR, B.Pst_MemberIDX_RR,	"
		SQL = SQL & "			B.ServeMemberIDX, B.RecieveMemberIDX, B.Pst_TourneyGroupIDX_L, B.Pst_TourneyGroupIDX_R, B.NextServeMemberIDX, A.SetNum	"
		SQL = SQL & "			FROM KoreaBadminton.dbo.tblGameResultDtl A	"
		SQL = SQL & "			INNER JOIN KoreaBadminton.dbo.tblGameResultDtl B ON B.GameLevelDtlidx = A.GameLevelDtlidx AND B.TeamGameNum = A.TeamGameNum AND B.GameNum = A.Gamenum AND B.GameResultDtlIDx >= A.GameResultDtlIDx  AND A.TourneyGroupIDX = B.TourneyGroupIDX "
		SQL = SQL & "			WHERE A.DelYN = 'N'	"
		SQL = SQL & "			AND B.DelYN = 'N'	"
		SQL = SQL & "			AND A.GameLevelDtlidx = '" & DEC_GameLevelDtlIDX & "' AND A.TeamGameNum = '" & DEC_TeamGameNum & "' AND A.GameNum = '" & DEC_GameNum & "'"
		
		SQL = SQL & " 			AND A.SetNum IN ('1','2','3')	"
		
		SQL = SQL & "			GROUP BY B.TourneyGroupIDX, B.GameResultDtlIDx, B.Pst_MemberIDX_LL, B.Pst_MemberIDX_LR, 	"
		SQL = SQL & "            B.Pst_MemberIDX_RR, B.Pst_MemberIDX_RL, B.ServeTourneyGroupIDX, B.ServeMemberIDX, B.RecieveMemberIDX, B.ServeMemberIDX, B.RecieveMemberIDX, B.Pst_TourneyGroupIDX_L, B.Pst_TourneyGroupIDX_R, B.NextServeMemberIDX, A.SetNum	"
		SQL = SQL & "			) AS AA	"
		SQL = SQL & "		) AS AAA	"
		SQL = SQL & "	) AS AAAA	"
		SQL = SQL & "	ORDER BY AAAA.SetNum, AAAA.GameResultDtlIDx	"
		Set rs = db.ExecSQLReturnRS(SQL , null, ConStr)
	'//기록 항목 

	If Not rs.EOF Then 
		arrRS = rs.getrows()
	End if
	Set rs = Nothing



'Call rsdrow(rs)
'Response.end



	'//jaax send obj
	Set snedobj = JSON.Parse("{}")
	Call snedobj.Set( "DEC_GameLevelDtlIDX",  DEC_GameLevelDtlIDX )
	Call snedobj.Set( "DEC_TeamGameNum",  DEC_TeamGameNum )
	Call snedobj.Set( "DEC_GameNum",  DEC_GameNum )

   strjson = JSON.stringify(snedobj)



%>


  <div id="score" class="score">
    <!-- S: game_title -->
          <div class="top_con">
               <!-- s:  section1 -->
               <div class="section1">
                    <table >
                         <p><%=game.gametitle%></p>
                         <tr><th>Event :</th><td><%=game.TeamGbNM%> <%=game.LevelName%></td></tr>
                         <tr><th>No :</th><td><%=game.GameNum%></td></tr>
                         <tr><th>Date :</th><td>Now <%=year(game.gameday)%></td></tr>
                    </table>
               </div>
               <!-- e:  section1 -->

               <!-- s:  section2 -->
               <div class="section2">
                    <table>
                         <tr>
                              <td class="no_border"></td>
                              <td class="no_border"></td>
                              <td width="15" class="txt_cen border_top border_left border_bottom">L</td>
                              <td class="font_bold border_top border_right border_left"><%=game.LPlayer1%></td>
                         </tr>
                         <tr>
                              <td class="no_border">&nbsp;</td><td class="no_border"></td><td class="no_border "></td>
                              <td class="border_right border_left"><%=game.LPlayer2%></td>
                         </tr>
                         <tr>
                              <td class="no_border" width="40">Time :</td><td class="no_border font_bold">19:30</td>
                              <td class="no_border " width="15"></td>
                              <td class="font_bold border_bottom border_right border_left" width="200"><%=game.LTeam1%></td>
                         </tr>
                    </table>
               </div>
               <!-- e:  section2 -->
               <!-- s:  section3 -->
               <div class="section3" id ="scoreboard">
                    <table>
                         <tr><td class="font_bold no_border">Score</td></tr>
                         <tr><td class="border_top border_right border_left"><%=tpoint1.SetPoint1%> : <%=tpoint2.SetPoint1%></td></tr>
                         <tr><td class="border_right border_left"><%=tpoint1.SetPoint2%> : <%=tpoint1.SetPoint2%></td></tr>
                         <tr><td class="border_bottom border_right border_left"><%=tpoint1.SetPoint3%> : <%=tpoint2.SetPoint3%></td></tr>
                    </table>
               </div>
               <!-- e:  section3 -->
               <!-- s:  section4 -->
               <div class="section4">
                    <table>
                         <tr>
                              <td class="font_bold border_top border_right border_left" width="150"><%=game.RPlayer1%></td>
                              <td width="15" class="txt_cen border_top border_right border_bottom">R</td>
                         </tr>
                         <tr>
                              <td class="border_right border_left"><%=game.RPlayer2%></td>
                              <td class="no_border bg_f"></td>
                         </tr>
                         <tr>
                              <td class="font_bold border_bottom border_right border_left"><%=game.RTeam1%></td>
                              <td class="no_border bg_f"></td>
                         </tr>
                         <tr>
                              <td class="no_border bg_f txt_cen"><p>Shuttles: <span>14</span></p></td>
                              <td class="no_border bg_f"></td>
                         </tr>
                    </table>
               </div>
               <!-- e:  section4 -->
               <!-- s:  section5 -->
               <div class="section5">
                    <table>
                         <tr><th>Court :</th><td><%=game.StadiumNum%></td></tr>
                         <tr><th>Umpire :</th><td></td></tr>
                         <tr><th>Service Judge :</th><td></td></tr>
                         <tr><th>Star match :</th><td></td></tr>
                         <tr><th>End match :</th><td></td></tr>
                         <tr><th>Duration :</th><td></td>
                         </tr>
                    </table>
               </div>
               <!-- e:  section5 -->
               <p class="p_title">TournamentStats www.tournamentsoftware.com</p>
          </div>
	

<%
Function scoreSheet(ByVal reqsetno)
	Dim left1,left2, right1,right2,setno,left1arr,left2arr,right1arr,right2arr, i , j

	If IsArray(arrRS) Then
	i = 1
	j  =1
	For ar = LBound(arrRS, 2) To UBound(arrRS, 2) 
			left1 = arrRS( 0 ,ar)
			left2 = arrRS( 2 ,ar)
			right1 = arrRS( 4 ,ar)
			right2 = arrRS( 6 ,ar)

			setno = arrRS( 13 ,ar)

			If CDbl(setno) = (reqsetno) Then
					If left1 = "" then
						left1arr = left1arr & ","
					Else
						left1arr = left1arr & "," & i
						i = i + 1
					End If

					If left2 = "" then					
						left2arr = left2arr & ","
					Else
						left2arr = left2arr & "," & i
						i = i + 1
					End If

					If right1 = "" then	
						right1arr = right1arr & ","
					Else
						right1arr = right1arr & "," & j
						j = j + 1
					End if	

					If right2 = "" then	
						right2arr = right2arr & ","
					Else
						right2arr = right2arr & "," & j
						j = j + 1
					End if					

			End if


	Next
	End If
	
	scoreSheet = left1arr & "-" & left2arr & "-" & right1arr & "-" & right2arr

End Function 
%>
<%'###################################################################%>	
	
	
	<table class="game_title">
      <tbody>

			<%For n = 1 To 6

			Select Case n
			Case 1,2
				setdata =  scoreSheet(1)	
			Case 3,4
				setdata =  scoreSheet(2)
			Case 5,6
				setdata =  scoreSheet(3)
			End Select 

				marr = Split(setdata, "-")
			%>
					<tr class="border_top">
					  <td width="100" class="l_name border_left border_right border_left border_right"><%=game.LPlayer1%></td>
					  <%
					 left1 = Split(marr(0), ",")
					  For i = 0 To 35
					  If n Mod 2 = 1 Then '홀수줄이라면
						  If i <= ubound(left1)  then
							  If left1(i) = "" Then
								left1val = ""	
							  Else
								left1val = left1(i)
							  End If
						  End if
					  Else
						  If i + 35 <= ubound(left1)  then
							  If left1(i+35) = "" Then
								left1val = ""	
							  Else
								left1val = left1(i+35)
							  End If
						  End if					  
					  End if
					  %>
					  <td <%If i = 35 then%>class="border_right"<%End if%>><input type="number" class="no-spinners" min="1" max="99" id="p1A_<%=n%>_<%=i%>" onchange='bm.SetScore(this.id, <%=strjson%>)'  value="<%=left1val%>"></td>
					  <%
  					  left1val = ""
					  next%>


					</tr>
					<tr class="border_bottom">
					  <td class="border_left border_right"><%=game.LPlayer2%></td>
					  <%
					 left2 = Split(marr(1), ",")
					  For i = 0 To 35
					  If n Mod 2 = 1 Then '홀수줄이라면
						  If i <= ubound(left2)  then
							  If left2(i) = "" Then
								left2val = ""	
							  Else
								left2val = left2(i)
							  End If
						  End if
					  Else
						  If i + 35 <= ubound(left2)  then
							  If left2(i+35) = "" Then
								left2val = ""	
							  Else
								left2val = left2(i+35)
							  End If
						  End if					  
					  End if
					  %>					  
					  <td <%If i = 35 then%>class="border_right"<%End if%>><input type="number" class="no-spinners" min="1" max="99" id="p1B_<%=n%>_<%=i%>" onchange='bm.SetScore(this.id, <%=strjson%>)' value="<%=left2val%>"></td>
					  <%
					  left2val = ""
					  next%>
					</tr>



					<tr class="bg_color border_top">
					  <td class="l_name border_left border_right border_left border_right"><%=game.RPlayer1%></td>
					 <%
					 right1 = Split(marr(2), ",")
					  For i = 0 To 35
					  If n Mod 2 = 1 Then '홀수줄이라면
						  If i <= ubound(right1)  then
							  If right1(i) = "" Then
								right1val = ""	
							  Else
								right1val = right1(i)
							  End If
						  End if
					  Else
						  If i + 35 <= ubound(right1)  then
							  If right1(i+35) = "" Then
								right1val = ""	
							  Else
								right1val = right1(i+35)
							  End If
						  End if					  
					  End if
					  %>		
					  <td <%If i = 35 then%>class="border_right"<%End if%>><input type="number" class="no-spinners" min="1" max="99" id="p2A_<%=n%>_<%=i%>" onchange='bm.SetScore(this.id, <%=strjson%>)' value="<%=right1val%>"></td>
					  <%
					  right1val = ""
					  next%>
					</tr>




					<!-- E : 10행 -->
					<tr class="bg_color border_bottom">
					  <td class="border_left border_right"><%=game.RPlayer2%></td>
					 <%
					 right2 = Split(marr(3), ",")
					  For i = 0 To 35
					  If n Mod 2 = 1 Then '홀수줄이라면
						  If i <= ubound(right2)  then
							  If right2(i) = "" Then
								right2val = ""	
							  Else
								right2val = right2(i)
							  End If
						  End if
					  Else
						  If i + 35 <= ubound(right2)  then
							  If right2(i+35) = "" Then
								right2val = ""	
							  Else
								right2val = right2(i+35)
							  End If
						  End if	
					  End if
					  %>		
					  <td <%If i = 35 then%>class="border_right"<%End if%>><input type="number" class="no-spinners" min="1" max="99"  id="p2B_<%=n%>_<%=i%>" onchange='bm.SetScore(this.id, <%=strjson%>)'  value="<%=right2val%>"></td>
					  <%
					  right2val = ""					  
					  next%>
					</tr>



					<tr><td colspan="41" class="td_blank"></td></tr>
			<%next%>


      </tbody>
    </table>



<%'###################################################################%>	

          <div class="bt_con">
               <ul>
                    <li class="l_blank">&nbsp;</li>
                    <li>
                         <span class="l_name">Umpire:</span><span class=""></span>
                    </li>
                    <li>
                         <span class="l_name">Referee:</span><span class=""></span>
                    </li>
               </ul>
          </div>
    <!-- E: game_title -->
  </div>