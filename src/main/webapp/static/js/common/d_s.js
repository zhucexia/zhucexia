// JavaScript Document
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
(function($){
$.fn.actabctl = function(options){
	//默认值
	var defaults = {
		selectedCss: "on", //选项卡选中样式
		evt: 0,  //默认事件，0表示点击，1表示滑过
		auto: false, //是否自定滑动
		nb:false,
		effect: true,
		pause: 4000 //两次滑动暂停时间
	};
	var options = $.extend({}, defaults, options);
	
	//检测必须条件
	if(!options.menu && !options.content) return;
	
	var $mobj = $(this).find(options.menu);
	var $cobj = $(this).find(options.content);
	
	function movement( obj, index ){
		
		var next = index >= 0 ? (index == $mobj.size() ? 0 : index) : $mobj.index(obj);
		
		// 隐藏全部选项卡内容并显示与单击相对应的那个选项卡内容
		if(options.effect){
			var _h = $cobj.eq(next).height();
			$cobj.hide().eq(next).css('top', '-'+_h+'px').show().animate({'top': '10px'}, 'fast').animate({'top': '0px'}, 'fast'); 
		}else{
			$cobj.hide().eq(next).show();
		}
		
		// 清除全部的菜单样式并选中当前菜单样式
		$mobj.removeClass(options.selectedCss).eq(next).addClass(options.selectedCss); 
		
		if ( options.auto ) {
			timeout = setTimeout(function() {
				movement(false, next + 1);
			}, options.pause);
		}
	}
		

	//初始化
	var timeout, delay;
	var evtName = options.evt === 0 ? "click" : options.evt === 1 ? "mouseover" : "click";
	
	if(options.auto) movement(false, 0);
	
	$mobj[evtName](function(){ 
	   clearTimeout(timeout); 
	   var _this_ = this;
	   delay = setTimeout(function(){movement(_this_);}, 100); 
	}).mouseout(function(){clearTimeout(delay);});

};
$.fn.flashSlider = function(options) {
	//默认值
	var defaults = {
		controlsShow: true, 	//是否显示数字导航
		customnev	: false, 	//是否自定义导航
		vertical	: 'left', 	//淡入[fade],向上滑动[top],左右滑动[left]
		speed		: 800, 		//滑动速度
		auto		: true,		//是否自定滑动
		pause		: 3000, 	//两次滑动暂停时间
		easing		: "swing", 	//easing效果，默认swing，更多效果需要easing插件支持
		height		: 0, 		//容器高度，不设置自动获取图片高度
		width		: 0,		//容器宽度，不设置自动获取图片宽度
		resize		: false, 	//图片自动调整大小
		delay		: false, 	//图片延迟加载
		char		: '', 		//文字标题绑定
		index		: '' 		//小图索引绑定
	};
	var options = $.extend({}, defaults, options);
	var FS = this;
	
	//开启图片自动调整大小
	if(options.resize && !options.delay){
		$("img", FS).each(function(i, c){
			var $Ig = new Image();
			$Ig.src = c.src;
			$(c).attr('alt','正在加载中...');
			$Ig.onload = function(){
				$(c).css({
					'width' : (this.width < options.width ? this.width : options.width), 
					'height' : (this.height < options.height ? this.height : options.height), 
					'margin-left' : (this.width < options.width ? (options.width - this.width)/2 : 0), 
					'margin-right' : (this.width < options.width ? (options.width - this.width)/2 : 0), 
					'margin-top' : (this.height < options.height ? (options.height - this.height)/2 : 0), 
					'margin-bottom' : (this.height < options.height ? (options.height - this.height)/2 : 0)
				});
			};
		});	
	}
	
	//开启延迟加载图片
	if(options.delay && !options.resize){
		$("img" ,FS).each(function(){
			$(this).attr('fsrc', $(this).attr('src')).removeAttr('src');
		});
		window.onload = function(){
			$("img" ,FS).each(function(){
				$(this).attr('src', $(this).attr('fsrc')).removeAttr('fsrc');
			});
		};
	}
	
	//判断图片少于或等于一张跳出
	if($("img" ,FS).size()<=1) return;
	
	FS.each(function() {
		var obj = $(this);
		var curr = 1; //当前索引
		var $img = obj.find("img");
		var s = $img.length;
		var w = $img.eq(0).width() || obj.width();
		var h = $img.eq(0).height() || obj.height();
		var $flashelement = $("ul", obj);
		options.height == 0 ? obj.height(h) : obj.height(options.height);
		options.width == 0 ? obj.width(w) : obj.width(options.width);
		obj.css("overflow", "hidden");
		obj.css("position", "relative");
		$flashelement.css('width', s * w);
		
		if(options.vertical === 'left') $("li", obj).css('float', 'left');
		if(options.vertical === 'top') $img.css('display', 'block');

		if (options.controlsShow) {
			if (options.customnev) {
				var navbtnhtml = '';
				for (var i = 0; i < s; i++) {
					tit =$img.eq(i).attr('title');
					hef =obj.find("a").eq(i).attr('href');
					navbtnhtml += '<span>' + '<i>' + (i + 1)+ '</i>' + '</span>';
				}
				$("#num").append(navbtnhtml);
			$("#num span").hover(function() {
				var num = $(this).find("i").html();
				flash(num, true);
			}, function() {
				timeout = setTimeout(function() {
					flash((curr / 1 + 1), false);
				}, options.pause / 4);
			});
			}else{
				var navbtnhtml = '<div id="num">';
				for (var i = 0; i < s; i++) {
					navbtnhtml += '<li>' + (i + 1) + '</li>';
				}
				navbtnhtml += '</div>';
				obj.append(navbtnhtml);
			$("#num li").hover(function() {
				var num = $(this).html();
				flash(num, true);
			}, function() {
				timeout = setTimeout(function() {
					flash((curr / 1 + 1), false);
				}, options.pause / 4);
			});
			}
			
		};
		
		if(options.index !== ''){
			$("#sliderindex").find(options.index)
			.each(function(i, e){
				$(e).attr('indexbind', i);
			})
			.hover(function() {
				var num = $(this).attr('indexbind');
					flash(parseInt(num)+1, true);
				}, function() {
				timeout = setTimeout(function() {
					flash((curr / 1 + 1), false);
				}, options.pause / 4);
			});
		}
		
		function setcurrnum(index) {
			if (options.controlsShow) $("#num li").eq(index).addClass('on').siblings().removeClass('on');
			if (options.customnev) $("#num span ").eq(index).addClass('on').siblings().removeClass('on');
			if(options.char !== '') $("#sliderchar").find(options.char).hide().eq(index).show();
			if(options.index !== '') $("#sliderindex").find(options.index).eq(index).addClass('on').siblings().removeClass('on');
		}
		
		function flash(index, clicked) {
			$flashelement.stop();
			var next = index == s ? 1 : index + 1;
			curr = index - 1;
			setcurrnum((index - 1));
			
			switch(options.vertical){
				case 'top':
					p = ((index - 1) * h * -1);
					$flashelement.animate({ marginTop: p },options.speed, options.easing);
					break;
				case 'left':
					p = ((index - 1) * w * -1);
					$flashelement.animate({ marginLeft: p },options.speed, options.easing);
					break;
				case 'fade':
					$flashelement.find('li').hide().eq(index-1).fadeIn('slow').show();
					break;
			}
			if (clicked) clearTimeout(timeout);
			if (options.auto && !clicked) {
				timeout = setTimeout(function() {
					flash(next, false);
				}, options.speed + options.pause);
			};
		}
		var timeout;
		//初始化
		setcurrnum(0);
		if (options.auto) {
			timeout = setTimeout(function() {
				flash(2, false);
			}, options.pause);
		};
	});
};

$.fn.amazon_scroller=function(p){
        var p=p||{};

        var g=p&&p.scroller_time_interval?p.scroller_time_interval:"3000";
        var h=p&&p.scroller_title_show?p.scroller_title_show:"enable";
        var i=p&&p.scroller_window_background_color?p.scroller_window_background_color:"white";
        var j=p&&p.scroller_window_padding?p.scroller_window_padding:"5";
        var k=p&&p.scroller_border_size?p.scroller_border_size:"0";
        var l=p&&p.scroller_border_color?p.scroller_border_color:"black";
        var m=p&&p.scroller_images_width?p.scroller_images_width:"150";
        var n=p&&p.scroller_images_height?p.scroller_images_height:"170";
        var o=p&&p.scroller_title_size?p.scroller_title_size:"12";
        var q=p&&p.scroller_title_color?p.scroller_title_color:"blue";
        var r=p&&p.scroller_show_count?p.scroller_show_count:"2";
        var d=p&&p.directory?p.directory:"imgs";
        j += "px";
        k += "px";
        m += "px";
        n += "px";
        o += "px";
        var dom=$(this);
        var s;
        var t=0;
        var u;
        var v;
        var w=dom.find("ul:first").children("li").length;
        var x=Math.ceil(w/r);
        if(dom.find("ul").length==0||dom.find("li").length==0){
            dom.append("Require content");
            return null
            }
            dom.find("ul:first").children("li").children("a").children("img").css("width",m).css("height",n);
        if(h=='enable'){
            dom.find("ul:first").children("li").children("a").each(function(){
                $(this).append('<br/>'+$(this).attr("title"))
                })
            }
            s_s_ul(dom,j,k,l,i);
        s_s_nav(dom.find(".amazon_scroller_nav"),d);
        m=parseInt(m);
        dom.find("ul:first").children("li").css("width",m+"px");
        dom.find("ul:first").children("li").children("a").css("color",q);
        dom.find("ul:first").children("li").children("a").css("font-size",o);
        begin();
        play();
        dom.find(".amazon_scroller_nav").children("li").hover(
            function(){
                if($(this).parent().children().index($(this))==0){
                $(this).css("background-position","-231px -64px");
                }else if($(this).parent().children().index($(this))==1){
                $(this).css("background-position","-251px -44px");
                }
            },
            function(){
                if($(this).parent().children().index($(this))==0){
                $(this).css("background-position","-231px -44px");
                }else if($(this).parent().children().index($(this))==1){
                $(this).css("background-position","-251px -64px");
                }
            }
        );
        dom.find(".amazon_scroller_nav").children("li").click(function(){
            if($(this).parent().children().index($(this))==0){
                previous()
                }else if($(this).parent().children().index($(this))==1){
                next()
                }
            });
    function begin(){
        var a=dom.find("ul:first").children("li").outerWidth(true)*w;
        dom.find("ul:first").children("li").hide();
        dom.find("ul:first").children("li").slice(0,r).show();
        u=dom.find("ul:first").outerWidth();
        v=dom.find("ul:first").outerHeight();
        dom.find("ul:first").width(a);
        dom.width(u+60);
        dom.height(v);
        dom.children(".amazon_scroller_mask").width(u);
        dom.children(".amazon_scroller_mask").height(v);
        dom.find("ul:first").children("li").show();
        dom.css("position","relative");
        dom.find("ul:first").css("position","absolute");
        dom.children(".amazon_scroller_mask").width(u);
        dom.children(".amazon_scroller_mask").height(v);
        //dom.find(".amazon_scroller_nav").css('top',(v-50)/2+parseInt(j)+"px");
        dom.find(".amazon_scroller_nav").width(u+60)
        }
        function previous(){
        if(t==0){
            t=x-2
            }else{
            if(t==1){
                t=x-1
                }else{
                t-=2
                }
            }
        play()
    }
    function next(){
    play()
    }
    function play(){
    clearTimeout(s);
    dom.find("ul:first").animate({
        left:-(t*u)
        },500);
    t++;
    if(t>=x){
        t=0
        }
        s=setTimeout(play,g)
    }
    function s_s_ul(a,b,c,d,e){
    b=parseInt(b);
    c=parseInt(c);
    var f="border: "+d+" solid "+" "+c+"px; padding:"+b+"px; background-color:"+e;
    a.attr("style",f)
    }
    function s_s_nav(a,d){
    var b=a.children("li:first");
    var c=a.children("li:last");
    a.children("li").css("width","20px");
    a.children("li").css("height","20px");
    //a.children("li").css('background-image','url("'+d+'/t_bg.gif")');
    c.css('background-position','-251px -64px');
    b.css('background-position','-231px -44px');
    c.css('right','0px')
    }
}
})(jQuery);