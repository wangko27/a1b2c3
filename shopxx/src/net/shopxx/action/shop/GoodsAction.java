package net.shopxx.action.shop;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.shopxx.bean.Pager.Order;
import net.shopxx.entity.Brand;
import net.shopxx.entity.Goods;
import net.shopxx.entity.GoodsAttribute;
import net.shopxx.entity.GoodsCategory;
import net.shopxx.service.BrandService;
import net.shopxx.service.GoodsAttributeService;
import net.shopxx.service.GoodsCategoryService;
import net.shopxx.service.GoodsService;
import net.shopxx.util.SettingUtil;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.ParentPackage;

import com.opensymphony.xwork2.interceptor.annotations.InputConfig;
import com.opensymphony.xwork2.validator.annotations.RequiredStringValidator;
import com.opensymphony.xwork2.validator.annotations.Validations;

/**
 * 前台Action类 - 商品
 * ============================================================================
 * 版权所有 2008-2010 长沙鼎诚软件有限公司,并保留所有权利。
 * ----------------------------------------------------------------------------
 * 提示：在未取得SHOP++商业授权之前,您不能将本软件应用于商业用途,否则SHOP++将保留追究的权力。
 * ----------------------------------------------------------------------------
 * 官方网站：http://www.shopxx.net
 * ----------------------------------------------------------------------------
 * KEY: SHOPXXD555C0667F7008EC5F71FFFB78A4F6AB
 * ============================================================================
 */

@ParentPackage("shop")
public class GoodsAction extends BaseShopAction {

	private static final long serialVersionUID = -4969421249817468001L;

	private String sign;
	private String compareIds;
	private Map<String, String> goodsAttributeIdMap;
	private Map<String, String> parameterMap;
	private String orderType;
	private String viewType;
	private String searchType;
	private String goodsId;
	private String goodsCategoryId;
	
	private GoodsCategory goodsCategory;
	private Brand brand;
	private List<GoodsCategory> pathList;
	private List<Goods> compareResultList;
	private List<Goods> recommendList;
	
	@Resource(name = "goodsServiceImpl")
	private GoodsService goodsService;
	@Resource(name = "goodsCategoryServiceImpl")
	private GoodsCategoryService goodsCategoryService;
	@Resource(name = "brandServiceImpl")
	private BrandService brandService;
	@Resource(name = "goodsAttributeServiceImpl")
	private GoodsAttributeService goodsAttributeService;
	
	@Validations(
			requiredStrings = {
				@RequiredStringValidator(fieldName = "goodsCategoryId", message = "参数错误!"),
				@RequiredStringValidator(fieldName = "goodsId", message = "参数错误!")
			}
		)
	@InputConfig(resultName = "error")
	public String recommend() {
		goodsCategory = goodsCategoryService.get(goodsCategoryId);
		if (goodsCategory == null) {
			addActionError("参数错误!");
			return ERROR;
		}
		
		String orderType = SettingUtil.getSetting().getDefaultSameGoodsOrder().toString();
		recommendList = goodsService.getRecommendGoodsList(goodsId, goodsCategory, orderType);
		return "recommend";
	}

	@Validations(
		requiredStrings = {
			@RequiredStringValidator(fieldName = "sign", message = "参数错误!")
		}
	)
	@InputConfig(resultName = "error")
	public String list() {
		parameterMap = new HashMap<String, String> ();
		if (StringUtils.equalsIgnoreCase(viewType, "tableType")) {
			viewType = "tableType";
		} else {
			viewType = "pictureType";
		}
		parameterMap.put("viewType", viewType);
		
		if (StringUtils.equalsIgnoreCase(orderType, "priceAsc")) {
			pager.setOrderBy("price");
			pager.setOrder(Order.asc);
		} else if (StringUtils.equalsIgnoreCase(orderType, "priceDesc")) {
			pager.setOrderBy("price");
			pager.setOrder(Order.desc);
		} else if (StringUtils.equalsIgnoreCase(orderType, "dateDesc")) {
			pager.setOrderBy("createDate");
			pager.setOrder(Order.desc);
		} else if (StringUtils.equalsIgnoreCase(orderType, "salesDesc")) {
			pager.setOrderBy("totalSales");
			pager.setOrder(Order.desc);
		} else if (StringUtils.equalsIgnoreCase(orderType, "discountAsc")) {
			pager.setOrderBy("discount");
			pager.setOrder(Order.asc);
		} else {
			orderType = "";
			pager.setOrderBy(null);
			pager.setOrder(null);
		}
		parameterMap.put("orderType", orderType);
		pager.setSearchBy(null);
		pager.setKeyword(null);
		
		goodsCategory = goodsCategoryService.getGoodsCategoryBySign(sign);
		if (goodsCategory == null) {
			addActionError("参数错误!");
			return ERROR;
		}
		
		if (brand != null && StringUtils.isNotEmpty(brand.getId())) {
			brand = brandService.load(brand.getId());
			parameterMap.put("brandId", brand.getId());
		} else {
			brand = null;
		}
		
		if (goodsAttributeIdMap == null || goodsAttributeIdMap.size() == 0) {
			pager = goodsService.getGoodsPager(goodsCategory, brand, null, pager);
		} else {
			Map<GoodsAttribute, String> goodsAttributeMap = new HashMap<GoodsAttribute, String>();
			for (String goodsAttributeId : goodsAttributeIdMap.keySet()) {
				GoodsAttribute goodsAttribute = goodsAttributeService.load(goodsAttributeId);
				String goodsAttributeOption = goodsAttributeIdMap.get(goodsAttributeId);
				goodsAttributeMap.put(goodsAttribute, goodsAttributeOption);
				parameterMap.put("goodsAttributeIdMap['" + goodsAttributeId + "']", goodsAttributeIdMap.get(goodsAttributeId));
			}
			pager = goodsService.getGoodsPager(goodsCategory, brand, goodsAttributeMap, pager);
		}
		pathList = goodsCategoryService.getGoodsCategoryPathList(goodsCategory);
		
		if (StringUtils.equalsIgnoreCase(viewType, "tableType")) {
			return "table_list";
		} else {
			return "picture_list";
		}
	}
	
