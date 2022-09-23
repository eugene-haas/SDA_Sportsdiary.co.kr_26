<%
    '====================================================================================
    '비밀번호가 발급된 임시비밀번호인지 체크 후 임시비밀번호인 경우 비밀번호변경 페이지로 이동시킵니다.
    '/Libary/common_function.asp
    CHK_USERPASS_TYPE()

    '====================================================================================
    'Gnb Type
    'COOKIE_MEMBER_IDX = decode(request.Cookies(SportsGb)("MemberIDX"),0)
    '/Libary/common_function.asp
    '====================================================================================
    dim Cookie_MemberIDX  : Cookie_MemberIDX  = COOKIE_MEMBER_IDX()               '종목별 가입계정 MemberIDX

	dim txt_Name  '테니스 로그인한 계정타입명
	dim Img_IDType  '테니스 가입한 계정프로필 이미지 출력
   	Set LRs= db.ExecSQLReturnRS(INFO_QUERY_JOINACCOUNT("GNB") , null, T_ConStr)

	IF Not(LRs.Eof or LRs.bof) Then
		txt_Name = LRs("PlayerRelnNm")
	END IF
		LRs.Close
	SET LRs = Nothing

	IF request.cookies(SportsGb)("PhotoPath") <> "" Then
		Img_IDType = decode(request.cookies(SportsGb)("PhotoPath"), 0)
	Else
		Img_IDType = ImgDefault
	End IF


    iLIUserID = Request.Cookies("SD")("UserID")
    iLIMemberIDX = Request.Cookies("SD")("MemberIDX")
    iLISportsGb = SportsGb

    'LocateIDX_ham_1 = "66"
    'LocateIDX_ham_2 = "10"
    LocateIDX_ham_3 = "66"

%>

<script>
	/*
		회원제 서비스 전환업데잍트 20180726
		1. 메인 SD뉴스, 더보기버튼 	/main/index.asp
		2. 대회일정/결과(본선)		/tournament/Totaltourney.asp
		3. Gnb영역 SD뉴스			/include/Player_Gnb.asp
		4. 메인 SD뉴스				/ajax/index_news_default.asp
	*/
	//현재계정 로그인 및 회원가입 상태 조회
	function CHK_JOINMEMBER(){
		var SDLoginID = '<%=request.Cookies("SD")("UserID")%>';
		var LoginIDX = '<%=Cookie_MemberIDX%>';
		var CHK_VALUE = 0;

		//통합회원 로그인 및 가입여부 체크
		if(!SDLoginID){
			CHK_VALUE = 1001;
		}
		else{
			//종목 계정가입 로그인 및 가입여부 체크
			//if(!LoginIDX) CHK_VALUE = 1002; // 백승훈 막음
		}

		return CHK_VALUE;
	}
