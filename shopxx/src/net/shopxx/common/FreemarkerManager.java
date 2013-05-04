package net.shopxx.common;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.ServletContext;

import net.shopxx.directive.ArticleCategoryListDirective;
import net.shopxx.directive.ArticleCategoryTreeDirective;
import net.shopxx.directive.ArticleListDirective;
import net.shopxx.directive.CheckboxDirective;
import net.shopxx.directive.CommentListDirective;
import net.shopxx.directive.FriendLinkListDirective;
import net.shopxx.directive.GoodsCategoryListDirective;
import net.shopxx.directive.GoodsCategoryTreeDirective;
import net.shopxx.directive.GoodsListDirective;
import net.shopxx.directive.InstantMessagingListDirective;
import net.shopxx.directive.NavigationListDirective;
import net.shopxx.directive.PaginationDirective;
import net.shopxx.directive.SubstringMethod;
import net.shopxx.util.SpringUtil;

import org.springframework.core.io.ClassPathResource;

import com.opensymphony.xwork2.util.logging.Logger;
import com.opensymphony.xwork2.util.logging.LoggerFactory;

import freemarker.template.Configuration;
import freemarker.template.TemplateException;

public class FreemarkerManager extends org.apache.struts2.views.freemarker.FreemarkerManager {

	private static final Logger LOG = LoggerFactory.getLogger(FreemarkerManager.class);

	@Override
	protected Configuration createConfiguration(ServletContext servletContext) throws TemplateException {
		Configuration configuration = super.createConfiguration(servletContext);
		
		SubstringMethod substringMethod = (SubstringMethod) SpringUtil.getBean("substringMethod");
		CheckboxDirective checkboxDirective = (CheckboxDirective) SpringUtil.getBean("checkboxDirective");
		PaginationDirective paginationDirective = (PaginationDirective) SpringUtil.getBean("paginationDirective");
		CommentListDirective commentListDirective = (CommentListDirective) SpringUtil.getBean("commentListDirective");
		NavigationListDirective navigationListDirective = (NavigationListDirective) SpringUtil.getBean("navigationListDirective");
		FriendLinkListDirective friendLinkListDirective = (FriendLinkListDirective) SpringUtil.getBean("friendLinkListDirective");
		InstantMessagingListDirective instantMessagingListDirective = (InstantMessagingListDirective) SpringUtil.getBean("instantMessagingListDirective");
		ArticleCategoryListDirective articleCategoryListDirective = (ArticleCategoryListDirective) SpringUtil.getBean("articleCategoryListDirective");
		ArticleCategoryTreeDirective articleCategoryTreeDirective = (ArticleCategoryTreeDirective) SpringUtil.getBean("articleCategoryTreeDirective");
		ArticleListDirective articleListDirective = (ArticleListDirective) SpringUtil.getBean("articleListDirective");
		GoodsCategoryListDirective goodsCategoryListDirective = (GoodsCategoryListDirective) SpringUtil.getBean("goodsCategoryListDirective");
		GoodsCategoryTreeDirective goodsCategoryTreeDirective = (GoodsCategoryTreeDirective) SpringUtil.getBean("goodsCategoryTreeDirective");
		GoodsListDirective goodsListDirective = (GoodsListDirective) SpringUtil.getBean("goodsListDirective");

		configuration.setSharedVariable(SubstringMethod.TAG_NAME, substringMethod);
		configuration.setSharedVariable(CheckboxDirective.TAG_NAME, checkboxDirective);
		configuration.setSharedVariable(PaginationDirective.TAG_NAME, paginationDirective);
		configuration.setSharedVariable(CommentListDirective.TAG_NAME, commentListDirective);
		configuration.setSharedVariable(NavigationListDirective.TAG_NAME, navigationListDirective);
		configuration.setSharedVariable(FriendLinkListDirective.TAG_NAME, friendLinkListDirective);
		configuration.setSharedVariable(InstantMessagingListDirective.TAG_NAME, instantMessagingListDirective);
		configuration.setSharedVariable(ArticleCategoryListDirective.TAG_NAME, articleCategoryListDirective);
		configuration.setSharedVariable(ArticleCategoryTreeDirective.TAG_NAME, articleCategoryTreeDirective);
		configuration.setSharedVariable(ArticleListDirective.TAG_NAME, articleListDirective);
		configuration.setSharedVariable(GoodsCategoryListDirective.TAG_NAME, goodsCategoryListDirective);
		configuration.setSharedVariable(GoodsCategoryTreeDirective.TAG_NAME, goodsCategoryTreeDirective);
		configuration.setSharedVariable(GoodsListDirective.TAG_NAME, goodsListDirective);

		return configuration;
	}

	@Override
	protected void loadSettings(ServletContext servletContext) {
		InputStream in = null;
		try {
			in = new ClassPathResource("freemarker.properties").getInputStream();
			if (in != null) {
				Properties p = new Properties();
				p.load(in);
				for (Object o : p.keySet()) {
					String name = (String) o;
					String value = (String) p.get(name);

					if (name == null) {
						throw new IOException("init-param without param-name.  Maybe the freemarker.properties is not well-formed?");
					}
					if (value == null) {
						throw new IOException("init-param without param-value.  Maybe the freemarker.properties is not well-formed?");
					}
					addSetting(name, value);
				}
			}
		} catch (IOException e) {
			LOG.error("Error while loading freemarker settings from /freemarker.properties", e);
		} catch (TemplateException e) {
			LOG.error("Error while loading freemarker settings from /freemarker.properties", e);
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException io) {
					if (LOG.isWarnEnabled()) {
						LOG.warn("Unable to close input stream", io);
					}
				}
			}
		}
	}

}