<!-- #include file="../../dev/dist/config.asp"-->
<%

  Response.CharSet="utf-8"
  Session.codepage="65001"
  Response.codepage="65001"
  Response.ContentType="text/html;charset=utf-8"

  Dim GameLevelDtlIdx	: GameLevelDtlIdx 		= fInject(Request("gameleveldtlidx"))
	Dim TeamGameNum		    : TeamGameNum 		    = fInject(Request("teamgamenum"))	
	Dim GameNum		: GameNum 		= fInject(Request("gamenum"))
  Dim SetNum		: SetNum 		= fInject(Request("SetNum"))
	Dim TourneyGroupIDX	: TourneyGroupIDX		= fInject(Request("TourneyGroupIDX"))

  Dim DEC_GameLevelDtlIdx	: DEC_GameLevelDtlIdx 		= crypt.DecryptStringENC(GameLevelDtlIdx)
  Dim DEC_TeamGameNum		    : DEC_TeamGameNum		    = crypt.DecryptStringENC(TeamGameNum)
  Dim DEC_GameNum		: DEC_GameNum 		= crypt.DecryptStringENC(GameNum)
  Dim DEC_SetNum	: DEC_SetNum     = crypt.DecryptStringENC(SetNum)
  Dim DEC_TourneyGroupIDX	: DEC_TourneyGroupIDX	= crypt.DecryptStringENC(TourneyGroupIDX)
  Dim DEC_GroupGameGb : DEC_GroupGameGb = ""

    
  LSQL = " SELECT A.Team AS LTeam, A.TeamDtl AS LTeamDtl, B.Team AS RTeam, B.TeamDtl AS RTeamDtl,"
  LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(A.Team,'Team') AS LTeamNM, "
  LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(B.Team,'Team') AS RTeamNM,"

  LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(D.Sex, 'PubCode') AS SexName,"
  LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(D.PlayType, 'PubCode') AS PlayTypeName,"
  LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(D.TeamGb, 'TeamGb') AS TeamGbName,"
  LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(D.Level, 'Level') AS LevelName,"
  LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(D.LevelJooName,'PubCode') AS LevelJooName, D.LevelJooNum, C.LevelJooNum AS LevelJooNumDtl, C.LevelDtlName, C.GameLevelDtlIDX, "
  LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(C.GameType,'PubCode') AS GameTypeName, "
  LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(C.PlayLevelType,'PubCode') AS PlayLevelTypeName,"
  LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(D.GroupGameGb,'PubCode') AS GroupGameGbName,"
  LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(A.StadiumIDX,'StadiumIDX') AS StadiumName,"
  LSQL = LSQL & " C.PlayLevelType,"
  LSQL = LSQL & " D.GameType, C.GameType AS GameTypeDtl, A.StadiumNum, C.TotRound, A.[ROUND] AS GameRound,"
  LSQL = LSQL & " E.Result AS LResult, dbo.FN_NameSch(E.Result, 'PubType') AS LResultNM, E.Jumsu AS LJumsu, E.TotalPoint AS LTotalPoint,"
  LSQL = LSQL & " F.Result AS RResult, dbo.FN_NameSch(F.Result, 'PubType') AS RResultNM, F.Jumsu AS RJumsu, F.TotalPoint AS RTotalPoint"

  LSQL = LSQL & " FROM tblTourneyTeam A"
  LSQL = LSQL & " INNER JOIN tblTourneyTeam B ON B.GameLevelDtlidx = A.GameLevelDtlidx AND B.TeamGameNum = A.TeamGameNum"
  LSQL = LSQL & " INNER JOIN tblGameLevelDtl C ON C.GameLevelDtlidx = A.GameLevelDtlidx"
  LSQL = LSQL & " INNER JOIN tblGameLevel D ON D.GameLevelidx = C.GameLevelidx"
  LSQL = LSQL & " LEFT JOIN ("
  LSQL = LSQL & "   SELECT GameLevelDtlidx, TeamGameNum, GameNum, Team, TeamDtl, Result, Jumsu, TotalPoint"
  LSQL = LSQL & "   FROM KoreaBadminton.dbo.tblGroupGameResult"
  LSQL = LSQL & "   WHERE DelYN = 'N'"
  LSQL = LSQL & "   ) AS E ON E.GameLevelDtlidx = A.GameLevelDtlidx AND E.TeamGameNum = A.TeamGameNum AND E.Team + E.TeamDtl = A.Team + A.TeamDtl"
  LSQL = LSQL & " LEFT JOIN ("
  LSQL = LSQL & "   SELECT GameLevelDtlidx, TeamGameNum, GameNum, Team, TeamDtl, Result, Jumsu, TotalPoint"
  LSQL = LSQL & "   FROM KoreaBadminton.dbo.tblGroupGameResult"
  LSQL = LSQL & "   WHERE DelYN = 'N'"
  LSQL = LSQL & "   ) AS F ON F.GameLevelDtlidx = B.GameLevelDtlidx AND F.TeamGameNum = A.TeamGameNum AND F.Team + F.TeamDtl = B.Team + B.TeamDtl "
  LSQL = LSQL & " WHERE A.DelYN = 'N'"
  LSQL = LSQL & " AND B.DelYN = 'N'"
  LSQL = LSQL & " AND A.ORDERBY < B.ORDERBY"
  LSQL = LSQL & " AND A.GameLevelDtlIDX  = '" & DEC_GameLevelDtlIDX & "'"
  LSQL = LSQL & " AND A.TeamGameNum = '" & DEC_TeamGameNum & "'"
 
  Set LRs = Dbcon.Execute(LSQL)

  If Not (LRs.Eof Or LRs.Bof) Then
    LTeam = LRs("LTeam")
    LTeamDtl = LRs("LTeamDtl")
    LTeamNM = LRs("LTeamNM")
    LResultNM = LRs("LResultNM")
    LTotalPoint = LRs("LTotalPoint")
    LJumsu = LRs("LJumsu")
    RTeam = LRs("RTeam")
    RTeamDtl = LRs("RTeamDtl")
    RTeamNM = LRs("RTeamNM")
    RResultNM = LRs("RResultNM")
    RTotalPoint = LRs("RTotalPoint")  
    RJumsu = LRs("RJumsu")
    SexName = LRs("SexName")
    PlayTypeName = LRs("PlayTypeName")
    TeamGbName = LRs("TeamGbName")
    LevelName = LRs("LevelName")
    LevelJooName = LRs("LevelJooName")
    LevelJooNum = LRs("LevelJooNum")
    LevelJooNumDtl = LRs("LevelJooNumDtl")
    PlayLevelType = LRs("PlayLevelType")
    GroupGameGbName = LRs("GroupGameGbName")
    Team_StadiumNum = LRs("StadiumNum")
    TotRound = LRs("TotRound")
    GameRound = crypt.EncryptStringENC(LRs("GameRound"))
    StadiumName = LRs("StadiumName")
  End If
  LRs.Close
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>???????????? ???????????????</title>
</head>
<body>

