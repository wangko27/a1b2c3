package net.shopxx.service.impl;

import javax.annotation.Resource;

import net.shopxx.dao.CarMakeDao;
import net.shopxx.entity.CarMake;
import net.shopxx.service.CarMakeService;

import org.springframework.stereotype.Service;

/**
 * Service实现类 - 适用车型
 */

@Service("carMakeServiceImpl")
public class CarMakeServiceImpl extends BaseServiceImpl<CarMake, String> implements CarMakeService {

	@Resource(name = "carMakeDaoImpl")
	public void setBaseDao(CarMakeDao carMakeDao) {
		super.setBaseDao(carMakeDao);
	}
	
}