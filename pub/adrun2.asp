<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>2. Using iframe - Launch App with page loading</title>
</head>
<body>
    <p>AppLoader runs on Android or iOS device.</p>
    <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/v1.3.0/tui-code-snippet.min.js"></script>
    <script type="text/javascript" src="../dist/tui-app-loader.comb.js"></script>
    <script type="text/javascript" class="code-js">
        // Run code
        var iosScheme = 'payco://open';
        // var intentURI = 'intent://open#Intent;scheme=payco;S.browser_fallback_url=http%3A%2F%2Fwww.payco.com;package=com.nhnent.payapp;end;';
        var intentURI = 'intent://open#Intent;scheme=payco;package=com.nhnent.payapp;end;';
        var loader = new tui.AppLoader();
        loader.exec({
            ios: {
                scheme: iosScheme,
                url: "https://itunes.apple.com/kr/app/id924292102"
            },
            timerSet: {
                ios: 2000,
                android: 1000
            },
            android: {
                intentURI: intentURI,
                useIframe: true,
                onErrorIframe: function() {
                    console.log('On error iframe');
                    // top.location.href = 'http://www.payco.com';
                }
            },
            etcCallback: function() { // Not mobile
                if (loader.getOS() !== 'iOS' && loader.getOS() !== 'Android') {
                    alert('Run in mobile');
                }
            },
            notFoundCallback: function() {
                if (loader.getOS() === 'iOS') {
                    top.location.href = 'https://itunes.apple.com/kr/app/id924292102';
                }
                console.log('Not Found Application');
            }
        });
    </script>
</body>
</html>