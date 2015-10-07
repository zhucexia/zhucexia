$(function() {
    $('.J_dialog').click(function(event) {
        var data = $(this).attr('data');
        $('.theme-popover').filter('#'+data).slideDown(200);
    });
    $('.theme-poptit .close').click(function(){
        $(this).parents('.theme-popover').slideUp(200);
    });

    var flag = false;

    var rules = {
        'username' : function(value){
            return value.length >= 3 && value.length <= 12 && value !== '';
        },
        'pwd' : function(value){
            return value.length >=6 && value.length <= 20 && value !== '';
        },
        'conpwd' : function(value){
            return value === $('input[name="pwd"]').val() && value !== '';
        },
        'phone' : /^\d{11}/,
        'email' : /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/

    };
    var SUCMSG = '输入成功';
    var errormsg  = {
        'username' : '用户名应该为3-20位之间',
        'pwd' : '密码应该为6-20位之间',
        'conpwd' : '输入密码要一致',
        'phone' : '手机号为11位数字',
        'email' : '请输入正确的EMAIL格式'
    }
    $('.theme-signin input').focus(function() {
        var $this = $(this),
            name = $this.attr('name');
        $this.next().not('.msgs').text(errormsg[name]).removeClass('success-text').addClass('error-text');
    }).blur(function() {
        var $this = $(this),
            name = $this.attr('name'),
            value = $this.val(),
            rule = rules[name];
        if(!rule) {
            flag = true;
            return;
        }
        if($.isFunction(rule) && rule(value) || rule.constructor == RegExp && rule.test(value)){
            $this.next().text(SUCMSG).removeClass('error-text').addClass('success-text');
            flag = true;
        }else{
            $this.next().text(errormsg.name).removeClass('success-text').addClass('error-text');
        }
    });
    //获取短信验证码
    var validCode = true;
    $(".msgs").click(function() {
        var time = 30;
        var code = $(this);
        if (validCode) {
            validCode = false;
            code.addClass("msgs1");
            var t = setInterval(function() {
                time--;
                code.html(time + "秒");
                if (time == 0) {
                    clearInterval(t);
                    code.html("重新获取");
                    validCode = true;
                    code.removeClass("msgs1");

                }
            }, 1000)
        }
    })


    //提交按钮,所有验证通过方可提交
    $('input[name="reg"]').click(function() {
        if (flag) {
            $(this).submit();
        } else {
            return false;
        }
    });

})