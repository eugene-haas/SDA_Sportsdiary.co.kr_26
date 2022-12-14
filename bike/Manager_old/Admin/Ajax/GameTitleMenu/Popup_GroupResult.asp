<!-- #include file="../../dev/dist/config.asp"-->
<!-- #include file="../../classes/JSON_2.0.4.asp" -->
<!-- #include file="../../classes/JSON_UTIL_0.1.1.asp" -->
<!-- #include file="../../classes/json2.asp" -->
<script language="Javascript" runat="server">
function hasown(obj,  prop){
	if (obj.hasOwnProperty(prop) == true){
		return "ok";
	}
	else{
		return "notok";
	}
}
</script>
<%
	Dim LSQL
	Dim LRs
	Dim strjson
	Dim strjson_sum

	Dim oJSONoutput_SUM
	Dim oJSONoutput

	Dim CMD  
	Dim GameTitleIDX 	

  REQ = Request("Req")
  'REQ = "{""CMD"":12,""tGameLevelDtlIDX"":""B905CA57110E063AAB13676B18043387"",""tTeamGameNum"":""BA8A3F4EEB3BD1BC6BDDCE9B834746BD"",""tGameNum"":""775A4EB13A5B7CE6E0E1AAB80606E49A""}"
  Set oJSONoutput = JSON.Parse(REQ)

  If hasown(oJSONoutput, "tGameLevelDtlIDX") = "ok" then
    GameLevelDtlIDX = fInject(oJSONoutput.tGameLevelDtlIDX)
    DEC_GameLevelDtlIDX = fInject(crypt.DecryptStringENC(oJSONoutput.tGameLevelDtlIDX))
  Else  
    GameLevelDtlIDX = ""
    DEC_GameLevelDtlIDX = ""
  End if	

	If hasown(oJSONoutput, "tTeamGameNum") = "ok" then
    If ISNull(oJSONoutput.tTeamGameNum) Or oJSONoutput.tTeamGameNum = "" Then
      TeamGameNum = ""
      DEC_TeamGameNum = ""
    Else
      TeamGameNum = fInject(oJSONoutput.tTeamGameNum)
      DEC_TeamGameNum = fInject(crypt.DecryptStringENC(oJSONoutput.tTeamGameNum))    
    End If
  Else  
    TeamGameNum = ""
    DEC_TeamGameNum = ""
	End if	

	If hasown(oJSONoutput, "tGameNum") = "ok" then
    If ISNull(oJSONoutput.tGameNum) Or oJSONoutput.tGameNum = "" Then
      GameNum = ""
      DEC_GameNum = ""
    Else
      GameNum = fInject(oJSONoutput.tGameNum)
      DEC_GameNum = fInject(crypt.DecryptStringENC(oJSONoutput.tGameNum))    
    End If
  Else  
    GameNum = ""
    DEC_GameNum = ""
	End if	

  If hasown(oJSONoutput, "tGroupGameGb") = "ok" then
    If ISNull(oJSONoutput.tGroupGameGb) Or oJSONoutput.tGroupGameGb = "" Then
      GroupGameGb = ""
      DEC_GroupGameGb = ""
    Else
      GroupGameGb = fInject(oJSONoutput.tGroupGameGb)
      DEC_GroupGameGb = fInject(crypt.DecryptStringENC(oJSONoutput.tGroupGameGb))    
    End If
  Else  
    GroupGameGb = ""
    DEC_GroupGameGb = ""
	End if	  

  If hasown(oJSONoutput, "tTempNum") = "ok" then
    If ISNull(oJSONoutput.tTempNum) Or oJSONoutput.tTempNum = "" Then
      TempNum = ""
      DEC_TempNum = ""
    Else
      TempNum = fInject(oJSONoutput.tTempNum)
      DEC_TempNum = fInject(crypt.DecryptStringENC(oJSONoutput.tTempNum))    
    End If
  Else  
    TempNum = ""
    DEC_TempNum = ""
	End if	    

  If hasown(oJSONoutput, "tPageGubun") = "ok" then
    If ISNull(oJSONoutput.tPageGubun) Or oJSONoutput.tPageGubun = "" Then
      DEC_PageGubun = ""
    Else
      DEC_PageGubun = fInject(oJSONoutput.tPageGubun) 
    End If
  Else  
    DEC_PageGubun = ""
	End if	    



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
  LSQL = LSQL & " F.Result AS RResult, dbo.FN_NameSch(F.Result, 'PubType') AS RResultNM, F.Jumsu AS RJumsu, F.TotalPoint AS RTotalPoint,"
  LSQL = LSQL & " C.FullGameYN"

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
    StadiumNum = LRs("StadiumNum")
    TotRound = LRs("TotRound")
    GameRound = crypt.EncryptStringENC(LRs("GameRound"))
    GameTypeDtl = LRs("GameTypeDtl")

    FullGameYN = LRs("FullGameYN")

    StadiumName = LRs("StadiumName")
  End If

  LRs.Close

  '????????????..
  If PlayLevelType = "B0100001" Then
      StrLevelName = SexName & " " & PlayTypeName & " " & TeamGbName & " " & LevelName & " " & LevelJooName & " " & LevelJooNum & " " & LevelJooNumDtl & "???" 
  '????????????
  Else
      StrLevelName = SexName & " " & PlayTypeName & " " & TeamGbName & " " & LevelName & " " & LevelJooName & " " & LevelJooNum
  End If

  Function SetJumsu(strGameLevelDtlidx, strTeamGameNum, strGameNum, strTourneyGroupIDX)

      MSQL = " SELECT ISNULL(SUM(SetPoint1),0) AS SetPoint1,"
      MSQL = MSQL & " ISNULL(SUM(SetPoint2),0) AS SetPoint2,"
      MSQL = MSQL & " ISNULL(SUM(SetPoint3),0) AS SetPoint3,"
      MSQL = MSQL & " ISNULL(SUM(SetPoint4),0) AS SetPoint4,"
      MSQL = MSQL & " ISNULL(SUM(SetPoint5),0) AS SetPoint5,"
      
      If SetNum = "1" Then
          MSQL = MSQL & " ISNULL(SUM(SetPoint1),0) AS NowSetPoint"
      ElseIf SetNum = "2" Then
          MSQL = MSQL & " ISNULL(SUM(SetPoint2),0) AS NowSetPoint"
      ElseIf SetNum = "3" Then
          MSQL = MSQL & " ISNULL(SUM(SetPoint3),0) AS NowSetPoint"
      ElseIf SetNum = "4" Then
          MSQL = MSQL & " ISNULL(SUM(SetPoint4),0) AS NowSetPoint"
      ElseIf SetNum = "5" Then
          MSQL = MSQL & " ISNULL(SUM(SetPoint5),0) AS NowSetPoint"
      Else
          MSQL = MSQL & " '-' AS NowSetPoint"
      End If

      MSQL = MSQL & " FROM"
      MSQL = MSQL & "  ("
      MSQL = MSQL & "  SELECT CASE WHEN SetNum = '1' THEN Jumsu ELSE 0 END AS SetPoint1,"
      MSQL = MSQL & "  CASE WHEN SetNum = '2' THEN Jumsu ELSE 0 END AS SetPoint2,"
      MSQL = MSQL & "  CASE WHEN SetNum = '3' THEN Jumsu ELSE 0 END AS SetPoint3,"
      MSQL = MSQL & "  CASE WHEN SetNum = '4' THEN Jumsu ELSE 0 END AS SetPoint4,"
      MSQL = MSQL & "  CASE WHEN SetNum = '5' THEN Jumsu ELSE 0 END AS SetPoint5"
      MSQL = MSQL & "  FROM KoreaBadminton.dbo.tblTourney A"
      MSQL = MSQL & "  LEFT JOIN KoreaBadminton.dbo.tblGameResultDtl B ON B.TourneyGroupIDX = A.TourneyGroupIDX AND B.GameLevelDtlidx = A.GameLevelDtlidx AND B.TeamGameNum = A.TeamGameNum AND B.GameNum = A.GameNum"
      MSQL = MSQL & "  WHERE A.DelYN = 'N'"
      MSQL = MSQL & "  AND B.DelYN = 'N'"
      MSQL = MSQL & "  AND B.GameLevelDtlidx = '" & strGameLevelDtlidx & "'"
      MSQL = MSQL & "  AND B.TeamGameNum = '" & strTeamGameNum & "'"
      MSQL = MSQL & "  AND B.GameNum = '" & strGameNum & "'"
      MSQL = MSQL & "  AND B.TourneyGroupIDX = '" & strTourneyGroupIDX & "'"

      MSQL = MSQL & "  ) AS A"

      Set MRs = Dbcon.Execute(MSQL)

      Set fn_oJSONoutput_ct = jsArray()
      Set fn_oJSONoutput_ct = jsObject()

      If Not (MRs.Eof Or MRs.Bof) Then

          Do Until MRs.Eof

            fn_oJSONoutput_ct("SetPoint1") = MRs("SetPoint1")
            fn_oJSONoutput_ct("SetPoint2") = MRs("SetPoint2")
            fn_oJSONoutput_ct("SetPoint3") = MRs("SetPoint3")
            fn_oJSONoutput_ct("SetPoint4") = MRs("SetPoint4")
            fn_oJSONoutput_ct("SetPoint5") = MRs("SetPoint5")
            fn_oJSONoutput_ct("NowSetPoint") = MRs("NowSetPoint")
                
            MRs.MoveNext
          Loop

      Else
        fn_oJSONoutput_ct("SetPoint1") = "0"
        fn_oJSONoutput_ct("SetPoint2") = "0"
        fn_oJSONoutput_ct("SetPoint3") = "0"
        fn_oJSONoutput_ct("SetPoint4") = "0"
        fn_oJSONoutput_ct("SetPoint5") = "0" 
        fn_oJSONoutput_ct("NowSetPoint") = "0"

      End If

      SetJumsu =  toJSON(fn_oJSONoutput_ct)

      MRs.Close

  End Function  	  

  strjson = JSON.stringify(oJSONoutput)
  Response.Write strjson
  Response.write "`##`"
  'Response.Write "LSQL : " & LSQL & "<BR/>"



  
