package net.shopxx.action.admin;

import java.util.List;

import javax.annotation.Resource;

import net.shopxx.entity.CarMode;
import net.shopxx.service.CarModeService;

import org.apache.struts2.convention.annotation.ParentPackage;

@ParentPackage("admin")
public class CarModeAction extends BaseAdminAction {

	private static final long serialVersionUID = 7812111672086577949L;

	@Resource(name = "carModeServiceImpl")
	private CarModeService carModeService;
	
	private CarMode carMode;

	private List<CarMode> carModeList;
	
	public String list(){
		carModeList = carModeService.getCarModeList(carMode.getCarMakeId());
		return ajax(carModeList);
	}

	// 保存
	public String save() {
		carModeService.save(carMode);
		return ajax(Status.success, "添加成功!");
	}

	public CarMode getCarMode() {
		return carMode;
	}

	public void setCarMode(CarMode carMode) {
		this.carMode = carMode;
	}

	public List<CarMode> getCarModeList() {
		return carModeList;
	}

	public void setCarModeList(List<CarMode> carModeList) {
		this.carModeList = carModeList;
	}
}
