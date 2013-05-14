package net.shopxx.action.admin;

import java.util.List;

import javax.annotation.Resource;

import net.shopxx.entity.CarStyle;
import net.shopxx.service.CarStyleService;

import org.apache.struts2.convention.annotation.ParentPackage;

@ParentPackage("admin")
public class CarStyleAction extends BaseAdminAction {

	private static final long serialVersionUID = 7812111672086577949L;

	@Resource(name = "carStyleServiceImpl")
	private CarStyleService carStyleService;
	
	private CarStyle carStyle;

	private List<CarStyle> carStyleList;
	
	public String list(){
		carStyleList = carStyleService.getCarStyleList(carStyle.getCarModeId());
		return ajax(carStyleList);
	}

	// 保存
	public String save() {
		carStyleService.save(carStyle);
		return ajax(Status.success, "添加成功!");
	}

	public CarStyle getCarStyle() {
		return carStyle;
	}

	public void setCarStyle(CarStyle carStyle) {
		this.carStyle = carStyle;
	}

	public List<CarStyle> getCarStyleList() {
		return carStyleList;
	}

	public void setCarStyleList(List<CarStyle> carStyleList) {
		this.carStyleList = carStyleList;
	}

}
