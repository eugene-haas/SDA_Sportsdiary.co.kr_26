<!--#include file="../Library/ajax_config_26.asp"-->
<%
  'Check_Login()

  iPlayerIDX = fInject(Request("iPlayerIDX"))
  iGameScoreIDX = fInject(Request("iGameScoreIDX"))
  iGroupGameGbName = fInject(Request("iGroupGameGbName"))
  iResultIDX = fInject(Request("iResultIDX"))

  iPlayerIDX = decode(iPlayerIDX,0)

  EnterType =  Request.Cookies(SportsGb)("EnterType")

  iSportsGb = SportsGb
  iEnterType = EnterType

  'iPlayerIDX = "1403"
  'iGameScoreIDX = "1588"
  'iGroupGameGbName = "sd040001"


  Dim iRGameLevelidx, iGameTitleIDX, iGroupGameGb, iGroupGameGbName, iGroupGameNum, iGameNum

  iType = "1"
  'iSportsGb = "judo"

  iGroupGameGb = ""

  LRsCnt = 0

    'iResultIDX=3623

  LSQL = "EXEC Record_Detail_Search '" & iType & "','" & iSportsGb & "','" & iPlayerIDX & "','" & iGameScoreIDX & "','" & iEnterType & "','" & iGroupGameGb & "','" & iResultIDX & "','','','','',''"
  'response.Write "LSQL="&LSQL&"<br>"
       ' response.End

  Set LRs = DBCon.Execute(LSQL)

  If Not (LRs.Eof Or LRs.Bof) Then
    Do Until LRs.Eof

        LRsCnt = LRsCnt + 1
        iMLink = LRs("MLink")
        iResultIDX = LRs("ResultIDX")
        iLgameMemberIDX = LRs("LgameMemberIDX")
        iLPlayerIDX1 = LRs("LPlayerIDX1")
        iLPlayerNm1 = LRs("LPlayerNm1")
        iLPlayerIDX2 = LRs("LPlayerIDX2")
        iLPlayerNm2 = LRs("LPlayerNm2")
        iLTeamNm1 = LRs("LTeamNm1")
        iLTeamNm2 = LRs("LTeamNm2")
        iRgameMemberIDX = LRs("RgameMemberIDX")
        iRPlayerIDX1 = LRs("RPlayerIDX1")
        iRPlayerNm1 = LRs("RPlayerNm1")
        iRPlayerIDX2 = LRs("RPlayerIDX2")
        iRPlayerNm2 = LRs("RPlayerNm2")
        iRTeamNm1 = LRs("RTeamNm1")
        iRTeamNm2 = LRs("RTeamNm2")

        im1set1 = LRs("m1set1")
        im1set2 = LRs("m1set2")
        im1set3 = LRs("m1set3")
        im2set1 = LRs("m2set1")
        im2set2 = LRs("m2set2")
        im2set3 = LRs("m2set3")
        im1set = LRs("m1set")
        im2set = LRs("m2set")
        iWinResult = LRs("WinResult")
        iTiebreakPT = LRs("TiebreakPT")

        'iRGameLevelidx = LRs("RGameLevelidx")
        'iGameTitleIDX = LRs("GameTitleIDX")
        'iGroupGameGb = LRs("GroupGameGb")
        'iGroupGameGbName = LRs("GroupGameGbName")
        'iGroupGameNum = LRs("GroupGameNum")
        'iGameNum = LRs("GameNum")

      LRs.MoveNext
    Loop
  else

  End If

  LRs.close


  Dim iLTeamNm, iRTeamNm, iLPlayerName, iRPlayerName, iPlayerResultName, iMediaLink, iLRPlayerType

  iType = "2"
  'iSportsGb = "judo"

  LRsCnt1 = 0

  LSQL = "EXEC Record_Detail_Search '" & iType & "','" & iSportsGb & "','" & iPlayerIDX & "','" & iGameScoreIDX & "','" & iEnterType & "','" & iGroupGameGb & "','" & iResultIDX & "','','','','',''"
  'response.Write "LSQL="&LSQL&"<br>"
  'response.End

  Set LRs = DBCon.Execute(LSQL)

  If Not (LRs.Eof Or LRs.Bof) Then
    Do Until LRs.Eof

			LRsCnt1 = LRsCnt1 + 1
      iLSvAceCnt = LRs("LSvAceCnt")
      iRSvAceCnt = LRs("RSvAceCnt")
      iLSvOutCnt = LRs("LSvOutCnt")
      iRSvOutCnt = LRs("RSvOutCnt")
      iLSvWinPer = LRs("LSvWinPer")
      iRSvWinPer = LRs("RSvWinPer")
      iLSvGCnt = LRs("LSvGCnt")
			iRSvGCnt = LRs("RSvGCnt")
			iLBPPer = LRs("LBPPer")
			iRBPPer = LRs("RBPPer")
			iLRGCnt = LRs("LRGCnt")
			iRRGCnt = LRs("RRGCnt")

      LRs.MoveNext
    Loop
  else

  End If

  LRs.close
  '
  '
  'Dim iLResultName, iLJumsu, LRsCnt1, iLRPlayerType2
  'LRsCnt1 = 0
  '
  'iType = "21"
  ''iSportsGb = "judo"
  '
  'LSQL = "EXEC Stat_TM_Record_Detail_Score_Search '" & iType & "','" & iSportsGb & "','" & iPlayerIDX & "','" & iGameScoreIDX & "','" & iRGameLevelidx & "','" & iGameTitleIDX & "','" & iGroupGameGb & "','" & iGroupGameNum & "','" & iGameNum & "'"
  ''response.Write "LSQL="&LSQL&"<br>"
  ''response.End
  '
  'Set LRs = DBCon.Execute(LSQL)
  '
  'If Not (LRs.Eof Or LRs.Bof) Then
  ' Do Until LRs.Eof
  '
  '      LRsCnt1 = LRsCnt1 + 1
  '
  '      'iWResultName = LRs("ResultName")
  '      'iWJumsu = LRs("Jumsu")
  '
  '      iLResultName = iLResultName&"^"&LRs("ResultName")&""
  '      iLJumsu = iLJumsu&"^"&LRs("Jumsu")&""
  '      iLRPlayerType2 = iLRPlayerType2&"^"&LRs("LRPlayerType")&""
  '
  '    LRs.MoveNext
  ' Loop
  'else
  '
  'End If
  '
  'LRs.close
  '
  '
  'Dim iRResultName, iRJumsu, LRsCnt2, iLRPlayerType3
  'LRsCnt2 = 0
  '
  'iType = "31"
  ''iSportsGb = "judo"
  '
  'LSQL = "EXEC Stat_TM_Record_Detail_Score_Search '" & iType & "','" & iSportsGb & "','" & iPlayerIDX & "','" & iGameScoreIDX & "','" & iRGameLevelidx & "','" & iGameTitleIDX & "','" & iGroupGameGb & "','" & iGroupGameNum & "','" & iGameNum & "'"
  ''response.Write "LSQL="&LSQL&"<br>"
  ''response.End
  '
  'Set LRs = DBCon.Execute(LSQL)
  '
  'If Not (LRs.Eof Or LRs.Bof) Then
  ' Do Until LRs.Eof
  '
  '      LRsCnt2 = LRsCnt2 + 1
  '
  '      iRResultName = iRResultName&"^"&LRs("ResultName")&""
  '      iRJumsu = iRJumsu&"^"&LRs("Jumsu")&""
  '      iLRPlayerType3 = iLRPlayerType3&"^"&LRs("LRPlayerType")&""
  '
  '    LRs.MoveNext
  ' Loop
  'else
  '
  'End If
  '
  'LRs.close
  '
  '
  'Dim iResultName, iSpecialtyDtlName, iCheckTime, iUserName, iLRPlayerType1, LRsCnt3
  'LRsCnt3 = 0
  '
  'iType = "42"
  ''iSportsGb = "judo"
  '
  'LSQL = "EXEC Stat_TM_Record_Detail_Score_Search '" & iType & "','" & iSportsGb & "','" & iPlayerIDX & "','" & iGameScoreIDX & "','" & iRGameLevelidx & "','" & iGameTitleIDX & "','" & iGroupGameGb & "','" & iGroupGameNum & "','" & iGameNum & "'"
  ''response.Write "LSQL="&LSQL&"<br>"
  ''response.End
  '
  'Set LRs = DBCon.Execute(LSQL)
  '
  'If Not (LRs.Eof Or LRs.Bof) Then
  ' Do Until LRs.Eof
  '
  '      LRsCnt3 = LRsCnt3 + 1
  '
  '      iResultName = iResultName&"^"&LRs("ResultName")&""
  '      iSpecialtyDtlName = iSpecialtyDtlName&"^"&LRs("SpecialtyDtlName")&""
  '      iCheckTime = iCheckTime&"^"&LRs("CheckTime")&""
  '      iUserName = iUserName&"^"&LRs("UserName")&""
  '      iLRPlayerType1 = iLRPlayerType1&"^"&LRs("LRPlayerType")&""
  '      iOverTime = iOverTime&"^"&LRs("OverTime")&""
  '
  '    LRs.MoveNext
  ' Loop
  'else
  '
  'End If
  '
  'LRs.close
  '

  Dbclose()


