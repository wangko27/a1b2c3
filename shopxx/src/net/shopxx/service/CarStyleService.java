package net.shopxx.service;

import java.util.List;

import net.shopxx.entity.CarStyle;

/**
 * Service接口 - 适用车型
 */

public interface CarStyleService extends BaseService<CarStyle, String> {
	public List<CarStyle> getCarStyleList(String carModeId);
}