	@Validations(
		requiredStrings = { 
			@RequiredStringValidator(fieldName = "pager.keyword", message = "搜索关键词不允许为空!") 
		}
	)
	@InputConfig(resultName = "error")
	public String search() throws Exception {
		if (StringUtils.equalsIgnoreCase(orderType, "priceAsc")) {
			pager.setOrderBy("price");
			pager.setOrder(Order.asc);
		} else if (StringUtils.equalsIgnoreCase(orderType, "priceDesc")) {
			pager.setOrderBy("price");
			pager.setOrder(Order.desc);
		} else if (StringUtils.equalsIgnoreCase(orderType, "dateDesc")) {
			pager.setOrderBy("createDate");
			pager.setOrder(Order.desc);
		} else if (StringUtils.equalsIgnoreCase(orderType, "salesDesc")) {
			pager.setOrderBy("totalSales");
			pager.setOrder(Order.desc);
		} else if (StringUtils.equalsIgnoreCase(orderType, "discountAsc")) {
			pager.setOrderBy("discount");
			pager.setOrder(Order.asc);
		} else {
			pager.setOrderBy(null);
			pager.setOrder(null);
		}
		
		pager = goodsService.search(pager);
		searchType = "product";
		if (StringUtils.equalsIgnoreCase(viewType, "tableType")) {
			return "table_search";
		} else {
			return "picture_search";
		}
	}
	
	public String compare() {
		String[] compareId = compareIds.split(",");
		compareResultList = new ArrayList<Goods>();
		for(String id : compareId) {
			compareResultList.add(goodsService.load(id));
		}
		return "compare";
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public String getCompareIds() {
		return compareIds;
	}

	public void setCompareIds(String compareIds) {
		this.compareIds = compareIds;
	}

	public Map<String, String> getGoodsAttributeIdMap() {
		return goodsAttributeIdMap;
	}

	public void setGoodsAttributeIdMap(Map<String, String> goodsAttributeIdMap) {
		this.goodsAttributeIdMap = goodsAttributeIdMap;
	}

	public Map<String, String> getParameterMap() {
		return parameterMap;
	}

	public void setParameterMap(Map<String, String> parameterMap) {
		this.parameterMap = parameterMap;
	}

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public String getViewType() {
		return viewType;
	}

	public void setViewType(String viewType) {
		this.viewType = viewType;
	}

	public GoodsCategory getGoodsCategory() {
		return goodsCategory;
	}

	public void setGoodsCategory(GoodsCategory goodsCategory) {
		this.goodsCategory = goodsCategory;
	}

	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public List<GoodsCategory> getPathList() {
		return pathList;
	}

	public void setPathList(List<GoodsCategory> pathList) {
		this.pathList = pathList;
	}

	public List<Goods> getCompareResultList() {
		return compareResultList;
	}

	public void setCompareResultList(List<Goods> compareResultList) {
		this.compareResultList = compareResultList;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}

	public String getGoodsCategoryId() {
		return goodsCategoryId;
	}

	public void setGoodsCategoryId(String goodsCategoryId) {
		this.goodsCategoryId = goodsCategoryId;
	}

	public List<Goods> getRecommendList() {
		return recommendList;
	}

	public void setRecommendList(List<Goods> recommendList) {
		this.recommendList = recommendList;
	}
	
}