<!--#include file = "./include/config_top.asp" -->
<title>KATA Tennis 대회 참가신청</title>
<!--#include file = "./include/config_bot.asp" -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="css/req_comp.css">
<!--#include file = "./Library/ajax_config.asp"-->
<%
  '===============================================================================================
  'KATA 대회참가신청 동의 페이지
  '===============================================================================================
  dim UserInfo  : UserInfo  = fInject(request("UserInfo"))

  'IF UserInfo = "" Then
  '  response.Write "<script>"
  '  response.Write "  alert('잘못된 접근입니다. 확인 후 이용하세요.');"
  '  response.Write "  window.close();"
  '  response.Write "</script>"
  '  response.End()
  'End IF

%>
<script>
  function Info_Request_Agr(){
    var strAjaxUrl = "./ajax/req_comp.asp";
    var UserInfo = $("#UserInfo").val();


    if(!UserInfo){
      alert("잘못된 접근입니다. 확인 후 이용하세요.");
      window.close();
    }
    else{
      $.ajax({
        url: strAjaxUrl,
        type: 'POST',
        dataType: 'html',
        data: {
          UserInfo : UserInfo
        },
        success: function(retDATA) {

          console.log(retDATA);

          if(retDATA){

            var strcut = retDATA.split("|");

            if(strcut[0]=="TRUE") {
              alert ("참가신청 접수가 완료되었습니다.");
              window.close();
            }
            else{
              switch (strcut[1]) {
                case '200'  : alert ("잘못된 접근입니다. 확인 후 이용하세요."); break;
                case '99' : alert ("일치하는 정보가 없습니다."); break;
                case '66' : alert ("이미 신청동의를 완료하였습니다."); break;
                default : alert ("잘못된 접근입니다. 확인 후 이용하세요."); break;
              }
              window.close();
            }
          }
          else{
            alert ("본인 확인이 이루지지 않았습니다. 관리자에게 문의하십시오.");
            window.close();
          }
        },
        error: function(xhr, status, error){
          if(error!=""){
            alert ("조회중 에러발생 - 시스템관리자에게 문의하십시오!");
            window.close();
          }
        }
      });
    }
  }
</script>
</head>
<body class="light_bg">
<form name="s_frm" method="post">
  <input type="hidden" name="UserInfo" id="UserInfo" value="<%=UserInfo%>" />
</form>
<!-- S: header -->
<div class="header req_comp_header">
  <h1><img src="imgs/public/logo_kata@3x.png" alt="KATA 테니스"></h1>
