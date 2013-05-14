package net.shopxx.service.impl;

import java.util.List;

import javax.annotation.Resource;

import net.shopxx.dao.CarStyleDao;
import net.shopxx.entity.CarStyle;
import net.shopxx.service.CarStyleService;

import org.springframework.stereotype.Service;

/**
 * Service实现类 - 适用车型
 */

@Service("carStyleServiceImpl")
public class CarStyleServiceImpl extends BaseServiceImpl<CarStyle, String> implements CarStyleService {
	
	@Resource(name = "carStyleDaoImpl")
	private CarStyleDao carStyleDao;

	@Resource(name = "carStyleDaoImpl")
	public void setBaseDao(CarStyleDao carStyleDao) {
		super.setBaseDao(carStyleDao);
	}
	
	public List<CarStyle> getCarStyleList(String carModeId) {
		return carStyleDao.getCarStyleList(carModeId);
	}
}