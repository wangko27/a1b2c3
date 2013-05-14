package net.shopxx.dao;

import java.util.List;

import net.shopxx.entity.CarStyle;

/**
 * Dao接口 - 适用车型
 */

public interface CarStyleDao extends BaseDao<CarStyle, String> {
	public List<CarStyle> getCarStyleList(String carModeId);
}