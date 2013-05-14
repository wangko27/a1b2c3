package net.shopxx.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

/**
 * 实体类 - 适用车型
 */

@Entity
public class CarStyle extends BaseEntity {

	private static final long serialVersionUID = -7879444120345126882L;
	private String carModeId;
	private String style;// 规格
	private Integer yearMade; // 生产年代

	@Column(nullable = false)
	public String getCarModeId() {
		return carModeId;
	}

	public void setCarModeId(String carModeId) {
		this.carModeId = carModeId;
	}

	@Column(nullable = false)
	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	@Column(nullable = false)
	public Integer getYearMade() {
		return yearMade;
	}

	public void setYearMade(Integer yearMade) {
		this.yearMade = yearMade;
	}
}