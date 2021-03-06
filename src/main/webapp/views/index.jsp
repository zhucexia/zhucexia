<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="/views/common/header.jsp" />
<jsp:include page="/views/common/top.jsp" />

<div class="fullSlide">
	<div class="bd">
		<ul style="position: relative; width: 1000px; height: 328px;">
			<li
				style="position: absolute; width: 1000px; left: 0px; top: 0px; display: none; background: url(${root }/static/images/index/ads/ads1.jpeg) 50% 0px no-repeat rgb(239, 239, 239);">
				<!-- <a target="_blank" href="http://www.zhucexia.com/#"></a> -->
			</li>
			<li
				style="position: absolute; width: 1000px; left: 0px; top: 0px; display: list-item; background: url(${root }/static/images/index/ads/ads2.jpeg) 50% 0px no-repeat rgb(239, 239, 239);">
				<!-- <a target="_blank" href="http://www.zhucexia.com/#"></a> -->
			</li>
			<li
				style="position: absolute; width: 1000px; left: 0px; top: 0px; display: none; background: url(${root }/static/images/index/ads/ads3.jpeg) 50% 0px no-repeat rgb(239, 239, 239);">
				<!-- <a target="_blank" href="http://www.zhucexia.com/#"></a> -->
			</li>
		</ul>
	</div>
	<div class="hd">
		<ul>
			<li class="">1</li>
			<li class="on">2</li>
			<li class="">3</li>
		</ul>
	</div>
	<span class="prev" style="opacity: 0.5; display: none;"></span><span
		class="next" style="opacity: 0.5; display: none;"></span>
</div>
<div id="mainmain">
	<div class="main clearfix">
		<!--start首页主体内容-->
		<div class="index_ser">
			<div class="box" id="news-channel">
				<div class="title common_title">
					<a href="${root }/good?flag=1"
						class="cur">套餐</a>
				</div>
				<ul class="newc-list clearfix" style="display: block; top: 0px;">
					<c:forEach items="${goodlist }" var="good" varStatus="status">
					<c:choose>
						<c:when test="${status.index%3==0 }">
							<li style="margin-left:0;">
								<div class="pic">
									<span><%-- <a href="#"
										title="${good.name }"> --%><img dataid="356963" width="320"
											src="http://${good.pic}"
											alt="${good.name }" class="356963" height="256"><!-- </a> --></span>
								</div>
								<div class="dec-right">
									<a href="${root}/good/goodsdetail?id=${good.id}" title="${good.name }">立刻申请</a>
								</div>
								<div class="dec-left">
									<h5 style="font-size:18px;font-weight:normal;color:#000;">
										<%-- <a href="#" title="${good.name }"> --%>${good.name }<!-- </a> -->
									</h5>
									<p>${good.apply_condition }</p>
								</div>
							</li>
						</c:when>
						<c:otherwise>
							<li>
								<div class="pic">
									<span><%-- <a href="#"
										title="${good.name }"> --%><img dataid="356963" width="320"
											src="http://${good.pic}"
											alt="${good.name }" class="356963" height="256"><!-- </a> --></span>
								</div>
								<div class="dec-right">
									<a href="${root}/good/goodsdetail?id=${good.id}" title="${good.name }">立刻申请</a>
								</div>
								<div class="dec-left">
									<h5 style="font-size:18px;font-weight:normal;color:#000;">
										<%-- <a href="#" title="${good.name }"> --%>${good.name }<!-- </a> -->
									</h5>
									<p>${good.apply_condition }</p>
								</div>
							</li>
						</c:otherwise>
					</c:choose>
						
					</c:forEach>
				
				</ul>
			</div>
			<script type="text/javascript" language="javascript">
				$("#news-channel").actabctl({
					menu : '.title a',
					content : '.newc-list',
					selectedCss : "cur",
					evt : 1
				});
			</script>
		</div>
		<div class="index_imageset mt20">
			<div class="w960" style="margin-left: 10px;">
				<div class="title common_title">
					<span class="common_more"><a
						href="${root }/good?flag=2">更多服务</a></span>
				</div>
				<div id="imageDemo" class="image_cont"
					style="visibility: visible; overflow: hidden; position: relative; z-index: 2; left: 0px; width: 1040px;">
					<div class="l" id="prev">
						<a href="javascript:void(0);"><img
							src="${root }/static/images/index/la.jpg"></a>
					</div>
					<div class="cont" style="overflow: hidden;">
						<ul
							style="margin: 0px; padding: 0px; position: relative; list-style-type: none; z-index: 1; width: 4680px; left: -1040px;">
							<c:forEach items="${ serverlist}" var="server">
								<li
								style="overflow: hidden; float: left; width: 500px; height: 225px;">
								<div class="pic"> 
									<!-- <a href="#"
										target="_blank"> --><img dataid="373471" width="225"
										src="http://${server.pic}"
										alt="${server.name}" class="373471" height="225"><!-- </a> -->
								</div>
								<div class="dec">
									<h5 style="font-size:18px;font-weight:normal;color:#000;">
										<!-- <a href="#"
											target="_blank"> -->${server.name}<!-- </a> -->
									</h5>
									<p><%-- ${server.detail_content} --%></p>
									<div class="index-btn">
										<a href="${root}/good/goodsdetail?id=${server.id}" title="${server.name}">立刻申请</a>
									</div>
								</div>
							</li>
							</c:forEach>
						</ul>
					</div>
					<div class="l" id="next">
						<a href="javascript:void(0);"><img
							src="${root }/static/images/index/ra.jpg"></a>
					</div>
				</div>
			</div>
		</div>
		<!--广告位indexmiddleone_ad-->
		<div class="mt10 t_c">
			<!-- <a href="http://www.zhucexia.com/#" target="_self"> --><img
				src="${root }/static/images/index/introduct.jpeg" alt=""><!-- </a> -->
		</div>
		<!--end首页主体内容-->
	</div>
</div>
<jsp:include page="/views/common/footer.jsp" />
<script src="${root }/static/js/plugins/mopublic.js"></script>
<script type="text/javascript"
	src="${root }/static/js/plugins/superslide.2.1.js"></script>
<script>
$LAB.script('${root }/static/js/plugins/mopublic.js').wait()
    .script('${root }/static/js/plugins/superslide.2.1.js').wait(function(){
    	$(function() {
    		$("#imageDemo").jCarouselLite({
    			btnNext : "#next",
    			btnPrev : "#prev",
    			visible : 2,
    			scroll : 1,
    			vertical : false,
    			speed : 500,
    			auto : false,
    			onMouse : true
    		});
    	});
    	jQuery(".fullSlide").hover(function() {
    		jQuery(this).find(".prev,.next").stop(true, true).fadeTo("show", 0.5)
    	}, function() {
    		jQuery(this).find(".prev,.next").fadeOut()
    	});
    	jQuery(".fullSlide").slide({
			titCell : ".hd ul",
			mainCell : ".bd ul",
			effect : "fold",
			autoPlay : true,
			autoPage : true,
			trigger : "click",
			startFun : function(i) {
				var curLi = jQuery(".fullSlide .bd li").eq(i);
				if (!!curLi.attr("_src")) {
					curLi.css("background-image", curLi.attr("_src"))
							.removeAttr("_src")
				}
			}
		});
    })   

</script>
