package net.shopxx.dao;

import java.util.List;

import net.shopxx.entity.GoodsRelation;

/**
 * Dao接口 - 商品关系
 * ============================================================================
 * 版权所有 2008-2010 长沙鼎诚软件有限公司,并保留所有权利。
 * ----------------------------------------------------------------------------
 * 提示：在未取得SHOP++商业授权之前,您不能将本软件应用于商业用途,否则SHOP++将保留追究的权力。
 * ----------------------------------------------------------------------------
 * 官方网站：http://www.shopxx.net
 * ----------------------------------------------------------------------------
 * KEY: SHOPXX345CC4FC5532785F1241F140FCE5A740
 * ============================================================================
 */

public interface GoodsRelationDao extends BaseDao<GoodsRelation, String> {
	
	
	/**
	 * 根据商品ID取得所有相关商品
	 * 
	 * @param id
	 *            商品ID
	 *            
	 * @param type
	 *            关系类型
	 * 
	 * @return 该商品的所有相关商品
	 */
	public List<GoodsRelation> getGoodsRelationList(String id, Integer type);

}