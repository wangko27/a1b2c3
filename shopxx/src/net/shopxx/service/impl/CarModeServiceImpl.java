package net.shopxx.service.impl;

import java.util.List;

import javax.annotation.Resource;

import net.shopxx.dao.CarModeDao;
import net.shopxx.entity.CarMode;
import net.shopxx.service.CarModeService;

import org.springframework.stereotype.Service;

/**
 * Service实现类 - 适用车型
 */

@Service("carModeServiceImpl")
public class CarModeServiceImpl extends BaseServiceImpl<CarMode, String> implements CarModeService {
	
	@Resource(name = "carModeDaoImpl")
	private CarModeDao carModeDao;

	@Resource(name = "carModeDaoImpl")
	public void setBaseDao(CarModeDao carModeDao) {
		super.setBaseDao(carModeDao);
	}
	
	public List<CarMode> getCarModeList(String carMakeId) {
		return carModeDao.getCarModeList(carMakeId);
	}
}