// JavaScript Document
$(document).ready(function () {
        Searchpress();//搜索框
        addFocus();
        clearFocus();
});

$(function(){
        $("#divMenu").click(function(){
                $(this).hide();
                $("#divOnline").hide();
                $("#divMenu-open").show();
                });
        $("#divMenu-open").click(function(){
                $(this).hide();
                $("#divOnline").show();
                $("#divMenu").show();
                });
})
//====================================================================================================
// [插件名称] 加入收藏于设为首页 兼容FF+IE
//----------------------------------------------------------------------------------------------------
// [使用方法]     <a href="javascript:void(0);" target="_self" onClick="javascript:AddFavorite()" >加入收藏</a>
//               <a href="javascript:void(0);" target="_self" onclick="SetHome(this)">设为首页</a>
//----------------------------------------------------------------------------------------------------
// [更新日期] 2012-7-24
//====================================================================================================

function AddFavorite()
{
var sURL = window.location.href;
var sTitle = document.title;
    try
    {
        window.external.addFavorite(sURL, sTitle);
    }
    catch (e)
    {
        try
        {
            window.sidebar.addPanel(sTitle, sURL, "");
        }
        catch (e)
        {
            alert("请使用Ctrl+D进行添加");
        }
    }
}
function SetHome(obj){
        var ulink =window.location.hostname;
        vrl= "http://" + ulink;
        try{
                obj.style.behavior='url(#default#homepage)';obj.setHomePage(vrl);
        }
        catch(e){
                if(window.netscape) {
                        try {
                                netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
                        }
                        catch (e)  {
                                alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入'about:config'并回车\n然后将[signed.applets.codebase_principal_support]设置为'true'");
                        }
                        var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
                        prefs.setCharPref('browser.startup.homepage',vrl);
                 }
        }
}

// 导航选卡
$(function(){
    ch = $('#menu').children();
    $.each(ch, function(index, value){
        if (value.hasChildNodes() && (window.location.href ==value.children[0].href || window.location.pathname == value.children[0].href)) {
            $(value).addClass("hover");
        }
    });
})

function addFocus(){
$(".s-box").click(function(event){
        $(".s-txt").focus();
    event=event||window.event;
    event.stopPropagation();
});
}

//点击层外，隐藏这个层。由于层内的事件停止了冒泡，所以不会触发这个事件
function clearFocus(){
        $(document).click(function(e){
                $(".s-box").blur();
        });
        $(".s-txt").focus(function(){
                $(".sec_cue").addClass("ont");
        })
        $(".s-box").blur(function(){
                $(".sec_cue").removeClass("ont");
                var stxt = $(".s-txt").val();
                if("" == stxt){
                        $(".sec_cue").show();
                }
        })
}
function Searchpress(){
        var sival = $(".s-txt").val();
        if(sival!==""){
                $(".sec_cue").hide();
                }
        $(".s-txt").keydown(function(){
                $(".sec_cue").hide();
        })
}



// 随屏滚动四角方位
var id=function(o){return document.getElementById(o)}
var scroll=function (o){
var space=id(o).offsetTop;
id(o).style.top=space+'px';
void function(){
var goTo = 0;
var roll=setInterval(function(){
var height =document.documentElement.scrollTop+document.body.scrollTop+space;
var top = parseInt(id(o).style.top);
if(height!= top){
goTo = height-parseInt((height - top)*0.9);
id(o).style.top=goTo+'px';
}
//else{if(roll) clearInterval(roll);}
},1);
}()
}

var maxwidth=720;
$(".typo_720 img").each(function(){
if (this.width>maxwidth)
this.width = maxwidth;
});