<%
 
  'CSQL = GetSQL(DEC_GameDay, DEC_GameTitleIDX, DEC_StadiumIDX,DEC_StadiumNumber, DEC_Searchkeyword,DEC_SearchKey)
  CSQL = " EXEC tblGamePaperGroupTourney_Searched_STR '" & DEC_GameLevelDtlIDX & "', '" & DEC_TeamGameNum & "', '" & DEC_GameNum &"',''"
  'Response.Write "CSQL :" & CSQL & "<BR/>"
  const teamGroupGameGb = "B0030002"
  const personGroupGameGb = "B0030001"
  SET CRs = DBCon.Execute(CSQL)

  IF NOT (CRs.Eof Or CRs.Bof) Then
    arrayGamePaper = CRs.getrows()
  End If


%>
  <table style="font-family: '?????? ??????';">
    <colgroup>
      <col width="140px;">
      <col width="140px;">
      <col width="140px;">
      <col width="160px;">
      <col width="160px;">
    </colgroup>
    <tbody>

    <%
      If IsArray(arrayGamePaper) Then
        For ar = LBound(arrayGamePaper, 2) To UBound(arrayGamePaper, 2)
          GameTitleIDX = arrayGamePaper(0, ar) 
          GameLevelDtlIDX = arrayGamePaper(1, ar) 
          TeamGameNum = arrayGamePaper(2, ar) 
          GameNum = arrayGamePaper(3, ar) 
          TeamGb = arrayGamePaper(4, ar) 
          Level = arrayGamePaper(5, ar) 
          LTourneyGroupIDX = arrayGamePaper(6, ar) 
          RTourneyGroupIDX = arrayGamePaper(7, ar) 
          TeamGbNM = arrayGamePaper(8, ar) 
          LevelNM = arrayGamePaper(9, ar) 
          PlayTypeNM = arrayGamePaper(10, ar) 
          L_Result = arrayGamePaper(11, ar) 
          L_ResultType = arrayGamePaper(12, ar) 
          L_ResultNM = arrayGamePaper(13, ar) 
          L_Jumsu = arrayGamePaper(14, ar) 
          L_ResultDtl = arrayGamePaper(15, ar) 

          R_Result = arrayGamePaper(16, ar) 
          R_ResultType = arrayGamePaper(17, ar) 
          R_ResultNM = arrayGamePaper(18, ar) 
          R_Jumsu = arrayGamePaper(19, ar) 
          R_ResultDtl = arrayGamePaper(20, ar) 
          GameStatus = arrayGamePaper(21, ar) 
          ROUNDS = arrayGamePaper(22, ar) 
          Sex = arrayGamePaper(23, ar) 
          TempNum = arrayGamePaper(24, ar) 
          TurnNum = arrayGamePaper(25, ar) 
          GroupGameGb = arrayGamePaper(26, ar) 
          TourneyCnt = arrayGamePaper(27, ar) 
          LTeamDtl = arrayGamePaper(28, ar) 
          RTeamDtl = arrayGamePaper(29, ar) 
          LPlayer1 = arrayGamePaper(30, ar) 
          LPlayer2 = arrayGamePaper(31, ar) 
          Rplayer1 = arrayGamePaper(32, ar) 
          Rplayer2 = arrayGamePaper(33, ar) 

          LTeam1 = arrayGamePaper(34, ar) 
          LTeam2 = arrayGamePaper(35, ar) 
          RTeam1 = arrayGamePaper(36, ar) 
          RTeam2 = arrayGamePaper(37, ar) 

          StadiumNum = arrayGamePaper(38, ar) 
          StadiumIDX = arrayGamePaper(39, ar) 
          GameDay = arrayGamePaper(40, ar) 
          LevelJooNum = arrayGamePaper(41, ar) 
          LevelDtlJooNum = arrayGamePaper(42, ar) 
          LevelDtlName = arrayGamePaper(43, ar) 
          StadiumName = arrayGamePaper(44, ar) 
          PlayLevelType = arrayGamePaper(45, ar) 
          LevelJooName = arrayGamePaper(46, ar) 

          MaxRound = arrayGamePaper(47, ar) 
          GameType = arrayGamePaper(48, ar) 
          GameTypeNM = arrayGamePaper(49, ar)
          ResultGangSu = GetGangSu(GameType, MaxRound,ROUNDS) 
    %>
      <tr style="height: 40pt;">
        <td colspan="4">
          <img style="width: 143px; height: 47px;" src="http://badmintonadmin.sportsdiary.co.kr/Main/GameTitleMenu/logo/badminton.png" alt="????????????????????????">
        </td>
        <td>
          <img style="width: 132px; height: 42px;" src="http://badmintonadmin.sportsdiary.co.kr/Main/GameTitleMenu/logo/sd.png" alt="?????????????????????">
        </td>
      </tr>
      <tr style="height: 42pt;">
        <td style="font-size: 18pt; vertical-align: bottom;">No. <span style="font-weight: bold;font-size: 26pt;"><%=TempNum%></span></d>
        <td style="font-size: 18pt; vertical-align: bottom;"><%=Sex & PlayTypeNM & " " & TeamGbNM & " " & LevelNM & LevelJooNum & " "%></td>
        <td style="font-size: 18pt; vertical-align: bottom;">
        <%
          If PlayLevelType = "B0100001" Then
            Response.Write "?????? " & LevelDtlJooNum & "???"
          ElseIf PlayLevelType = "B0100002" Then
            IF ResultGangSu = "" Then
              Response.Write " ??????" 
            Else
              Response.Write " ??????" & "-" & ResultGangSu
            ENd IF
          Else
            Response.Write "-"
          End If  
        %>      
        
        </td>
        <td style="font-size: 18pt; vertical-align: bottom;"><span style="font-size: 26pt;font-weight: bold;"><%=Team_StadiumNum%></span>??????</td>
        <td style="font-size: 18pt; vertical-align: bottom;"><span style="font-size: 26pt;font-weight: bold;">
        <%
          Response.Write GameNum
        %>
        </span>??????</td>
      </tr>
      <tr style="height: 45pt;">
     
        <td style="vertical-align: middle;text-align: center;border-bottom: 1px solid #000;border-top: thin solid #000;border-left: thin solid #000;border-right: thin solid #000;font-size: 16pt;">??? ???</td>
      
    
        <td style="vertical-align: middle;text-align: center;border-bottom: 1px solid #000;border-top: thin solid #000;border-left: thin solid #000;border-right: thin solid #000;font-size: 16pt;" colspan="2">??? ???</td>
      
        <td style="vertical-align: middle;text-align: center;border-bottom: 1px solid #000;border-top: thin solid #000;border-left: thin solid #000;border-right: thin solid #000;font-size: 16pt;">??? ???</td>
        <td style="vertical-align: middle;text-align: center;border-bottom: 1px solid #000;border-top: thin solid #000;border-left: thin solid #000;border-right: thin solid #000;font-size: 16pt;">??? ???</td>
      </tr>
      <tr style="height: 65.099pt;">
       
        <td style="vertical-align: middle;text-align: center; font-size: 20pt;border-bottom: thin solid #000;border-top: none;border-left: thin solid #000;border-right: thin solid #000;"><%=LTeam1%>
        </td>
        <td style="vertical-align: middle;text-align: center; font-size: 20pt;border-bottom: thin solid #000;border-top: none;border-left: thin solid #000;border-right: thin solid #000;" colspan="2"><%=LPlayer1%>  <%IF LPlayer2 <> "" Then Response.Write ", " & LPlayer2 End IF %>
        <td style="vertical-align: middle;text-align: center; font-size: 20pt;border-bottom: thin solid #000;border-top: none;border-left: thin solid #000;border-right: thin solid #000;"></td>
        <td style="vertical-align: middle;text-align: center; font-size: 20pt;border-bottom: thin solid #000;border-top: none;border-left: thin solid #000;border-right: thin solid #000;"></td>
      </tr>
      <tr style="height: 65.099pt;">
      
        <td style="vertical-align: middle;text-align: center; font-size: 20pt;border-bottom: thin solid #000;border-top: none;border-left: thin solid #000;border-right: thin solid #000;"><%=RTeam1%></td>
        <td style="vertical-align: middle;text-align: center; font-size: 20pt;border-bottom: thin solid #000;border-top: none;border-left: thin solid #000;border-right: thin solid #000;" colspan="2"><%=RPlayer1%>  <%IF RPlayer2 <> "" Then Response.Write ", " & RPlayer2 End IF %></td>
        <td style="vertical-align: middle;text-align: center; font-size: 20pt;border-bottom: thin solid #000;border-top: none;border-left: thin solid #000;border-right: thin solid #000; width: 160px;"></td>
        <td style="vertical-align: middle;text-align: center; font-size: 20pt;border-bottom: thin solid #000;border-top: none;border-left: thin solid #000;border-right: thin solid #000; width: 160px"></td>
      </tr>
      <tr style="height: 44.1pt;">
        <td></td>
        <td colspan="3" style="font-weight: bold;font-size: 28pt;vertical-align: middle;text-align: center;"></td>
        <td></td>
      </tr>
      <%
        arrayGamePaperTempNum = null
        
        'CSQLTempNum = GetSQLTempNum(DEC_GameDay, DEC_GameTitleIDX, DEC_StadiumIDX,DEC_StadiumNumber, DEC_Searchkeyword,DEC_SearchKey,TempNum)
        CSQLTempNum = " EXEC tblGamePaperGroupTourney_Searched_STR '" & DEC_GameLevelDtlIDX & "', '" & DEC_TeamGameNum & "', '" & DEC_GameNum &"', '" & DEC_GameNum &"'"

        SET CRsTempNum = DBCon.Execute(CSQLTempNum)

        IF NOT (CRsTempNum.Eof and CRsTempNum.Bof) Then
          arrayGamePaperTempNum = CRsTempNum.getrows()
        End If
        CRsTempNum.close

        arrayTempNumCnt = 0

        If IsArray(arrayGamePaperTempNum) Then
          For ar_TempNum = LBound(arrayGamePaperTempNum, 2) To UBound(arrayGamePaperTempNum, 2) 
            arrayTempNumCnt = arrayTempNumCnt + 1
            B_GameTitleIDX = arrayGamePaperTempNum(0, ar_TempNum) 
            B_GameLevelDtlIDX = arrayGamePaperTempNum(1, ar_TempNum) 
            B_TeamGameNum = arrayGamePaperTempNum(2, ar_TempNum) 
            B_GameNum = arrayGamePaperTempNum(3, ar_TempNum) 
            B_TeamGb = arrayGamePaperTempNum(4, ar_TempNum) 
            B_Level = arrayGamePaperTempNum(5, ar_TempNum) 
            B_LTourneyGroupIDX = arrayGamePaperTempNum(6, ar_TempNum) 
            B_RTourneyGroupIDX = arrayGamePaperTempNum(7, ar_TempNum) 
            B_TeamGbNM = arrayGamePaperTempNum(8, ar_TempNum) 
            B_LevelNM = arrayGamePaperTempNum(9, ar_TempNum) 
            B_GameTypeNM = arrayGamePaperTempNum(10, ar_TempNum) 
            B_LResult = arrayGamePaperTempNum(11, ar_TempNum) 
            B_LResultType = arrayGamePaperTempNum(12,ar_TempNum) 
            B_LResultNM = arrayGamePaperTempNum(13, ar_TempNum) 
            B_LJumsu = arrayGamePaperTempNum(14, ar_TempNum) 
            B_LResultDtl = arrayGamePaperTempNum(15, ar_TempNum) 

            B_RResult = arrayGamePaperTempNum(16, ar_TempNum) 
            B_RResultType = arrayGamePaperTempNum(17, ar_TempNum) 
            B_RResultNM = arrayGamePaperTempNum(18, ar_TempNum) 
            B_RJumsu = arrayGamePaperTempNum(19, ar_TempNum) 
            B_RResultDtl = arrayGamePaperTempNum(20, ar_TempNum) 
            B_GameStatus = arrayGamePaperTempNum(21, ar_TempNum) 
            B_ROUNDS = arrayGamePaperTempNum(22, ar_TempNum) 
            B_Sex = arrayGamePaperTempNum(23, ar_TempNum) 
            B_TempNum = arrayGamePaperTempNum(24, ar_TempNum) 
            B_TurnNum = arrayGamePaperTempNum(25, ar_TempNum) 
            B_GroupGameGb = arrayGamePaperTempNum(26, ar_TempNum) 
            B_TourneyCnt = arrayGamePaperTempNum(27, ar_TempNum) 
            B_LTeamDtl = arrayGamePaperTempNum(28, ar_TempNum) 
            B_RTeamDtl = arrayGamePaperTempNum(29, ar_TempNum) 
            B_LPlayer1 = arrayGamePaperTempNum(30, ar_TempNum) 
            B_LPlayer2 = arrayGamePaperTempNum(31, ar_TempNum) 
            B_Rplayer1 = arrayGamePaperTempNum(32, ar_TempNum) 
            B_Rplayer2 = arrayGamePaperTempNum(33, ar_TempNum) 

            B_LTeam1 = arrayGamePaperTempNum(34, ar_TempNum) 
            B_LTeam2 = arrayGamePaperTempNum(35, ar_TempNum) 
            B_RTeam1 = arrayGamePaperTempNum(36, ar_TempNum) 
            B_RTeam2 = arrayGamePaperTempNum(37, ar_TempNum) 

            B_StadiumNum = arrayGamePaperTempNum(38, ar_TempNum) 
            B_StadiumIDX = arrayGamePaperTempNum(39, ar_TempNum) 
            B_GameDay = arrayGamePaperTempNum(40, ar_TempNum) 
            B_LevelJooNum = arrayGamePaperTempNum(41, ar_TempNum) 
            B_LevelDtlJooNum = arrayGamePaperTempNum(42, ar_TempNum) 
            B_LevelDtlName = arrayGamePaperTempNum(43, ar_TempNum) 
            B_StadiumName = arrayGamePaperTempNum(44, ar_TempNum) 
            B_PlayLevelType = arrayGamePaperTempNum(45, ar_TempNum) 
            B_LevelJooName = arrayGamePaperTempNum(46, ar_TempNum) 
              
            B_MaxRound = arrayGamePaperTempNum(47, ar_TempNum) 
            B_GameType = arrayGamePaperTempNum(48, ar_TempNum) 
            B_GameTypeNM = arrayGamePaperTempNum(49, ar_TempNum) 
            B_ResultGangSu = GetGangSu(B_GameType, B_MaxRound,B_ROUNDS)

            IF B_LTeamDtl = "0" Then  
              B_LTeamDtl = ""
            End IF 

            IF B_RTeamDtl = "0" Then  
              B_RTeamDtl = ""
            End IF 


            if cdbl(arrayTempNumCnt) = 1 Then
              Response.Write " <tr style='height: 30pt;'>"
            
                Response.Write "<td colspan='5' style='font-size: 14pt; vertical-align: middle; text-align: center;'>???????????? "
                If B_PlayLevelType = "B0100001" Then
                  Response.Write "?????? " & B_LevelDtlJooNum & "???"
                ElseIf B_PlayLevelType = "B0100002" Then
                  IF B_ResultGangSu = "" Then
                    Response.Write " ??????" 
                  Else
                    Response.Write " ??????" & "-" & B_ResultGangSu
                  ENd IF
                Else
                  Response.Write "-"
                End If  
                if B_LPlayer2 <> "" And B_RPlayer1 <> "" Then
                  Response.Write  " " & B_LTeam1  & " " &  "(" & B_LPlayer1 & ", " & B_LPlayer2 & ") / " & B_RTeam1 & "(" & " " & B_RPlayer1 & ", " & B_RPlayer2 &  ")  ??? " & Team_StadiumNum & " ?????? "   & B_GameNum & "</td>"
                ELSE
                  Response.Write  " " & B_LTeam1  & " " &  "(" & B_LPlayer1 & ") / " & B_RTeam1 & "(" & " " & B_RPlayer1 &  ")  ??? " & Team_StadiumNum & " ?????? "   & B_GameNum & "</td>"
                END IF
             
              Response.Write "</tr>"
            End IF

          
            if cdbl(arrayTempNumCnt) = 2 Then
              Response.Write " <tr style='height: 30pt;'>"
              
                Response.Write "<td colspan='5' style='font-size: 14pt; vertical-align: middle; text-align: center;'>???????????? "
                If B_PlayLevelType = "B0100001" Then
                  Response.Write "?????? " & B_LevelDtlJooNum & "???"
                ElseIf B_PlayLevelType = "B0100002" Then
                  IF B_ResultGangSu = "" Then
                    Response.Write " ??????" 
                  Else
                    Response.Write " ??????" & "-" & B_ResultGangSu
                  ENd IF
                Else
                  Response.Write "-"
                End If  
                if B_LPlayer2 <> "" And B_RPlayer1 <> "" Then
                  Response.Write  " " & B_LTeam1  & " " &  "(" & B_LPlayer1 & ", " & B_LPlayer2 & ") / " & B_RTeam1 & "(" & " " & B_RPlayer1 & ", " & B_RPlayer2 &  ")  ??? " & Team_StadiumNum & " ?????? "   & B_GameNum & "</td>"
                ELSE
                  Response.Write  " " & B_LTeam1  & " " &  "(" & B_LPlayer1 & ") / " & B_RTeam1 & "(" & " " & B_RPlayer1 &  ")  ??? " & Team_StadiumNum & " ?????? "   & B_GameNum & "</td>"
                END IF
             
               Response.Write "</tr>"
            End IF
          NEXT
        END IF

        if(cdbl(arrayTempNumCnt) < 2 ) Then
          For i = arrayTempNumCnt To 1
            Response.Write " <tr style='height: 30pt;'>"
            Response.Write "<td colspan='5' style='font-size: 18pt; vertical-align: middle; text-align: center;'></td>"
            Response.Write "</tr>"
          Next
        End if
      %>

      <!--
      <tr style="height: 30pt;">
        <td colspan="5" style="font-size: 18pt; vertical-align: middle; text-align: center;">???????????? (????????? / ?????????) -> 12:30 ??? 17?????? 3?????? ?????? (53)</td>
      </tr>
      <tr style="height: 30pt;">
        <td colspan="5" style="font-size: 18pt; vertical-align: middle; text-align: center;">???????????? (????????? / ?????????) -> 12:30 ??? 16?????? 3?????? ?????? (52)</td>
      </tr>

      -->
      <tr style="height: 30pt;">
        <td colspan="5" style="font-size: 18pt; vertical-align: middle; text-align: center;"></td>
      </tr>
      <tr style="height: 30pt;">
        <td colspan="5" style="font-size: 18pt; vertical-align: middle; text-align: center;"></td>
      </tr>


      <%
          Next
        End If          
      %>  
   
    </tbody>
  </table>
</body>
</html>


<%
  DBClose()
%>


<%


  Response.Buffer = True
  Response.ContentType = "application/vnd.ms-excel"
  Response.CacheControl = "public"
  Response.AddHeader "Content-disposition","attachment;filename=score.xls"
%>