%>
        <!-- S: modal-body -->
        <div class="modal-body">
         <!-- S: content-title -->
          <h3 class="content-title">
            <span><%=StadiumName%></span> 
						<span><%=StadiumNum%>?????????</span>
						<span><%=DEC_TeamGameNum%>??????</span>
            <span class="redy">???????????? 40D</span>
            <span class="redy">
              <%
              If PlayLevelType = "B0100001" Then
                  Response.Write " ??????" & LevelJooNumDtl & "???"
              ElseIf PlayLevelType = "B0100002" Then

                  If GameTypeDtl = "B0040001" AND FullGameYN = "Y" Then
                    Response.Write "?????????"
                  Else
                    Response.Write "??????"
                  End If

              Else
                  Response.Write "-"
              End If        
              %>               
            </span>
          </h3>
          <!-- E: content-title -->

          <!-- S: ????????? -->
          <!-- s: ?????????????????? ?????? -->
					<div class="select_results">
						<div class="l_con">
							<span class="belong_title">??????</span>
							<span class="belong_name"><%=LTeamNM%></span>
						</div>
						<div class="c_con" onclick="OnAnotherResultBtnClick('<%=crypt.EncryptStringENC(DEC_GameLevelDtlIDX)%>','<%=crypt.EncryptStringENC(DEC_TeamGameNum)%>','<%=crypt.EncryptStringENC("0")%>')" >
							<span>??? ??? ???????????? ??????</span>
						</div>
						<div class="r_con">
							<span class="belong_name"><%=RTeamNM%></span>
							<span class="belong_title">??????</span>
						</div>
					</div>          
					<!-- e: ?????????????????? ?????? -->

          <!-- S: ????????? ????????? -->
          <div class="table_list">
						<table cellspacing="0" cellpadding="0">
							<tr>
								<th>?????????</th>
								<th>???/???</th>
								<th>1??????</th>
								<th>2??????</th>
								<th>3??????</th>
								<th>4??????</th>
								<th>5??????</th>
								<th class="border_3">??? ??? ??????</th>
							</tr>
							<tr>
								<td>
									<span><%=LTeamNM%></span>
									<span><%=LPlayer2%>(<%=LTeam2%>)</span>
                 
								</td>
                <%If LResultType = "WIN" Then%>
                  <td class="yello_bg">
                    <span>???</span>
                  </td>
                <%ElseIf LResultType = "LOSE" Then%>
                  <td>
                    <span>???</span>
                  </td>  
                <%Else%>   
                  <td>
                    <span></span>
                  </td>                             
                <%End If%>
								<td>
									<a href="#" class="rect-jumsu"
                  onclick="OnScoreBtnClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>','<%=GameNum%>','<%=crypt.EncryptStringENC("1")%>','<%=crypt.EncryptStringENC(LTourneyGroupIDX)%>')"
                  data-toggle="modal" data-target=".play_detail_modified" <%If DEC_SetNum = "1" AND LTourneyGroupIDX = DEC_TourneyGroupIDX Then%>class="on"<%End If%>>
                  <%'=JSON_LJumsu.SetPoint1%>
                  </a>
								</td>
								<td>
									<a href="#"
                  onclick="OnScoreBtnClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>','<%=GameNum%>','<%=crypt.EncryptStringENC("2")%>','<%=crypt.EncryptStringENC(LTourneyGroupIDX)%>')"
                  data-toggle="modal" data-target=".play_detail_modified" <%If DEC_SetNum = "2" AND LTourneyGroupIDX = DEC_TourneyGroupIDX Then%>class="on"<%End If%>>
                  <%'=JSON_LJumsu.SetPoint2%>
                  </a>
								</td>
								<td>
									<a href="#"
                  onclick="OnScoreBtnClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>','<%=GameNum%>','<%=crypt.EncryptStringENC("3")%>','<%=crypt.EncryptStringENC(LTourneyGroupIDX)%>')"
                  data-toggle="modal" data-target=".play_detail_modified" <%If DEC_SetNum = "3" AND LTourneyGroupIDX = DEC_TourneyGroupIDX Then%>class="on"<%End If%>>
                  <%'=JSON_LJumsu.SetPoint3%>
                  </a>
								</td>
								<td>
									<a href="#"
                  onclick="OnScoreBtnClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>','<%=GameNum%>','<%=crypt.EncryptStringENC("4")%>','<%=crypt.EncryptStringENC(LTourneyGroupIDX)%>')"
                  data-toggle="modal" data-target=".play_detail_modified" <%If DEC_SetNum = "4" AND LTourneyGroupIDX = DEC_TourneyGroupIDX Then%>class="on"<%End If%>>
                  <%'=JSON_LJumsu.SetPoint4%>
                  </a>
								</td>
								<td>
									<a href="#"
                  onclick="OnScoreBtnClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>','<%=GameNum%>','<%=crypt.EncryptStringENC("5")%>','<%=crypt.EncryptStringENC(LTourneyGroupIDX)%>')"
                  data-toggle="modal" data-target=".play_detail_modified" <%If DEC_SetNum = "5" AND LTourneyGroupIDX = DEC_TourneyGroupIDX Then%>class="on"<%End If%>>
                  <%'=JSON_LJumsu.SetPoint5%>
                  </a>
								</td>
								<td>
                  <%If LResultDtl <> "" Then%>
                    <a href="#" class="red_btn" id="DP_A_AnthCheck_1" onclick="OnAnthTorneyGroupChecked('1','<%=crypt.EncryptStringENC(LTourneyGroupIDX)%>')">
                      <img id="DP_IMGAnthCheck_1" src="/include/modal/img/btn_icon2.png" alt="">
                    </a>
                  <%Else%>
                    <a href="#" class="white_btn" id="DP_A_AnthCheck_1" onclick="OnAnthTorneyGroupChecked('1','<%=crypt.EncryptStringENC(LTourneyGroupIDX)%>')">
                      <img id="DP_IMGAnthCheck_1" src="/include/modal/img/btn_icon1.png" alt="">
                    </a>                  
                  <%End If%>
								</td>
							</tr>
							<tr class="blue_bg">
								<td>
                  <span><%=RPlayer1%>(<%=RTeam1%>)</span>
                  <span><%=RPlayer2%>(<%=RTeam2%>)</span>
                  
								</td>
                <%If RResultType = "WIN" Then%>
                  <td class="yello_bg">
                    <span>???</span>
                  </td>
                <%ElseIf RResultType = "LOSE" Then%>
                  <td>
                    <span>???</span>
                  </td>  
                <%Else%>   
                  <td>
                    <span></span>
                  </td>                             
                <%End If%>     
								<td>
									<a href="#"
                  onclick="OnScoreBtnClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>','<%=GameNum%>','<%=crypt.EncryptStringENC("1")%>','<%=crypt.EncryptStringENC(RTourneyGroupIDX)%>')"
                  data-toggle="modal" data-target=".play_detail_modified" <%If DEC_SetNum = "1" AND RTourneyGroupIDX = DEC_TourneyGroupIDX Then%>class="on"<%End If%>>
                  <%'=JSON_RJumsu.SetPoint1%>
                  </a>
								</td>
								<td>
									<a href="#"
                  onclick="OnScoreBtnClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>','<%=GameNum%>','<%=crypt.EncryptStringENC("2")%>','<%=crypt.EncryptStringENC(RTourneyGroupIDX)%>')"
                  data-toggle="modal" data-target=".play_detail_modified" <%If DEC_SetNum = "2" AND RTourneyGroupIDX = DEC_TourneyGroupIDX Then%>class="on"<%End If%>>
                  <%'=JSON_RJumsu.SetPoint2%>
                  </a>
								</td>
								<td>
									<a href="#"
                  onclick="OnScoreBtnClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>','<%=GameNum%>','<%=crypt.EncryptStringENC("3")%>','<%=crypt.EncryptStringENC(RTourneyGroupIDX)%>')"
                  data-toggle="modal" data-target=".play_detail_modified" <%If DEC_SetNum = "3" AND RTourneyGroupIDX = DEC_TourneyGroupIDX Then%>class="on"<%End If%>>
                  <%'=JSON_RJumsu.SetPoint3%>
                  </a>
								</td>
								<td>
									<a href="#"
                  onclick="OnScoreBtnClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>','<%=GameNum%>','<%=crypt.EncryptStringENC("4")%>','<%=crypt.EncryptStringENC(RTourneyGroupIDX)%>')"
                  data-toggle="modal" data-target=".play_detail_modified" <%If DEC_SetNum = "4" AND RTourneyGroupIDX = DEC_TourneyGroupIDX Then%>class="on"<%End If%>>
                  <%'=JSON_RJumsu.SetPoint4%>
                  </a>
								</td>
								<td>
									<a href="#"
                  onclick="OnScoreBtnClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>','<%=GameNum%>','<%=crypt.EncryptStringENC("5")%>','<%=crypt.EncryptStringENC(RTourneyGroupIDX)%>')"
                  data-toggle="modal" data-target=".play_detail_modified" <%If DEC_SetNum = "5" AND RTourneyGroupIDX = DEC_TourneyGroupIDX Then%>class="on"<%End If%>>
                  <%'=JSON_RJumsu.SetPoint5%>
                  </a>
								</td>
								<td>
                  <%If RResultDtl <> "" Then%>
                    <a href="#" class="red_btn" id="DP_A_AnthCheck_2" onclick="OnAnthTorneyGroupChecked('2','<%=crypt.EncryptStringENC(RTourneyGroupIDX)%>')">
                      <img id="DP_IMGAnthCheck_2" src="/include/modal/img/btn_icon2.png" alt="">
                    </a>
                  <%Else%>
                    <a href="#" class="white_btn" id="DP_A_AnthCheck_2" onclick="OnAnthTorneyGroupChecked('2','<%=crypt.EncryptStringENC(RTourneyGroupIDX)%>')">
                      <img id="DP_IMGAnthCheck_2" src="/include/modal/img/btn_icon1.png" alt="">
                    </a>                  
                  <%End If%>
								</td>
							</tr>
						</table>
					</div>
          <!-- E: ????????? ????????? -->	

					<!-- s: ????????? ????????? -->
					<div class="table_list">





            <table cellspacing="0" cellpadding="0">
              <tr>
                <th rowspan="2">No</th>
                <th rowspan="2">??????</th>
                <th rowspan="2" colspan="2">?????????(?????????)</th>
                <th colspan="6">??????</th>
                <th rowspan="2">????????????</th>
                <th rowspan="2">??????</th>
                <th rowspan="2">??????</th>                
              </tr>
              <tr>
                <th>1??????</th>
                <th>2??????</th>
                <th>3??????</th>
                <th>4??????</th>
                <th>5??????</th>
                <th>???/???</th>
              </tr>  
              <%
                LSQL = " SELECT CCC.GameTitleIDX, CCC.GameLevelDtlIDX, CCC.TeamGameNum, CCC.GameNum, CCC.TeamGb, CCC.Level, CCC.LTourneyGroupIDX , CCC.RTourneyGroupIDX,"
                LSQL = LSQL & " 	CCC.TeamGbNM, CCC.LevelNM, CCC.GameTypeNM,"
                LSQL = LSQL & " 	CCC.LResult, CCC.LResultType, CCC.LResultNM, ISNULL(CCC.LJumsu,0) AS LJumsu,"
                LSQL = LSQL & " 	CCC.RResult, CCC.RResultType, CCC.RResultNM, ISNULL(CCC.RJumsu,0) AS RJumsu,"
                LSQL = LSQL & " 	CCC.GameStatus, CCC.[ROUND], CCC.Sex,"
                LSQL = LSQL & " 	CCC.TempNum, CCC.TurnNum, CCC.GroupGameGb,"
                LSQL = LSQL & " 	CCC.LPlayer1, CCC.LPlayer2, CCC.Rplayer1, CCC.Rplayer2, CCC.LTeam1, CCC.LTeam2, CCC.RTeam1, CCC.RTeam2, CCC.StadiumNum, CCC.StadiumIDX,"
                LSQL = LSQL & " 	CCC.GameDay, CCC.LevelJooNum, CCC.LevelDtlJooNum, CCC.LevelDtlName, dbo.FN_NameSch(CCC.StadiumIDX, 'StadiumIDX') AS StadiumName, PlayLevelType, LevelJooName,"
                LSQL = LSQL & " 	CCC.Win_TourneyGroupIDX, CCC.LGroupJumsu, CCC.RGroupJumsu, CCC.LDtlJumsu, CCC.RDtlJumsu, CCC.SignData, dbo.FN_GameType(CCC.LTourneyGroupIDX,CCC.RTourneyGroupIDX) AS RowGameType"			
                LSQL = LSQL & " FROM "
                LSQL = LSQL & " ("
                LSQL = LSQL & " 	SELECT "
                LSQL = LSQL & " 	BBB.GameTitleIDX, BBB.GameLevelDtlIDX, BBB.TeamGameNum, BBB.GameNum, BBB.TeamGb, BBB.Level, BBB.LTourneyGroupIDX , BBB.RTourneyGroupIDX,"
                LSQL = LSQL & " 	BBB.TeamGbNM, BBB.LevelNM, BBB.GameTypeNM,"
                LSQL = LSQL & " 	BBB.LResult, BBB.LResultType, BBB.LResultNM, BBB.LJumsu,"
                LSQL = LSQL & " 	BBB.RResult, BBB.RResultType, BBB.RResultNM, BBB.RJumsu,"			
                LSQL = LSQL & " 	BBB.GameStatus, BBB.[ROUND], BBB.Sex,"
                LSQL = LSQL & " 	ROW_NUMBER() OVER(ORDER BY CONVERT(BIGINT,ISNULL(BBB.TurnNum,'0')), CONVERT(BIGINT,ISNULL(BBB.TeamGameNum,'0')) ASC, CONVERT(BIGINT,ISNULL(BBB.GameNum,'0'))) AS TempNum, TurnNum, PlayLevelType, GroupGameGb, StadiumNum, StadiumIDX,"
                LSQL = LSQL & " 	GameDay, LevelJooNum, LevelDtlJooNum, LevelDtlName, LevelJooName,"
                LSQL = LSQL & " 	LPlayer1, LPlayer2, Rplayer1, Rplayer2, LTeam1, LTeam2, RTeam1, RTeam2,"
                LSQL = LSQL & " 	BBB.Win_TourneyGroupIDX, BBB.LGroupJumsu, BBB.RGroupJumsu, BBB.LDtlJumsu, BBB.RDtlJumsu, BBB.SignData"			
                LSQL = LSQL & " 	FROM"
                LSQL = LSQL & " 	("
                LSQL = LSQL & " 		SELECT AA.GameTitleIDX, AA.GameLevelDtlIDX, AA.TeamGameNum, AA.GameNum, AA.TeamGb, AA.Level, AA.LTourneyGroupIDX , AA.RTourneyGroupIDX,"
                LSQL = LSQL & " 		AA.TeamGbNM, AA.LevelNM, AA.GameTypeNM,"
                LSQL = LSQL & " 		AA.LResult, AA.LResultType, AA.LResultNM, AA.LJumsu,"
                LSQL = LSQL & " 		AA.RResult, AA.RResultType, AA.RResultNM, AA.RJumsu,"
                LSQL = LSQL & " 		AA.GameStatus, AA.[ROUND], AA.Sex, AA.TurnNum, AA.PlayLevelType, AA.GroupGameGb, AA.StadiumNum, AA.StadiumIDX, AA.GameDay, AA.LevelJooNum, AA.LevelDtlJooNum, AA.LevelDtlName, AA.LevelJooName, AA.SignData,"
                LSQL = LSQL & " 		AA.TourneyGroupIDX AS Win_TourneyGroupIDX, AA.LGroupJumsu, AA.RGroupJumsu, AA.LDtlJumsu, AA.RDtlJumsu,"
                LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',LPlayers) > 0 THEN LEFT(LPlayers,CHARINDEX('|',LPlayers)-1) ELSE LPlayers END  AS LPlayer1, "
                LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',LPlayers) > 0 THEN RIGHT(LPlayers,CHARINDEX('|',REVERSE(LPlayers))-1) ELSE '' END  AS LPlayer2, "
                LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',RPlayers) > 0 THEN LEFT(RPlayers,CHARINDEX('|',RPlayers)-1) ELSE RPlayers END AS RPlayer1, "
                LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',RPlayers) > 0 THEN RIGHT(RPlayers,CHARINDEX('|',REVERSE(RPlayers))-1) ELSE '' END  AS RPlayer2, "
                LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',LTeams) > 0 THEN LEFT(LTeams,CHARINDEX('|',LTeams)-1) ELSE LTeams END AS LTeam1, "
                LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',LTeams) > 0 THEN RIGHT(LTeams,CHARINDEX('|',REVERSE(LTeams))-1) ELSE '' END AS LTeam2, "
                LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',RTeams) > 0 THEN LEFT(RTeams,CHARINDEX('|',RTeams)-1) ELSE RTeams END AS RTeam1, "
                LSQL = LSQL & " 		CASE WHEN CHARINDEX('|',RTeams) > 0 THEN RIGHT(RTeams,CHARINDEX('|',REVERSE(RTeams))-1) ELSE '' END AS RTeam2"
                LSQL = LSQL & " 		FROM"
                LSQL = LSQL & " 		("
                LSQL = LSQL & " 		    SELECT A.GameTitleIDX, A.GameLevelDtlIDX, A.TeamGameNum, A.GameNum, A.TeamGb, A.Level, CONVERT(VARCHAR(10),A.TourneyGroupIDX) AS LTourneyGroupIDX, CONVERT(VARCHAR(10),B.TourneyGroupIDX) AS RTourneyGroupIDX, "
                LSQL = LSQL & " 		    KoreaBadminton.dbo.FN_NameSch(A.TeamGb,'TeamGb') AS TeamGbNM, KoreaBadminton.dbo.FN_NameSch(A.Level,'Level') AS LevelNM,"
                LSQL = LSQL & " 		    KoreaBadminton.dbo.FN_NameSch(D.PlayType,'PubCode') AS GameTypeNM,"
                LSQL = LSQL & " 		    E.Result AS LResult, dbo.FN_NameSch(E.Result, 'PubType') AS LResultType, dbo.FN_NameSch(E.Result, 'PubCode') AS LResultNM, E.Jumsu AS LJumsu,"
                LSQL = LSQL & " 		    F.Result AS RResult, dbo.FN_NameSch(F.Result, 'PubType') AS RResultType, dbo.FN_NameSch(F.Result, 'PubCode') AS RResultNM, F.Jumsu AS RJumsu,"
                LSQL = LSQL & " 		    E.Result, dbo.FN_NameSch(E.Result, 'PubType') AS ResultType, dbo.FN_NameSch(E.Result, 'PubCode') AS ResultNM, E.Jumsu,"
                LSQL = LSQL & " 		    KoreaBadminton.dbo.FN_GameStatus(A.GameLevelDtlidx, A.TeamGameNum, A.GameNum) AS GameStatus, A.[ROUND], C.PlayLevelType, A.ORDERBY, dbo.FN_NameSch(D.Sex, 'PubCode') AS Sex,"
                LSQL = LSQL & " 		    A.TurnNum, D.GroupGameGb, A.StadiumNum, A.StadiumIDX, A.GameDay, D.LevelJooNum, C.LevelJooNum AS LevelDtlJooNum, C.LevelDtlName, dbo.FN_NameSch(D.LevelJooName,'Pubcode') AS LevelJooName, G.SignData,"
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
                LSQL = LSQL & " 		    		SELECT GameLevelDtlidx, TeamGameNum, GameNum, TourneyGroupIDX, Result, Jumsu"
                LSQL = LSQL & " 		    		FROM KoreaBadminton.dbo.tblGameResult"
                LSQL = LSQL & " 		    		WHERE DelYN = 'N'"
                LSQL = LSQL & " 		    		GROUP BY GameLevelDtlidx, TeamGameNum, GameNum, TourneyGroupIDX, Result, Jumsu"
                LSQL = LSQL & " 		    		) AS E ON E.GameLevelDtlidx = A.GameLevelDtlidx AND E.TeamGameNum = A.TeamGameNum AND E.GameNum = A.GameNum AND E.TourneyGroupIDX = A.TourneyGroupIDX    "
                LSQL = LSQL & " 		    	LEFT JOIN ("
                LSQL = LSQL & " 		    		SELECT GameLevelDtlidx, TeamGameNum, GameNum, TourneyGroupIDX, Result, Jumsu"
                LSQL = LSQL & " 		    		FROM KoreaBadminton.dbo.tblGameResult"
                LSQL = LSQL & " 		    		WHERE DelYN = 'N'"
                LSQL = LSQL & " 		    		GROUP BY GameLevelDtlidx, TeamGameNum, GameNum, TourneyGroupIDX, Result, Jumsu"
                LSQL = LSQL & " 		    		) AS F ON F.GameLevelDtlidx = B.GameLevelDtlidx AND F.TeamGameNum = B.TeamGameNum AND F.GameNum = B.GameNum AND F.TourneyGroupIDX = B.TourneyGroupIDX    "			
                LSQL = LSQL & " 		    	LEFT JOIN ("
                LSQL = LSQL & " 		    		SELECT GameLevelDtlidx, TeamGameNum, GameNum, SignData"
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
                LSQL = LSQL & " 		) AS AA"
                LSQL = LSQL & " 		WHERE GameLevelDtlIDX IS NOT NULL"
                LSQL = LSQL & " 	) AS BBB"
                LSQL = LSQL & " ) AS CCC"
                LSQL = LSQL & " WHERE CCC.GameLevelDtlIDX IS NOT NULL"   

                Set LRs = Dbcon.Execute(LSQL)

                i = 1

                If Not (LRs.Eof Or LRs.Bof) Then
                  Do Until LRs.Eof         

                    Set fn_oJSONoutput_LJumsu = jsArray()
                    Set fn_oJSONoutput_RJumsu = jsArray()

                    '??????????????????????????? ?????? ???????????? ??????
                  
                      fn_oJSONoutput_LJumsu = SetJumsu(DEC_GameLevelDtlIDX, DEC_TeamGameNum, LRs("GameNum"), LRs("LTourneyGroupIDX"))
                      fn_oJSONoutput_RJumsu = SetJumsu(DEC_GameLevelDtlIDX, DEC_TeamGameNum, LRs("GameNum"), LRs("RTourneyGroupIDX"))			
                      Win_TourneyGroupIDX = LRs("Win_TourneyGroupIDX")
                      LResultType = LRs("LResultType")
                      RResultType = LRs("RResultType")
                      SignData = LRs("SignData")


                    Set JSON_LJumsu = JSON.Parse(fn_oJSONoutput_LJumsu)
                    Set JSON_RJumsu = JSON.Parse(fn_oJSONoutput_RJumsu)		                                         
              %>        
              <tr <%If i mod 2 = 1 Then%>style="background:#f7f9fb;"<%End If%>>
                <td rowspan="2"><%=i%></td>
                <td rowspan="2"><%=LRs("RowGameType")%></td>
                <td><%=LRs("LPlayer1")%></td>
                <td><%=LRs("LPlayer2")%></td>                
                <td><%=JSON_LJumsu.SetPoint1%></td>
                <td><%=JSON_LJumsu.SetPoint2%></td>
                <td><%=JSON_LJumsu.SetPoint3%></td>
                <td><%=JSON_LJumsu.SetPoint4%></td>
                <td><%=JSON_LJumsu.SetPoint5%></td>
                <%
                  '??????????????? ????????? ?????????
                  If Win_TourneyGroupIDX <> "" Then
                    '????????? ??????????????? "???" ??????
                    If LResultType = "WIN" Then
                %>
                  <td class="yello_bg">
                    <span>???</span>
                  </td>
                <%
                    Else
                %>
                  <td>
                    <span>???</span>
                  </td>                
                <%
                    End If
                  Else
                %>
                  <td>
                    <span>-</span>
                  </td>                
                <%
                  End If
                %>	
                <td>
                  <%If SignData <> "" AND NOT ISNULL(SignData) Then
                      If LResultType = "WIN" Then
                  %>
                    <img src="<%=SignData%>" width="40" alt="">
                  <%
                      End If
                    End If
                  %>	                
                </td>                
                <td rowspan="2"><a href="#" class="modified_btn btn-blue" onclick="OnGroupResultDtlBtnExcelClick('<%=crypt.EncryptStringENC(LRs("GameLevelDtlIDX"))%>','<%=crypt.EncryptStringENC(LRs("TeamGameNum"))%>','<%=crypt.EncryptStringENC(LRs("GameNum"))%>','<%=crypt.EncryptStringENC("1")%>','')">??????</a></td>
                <td rowspan="2"><a href="#" class="modified_btn" onclick="OnGroupResultDtlBtnClick('<%=crypt.EncryptStringENC(LRs("GameLevelDtlIDX"))%>','<%=crypt.EncryptStringENC(LRs("TeamGameNum"))%>','<%=crypt.EncryptStringENC(LRs("GameNum"))%>','<%=crypt.EncryptStringENC("1")%>','')">??????</a></td>
              </tr>                
              <tr <%If i mod 2 = 1 Then%>style="background:#f7f9fb;"<%End If%>>
                <td><%=LRs("RPlayer1")%></td>
                <td><%=LRs("RPlayer2")%></td>                
                <td><%=JSON_RJumsu.SetPoint1%></td>
                <td><%=JSON_RJumsu.SetPoint2%></td>
                <td><%=JSON_RJumsu.SetPoint3%></td>
                <td><%=JSON_RJumsu.SetPoint4%></td>
                <td><%=JSON_RJumsu.SetPoint5%></td>
                <%
                  '??????????????? ????????? ?????????
                  If Win_TourneyGroupIDX <> "" Then
                    '????????? ??????????????? "???" ??????
                    If RResultType = "WIN" Then
                %>
                  <td class="yello_bg">
                    <span>???</span>
                  </td>
                <%
                    Else
                %>
                  <td>
                    <span>???</span>
                  </td>                
                <%
                    End If
                  Else
                %>
                  <td>
                    <span>-</span>
                  </td>                
                <%
                  End If
                %>	    
                <td>
                  <%If SignData <> "" AND NOT ISNULL(SignData) Then
                      If RResultType = "WIN" Then
                  %>
                    <img src="<%=SignData%>" width="40" alt="">
                  <%
                      End If
                    End If
                  %>	                
                </td>                

              </tr>  
              <%
                      i = i + 1
                    LRs.MoveNext
                  Loop 
                End If
              %>				
            </table>
            
					</div>
					<!-- e: ????????? ????????? -->
          <!-- E: ????????? -->
        </div>
        <!-- E: modal-body -->
        <!-- S: order-footer -->
        <div class="order-footer">
          <ul class="btn-list clearfix">
            <li><a href="#" class="btn btn-default" data-dismiss="modal">??????</a></li>
            <li><a href="#" class="btn btn-red" onclick="OnGroupResultCompleteClick('<%=GameLevelDtlIDX%>', '<%=TeamGameNum%>', '<%=GameNum%>', '<%=GameRound%>');">??????</a></li>
            <li><a href="#" class="btn btn-blue" onclick="OnGroupResultPrintClick('<%=GameLevelDtlIDX%>', '<%=TeamGameNum%>', '<%=GameNum%>', '1',  '<%=GroupGameGb%>', '<%=TempNum%>');">?????????????????? ??????</a></li>
          </ul>
        </div>
        <!-- E: order-footer -->
<%

Set LRs = Nothing
DBClose()
  
%>