</div>
<!-- E: header -->
<!-- S: main -->
<div class="main req_comp">
  <h3>KATA(사)한국테니스진흥협회</h3>
  <h2>대회 참가신청 본인확인</h2>
  <h4>본인이 맞으면 대회참가를 신청합니다.</h4>
  <p class="guide_txt agree">아래의 모든 내용을 확인하고 동의하시면 아래의 확인 버튼을 눌러주시기 바랍니다.</p>
  <!-- S: btn_list -->
  <div class="btn_list"> <a href="javascript:Info_Request_Agr();" class="btn btn_green" style="background:#009328;font-size:13px;font-weight:600;color:#fff;width:80px;height:40px;line-height:40px;text-align:center;">확인</a> </div>
  <!-- E: btn_list -->
  <!-- S: cont_txt -->
  <div class="cont_txt">
    <p> KATA(사)한국테니스진흥협회에서는, 앞으로 대회운영 및 회원 서비스의 품질향상을 위해서 대회에 참가신청 한 선수의 본인확인을 확인 받고 있습니다. <br>
      SPORTS DIARY(스포츠 다이어리)는 KATA(사)한국테니스진흥협회와 전략적 기술업무 협약단체로써 대회 참가신청 및 마케팅 정보 제공의 목적으로 회원정보를 함께 활용하게 됩니다. <br>
      신청내역은 접수 완료 후 KATA(사)한국테니스진흥협회 홈페이지에서 확인 가능합니다. <br>
      앞으로 SPORTS DIARY(스포츠 다이어리) 어플리케이션을 모바일에서 무료로 다운로드 받으신 후, 아래의 다양한 서비스를 이용해보시기 바랍니다. <br>
      <br>
      - 대진표 실시간 조회 <br>
      - LIVE SCORE 제공 <br>
      - 경기분석 / 선수분석 서비스 <br>
      - 파트너(Pair) 찾기 / 난타모집 <br>
      - 경기영상 제공 (추후 일정공지) <br>
       </p>
  </div>
  <!-- E: cont_txt -->

  <div class="terms">
    <h3>개인정보 취급 방침 안내</h3>
    <div class="scroll-box">
      <pre>
        ㈜위드라인(이하 “회사”라고 합니다)은 이용자들의 개인정보보호를 매우 중요시하며, 이용자는 회사가 운영하고 있는 인터넷관련 서비스(스포츠다이어리)의 서비스를 이용함과 동시에 온라인상에서 회사에 제공한 개인정보가 보호 받을 수 있도록 최선을 다하고 있습니다.
        이에 회사는 통신비밀보호법, 전기통신사업법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 정보통신서비스제공자가 준수하여야 할 관련 법규상의 개인정보보호 규정 및 정보통신부가 제정한 개인정보보호지침을 준수하고 있습니다.
        회사는 개인정보 취급방침을 통하여 이용자들이 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려 드립니다.
        회사는 개인정보 취급방침을 홈페이지 첫 화면에 공개함으로써 이용자들이 언제나 용이하게 보실 수 있도록 조치하고 있습니다.
        회사의 개인정보 취급방침은 정부의 법률 및 지침 변경이나 회사의 내부 방침 변경 등으로 인하여 수시로 변경될 수 있고, 이에 따른 개인정보 취급방침의 지속적인 개선을 위하여 필요한 절차를 정하고 있습니다. 그리고 개인정보 취급방침을 개정하는 경우나 개인정보 취급방침 변경될 경우 홈페이지 및 앱의 게시판 공지를 통해 고지하고 있습니다.
        회사의 개인정보 취급방침은 다음과 같은 내용을 담고 있습니다.(개인정보취급방침 버전번호 : SD-16.01)
        1. 개인정보 수집에 대한 동의
        2. 개인정보의 수집목적 및 이용목적
        3. 수집하는 개인정보 항목 및 수집방법
        4. 수집하는 개인정보의 보유 및 이용기간
        5. 수집한 개인정보의 공유 및 제공
        6. 이용자 자신의 개인정보 관리(열람,정정,삭제 등)에 관한 사항
        7. 쿠키(cookie)의 운영에 관한 사항
        8. 비회원 고객의 개인정보 관리
        9. 개인정보관련 의견수렴 및 불만처리에 관한 사항
        10. 개인정보 관리책임자 및 담당자의 소속-성명 및 연락처
        11. 고지의 의무

        1. 개인정보 수집에 대한 동의
        스포츠다이어리 이용자들이 회사의 개인정보 취급방침 또는 이용약관의 내용에 대하여 「동의」버튼 또는「취소」버튼을 클릭할 수 있는 절차를 마련하여, 「동의」버튼을 클릭하면 개인정보 수집에 대해 동의한 것으로 봅니다.

        2. 개인정보의 수집목적 및 이용목적
        "개인정보"라 함은 생존하는 개인에 관한 정보로서 당해 정보에 포함되어 있는 성명, 주민등록번호 등의 사항에 의하여 당해 개인을 식별할 수 있는 정보(당해 정보만으로는 특정 개인을 식별할 수 없더라도 다른 정보와 용이하게 결합하여 식별할 수 있는 것을 포함)를 말합니다.
        대부분의 서비스는 별도의 사용자 등록이 없이 언제든지 사용할 수 있습니다. 그러나 회사는 회원서비스를 통하여 이용자들에게 맞춤식 서비스를 비롯한 보다 더 향상된 양질의 서비스를 제공하기 위하여 공식MOU를 체결한 각 스포츠종목 단체별 사전에 합의된 해당 단체 회원 및 이용자 개인의 정보를 수집하고 있습니다. 회사는 이용자의 사전 동의 없이는 이용자의 개인 정보를 공개하지 않으며, 종목간의 회원정보 보완에 있어서도 공개되지 않습니다. 수집된 정보는 공식 MOU를 체결한 각 스포츠종목 단체와 함께 공유 및 서비스활용에 상호 적극 활용되고 있습니다. 자세한 내용은 아래와 같이 이용하고 있습니다.
        첫째, 이용자들이 제공한 개인정보를 바탕으로 보다 더 유용한 서비스를 개발할 수 있습니다.
        회사는 신규 서비스개발이나 컨텐츠의 확충 시에 기존 이용자들이 회사에 제공한 개인정보를 바탕으로 개발해야 할 서비스의 우선 순위를 보다 더 효율적으로 정하고, 이용자들이 필요로 할 컨텐츠를 합리적으로 선택하여 제공할 수 있습니다.
        둘째, 수집하는 개인정보 항목과 수집 및 이용목적은 다음과 같습니다.
        1. 성명, 생년월일, 아이디, 비밀번호, 소속명 : 회원제 서비스 이용에 따른 본인 확인 절차에 이용
        2. 이메일주소, 전화번호(휴대폰번호) : 고지사항 전달, 불만처리 등을 위한 원활한 의사소통 경로의 확보, 대회정보, 선수정보, 신규 서비스(제품) 개발 및 맞춤 서비스 제공, 이벤트 및 광고성 정보 제공, 인구통계학적 특성에 따른 서비스 제공 및 광고 게재, 서비스의 유효성 확인, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계, 이벤트 참여 기회 제공 (그 외, 마케팅 정보수집 및 활용)
        3. 운동정보 : 개인맞춤 통계자료제공을 위한 회원의 기초정보, 훈련데이터, 공식경기영상으로 이용
        4. IP Address, 쿠키, 방문일시, 서비스 이용 기록 : 서비스 이용과정이나 불량회원의 부정 이용 방지와 비인가 사용 방지
        5. 유료 회원제 컨텐츠 서비스 및 SDA몰 이용 시 이용 정보
        - 신용카드 결제시 : 카드사명, 암호회된 카드번호 등
        - 무통장 입금시 : 은행명, 암호화된 계좌번호 등
        6. App 이용시 카메라 권한
        - 스포츠다이어리는 프로필사진을 교체를 위해 카메라를 사용합니다.
        7. App 이용시 사진/영상/파일
        - 스포츠다이어리는 프로필사진 교체를 위해 사진/영상/파일을 사용합니다.

        3. 수집하는 개인정보 항목 및 수집방법
        회사는 이용자들이 회원서비스를 이용하기 위해 회원으로 가입하실 때 서비스 제공을 위한 필수적인 정보들을 온라인상에서 입력 받고 있습니다. 회원 가입 시에 받는 필수적인 정보는 이름, 연락처, 이메일, 소속 등입니다. 또한 양질의 서비스 제공을 위하여 이용자들이 선택적으로 입력할 수 있는 사항으로서 상대선수의 정보 등을 입력 받고 있습니다.
        또한 게시판(홈페이지 또는 모바일) 혹은 개별공지(이메일 또는 SMS문자발송)를 통해 설문조사나 이벤트 행사 시 통계분석이나 경품제공 등을 위해 선별적으로 개인정보 입력을 요청할 수 있습니다.
        그러나, 이용자의 기본적 인권 침해의 우려가 있는 민감한 개인정보(인종 및 민족, 사상 및 신조, 출신지 및 본적지, 정치적 성향 및 범죄기록, 건강상태 및 성생활 등)는 수집하지 않으며 부득이하게 수집해야 할 경우 이용자들의 사전동의를 반드시 구할 것입니다. 그리고, 어떤 경우에라도 입력하신 정보를 이용자들에게 사전에 밝힌 목적 이외에 다른 목적으로는 사용하지 않으며 외부로 유출하지 않습니다.

        4. 수집하는 개인정보의 보유 및 이용기간
        이용자가 스포츠다이어리 회원으로서 회사에 제공하는 서비스를 이용하는 동안 회사는 이용자들의 개인정보를 계속적으로 보유하며 서비스 제공 등을 위해 이용합니다. 다만, 아래의 "6. 이용자 자신의 개인정보관리(열람, 정정, 삭제 등)에 관한 사항" 에서 설명한 절차와 방법에 따라 회원 본인이 직접 삭제하거나 수정한 정보, 가입 해지를 요청한 경우에는 재생할 수 없는 방법에 의하여 디스크에서 완전히 삭제하며 추후 열람이나 이용이 불가능한 상태로 처리됩니다.
        그리고 "3. 수집하는 개인정보 항목 및 수집방법"에서와 같이 일시적인 목적 (설문조사, 이벤트, 본인확인 등)으로 입력 받은 개인정보는 그 목적이 달성된 이후에는 동일한 방법으로 사후 재생이 불가능한 상태로 처리됩니다.
        귀하의 개인정보는 다음과 같이 개인정보의 수집목적 또는 제공받은 목적이 달성되면 파기하는 것을 원칙으로 합니다. 다만, 회사는 불량 회원의 부정한 이용의 재발을 방지하기 위해, 이용계약 해지일로부터 1년간 해당 회원의 주민등록번호를 보유할 수 있습니다.
        그리고 상법, 전자상거래 등에서의 소비자보호에 관한 법률 등 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다. 이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다.

        o 계약 또는 청약철회 등에 관한 기록
        - 보존근거 : 전자상거래 등에서의 소비자보호에 관한 법률 제6조 및 시행령 제6조
        - 보존기간 : 5년

        o 대금결제 및 재화 등의 공급에 관한 기록
        - 보존근거 : 전자상거래 등에서의 소비자보호에 관한 법률 제6조 및 시행령 제6조
        - 보존기간 : 5년

        o 소비자의 불만 또는 분쟁처리에 관한 기록
        - 보존근거 : 전자상거래 등에서의 소비자보호에 관한 법률 제6조 및 시행령 제6조
        - 보존기간 : 3년

        o 신용정보의 수집, 처리 및 이용 등에 관한 기록
        - 보존근거 : 신용정보의 이용 및 보호에 관한 법률
        - 보존기간 : 3년

        o 접속에 관한 기록보존
        - 보존근거 : 통신비밀보호법 제15조의2 및 시행령 제41조
        - 보존기간 : 3개월

        회사는 귀중한 회원의 개인정보를 안전하게 처리하며, 유출의 방지를 위하여 다음과 같은 방법을 통하여 개인정보를 파기합니다.
        o 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.
        o 전자적 파일 형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.

        5. 수집한 개인정보의 공유 및 제공
        회사는 이용자들의 개인정보를 "2. 개인정보의 수집목적 및 이용목적"에서 고지한 범위 내에서 사용하며, 이용자의 사전 동의 없이는 동 범위를 초과하여 이용하거나 원칙적으로 이용자의 개인정보를 외부에 공개하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.
        o 이용자들이 사전에 공개에 동의한 경우
        o 서비스 제공에 따른 요금정산을 위하여 필요한 경우
        o 홈페이지 및 모바일에 게시한 서비스 이용 약관 및 기타 회원 서비스 등의 이용약관 또는 운영원칙을 위반한 경우
        o 자사 서비스를 이용하여 타인에게 정신적, 물질적 피해를 줌으로써 그에 대한 법적인 조치를 취하기 위하여 개인정보를 공개해야 한다고 판단되는 충분한 근거가 있는 경우
        o 기타 법에 의해 요구된다고 선의로 판단되는 경우 (ex. 관련법에 의거 적법한 절차에 의한 정부/수사기관의 요청이 있는 경우 등)
        o 통계작성, 학술연구나 시장조사를 위하여 특정개인을 식별할 수 없는 형태로 광고주, 협력업체나 연구단체 등에 제공하는 경우
        o 이용자의 서비스 이용에 따른 불만사항 및 문의사항(민원사항)의 처리를 위하여 고객센터를 위탁하는 경우
        o 고객센터를 운영하는 전문업체에 해당 민원사항의 처리에 필요한 개인 정보를 제공하는 경우

        6. 이용자 자신의 개인정보 관리(열람, 정정, 삭제 등)에 관한 사항
        o 회원님이 원하 실 경우 언제라도 당사에서 개인정보를 열람하실 수 있으며 보관된 필수 정보를 수정하실 수 있습니다.
        o 또한 회원 가입 시 요구된 필수 정보 외의 추가 정보는 언제나 열람, 수정, 삭제할 수 있습니다.
        o 회원님의 개인정보 변경 및 삭제와 회원탈퇴는 당사의 고객센터에서 로그인(Login) 후 이용하실 수 있습니다.

        7. 쿠키(cookie)의 운영에 관한 사항
        당사는 회원인증을 위하여 Cookie 방식을 이용하고 있습니다. 이는 로그아웃(Logout)시 자동으로 컴퓨터에 저장되지 않고 삭제되도록 되어 있으므로 공공장소나 타인이 사용할 수 있는 컴퓨터를 사용 하 실 경우에는 로그인(Login)후 서비스 이용이 끝나시면 반드시 로그아웃(Logout)해 주시기 바랍니다.
        o 쿠키 설정 거부 방법
        쿠키 설정을 거부하는 방법으로는 회원님이 사용하시는 웹 브라우저의 옵션을 선택함으로써 모든 쿠키를 허용하거나 쿠키를 저장할 때마다 확인을 거치거나, 모든 쿠키의 저장을 거부할 수 있습니다.
        설정방법 예(인터넷 익스플로어의 경우) : 웹 브라우저 상단의 도구 > 인터넷 옵션 > 개인정보
        단, 귀하께서 쿠키 설치를 거부하였을 경우 서비스 제공에 어려움이 있을 수 있습니다.

        8. 개인정보관련 의견수렴 및 불만처리에 관한 사항
        당사는 개인정보보호와 관련하여 이용자 여러분들의 의견을 수렴하고 있으며 불만을 처리하기 위하여 모든 절차와 방법을 마련하고 있습니다. 이용자들은 하단에 명시한 "11. 개인정보관리책임자 및 담당자의 소속-성명 및 연락처"항을 참고하여 전화나 메일을 통하여 불만사항을 신고 할 수 있고, 회사는 이용자들의 신고사항에 대하여 신속하고도 충분한 답변을 해드릴 것입니다.

        9. 개인정보 관리책임자 및 담당자의 소속-성명 및 연락처
        당사는 귀하가 좋은 정보를 안전하게 이용할 수 있도록 최선을 다하고 있습니다. 개인정보를 보호하는데 있어 귀하께 고지한 사항들에 반하는 사고가 발생할 경우 개인정보관리책임자가 책임을 집니다.
        o 이용자 개인정보와 관련한 아이디(ID)의 비밀번호에 대한 보안유지책임은 해당 이용자 자신에게 있습니다.

        o 회사는 비밀번호에 대해 어떠한 방법으로도 이용자에게 직접적으로 질문하는 경우는 없으므로 타인에게 비밀번호가 유출되지 않도록 각별히 주의하시기 바랍니다.

        o 특히 공공장소에서 온라인상에서 접속해 있을 경우에는 더욱 유의하셔야 합니다.

        o 회사는 개인정보에 대한 의견수렴 및 불만처리를 담당하는 개인정보 관리책임자 및 담당자를 지정하고 있고, 연락처는 아래와 같습니다.

        개인정보관리 책임자
        이름 : 백승훈
        소속/직위 : 연구전담부 / 연구소장
        E-MAIL : sh.baek@widline.co.kr
        전화번호 : 02-715-0282

        10. 고지의 의무
        본 개인정보 취급방침은 정부의 정책 또는 보안기술의 변경에 따라 개인정보취급방침 내용 추가,삭제 및 수정이 있을 시에는 개정 최소 7일전부터 개정 최소 7일전부터 홈페이지 또는 모바일을 통해 고지하도록 하겠습니다.
        - 개인정보취급방침 버전번호 : SD-16.12
        - 개인정보취급방침 시행일자 : 2016년 12월 01일