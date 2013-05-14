package net.shopxx.dao;

import java.util.List;

import net.shopxx.entity.CarMode;

/**
 * Dao接口 - 适用车型
 */

public interface CarModeDao extends BaseDao<CarMode, String> {
	public List<CarMode> getCarModeList(String carMakeId);
}