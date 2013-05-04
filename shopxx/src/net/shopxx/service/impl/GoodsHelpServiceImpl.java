package net.shopxx.service.impl;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;

import net.shopxx.bean.GoodsHelp;
import net.shopxx.bean.Setting;
import net.shopxx.service.GoodsHelpService;
import net.shopxx.util.CommonUtil;
import net.shopxx.util.SettingUtil;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ServletContextAware;

/**
 * Service实现类 - 商品帮助文件
 * ============================================================================
 * 版权所有 2008-2010 长沙鼎诚软件有限公司,并保留所有权利。
 * ----------------------------------------------------------------------------
 * 提示：在未取得SHOP++商业授权之前,您不能将本软件应用于商业用途,否则SHOP++将保留追究的权力。
 * ----------------------------------------------------------------------------
 * 官方网站：http://www.shopxx.net
 * ----------------------------------------------------------------------------
 * KEY: SHOPXX69F2EBC7A6A837BABDA5487C75D38611
 * ============================================================================
 */

@Service("goodsHelpServiceImpl")
public class GoodsHelpServiceImpl implements GoodsHelpService, ServletContextAware {
	
	private ServletContext servletContext;
	
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}
	
	public GoodsHelp uploadGoodsHelp(File goodsHelpFile, String suffix) {
		Setting setting = SettingUtil.getSetting();
		String uuid = CommonUtil.getUUID();
		GoodsHelp goodsHelp = new GoodsHelp();
		goodsHelp.setId(uuid);
		goodsHelp.setPath(setting.getImageUploadRealPath());
		String path = goodsHelp.getSourceImagePath(suffix);
		File sourceGoodsHelpFile = new File(servletContext.getRealPath(path));
		goodsHelp.setPath(path);
		File sourceGoodsImageParentFile = sourceGoodsHelpFile.getParentFile();

		if (!sourceGoodsImageParentFile.isDirectory()) {
			sourceGoodsImageParentFile.mkdirs();
		}
		
		try {
			FileUtils.copyFile(goodsHelpFile, sourceGoodsHelpFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return goodsHelp;
	}

}