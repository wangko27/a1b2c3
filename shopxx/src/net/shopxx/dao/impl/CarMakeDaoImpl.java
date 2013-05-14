package net.shopxx.dao.impl;

import net.shopxx.dao.CarMakeDao;
import net.shopxx.entity.CarMake;

import org.springframework.stereotype.Repository;

/**
 * Dao实现类 - 适用车型
 */

@Repository("carMakeDaoImpl")
public class CarMakeDaoImpl extends BaseDaoImpl<CarMake, String> implements CarMakeDao {
	
	// 关联处理
	@Override
	public void delete(String id) {
		CarMake carMake = load(id);
		this.delete(carMake);
	}

	// 关联处理
	@Override
	public void delete(String[] ids) {
		for (String id : ids) {
			CarMake carMake = load(id);
			this.delete(carMake);
		}
	}
	
}