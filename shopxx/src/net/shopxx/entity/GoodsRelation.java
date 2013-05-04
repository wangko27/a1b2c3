package net.shopxx.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import org.hibernate.search.annotations.Indexed;

/**
 * 实体类 - 商品关系（相关产品或组成部件）
 * ============================================================================
 * 版权所有 2008-2010 长沙鼎诚软件有限公司,并保留所有权利。
 * ----------------------------------------------------------------------------
 * 提示：在未取得SHOP++商业授权之前,您不能将本软件应用于商业用途,否则SHOP++将保留追究的权力。
 * ----------------------------------------------------------------------------
 * 官方网站：http://www.shopxx.net
 * ----------------------------------------------------------------------------
 * KEY: SHOPXXA422025AB3BAEE5940EB4488D12B6691
 * ============================================================================
 */

@Indexed
@Entity
public class GoodsRelation extends BaseEntity {

	private static final long serialVersionUID = 977601875020048056L;
	
	private String parentId;// 大商品ID
	private String childId;// 组件ID或相关产品ID
	private Integer orderList;// 顺序
	private Integer type;// 关系类型：0-组件 1-相关产品

	@Column(nullable = false)
	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	@Column(nullable = false)
	public String getChildId() {
		return childId;
	}

	public void setChildId(String childId) {
		this.childId = childId;
	}
	
	@Column(nullable = false)
	public Integer getOrderList() {
		return orderList;
	}

	public void setOrderList(Integer orderList) {
		this.orderList = orderList;
	}

	@Column(nullable = false)
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
}