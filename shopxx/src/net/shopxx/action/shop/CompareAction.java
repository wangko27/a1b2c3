package net.shopxx.action.shop;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.shopxx.entity.Goods;
import net.shopxx.service.GoodsService;

import org.apache.struts2.convention.annotation.ParentPackage;

import com.opensymphony.xwork2.interceptor.annotations.InputConfig;
import com.opensymphony.xwork2.validator.annotations.RequiredStringValidator;
import com.opensymphony.xwork2.validator.annotations.Validations;

@ParentPackage("shop")
public class CompareAction extends BaseShopAction {

	private static final long serialVersionUID = -6633911393693777393L;
	
	private String compareIds;
	private int resultSize = 0;
	private List<Goods> compareResultList;
	
	@Resource(name = "goodsServiceImpl")
	private GoodsService goodsService;

	@Validations(requiredStrings = { @RequiredStringValidator(fieldName = "compareIds", message = "参数错误!") })
	@InputConfig(resultName = "error")
	public String showSimple() {
		String[] compareId = compareIds.split(",");
		compareResultList = new ArrayList<Goods>();
		for(String id : compareId) {
			compareResultList.add(goodsService.load(id));
		}
		resultSize = compareResultList.size();
		return "simple";
	}
	
	@Validations(requiredStrings = { @RequiredStringValidator(fieldName = "compareIds", message = "参数错误!") })
	@InputConfig(resultName = "error")
	public String showResult() {
		String[] compareId = compareIds.split(",");
		compareResultList = new ArrayList<Goods>();
		for(String id : compareId) {
			compareResultList.add(goodsService.load(id));
		}
		return "result";
	}

	public String getCompareIds() {
		return compareIds;
	}

	public void setCompareIds(String compareIds) {
		this.compareIds = compareIds;
	}

	public int getResultSize() {
		return resultSize;
	}

	public void setResultSize(int resultSize) {
		this.resultSize = resultSize;
	}

	public List<Goods> getCompareResultList() {
		return compareResultList;
	}

	public void setCompareResultList(List<Goods> compareResultList) {
		this.compareResultList = compareResultList;
	}
}
