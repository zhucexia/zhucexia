// 2014-12-27

(function (){
    var configTrackerUrl = '/demlution.gif';

    function getRandomNum(num){
        return Math.round(Math.random()*num);
    }

    function setCookie(c_name,value){
        document.cookie=c_name+ "=" +escape(value);
    }

    function getCookie(c_name){
        if (document.cookie.length>0){
            var c_start = document.cookie.indexOf(c_name + "=");
            if (c_start != -1){
                c_start = c_start + c_name.length+1
                var c_end = document.cookie.indexOf(";", c_start)
                if (c_end == -1){
                    c_end = document.cookie.length
                }
            return unescape(document.cookie.substring(c_start, c_end))
            }
        }
        return "";
    }

    function checkCookie(c_name){
        var da_a = getCookie(c_name)
        if (da_a != null && da_a != ""){
            return da_a;
        }
        else {
            var da_a = getRandomNum(100000000);
            setCookie(c_name, da_a)
            return da_a;
        }
    }

    var obj = {
        id: getRandomNum(100000000),
        referer: document.referrer,
        da_a: checkCookie('da_a'),

        width: window.screen.width,
        height: window.screen.height,
        color: screen.colorDepth,
        lang:  navigator.browserLanguage ? navigator.browserLanguage : navigator.language,

        title: document.title,
    }

    // https://github.com/piwik/piwik/blob/master/js/piwik.js#L2421
    // http://google-analytics.com/ga.js
    function getImage(request, callback) {
        var image = new Image(1, 1);
        image.onload = function () {
            iterator = 0; // To avoid JSLint warning of empty block
            if (typeof callback === 'function') { callback(); }
        };
        image.src = configTrackerUrl + '?' + request.slice(1, request.length);
    }

    var request = '';
    for (k in obj) {
        request += '&' + k + '=' + obj[k];
    };

    getImage(request);

}).call(this);

