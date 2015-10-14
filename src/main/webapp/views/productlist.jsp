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
									<div class="cat-name cat-name-1 pos linkon" id="cat-id-114179">
										<a href="javascript:good()">
											上海创业套餐</a>
									</div>
									<ul class="children level-1">
										<li class="li-level-2">
											<div class="cat-item">
												<div class="cat-name cat-name-2" id="cat-id-114922">
													<a
														href="#">
														最新</a>
												</div>
											</div>
										</li>
									</ul>
								</div>
							</li>
							<li class="li-level-1">
								<div class="cat-item">
									<div class="cat-name cat-name-1" id="cat-id-114852">
										<a href="javascript:server()"> 更多免费服务</a>
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
		<div id="jy-right" class="good">
			<div class="rcont clearfix">
				<div class="rtop">
					<div class="rtop-tit">上海创业套餐</div>
					<div class="site-tips rr">
						当前位置：<a href="/">首页</a> >><a
							href="http://www.zhucexia.com/usercategory/product/114179/">上海创业套餐</a>
					</div>
				</div>
				<div class="rmid">
					<div class="box_content">
						<div class="pro_list clearfix">
							<ul>
							<c:forEach var="good" items="${ goodlist}">
								<li><div class="pro_img">
										<a href="${root}/good/goodsdetail?id=${good.id }"><img
											dataid="356963" width="215"
											src="${root }/static/images/index/goods/${good.pic}"
											alt="${good.name }" class="356963" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="${root}/good/goodsdetail?id=${good.id }">${good.name }</a>
									</div>
								</li>
							</c:forEach>
								<%-- <li><div class="pro_img">
										<a href="＃"><img
											dataid="356963" width="215"
											src="${root }/static/images/product/product_hongkou.jpg"
											alt="虹口定制套餐" class="356963" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="＃">虹口定制套餐</a>
									</div></li>
								<li><div class="pro_img">
										<a href="＃"><img
											dataid="357210" width="215"
											src="${root }/static/images/product/product_jiading.jpg"
											alt="嘉定定制套餐" class="357210" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="＃">嘉定定制套餐</a>
									</div></li>
								<li><div class="pro_img">
										<a href="＃"><img
											dataid="357541" width="215"
											src="${root }/static/images/product/product_baoshan.jpg"
											alt="宝山定制套餐" class="357541" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="＃">宝山定制套餐</a>
									</div></li>
								<li><div class="pro_img">
										<a href="＃"><img
											dataid="356963" width="215"
											src="${root }/static/images/product/product_hongkou.jpg"
											alt="虹口定制套餐" class="356963" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="＃">虹口定制套餐</a>
									</div></li>
								<li><div class="pro_img">
										<a href="＃"><img
											dataid="357210" width="215"
											src="${root }/static/images/product/product_jiading.jpg"
											alt="嘉定定制套餐" class="357210" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="＃">嘉定定制套餐</a>
									</div></li>
								<li><div class="pro_img">
										<a href="＃"><img
											dataid="357541" width="215"
											src="${root }/static/images/product/product_baoshan.jpg"
											alt="宝山定制套餐" class="357541" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="＃">宝山定制套餐</a>
									</div></li> --%>
							</ul>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		
		
		<div id="jy-right" class="server" style="display:none;">
			<div class="rcont clearfix">
				<div class="rtop">
					<div class="rtop-tit">上海创业服务</div>
					<div class="site-tips rr">
						当前位置：<a href="/">首页</a> >><a
							href="http://www.zhucexia.com/usercategory/product/114179/">上海创业服务</a>
					</div>
				</div>
				<div class="rmid">
					<div class="box_content">
						<div class="pro_list clearfix">
							<ul>
							<c:forEach var="good" items="${ serverlist}">
								<li><div class="pro_img">
										<a href="＃"><img
											dataid="356963" width="215"
											src="${root }/static/images/index/banner/${good.pic}"
											alt="${good.name }" class="356963" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="＃">${good.name }</a>
									</div>
								</li>
							</c:forEach>
								<%-- <li><div class="pro_img">
										<a href="＃"><img
											dataid="356963" width="215"
											src="${root }/static/images/product/product_hongkou.jpg"
											alt="虹口定制套餐" class="356963" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="＃">虹口定制套餐</a>
									</div></li>
								<li><div class="pro_img">
										<a href="＃"><img
											dataid="357210" width="215"
											src="${root }/static/images/product/product_jiading.jpg"
											alt="嘉定定制套餐" class="357210" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="＃">嘉定定制套餐</a>
									</div></li>
								<li><div class="pro_img">
										<a href="＃"><img
											dataid="357541" width="215"
											src="${root }/static/images/product/product_baoshan.jpg"
											alt="宝山定制套餐" class="357541" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="＃">宝山定制套餐</a>
									</div></li>
								<li><div class="pro_img">
										<a href="＃"><img
											dataid="356963" width="215"
											src="${root }/static/images/product/product_hongkou.jpg"
											alt="虹口定制套餐" class="356963" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="＃">虹口定制套餐</a>
									</div></li>
								<li><div class="pro_img">
										<a href="＃"><img
											dataid="357210" width="215"
											src="${root }/static/images/product/product_jiading.jpg"
											alt="嘉定定制套餐" class="357210" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="＃">嘉定定制套餐</a>
									</div></li>
								<li><div class="pro_img">
										<a href="＃"><img
											dataid="357541" width="215"
											src="${root }/static/images/product/product_baoshan.jpg"
											alt="宝山定制套餐" class="357541" height="215" /></a>
									</div>
									<div class="pro_tit">
										<a href="＃">宝山定制套餐</a>
									</div></li> --%>
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
	}
	function good(){
		$(".server").hide();
		$(".good").show();
	}
</script>
<jsp:include page="/views/common/footer.jsp" />