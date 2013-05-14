package net.shopxx.dao.impl;

import java.util.List;

import net.shopxx.dao.CarStyleDao;
import net.shopxx.entity.CarStyle;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

/**
 * Dao实现类 - 适用车型
 */

@Repository("carStyleDaoImpl")
public class CarStyleDaoImpl extends BaseDaoImpl<CarStyle, String> implements CarStyleDao {
	
	@SuppressWarnings("unchecked")
	public List<CarStyle> getCarStyleList(String carModeId) {
		String hql = "from CarStyle as style where style.carModeId = :carModeId";
		Query query = getSession().createQuery(hql);
		query.setParameter("carModeId", carModeId);
		
		return query.list();
	}
	
	// 关联处理
	@Override
	public void delete(String id) {
		CarStyle carStyle = load(id);
		this.delete(carStyle);
	}

	// 关联处理
	@Override
	public void delete(String[] ids) {
		for (String id : ids) {
			CarStyle carStyle = load(id);
			this.delete(carStyle);
		}
	}
	
}