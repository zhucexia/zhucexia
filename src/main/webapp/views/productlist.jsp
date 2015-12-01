<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="/views/common/header.jsp" />
<jsp:include page="/views/common/top.jsp" />
<div class="list-banner">
	<!--广告位producttop_ad-->
</div>
<div id="mainmain">
	<div class="main clearfix">
		<div id="jy-left">
			<div class="ltop clearfix">
				<div class="ltop-hd">
					<div class="ltop-tit"></div>
				</div>
				<div class="ltop-bd">
					<div class="cat_con">
						<ul>
							<li class="li-level-1">
								<div class="cat-item">
								<!-- <div class="cat-name cat-name-1 pos linkon" id="cat-id-114179"> -->
									<div class="cat-name cat-name-1 pos<c:if test='${flag==1}'> linkon</c:if>" id="cat-id-114179">
										<a href="javascript:good()">
											上海创业套餐</a>
									</div>
									<ul class="children level-1">
										<li class="li-level-2">
											<div class="cat-item">
												<div class="cat-name cat-name-2" id="cat-id-114922">
													<a
														href="javascript:newgood()">
														最新</a>
												</div>
											</div>
										</li>
									</ul>
								</div>
							</li>
							<li class="li-level-1">
								<div class="cat-item">
									<div class="cat-name cat-name-1<c:if test='${flag==2}'> pos linkon</c:if>" id="cat-id-114852">
										<a href="javascript:server()"> 更多服务</a>
									</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="list_contact clearfix mt10">
				<div class="listc-hd">联系我们</div>
				<div class="listc-bd">
					公司电话：4009207898 <br> 联系人：注册侠 <br>
				</div>
			</div>
		</div>
		<div id="jy-right" class="good" <c:if test="${flag==1 }">style="display:block"</c:if>
			<c:if test="${flag!=1 }">style="display:none"</c:if>
		>
			<div class="rcont clearfix">
				<div class="rtop">
					<div class="rtop-tit">上海创业套餐</div>
					<div class="site-tips rr">
						当前位置：<a href="${root }/">首页</a> >><span>上海创业套餐</span>
					</div>
				</div>
				<div class="rmid">
					<div class="box_content">
						<div class="pro_list clearfix">
							<ul id="normal">
							<c:if test="${! empty goodlist }">
							<c:forEach var="good" items="${ goodlist}">
								<li><div class="pro_img">
										<a href="${root}/good/goodsdetail?id=${good.id }"><img
											dataid="356963" width="215"
											src="http://${good.pic}"
											alt="${good.name }" class="356963" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="${root}/good/goodsdetail?id=${good.id }">${good.name }</a>
									</div>
								</li>
							</c:forEach>
							</c:if>
							</ul>
							<ul id="new" style="display:none;">
								<c:if test="${! empty newgoodlist }">
								<c:forEach var="good" items="${ newgoodlist}">
									<li><div class="pro_img">
											<a href="${root}/good/goodsdetail?id=${good.id }"><img
												dataid="356963" width="215"
												src="http://${good.pic}"
												alt="${good.name }" class="356963" height="215" /></a>
										</div>
										<div class="pro_tit">
											<a href="${root}/good/goodsdetail?id=${good.id }">${good.name }</a>
										</div>
									</li>
								</c:forEach>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>	
		</div>	
		<div id="jy-right" class="server" <c:if test="${flag==2 }">style="display:block"</c:if>
			<c:if test="${flag!=2 }">style="display:none"</c:if>>
			<div class="rcont clearfix">
				<div class="rtop">
					<div class="rtop-tit">上海创业服务</div>
					<div class="site-tips rr">
						当前位置：<a href="${root }/">首页</a> >><span>上海创业服务</span>
					</div>
				</div>
				<div class="rmid">
					<div class="box_content">
						<div class="pro_list clearfix">
							<ul>
							<c:if test="${! empty serverlist }">
							<c:forEach var="good" items="${serverlist}">
								<li><div class="pro_img">
										<a href="${root}/good/goodsdetail?id=${good.id }"><img
											dataid="356963" width="215"
											src="http://${good.pic}"
											alt="${good.name }" class="356963" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="${root}/good/goodsdetail?id=${good.id }">${good.name }</a>
									</div>
								</li>
							</c:forEach>
							</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		<!-- ww -->
	</div>
</div>
<script type="text/javascript">
	function server(){
		$(".server").show();
		$(".good").hide();
		$(".linkon").removeClass("pos linkon");
		$("#cat-id-114852").addClass("pos linkon");
		
	}
	function good(){
		$(".server").hide();
		$("#new").hide();
		$(".good").show();
		$("#normal").show();
		$(".linkon").removeClass("pos linkon");
		$("#cat-id-114179").addClass("pos linkon");
	}
	function newgood(){
		$(".server").hide();
		$("#normal").hide();
		$(".good").show();
		$("#new").show();
		$(".linkon").removeClass("pos linkon");
		$("#cat-id-114922").addClass("pos linkon");
	}
</script>
<jsp:include page="/views/common/footer.jsp" />
