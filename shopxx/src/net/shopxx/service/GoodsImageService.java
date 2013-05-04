package net.shopxx.service;

import java.io.File;

import net.shopxx.bean.GoodsImage;


/**
 * Service接口 - 商品图片
 * ============================================================================
 * 版权所有 2008-2010 长沙鼎诚软件有限公司,并保留所有权利。
 * ----------------------------------------------------------------------------
 * 提示：在未取得SHOP++商业授权之前,您不能将本软件应用于商业用途,否则SHOP++将保留追究的权力。
 * ----------------------------------------------------------------------------
 * 官方网站：http://www.shopxx.net
 * ----------------------------------------------------------------------------
 * KEY: SHOPXX89343F3383F923F8C0F63F568A7EC7A7
 * ============================================================================
 */

public interface GoodsImageService {
	
	/**
	 * 生成商品图片（大图、小图、缩略图）
	 * 
	 * @param goodsImageFile
	 *            图片文件
	 * 
	 */
	public GoodsImage buildGoodsImage(File goodsImageFile);

}