package net.shopxx.dao.impl;

import java.util.List;

import net.shopxx.dao.CarModeDao;
import net.shopxx.entity.CarMode;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

/**
 * Dao实现类 - 适用车型
 */

@Repository("carModeDaoImpl")
public class CarModeDaoImpl extends BaseDaoImpl<CarMode, String> implements CarModeDao {
	
	@SuppressWarnings("unchecked")
	public List<CarMode> getCarModeList(String carMakeId) {
		String hql = "from CarMode as mode where mode.carMakeId = :carMakeId";
		Query query = getSession().createQuery(hql);
		query.setParameter("carMakeId", carMakeId);
		
		return query.list();
	}
	
	// 关联处理
	@Override
	public void delete(String id) {
		CarMode carMode = load(id);
		this.delete(carMode);
	}

	// 关联处理
	@Override
	public void delete(String[] ids) {
		for (String id : ids) {
			CarMode carMode = load(id);
			this.delete(carMode);
		}
	}
	
}