%>
<% if LRsCnt = 0 then %>

<!-- S: modal-dialog -->
  <div class="modal-dialog">
    <!-- S: modal-content -->
    <div class="modal-content">
      <!-- S: modal-header -->
      <div class="modal-header">
        <h3>???????????????</h3>
        <a href="#" class="btn btn-close" data-dismiss="modal">&times;</a>
      </div>
      <!-- E: modal-header -->

      <!-- S: modal-body -->
      <div class="modal-body">
        <!-- S: banner -->
        <!-- <div class="banner banner_md">
          <div class="img_box">
            <img src="../images/public/banner_md@3x.png" alt="????????????">
          </div>
        </div> -->
        <!-- E: banner -->

        <!-- S: score_board -->
        <div class="score_board" id="ScoreBoard">
          <h4><span>SET SCORE 2:1</span></h4>

          <!-- S: board_table -->
          <ul class="tn_board_table clearfix">
            <li>
              <div class="board_header">
                <!-- S: p_self -->
                <div class="p_self">
                  <span class="player">?????????</span>
                  <span class="team">????????????_??????, ???1 ??????????????????</span>
                </div>
                <!-- E: p_self -->
                <!-- S: p_pt -->
                <div class="p_pt">
                  <span class="player">?????????</span>
                  <span class="team">????????????, ???2 ??????????????????</span>
                </div>
                <!-- E: p_pt -->
              </div>
              <!-- S: win -->
              <div class="win" rowspan="2">
                <div class="img_box">
                  <img src="http://img.sportsdiary.co.kr/sdapp/modal/win_crown@3x.png" alt="win">
                </div>
              </div>
              <!-- E: win -->
              <div class="num y">7</div>
              <div class="num">4</div>
              <div class="num y">7</div>
              <div class="num"></div>
              <div class="num y"></div>
            </li>

            <li class="set_line">
              <div class="board_header"></div>
              <div class="win"></div>
              <div class="num">1</div>
              <div class="num">2</div>
              <div class="num">3</div>
              <div class="num">4</div>
              <div class="num">5</div>
            </li>

            <li>
              <div class="board_header">
                <!-- S: p_self -->
                <div class="p_self">
                  <span class="player">?????????</span>
                  <span class="team">????????????, ???1 ??????????????????</span>
                </div>
                <!-- E: p_self -->
                <!-- S: p_pt -->
                <div class="p_pt">
                  <span class="player">?????????</span>
                  <span class="team">????????????, ???2 ??????????????????</span>
                </div>
                <!-- E: p_pt -->
              </div>
              <!-- S: win -->
              <div class="win" rowspan="2">
                <div class="img_box">
                  <img src="http://img.sportsdiary.co.kr/sdapp/modal/win_crown@3x.png" alt="win">
                </div>
              </div>
              <!-- E: win -->
              <div class="num">5</div>
              <div class="num y">6</div>
              <div class="num">6 <span class="tie">(11)</span></div>
              <div class="num y"></div>
              <div class="num"></div>
            </li>

            <li class="duration">
              <div class="board_header">
                <span class="ic_deco"><i class="fa fa-clock-o"></i></span>
                <span>Match Duration</span>
                <span>2'10'</span>
              </div>
              <div class="win"></div>
              <div class="num">46'</div>
              <div class="num">29'</div>
              <div class="num">55'</div>
              <div class="num"></div>
              <div class="num"></div>
            </li>
          </ul>
          <!-- E: board_table -->
        </div>
        <!-- E: score_board -->

        <!-- S: tn_display_board -->
        <!-- <div class="tn_display_board" id="DetailScoreBoard">
          S: record-box
          <div class="record-box panel">
            <h4>????????????</h4>
            S: scroll_box
            <div class="scroll_box">
              S: ???????????? ?????? ???
              <table class="match_summary tn_match_summary">
                <tr>
                  <td>2</td>
                  <th>?????? ????????? ???</th>
                  <td>8</td>
                </tr>
                <tr>
                  <td>8</td>
                  <th>???????????? ???</th>
                  <td>7</td>
                </tr>
                <tr>
                  <td>39%</td>
                  <th>????????? ?????? IN(%)</th>
                  <td>61%</td>
                </tr>
                <tr>
                  <td>45%</td>
                  <th>????????? ?????? ????????? ?????????(%)</th>
                  <td>61%</td>
                </tr>
                <tr>
                  <td>40%</td>
                  <th>?????? ?????? IN(%)</th>
                  <td>60%</td>
                </tr>
                <tr>
                  <td>41%</td>
                  <th>?????? ?????? ????????? ?????????(%)</th>
                  <td>59%</td>
                </tr>
                <tr>
                  <td>30%</td>
                  <th>????????? ?????? ?????????(%)</th>
                  <td>70%</td>
                </tr>
                <tr>
                  <td>45%</td>
                  <th>???????????? ????????? ?????????(%)</th>
                  <td>55%</td>
                </tr>
                <tr>
                  <td>40%</td>
                  <th>?????? ????????? ?????????(%)</th>
                  <td>60%</td>
                </tr>
                <tr>
                  <td>41%</td>
                  <th>???????????? ????????? ?????????(%)</th>
                  <td>59%</td>
                </tr>
                <tr>
                  <td>30%</td>
                  <th>?????? ????????? ?????????(%)</th>
                  <td>70%</td>
                </tr>
                <tr>
                  <td>12%</td>
                  <th>????????? ????????? ?????????(%)</th>
                  <td>30%</td>
                </tr>
              </table>
              E: ???????????? ?????? ???
            </div>
            E: scroll_box
          </div> -->
          <!-- E: record-box -->

          <!-- S: banner_lg -->
          <!-- <div class="banner banner_lg">
            <div class="img_box">
              <img src="../images/public/banner_lg@3x.png" alt="????????????">
            </div>
          </div> -->
          <!-- E: banner_lg -->

          <!-- S: ????????????  -->
          <!-- <div class="film-box panel clearfix">
            <iframe width="100%" height="220" src="https://www.youtube.com/embed/DCLAOwf9rgM?rel=0" frameborder="0" allowfullscreen></iframe>
            <button id="btnrewind" onclick="rewind(5);" class="btn btn-orage btn-rewind"><<</button>
            <button id="btnfastforward" onclick="fastforward(5)" class="btn btn-orange btn-fastforward">>></button>
          </div> -->
          <!-- E: ????????????  -->

        <!-- </div> -->
        <!-- E: tn_display_board -->
      </div>
      <!-- E: modal-body -->

      <!-- S: modal-footer -->
      <div class="modal-footer">
        <div class="btn-list flex">
          <!-- <button class="btn btn-green">
            <span class="ic-deco"><img src="../images/stats/film-icon@3x.png" alt></span>
            ????????????
          </button>
          <button class="btn btn-green btn-record">????????????</button> -->
          <button class="btn btn-default" data-dismiss="modal">??????</button>
        </div>
      </div>
      <!-- E: modal-footer -->
    </div>
    <!-- E: modal-content -->
  </div>
  <!-- E: modal-dialog -->

