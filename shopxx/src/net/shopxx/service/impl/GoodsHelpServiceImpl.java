package net.shopxx.service.impl;

import java.io.File;
import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import net.shopxx.bean.GoodsHelp;
import net.shopxx.bean.Setting;
import net.shopxx.service.GoodsHelpService;
import net.shopxx.util.ImageUtil;
import net.shopxx.util.SettingUtil;

import org.apache.commons.io.FileUtils;
import org.springframework.core.task.TaskExecutor;
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
	
	@Resource(name = "taskExecutor")
	private TaskExecutor taskExecutor;
	
	private ServletContext servletContext;
	
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}
	
	public GoodsHelp uploadGoodsHelp(String id, File goodsHelpFile, String suffix) {
		Setting setting = SettingUtil.getSetting();
		GoodsHelp goodsHelp = new GoodsHelp();
		goodsHelp.setId(id);
		// 设置帮助文件上传目录
		goodsHelp.setFilePath(setting.getFileUploadRealPath());
		// 获取帮助文件全路径
		String path = goodsHelp.getHelpFilePath(suffix);
		File sourceGoodsHelpFile = new File(servletContext.getRealPath(path));
		goodsHelp.setFilePath(path);
		
		File sourceGoodsHelpFileDir = sourceGoodsHelpFile.getParentFile();

		if (!sourceGoodsHelpFileDir.isDirectory()) {
			sourceGoodsHelpFileDir.mkdirs();
		}
		
		try {
			FileUtils.copyFile(goodsHelpFile, sourceGoodsHelpFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return goodsHelp;
	}
	
	public GoodsHelp uploadGoodsHelpThumbnail(String id, File goodsHelpThumbnail) {
		Setting setting = SettingUtil.getSetting();
		
		GoodsHelp goodsHelp = new GoodsHelp();
		goodsHelp.setId(id);
		goodsHelp.setFileThumbnail(setting.getImageUploadRealPath());
		// 获取图片文件格式
		goodsHelp.setSourceImageFormatName(ImageUtil.getFormatName(goodsHelpThumbnail));
		
		File sourceFile = new File(servletContext.getRealPath(goodsHelp.getSourceImagePath()));
		File thumbnailFile = new File(servletContext.getRealPath(goodsHelp.getThumbnailImagePath()));
		
		File sourceFileDir = sourceFile.getParentFile();
		File thumbnailFileDir = thumbnailFile.getParentFile();

		if (!sourceFileDir.isDirectory()) {
			sourceFileDir.mkdirs();
		}
		if (!thumbnailFileDir.isDirectory()) {
			thumbnailFileDir.mkdirs();
		}
		
		try {
			FileUtils.copyFile(goodsHelpThumbnail, sourceFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		addBuildTask(sourceFile, thumbnailFile, setting);
		return goodsHelp;
	}
	
	/**
	 * 添加图片处理任务
	 * @param sourceFile 原图片文件
	 * @param thumbnailFile 图片文件(缩略)
	 * @param setting 系统设置
	 */
	private void addBuildTask(final File sourceFile, final File thumbnailFile, final Setting setting) {
		try {
			taskExecutor.execute(
				new Runnable() {
					public void run() {
						ImageUtil.zoom(sourceFile, thumbnailFile, setting.getThumbnailGoodsImageWidth(), setting.getThumbnailGoodsImageHeight());
					}
				}
			);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}