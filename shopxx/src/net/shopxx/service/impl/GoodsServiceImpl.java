package net.shopxx.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.shopxx.bean.Pager;
import net.shopxx.bean.Pager.Order;
import net.shopxx.dao.GoodsDao;
import net.shopxx.entity.Brand;
import net.shopxx.entity.Goods;
import net.shopxx.entity.GoodsAttribute;
import net.shopxx.entity.GoodsCategory;
import net.shopxx.entity.Member;
import net.shopxx.service.GoodsService;

import org.apache.commons.lang.StringUtils;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.BooleanClause.Occur;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.FuzzyQuery;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.SortField;
import org.apache.lucene.search.TermQuery;
import org.apache.lucene.util.Version;
import org.hibernate.search.FullTextQuery;
import org.hibernate.search.FullTextSession;
import org.hibernate.search.Search;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springmodules.cache.annotations.CacheFlush;
import org.springmodules.cache.annotations.Cacheable;
import org.wltea.analyzer.lucene.IKAnalyzer;

/**
 * Service实现类 - 商品
 * ============================================================================
 * 版权所有 2008-2010 长沙鼎诚软件有限公司,并保留所有权利。
 * ----------------------------------------------------------------------------
 * 提示：在未取得SHOP++商业授权之前,您不能将本软件应用于商业用途,否则SHOP++将保留追究的权力。
 * ----------------------------------------------------------------------------
 * 官方网站：http://www.shopxx.net
 * ----------------------------------------------------------------------------
 * KEY: SHOPXX603F6052C7BD6E1C6113519369127127
 * ============================================================================
 */

@Service("goodsServiceImpl")
public class GoodsServiceImpl extends BaseServiceImpl<Goods, String> implements GoodsService {
	
	private static final float FUZZY_QUERY_MINIMUM_SIMILARITY = 0.5F;// 模糊查询最小相似度

	@Resource(name = "goodsDaoImpl")
	private GoodsDao goodsDao;

	@Resource(name = "goodsDaoImpl")
	public void setBaseDao(GoodsDao goodsDao) {
		super.setBaseDao(goodsDao);
	}
	
	@Transactional(readOnly = true)
	public boolean isExistByGoodsSn(String goodsSn) {
		return goodsDao.isExistByGoodsSn(goodsSn);
	}
	
	@Transactional(readOnly = true)
	public boolean isUniqueByGoodsSn(String oldGoodsSn, String newGoodsSn) {
		if (StringUtils.equalsIgnoreCase(oldGoodsSn, newGoodsSn)) {
			return true;
		} else {
			if (goodsDao.isExistByGoodsSn(newGoodsSn)) {
				return false;
			} else {
				return true;
			}
		}
	}
	
	@Cacheable(modelId = "goodsCaching")
	@Transactional(readOnly = true)
	public List<Goods> getGoodsList(GoodsCategory goodsCategory, String type, boolean isContainChildren, Integer maxResults) {
		return goodsDao.getGoodsList(goodsCategory, type, isContainChildren, maxResults);
	}
	
	@Transactional(readOnly = true)
	public List<Goods> getGoodsList(GoodsCategory goodsCategory, Date beginDate, Date endDate, Integer firstResult, Integer maxResults) {
		return goodsDao.getGoodsList(goodsCategory, beginDate, endDate, firstResult, maxResults);
	}
	
	@Transactional(readOnly = true)
	public Pager getGoodsPager(GoodsCategory goodsCategory, Pager pager) {
		return goodsDao.getGoodsPager(goodsCategory, pager);
	}
	
	@Transactional(readOnly = true)
	public Pager getGoodsPager(GoodsCategory goodsCategory, Brand brand, Map<GoodsAttribute, String> goodsAttributeMap, Pager pager) {
		return goodsDao.getGoodsPager(goodsCategory, brand, goodsAttributeMap, pager);
	}
	
	@Transactional(readOnly = true)
	public Pager getFavoriteGoodsPager(Member member, Pager pager) {
		return goodsDao.getFavoriteGoodsPager(member, pager);
	}
	
	@Transactional(readOnly = true)
	public Long getMarketableGoodsCount() {
		return goodsDao.getMarketableGoodsCount();
	}
	
	@Transactional(readOnly = true)
	public List<Goods> getGoodsListByIds(List<String> ids) {
		return goodsDao.getGoodsListByIds(ids);
	}
	
	@Transactional(readOnly = true)
	public Long getUnMarketableGoodsCount() {
		return goodsDao.getUnMarketableGoodsCount();
	}
	