<% else %>

<!-- S: modal-dialog -->
  <div class="modal-dialog">
    <!-- S: modal-content -->
    <div class="modal-content">
      <!-- S: modal-header -->
      <div class="modal-header">
        <h3>???????????????</h3>
        <a href="#" class="btn btn-close" data-dismiss="modal">&times;</a>
      </div>
      <!-- E: modal-header -->

      <!-- S: modal-body -->
      <div class="modal-body">
        <!-- S: banner -->
        <!-- <div class="banner banner_md">
          <div class="img_box">
            <img src="../images/public/banner_md@3x.png" alt="????????????">
          </div>
        </div> -->
        <!-- E: banner -->

        <!-- S: score_board -->
        <div class="score_board" id="ScoreBoard">
          <h4><span>SET SCORE <%=im1set %>:<%=im2set %></span></h4>

          <!-- S: board_table -->
          <ul class="tn_board_table clearfix">
            <li>
              <div class="board_header">
                <!-- S: p_self -->
                <div class="p_self">
                  <span class="player"><%=iLPlayerNm1 %></span>
                  <span class="team"><%=iLTeamNm1 %></span>
                </div>
                <!-- E: p_self -->
                <!-- S: p_pt -->
                <div class="p_pt">
                  <span class="player"><%=iLPlayerNm2 %></span>
                  <span class="team"><%=iLTeamNm2 %></span>
                </div>
                <!-- E: p_pt -->
              </div>
              <!-- S: win -->
              <div class="win" rowspan="2">
                <% if iWinResult = "left" then %>
                <div class="img_box">
                  <img src="../images/modal/win_crown@3x.png" alt="win">
                </div>
                <% end if %>
              </div>
              <!-- E: win -->
              <div class="num y"><%=im1set1 %></div>
              <div class="num"><%=im1set2 %></div>
              <div class="num y"><%=im1set3 %>
                <% if iTiebreakPT <> "0" and iWinResult = "right" then %>
                <span class="tie">(<%=iTiebreakPT %>)</span>
                <% end if %>
              </div>
              <div class="num"></div>
              <div class="num y"></div>
            </li>

            <li class="set_line">
              <div class="board_header"></div>
              <div class="win"></div>
              <div class="num">1</div>
              <div class="num">2</div>
              <div class="num">3</div>
              <div class="num">4</div>
              <div class="num">5</div>
            </li>

            <li>
              <div class="board_header">
                <!-- S: p_self -->
                <div class="p_self">
                  <span class="player"><%=iRPlayerNm1 %></span>
                  <span class="team"><%=iRTeamNm1 %></span>
                </div>
                <!-- E: p_self -->
                <!-- S: p_pt -->
                <div class="p_pt">
                  <span class="player"><%=iRPlayerNm2 %></span>
                  <span class="team"><%=iRTeamNm2 %></span>
                </div>
                <!-- E: p_pt -->
              </div>
              <!-- S: win -->
              <div class="win" rowspan="2">
                <% if iWinResult = "right" then %>
                <div class="img_box">
                  <img src="../images/modal/win_crown@3x.png" alt="win">
                </div>
                <% end if %>
              </div>
              <!-- E: win -->
              <div class="num"><%=im2set1 %></div>
              <div class="num y"><%=im2set2 %></div>
              <div class="num"><%=im2set3 %>
                <% if iTiebreakPT <> "0" and iWinResult = "left" then %>
                <span class="tie">(<%=iTiebreakPT %>)</span>
                <% end if %>
              </div>
              <div class="num y"></div>
              <div class="num"></div>
            </li>

            <!--<li class="duration">
              <div class="board_header">
                <span class="ic_deco"><i class="fa fa-clock-o"></i></span>
                <span>Match Duration</span>
                <span>2'10'</span>
              </div>
              <div class="win"></div>
              <div class="num">46'</div>
              <div class="num">29'</div>
              <div class="num">55'</div>
              <div class="num"></div>
              <div class="num"></div>
            </li>-->
          </ul>
          <!-- E: board_table -->
        </div>
        <!-- E: score_board -->

        <!-- S: tn_display_board -->
        <div class="tn_display_board" id="DetailScoreBoard">

          <!-- S: record-box -->
          <div class="record-box panel">
            <h4>????????????</h4>

            <div class="player_divn">
              <ul class="clearfix">
                <li class="team_a">
                  <span><%=iLPlayerNm1 %></span>
                  <span><%=iLPlayerNm2 %></span>
                </li>
                <li class="vs"><span>VS</span></li>
                <li class="team_b">
                  <span><%=iRPlayerNm1 %></span>
                  <span><%=iRPlayerNm2 %></span>
                </li>
              </ul>
            </div>

            <!-- S: scroll_box -->
            <div class="scroll_box">
              <!-- S: ???????????? ?????? ???-->
              <table class="match_summary tn_match_summary">
                <tr>
                  <td><%=iLSvAceCnt %></td>
                  <th>?????? ????????? ???</th>
                  <td><%=iRSvAceCnt %></td>
                </tr>
                <tr>
                  <td><%=iLSvOutCnt %></td>
                  <th>???????????? ???</th>
                  <td><%=iRSvOutCnt %></td>
                </tr>
                <tr>
                  <td><%=iLSvWinPer %>%</td>
                  <th>????????? ?????? ?????????(%)</th>
                  <td><%=iRSvWinPer %>%</td>
                </tr>
                <tr>
                  <td><%=iLSvGCnt %></td>
                  <th>????????? ?????? ???</th>
                  <td><%=iRSvGCnt %></td>
                </tr>
                <tr>
                  <td><%=iLBPPer %>%</td>
                  <th>???????????? ????????? ?????????(%)</th>
                  <td><%=iRBPPer %>%</td>
                </tr>
                <tr>
                  <td><%=iLRGCnt %></td>
                  <th>?????? ?????? ???</th>
                  <td><%=iRRGCnt %></td>
                </tr>
                <!--<tr>
                  <td>30%</td>
                  <th>????????? ?????? ?????????(%)</th>
                  <td>70%</td>
                </tr>
                <tr>
                  <td>45%</td>
                  <th>???????????? ????????? ?????????(%)</th>
                  <td>55%</td>
                </tr>
                <tr>
                  <td>40%</td>
                  <th>?????? ????????? ?????????(%)</th>
                  <td>60%</td>
                </tr>
                <tr>
                  <td>41%</td>
                  <th>???????????? ????????? ?????????(%)</th>
                  <td>59%</td>
                </tr>
                <tr>
                  <td>30%</td>
                  <th>?????? ????????? ?????????(%)</th>
                  <td>70%</td>
                </tr>
                <tr>
                  <td>12%</td>
                  <th>????????? ????????? ?????????(%)</th>
                  <td>30%</td>
                </tr>-->
              </table>
              <!-- E: ???????????? ?????? ??? -->
            </div>
            <!-- E: scroll_box -->
          </div>
          <!-- E: record-box -->

          <!-- S: banner_lg -->
          <!-- <div class="banner banner_lg">
            <div class="img_box">
              <img src="../images/public/banner_lg@3x.png" alt="????????????">
            </div>
          </div> -->
          <!-- E: banner_lg -->

					<% if iMlink <> "" then %>
          <!-- S: ????????????  -->
          <div class="film-box panel clearfix">
            <iframe id="player_Ifram_MediaLink" width="100%" height="220" src="https://www.youtube.com/embed/<%=iMlink %>?rel=0&cc_load_policy=1" frameborder="0" allowfullscreen></iframe>
          </div>
          <!-- E: ????????????  -->
					<% end if %>

        </div>
        <!-- E: tn_display_board -->
      </div>
      <!-- E: modal-body -->

      <!-- S: modal-footer -->
      <div class="modal-footer">
        <div class="btn-list flex">
					<% if iMlink <> "" then %>
          <button class="btn btn-green btn-film" id="btn_movie"><span class="ic-deco"><img src="../images/stats/film-icon@3x.png" alt></span>????????????</button>
					<% else %>
					<button class="btn btn-gray" id="btn_movie"><span class="ic-deco"><img src="../images/stats/film-icon@3x.png" alt></span>????????????</button>
					<% end if %>
          <button class="btn btn-green btn-record" id="btn_log" >????????????</button>
          <button class="btn btn-default" data-dismiss="modal" >??????</button>
        </div>
      </div>
      <!-- E: modal-footer -->
    </div>
    <!-- E: modal-content -->
  </div>
  <!-- E: modal-dialog -->

