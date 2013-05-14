package net.shopxx.action.admin;

import java.util.List;

import javax.annotation.Resource;

import net.shopxx.action.admin.BaseAdminAction.Status;
import net.shopxx.entity.CarMake;
import net.shopxx.service.CarMakeService;

import org.apache.struts2.convention.annotation.ParentPackage;

@ParentPackage("admin")
public class CarMakeAction extends BaseAdminAction {

	private static final long serialVersionUID = 7812111672086577949L;

	@Resource(name = "carMakeServiceImpl")
	private CarMakeService carMakeService;
	
	private String name;

	private List<CarMake> carMakeList;

	// 列表
	public String list() {
		carMakeList = carMakeService.getAllList();
		return LIST;
	}

	// 保存
	public String save() {
		CarMake carMake = new CarMake();
		carMake.setName(name);
		carMakeService.save(carMake);
		return ajax(Status.success, "添加成功!");
	}

	public List<CarMake> getCarMakeList() {
		return carMakeList;
	}

	public void setCarMakeList(List<CarMake> carMakeList) {
		this.carMakeList = carMakeList;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