	public Pager search(Pager pager) {
		String keyword = pager.getKeyword();
		try {
			String text = QueryParser.escape(keyword);
			QueryParser nameParser = new QueryParser(Version.LUCENE_31, "name", new IKAnalyzer());
			nameParser.setDefaultOperator(QueryParser.AND_OPERATOR);
			Query nameQuery = nameParser.parse(text);
			FuzzyQuery nameFuzzyQuery = new FuzzyQuery(new Term("name", text), FUZZY_QUERY_MINIMUM_SIMILARITY);
			TermQuery introductionQuery = new TermQuery(new Term("introduction", text));
			TermQuery isMarketableQuery = new TermQuery(new Term("isMarketable", "true"));
			BooleanQuery textQuery = new BooleanQuery();
			BooleanQuery query = new BooleanQuery();
			textQuery.add(nameQuery, Occur.SHOULD);
			textQuery.add(nameFuzzyQuery, Occur.SHOULD);
			textQuery.add(introductionQuery, Occur.SHOULD);
			query.add(isMarketableQuery, Occur.MUST);
			query.add(textQuery, Occur.MUST);
			FullTextSession fullTextSession = Search.getFullTextSession(goodsDao.getSession());
			FullTextQuery fullTextQuery = fullTextSession.createFullTextQuery(query, Goods.class);
			String orderBy = pager.getOrderBy();
			Order order = pager.getOrder();
			SortField[] sortFields = null;
			if (StringUtils.equalsIgnoreCase(orderBy, "price")) {
				if (order == Order.asc) {
					sortFields = new SortField[] { new SortField("price", SortField.DOUBLE, false), new SortField("modifyDate", SortField.LONG, true) };
				} else {
					sortFields = new SortField[] { new SortField("price", SortField.DOUBLE, true), new SortField("modifyDate", SortField.LONG, true) };
				}
			} else if (StringUtils.equalsIgnoreCase(orderBy, "createDate")) {
				if (order == Order.asc) {
					sortFields = new SortField[] { new SortField("createDate", SortField.LONG, false) };
				} else {
					sortFields = new SortField[] { new SortField("createDate", SortField.LONG, true) };
				}
			} else if (StringUtils.equalsIgnoreCase(orderBy, "salesDesc")) {
				if (order == Order.asc) {
					sortFields = new SortField[] { new SortField("totalSales", SortField.LONG, false) };
				} else {
					sortFields = new SortField[] { new SortField("totalSales", SortField.LONG, true) };
				}
			} else if (StringUtils.equalsIgnoreCase(orderBy, "discountAsc")) {
				if (order == Order.asc) {
					sortFields = new SortField[] { new SortField("discount", SortField.LONG, false) };
				} else {
					sortFields = new SortField[] { new SortField("discount", SortField.LONG, true) };
				}
			}
			else {
				sortFields = new SortField[] { new SortField("isBest", SortField.STRING, true), new SortField(null, SortField.SCORE), new SortField("modifyDate", SortField.LONG, true) };
			}
			fullTextQuery.setSort(new Sort(sortFields));
			fullTextQuery.setFirstResult((pager.getPageNumber() - 1) * pager.getPageSize());
			fullTextQuery.setMaxResults(pager.getPageSize());
			pager.setTotalCount(fullTextQuery.getResultSize());
			pager.setResult(fullTextQuery.list());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pager;
	}
	
	public void index(Goods goods) {
		FullTextSession fullTextSession = Search.getFullTextSession(goodsDao.getSession());
		fullTextSession.index(goods);
	}
	
	public void index() {
		List<Goods> goods = goodsDao.getAllList();
		FullTextSession fullTextSession = Search.getFullTextSession(goodsDao.getSession());
		for (Goods good : goods) {
			fullTextSession.index(good);
		}
	}

	@Override
	@CacheFlush(modelId = "goodsFlushing")
	public void delete(Goods goods) {
		super.delete(goods);
	}

	@Override
	@CacheFlush(modelId = "goodsFlushing")
	public void delete(String id) {
		super.delete(id);
	}

	@Override
	@CacheFlush(modelId = "goodsFlushing")
	public void delete(String[] ids) {
		super.delete(ids);
	}

	@Override
	@CacheFlush(modelId = "goodsFlushing")
	public String save(Goods goods) {
		return super.save(goods);
	}

	@Override
	@CacheFlush(modelId = "goodsFlushing")
	public void update(Goods goods) {
		super.update(goods);
	}

}