<% end if %>

<script type="text/javascript">

  //// ??????????????? ?????? ?????? ( ????????? ???????????? ????????? ??????, ????????? ???????????? ????????? ?????? )
  //var TCnt1 = Number("<%=LRsCnt1%>");
  ////alert(TCnt1);
  //
  //if (TCnt1 > 0) {
  //
  //  var iLResultName = "<%=iLResultName%>";
  //  var iLJumsu = "<%=iLJumsu%>";
  //  var iLRPlayerType2 = "<%=iLRPlayerType2%>";
  //
  //  var iLResultNamearr = iLResultName.split("^");
  //  var iLJumsuarr = iLJumsu.split("^");
  //  var iLRPlayerType2arr = iLRPlayerType2.split("^");
  //
  //  for (var i = 1; i < TCnt1 + 1; i++) {
  //
  //    if (iLResultNamearr[i] == "??????") {
  //      if (iLRPlayerType2arr[i] == "RPlayer") {
  //        $('#RJumsuGb1').text(iLJumsuarr[i]);
  //      }
  //      else {
  //        $('#LJumsuGb1').text(iLJumsuarr[i]);
  //      }
  //    }
  //    else if (iLResultNamearr[i] == "??????") {
  //      if (iLRPlayerType2arr[i] == "RPlayer") {
  //        $('#RJumsuGb2').text(iLJumsuarr[i]);
  //      }
  //      else {
  //        $('#LJumsuGb2').text(iLJumsuarr[i]);
  //      }
  //    }
  //    else if (iLResultNamearr[i] == "??????") {
  //      if (iLRPlayerType2arr[i] == "RPlayer") {
  //        $('#RJumsuGb4').text(iLJumsuarr[i]);
  //      }
  //      else {
  //        $('#LJumsuGb4').text(iLJumsuarr[i]);
  //      }
  //    }
  //
  //  }
  //
  //}
  //
  //// ???????????? ?????? ??????
  //var TCnt2 = Number("<%=LRsCnt2%>");
  ////alert(TCnt1);
  //
  //if (TCnt2 > 0) {
  //
  //  var iRResultName = "<%=iRResultName%>";
  //  var iRJumsu = "<%=iRJumsu%>";
  //  var iLRPlayerType3 = "<%=iLRPlayerType3%>";
  //
  //  var iRResultNamearr = iRResultName.split("^");
  //  var iRJumsuarr = iRJumsu.split("^");
  //  var iLRPlayerType3arr = iLRPlayerType3.split("^");
  //
  //  for (var i = 1; i < TCnt2 + 1; i++) {
  //
  //    if (iRResultNamearr[i] == "??????") {
  //      if (iLRPlayerType3arr[i] == "RPlayer") {
  //        $('#RJumsuGb1').text(iRJumsuarr[i]);
  //      }
  //      else {
  //        $('#LJumsuGb1').text(iRJumsuarr[i]);
  //      }
  //    }
  //    else if (iRResultNamearr[i] == "??????") {
  //      if (iLRPlayerType3arr[i] == "RPlayer") {
  //        $('#RJumsuGb2').text(iRJumsuarr[i]);
  //      }
  //      else {
  //        $('#LJumsuGb2').text(iRJumsuarr[i]);
  //      }
  //    }
  //    else if (iRResultNamearr[i] == "??????") {
  //      if (iLRPlayerType3arr[i] == "RPlayer") {
  //        $('#RJumsuGb4').text(iRJumsuarr[i]);
  //      }
  //      else {
  //        $('#LJumsuGb4').text(iRJumsuarr[i]);
  //      }
  //    }
  //
  //  }
  //
  //}
  //
  //
  //// ?????? ??? ??????
  //var iPlayerResultName = "<%=iPlayerResultName%>";
  //
  //if (iPlayerResultName != "") {
  //
  //  var iPlayerResultName = "<%=iPlayerResultName%>";
  //  var iLRPlayerType = "<%=iLRPlayerType%>";
  //
  //  // ??? ?????????
  //  if (iLRPlayerType == "LPlayer") {
  //    $('#iLWImg').removeClass('disp-none');
  //    $('#iLWImg').addClass('disp-win');
  //  }
  //  else {
  //    $('#iRWImg').removeClass('disp-none');
  //    $('#iRWImg').addClass('disp-win');
  //  }
  //
  //  //iLRPlayerType = "A";
  //
  //  //alert(iLRPlayerType);
  //
  //  if (iPlayerResultName == "???(??????)") {
  //    if (iLRPlayerType == "LPlayer") {
  //      //$("#DP_L_GameResult").append("<option value=''>?????????</option>");
  //      $("#DP_L_GameResult").html("?????????");
  //    }
  //    else {
  //      //$("#DP_R_GameResult").append("<option value=''>?????????</option>");
  //      $("#DP_R_GameResult").html("?????????");
  //    }
  //  }
  //  else if (iPlayerResultName == "???(??????)") {
  //    if (iLRPlayerType == "LPlayer") {
  //      //$("#DP_L_GameResult").append("<option value=''>?????????</option>");
  //      $("#DP_L_GameResult").html("?????????");
  //    }
  //    else {
  //      //$("#DP_R_GameResult").append("<option value=''>?????????</option>");
  //      $("#DP_R_GameResult").html("?????????");
  //    }
  //  }
  //  else if (iPlayerResultName == "???(??????)") {
  //    if (iLRPlayerType == "LPlayer") {
  //      //$("#DP_L_GameResult").append("<option value=''>?????????</option>");
  //      $("#DP_L_GameResult").html("?????????");
  //    }
  //    else {
  //      //$("#DP_R_GameResult").append("<option value=''>?????????</option>");
  //      $("#DP_R_GameResult").html("?????????");
  //    }
  //  }
  //  else if (iPlayerResultName == "???(??????)") {
  //    if (iLRPlayerType == "LPlayer") {
  //      //$("#DP_L_GameResult").append("<option value=''>?????????</option>");
  //      $("#DP_L_GameResult").html("?????????");
  //    }
  //    else {
  //      //$("#DP_R_GameResult").append("<option value=''>?????????</option>");
  //      $("#DP_R_GameResult").html("?????????");
  //    }
  //  }
  //  //else if (iPlayerResultName == "???(??????)") {
  //  //  if (iLRPlayerType == "LPlayer") {
  //  //    $("#DP_L_GameResult").append("<option value=''>??????</option>");
  //  //  }
  //  //  else {
  //  //    $("#DP_R_GameResult").append("<option value=''>??????</option>");
  //  //  }
  //  //}
  //  else {
  //    //$('#DP_GameResultli').remove();
  //    //$('#DP_L_GameResultli').remove();
  //    //$('#DP_R_GameResultli').remove();
  //  }
  //
  //
  //  var TCnt3 = Number("<%=LRsCnt3%>");
  //  //alert(TCnt3);
  //
  //  if (TCnt3 > 0) {
  //
  //    var iResultName = "<%=iResultName%>";
  //    var iSpecialtyDtlName = "<%=iSpecialtyDtlName%>";
  //    var iCheckTime = "<%=iCheckTime%>";
  //    var iUserName = "<%=iUserName%>";
  //    var iLRPlayerType1 = "<%=iLRPlayerType1%>";
  //    var iOverTime = "<%=iOverTime%>";
  //
  //    var iResultNamearr = iResultName.split("^");
  //    var iSpecialtyDtlNamearr = iSpecialtyDtlName.split("^");
  //    var iCheckTimearr = iCheckTime.split("^");
  //    var iUserNamearr = iUserName.split("^");
  //    var iLRPlayerType1arr = iLRPlayerType1.split("^");
  //    var iOverTimearr = iOverTime.split("^");
  //
  //    var ihtml = "";
  //
  //    for (var i = 1; i < TCnt3 + 1; i++) {
  //      if (iLRPlayerType1arr[i] == "LPlayer") {
  //        ihtml = "<li class='pratice-txt-white'>";
  //      }
  //      else {
  //        ihtml = "<li class='pratice-txt-blue'>";
  //      }
  //
  //      if (iOverTimearr[i] == "1") {
  //        ihtml = ihtml + "(???)";
  //      }
  //
  //      ihtml = ihtml + "[" + iCheckTimearr[i] + "]" + iUserNamearr[i] + ": " + iResultNamearr[i] + "" + iSpecialtyDtlNamearr[i] + "</li>";
  //      $('#praticetxt').append(ihtml);
  //    }
  //
  //    //for (var i = 1; i < TCnt1 + 1; i++) {
  //    //
  //    //  if (iLResultNamearr[i] == "??????") {
  //    //    $('#LJumsuGb1').text(iLJumsuarr[i]);
  //    //  }
  //    //  else if (iLResultNamearr[i] == "??????") {
  //    //    $('#LJumsuGb2').text(iLJumsuarr[i]);
  //    //  }
  //    //  else if (iLResultNamearr[i] == "??????") {
  //    //    $('#LJumsuGb4').text(iLJumsuarr[i]);
  //    //  }
  //    //
  //    //}
  //
  //  }
  //}
  //
  //function changeDet(act, url){
  //  if(act=="OPEN"){
  //    if(!$('#iframeMov').attr('src')) $('#iframeMov').attr('src', url);
  //  }
  //  else{
  //    $('#iframeMov').attr('src', '');
  //  }
  //}
</script>
