package net.shopxx.service;

import java.util.List;

import net.shopxx.entity.CarMode;

/**
 * Service接口 - 适用车型
 */

public interface CarModeService extends BaseService<CarMode, String> {
	public List<CarMode> getCarModeList(String carMakeId);
}