</script>
<div class="gnb" id="gnb">
  <!-- <div class="gnb-box"> -->
    <!-- S: gnb-header -->
    <div class="gnb-header clearfix">
      <!-- S: profile 사진 -->
      <%
  IF request.Cookies("SD")("UserID") <> "" Then
    'IF Cookie_MemberIDX <> "" Then
  %>

    <!-- 베타용 프로필, 오픈 시 아래 내용 출력하기 -->
    <div class="profile">
      <img id="imgGnb" src="<%=Img_IDType%>" alt="프로필 사진"> </div>
    <!-- E: profile 사진 -->

	<!-- S: 환영, 로그아웃 -->
    <div class="welcome">
      <h2><span><%=Request.Cookies("SD")("UserName")%></span> 님</h2>
      <span class="user_type"><%=txt_Name%></span>
    </div>
    <!-- E: 환영, 로그아웃 -->
    <!-- S: gnb icon -->
    <div class="gnb-icon clearfix" >
      <a href="../mypage/mypage.asp" class="ic_mypage"> <img src="http://img.sportsdiary.co.kr/sdapp/main/ic_people@3x.png" alt="마이페이지"> </a></div>
  <%

  Else
  %>
    <!-- S: no-member -->
    <div class="no-member">
      <h2>처음이신가요?<br><span class="bluy">회원가입을 해주세요.</span></h2>
      <ul class="flex">
        <li>
          <a href="http://sdmain.sportsdiary.co.kr/sdmain/login.asp">
            <span class="ic-deco">
              <i class="fa fa-sign-in"></i>
            </span>
            <span class="txt">로그인</span>
          </a>
        </li>
        <li>
          <a href="http://sdmain.sportsdiary.co.kr/sdmain/combine_check.asp">
            <span class="ic-deco circle-deco">
              <i class="fa fa-user"></i>
            </span>
            <span class="txt">회원가입</span>
          </a>
        </li>
        <!--<li> <a href="#" class="btn_not_yet"> <span class="txt">로그인</span> <span class="r_arr"> <img src="../images/include/gnb/r_arr@3x.png" alt> </span> </a> </li>-->
      </ul>
    </div>
    <!-- E: no-member -->
  <%End IF%>
    </div>
    <!-- E: gnb-header -->

    <!-- S: gnb-list -->
    <div class="gnb-list">
      <h2>대회정보</h2>
      <ul class="clearfix">
        <li>
          <a href="/tennis/m_player/Result/institute-search.asp">
            <span class="txt">대회일정/결과</span>
            <span class="r_arr">
              <img src="http://img.sportsdiary.co.kr/sdapp/gnb/r_arr@3x.png" alt>
            </span>
          </a>
        </li>
        <li>
          <a href="#" class="btn_not_yet">
            <span class="txt">대회영상모음</span>
            <span class="r_arr">
              <img src="http://img.sportsdiary.co.kr/sdapp/gnb/r_arr@3x.png" alt>
            </span>
          </a>
        </li>
        <li>
          <a href="../Record/record-srch-win.asp" class="btn_not_yet">
            <span class="txt">경기기록실</span>
            <span class="r_arr">
              <img src="http://img.sportsdiary.co.kr/sdapp/gnb/r_arr@3x.png" alt>
            </span>
          </a>
        </li>
        <li>
          <a href="../Analysis/analysis-match-result.asp" class="btn_not_yet">
            <span class="txt">선수분석</span>
            <span class="r_arr">
              <img src="http://img.sportsdiary.co.kr/sdapp/gnb/r_arr@3x.png" alt>
            </span>
          </a>
        </li>
      </ul>
    </div>
    <!-- E: gnb-list -->

    <!-- S: gnb-list -->
    <div class="gnb-list">
      <h2>자료실</h2>
      <ul class="clearfix">
        <li>
			<a href="../Media/list.asp">
            <span class="txt">뉴스</span>
            <span class="r_arr">
              <img src="http://img.sportsdiary.co.kr/sdapp/gnb/r_arr@3x.png" alt>
            </span>
          </a>
        </li>
        <li>
          <a href="#" class="btn_not_yet">
            <span class="txt">동영상</span>
            <span class="r_arr">
              <img src="http://img.sportsdiary.co.kr/sdapp/gnb/r_arr@3x.png" alt>
            </span>
          </a>
        </li>
        <li>
          <a href="#" class="btn_not_yet">
            <span class="txt">칼럼리스트</span>
            <span class="r_arr">
              <img src="http://img.sportsdiary.co.kr/sdapp/gnb/r_arr@3x.png" alt>
            </span>
          </a>
        </li>
        <li>
          <a href="#" class="btn_not_yet">
            <span class="txt">애널리스트</span>
            <span class="r_arr">
              <img src="http://img.sportsdiary.co.kr/sdapp/gnb/r_arr@3x.png" alt>
            </span>
          </a>
        </li>
      </ul>
    </div>
    <!-- E: gnb-list -->

    <!-- S: gnb-icon-list -->
    <div class="gnb-icon-list list-3">
      <h2>게시판</h2>
      <ul class="flex">
        <li>
          <a href="../Board/notice-list.asp">
            <span class="img_box">
              <img src="http://img.sportsdiary.co.kr/sdapp/gnb/notice_board@3x.png" alt>
            </span>
            <span class="txt">공지사항</span>
          </a>
        </li>
        <li>
          <a href="../Board/qa_board.asp">
            <span class="img_box">
              <img src="http://img.sportsdiary.co.kr/sdapp/gnb/qa_board@3x.png" alt>
            </span>
            <span class="txt">질문과답변</span>
          </a>
        </li>
        <li>
          <a href="../Board/faq.asp">
            <span class="img_box">
              <img src="http://img.sportsdiary.co.kr/sdapp/gnb/faq_board@3x.png" alt>
            </span>
            <span class="txt">자주하는 질문</span>
          </a>
        </li>
      </ul>
    </div>
    <!-- E: gnb-icon-list -->


    <div class="banner_wrap">
      <!-- S: main banner 03 -->
      <%
        imType = "1"
        imSportsGb = "tennis"
        imLocateIDX = LocateIDX_ham_3

        LSQL = "EXEC AD_View_S '" & imType & "','" & imSportsGb & "','" & imLocateIDX & "','','','','',''"
	   	Set LRs= db.ExecSQLReturnRS(LSQL , null, BN_ConStr)
        If Not (LRs.Eof Or LRs.Bof) Then
      %>
	    <div class="major_banner">
	      <div class="banner banner_<%=LRs("LocateGb")%> carousel">
	    	  <div <% if LRs("TypeOutput") = "S" then %>class="bxslider"<% end if %>>
	    		  <%
	    			  Do Until LRs.Eof

                iLink = LRs("Link")

                if Len(iLink) = 0 then

                  iLink = ""

                else

                  if instr(iLink,"?") > 0 then

                    iLink = iLink&"&"&tpara

                  else

                    iLink = iLink&"?"&tpara

                  end if

                end if
	    			    iLinkType = LRs("LinkType")
                iProductLocateIDX = LRs("ProductLocateIDX")
                ieProductLocateIDX = encode(iProductLocateIDX, 0)
	  		    %>
	  		      <% if (IPHONEYN() = "0" and iLinkType = "2") then %>
                <% if iLink = "" then %>
	  		        <div style="background-color: #<%=LRs("BColor")%>"> <img src="<%=global_filepathUrl_ADIMG %><%=LRs("ImgFileNm") %>" alt="" /> </div>
	  		        <% else %>
                <div style="background-color: #<%=LRs("BColor")%>"> <a href="<%=iLink %>" class="banner_area" target="_blank" onclick="javascript:fn_ADLOG('<%=iLISportsGb %>','<%=ieProductLocateIDX %>','<%=iLIUserID %>','<%=iLIMemberIDX %>');"> <img src="<%=global_filepathUrl_ADIMG %><%=LRs("ImgFileNm") %>" alt="" /> </a> </div>
                <% end if %>
              <% else %>
                <% if iLink = "" then %>
                <div style="background-color: #<%=LRs("BColor")%>"> <img src="<%=global_filepathUrl_ADIMG %><%=LRs("ImgFileNm") %>" alt="" /> </div>
                <% else %>
                <div style="background-color: #<%=LRs("BColor")%>"> <a href="javascript:;" onclick="javascript:fn_ADLOG('<%=iLISportsGb %>','<%=ieProductLocateIDX %>','<%=iLIUserID %>','<%=iLIMemberIDX %>');javascript:fn_mclicklink('<%=iLinkType %>','<%=iLink %>');" class="banner_area"> <img src="<%=global_filepathUrl_ADIMG %><%=LRs("ImgFileNm") %>" alt="" /> </a> </div>
                <% end if %>
              <% end if %>
	  		    <%
	    					LRs.MoveNext
	    				Loop
	    			%>
	    		</div>
	    	</div>
	    </div>
	    <%
	      End If
	      LRs.close
	    %>
      <!-- E: main banner 03 -->
    </div>


    <!-- S: gnb-footer -->
    <div class="gnb-footer">
      <ul class="clearfix">
        <li class="r-bar"><a href="http://sdmain.sportsdiary.co.kr/sdmain/company.asp">회사소개</a></li>
        <li class="r-bar"><a href="http://sdmain.sportsdiary.co.kr/sdmain/access.asp">이용약관</a></li>
        <li class="r-bar"><a href="http://sdmain.sportsdiary.co.kr/sdmain/personal.asp">개인정보처리방침</a></li>
      </ul>
      <p class="bot_info">
        Copyright &copy;WIDLINE Corp.<br>
        All Right Reserved.<br>
        Sports Diary <span class="bluy">오픈베타서비스</span>
      </p>
    </div>

    <!-- E: gnb-footer -->

    <!-- S: gnb_ctr -->
    <div class="gnb_ctr">
      <ul class="clearfix">
        <li class="idx_link">
          <a href="http://sdmain.sportsdiary.co.kr/sdmain/index.asp">
            <img src="http://img.sportsdiary.co.kr/sdapp/gnb/ic_event.png" alt="종목">
          </a>
        </li>
        <li>
          <a href="javascript:alert('sportsdiary://goPushMsg');">
            <img src="http://img.sportsdiary.co.kr/sdapp/gnb/ic_push@3x.png" alt="앱 알림함">
          </a>
        </li>
        <li>
          <a href="../main/index.asp">
            <img src="http://img.sportsdiary.co.kr/sdapp/gnb/ic_home@3x.png" alt="홈으로 이동">
          </a>
        </li>
        <li>
          <a href="#" class="close-btn">
            <img src="http://img.sportsdiary.co.kr/sdapp/gnb/ic_x@3x.png" alt="닫기">
          </a>
        </li>
      </ul>
    </div>
    <!-- E: gnb_ctr -->
  </div>
  <!-- E: gnb-box -->

  <!-- S: tops top-btn -->
  <div class="tops btn-div">
    <a href="#" class="top_btn">TOP</a>
  </div>
  <!-- E: tops top-btn -->

  <!-- S: 계정 전환 모달 -->
  <!-- #include file="./change_modal_new.asp" -->
  <!-- E: 계정 전환 모달 -->