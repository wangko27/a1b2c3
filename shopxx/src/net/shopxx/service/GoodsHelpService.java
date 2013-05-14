package net.shopxx.service;

import java.io.File;

import net.shopxx.bean.GoodsHelp;


/**
 * Service接口 - 商品帮助文件
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

public interface GoodsHelpService {
	
	/**
	 * 上传帮助文件
	 * 
	 * @param goodsHelpFile
	 *            帮助文件
	 * @param suffix 后缀
	 * 
	 */
	public GoodsHelp uploadGoodsHelp(String id, File goodsHelpFile, String suffix);
	
	public GoodsHelp uploadGoodsHelpThumbnail(String id, File goodsHelpThumbnail);

}