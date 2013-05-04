package net.shopxx.dao.impl;

import java.util.List;

import net.shopxx.dao.GoodsRelationDao;
import net.shopxx.entity.GoodsRelation;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

/**
 * Dao实现类 - 商品关系
 * ============================================================================
 * 版权所有 2008-2010 长沙鼎诚软件有限公司,并保留所有权利。
 * ----------------------------------------------------------------------------
 * 提示：在未取得SHOP++商业授权之前,您不能将本软件应用于商业用途,否则SHOP++将保留追究的权力。
 * ----------------------------------------------------------------------------
 * 官方网站：http://www.shopxx.net
 * ----------------------------------------------------------------------------
 * KEY: SHOPXX027556F67EB15567DE4DCC7E9D2E5516
 * ============================================================================
 */

@Repository("goodsRelationDaoImpl")
public class GoodsRelationDaoImpl extends BaseDaoImpl<GoodsRelation, String> implements GoodsRelationDao {

	@SuppressWarnings("unchecked")
	public List<GoodsRelation> getGoodsRelationList(String id, Integer type) {
		String hql = "from GoodsRelation as gr where gr.id = :id and gr.type = :type order by gr.orderList asc";
		Query query = getSession().createQuery(hql);
		query.setParameter("id", id);
		query.setParameter("type", type);
		return query.list();
	}
	

}