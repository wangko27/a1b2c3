package net.shopxx.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

/**
 * 实体类 - 适用车型
 */

@Entity
public class CarMake extends BaseEntity {

	private static final long serialVersionUID = -7879444120345126882L;
	private String name;// 名称

	@Column(nullable = false)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}