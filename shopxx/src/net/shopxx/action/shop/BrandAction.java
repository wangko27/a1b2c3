package net.shopxx.action.shop;

import java.util.List;

import javax.annotation.Resource;

import net.shopxx.entity.Brand;
import net.shopxx.service.BrandService;

import org.apache.struts2.convention.annotation.ParentPackage;

/**
 * 前台Action类 - 厂家检索
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
public class BrandAction extends BaseShopAction {

	private static final long serialVersionUID = -8081978251791210036L;
	
	@Resource(name = "brandServiceImpl")
	private BrandService brandService;
	
	private List<Brand> brandList;

	// 列表
	public String list() {
		brandList = brandService.getAllList();
		return LIST;
	}
	
	public List<Brand> getBrandList() {
		return brandList;
	}

	public void setBrandList(List<Brand> brandList) {
		this.brandList = brandList;
	}
	
}