package net.shopxx.bean;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

/**
 * Bean类 - 商品帮助文件
 */

@JsonIgnoreProperties(value = { "sourceImagePath", "helpFilePath", "thumbnailImagePath", "sourceImageFormatName", "fileSuffix" })
public class GoodsHelp implements Comparable<GoodsHelp> {

	public static final String IMAGE_PATH_SEPARATOR = "/";// 图片路径分隔符
	public static final String DESTINATION_IMAGE_FORMAT_NAME = "jpg";// 目标图片格式名称
	public static final String SOURCE_IMAGE_FOLDER_NAME = "source";// 图片（原）文件保存目录
	public static final String BIG_IMAGE_FOLDER_NAME = "big";// 图片（大）文件保存目录
	public static final String SMALL_IMAGE_FOLDER_NAME = "small";// 图片（小）文件保存目录
	public static final String THUMBNAIL_IMAGE_FOLDER_NAME = "thumbnail";// 图文（缩略）保存目录

	private String id;// ID
	private String filePath;// 文件路径
	private String fileSuffix;// 文件后缀
	private String name;// 文件名字
	private String fileThumbnail;// 缩略图
	private String sourceImageFormatName;// 缩略图格式
	private Integer orderList;// 排序

	// 获取帮助文件路径
	public String getHelpFilePath(String prefix) {
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append(filePath);
		stringBuffer.append(IMAGE_PATH_SEPARATOR);
		stringBuffer.append(id);
		stringBuffer.append(".");
		stringBuffer.append(prefix);
		return stringBuffer.toString();
	}

	// 获得缩略图（原）路径
	public String getSourceImagePath() {
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append(fileThumbnail);
		stringBuffer.append(IMAGE_PATH_SEPARATOR);
		stringBuffer.append(SOURCE_IMAGE_FOLDER_NAME);
		stringBuffer.append(IMAGE_PATH_SEPARATOR);
		stringBuffer.append(id);
		stringBuffer.append(".");
		stringBuffer.append(sourceImageFormatName);
		return stringBuffer.toString();
	}

	// 获得缩略图（缩略）路径
	public String getThumbnailImagePath() {
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append(fileThumbnail);
		stringBuffer.append(IMAGE_PATH_SEPARATOR);
		stringBuffer.append(THUMBNAIL_IMAGE_FOLDER_NAME);
		stringBuffer.append(IMAGE_PATH_SEPARATOR);
		stringBuffer.append(id);
		stringBuffer.append(".");
		stringBuffer.append(DESTINATION_IMAGE_FORMAT_NAME);
		return stringBuffer.toString();
	}

	@Override
	public boolean equals(Object object) {
		if (object == null) {
			return false;
		}
		if (object instanceof GoodsHelp) {
			GoodsHelp goodsImage = (GoodsHelp) object;
			if (this.getId() == null || goodsImage.getId() == null) {
				return false;
			} else {
				return (this.getId().equals(goodsImage.getId()));
			}
		}
		return false;
	}

	@Override
	public int hashCode() {
		return id == null ? System.identityHashCode(this) : (this.getClass().getName() + this.getId()).hashCode();
	}

	public int compareTo(GoodsHelp goodsImage) {
		if (goodsImage.getOrderList() == null) {
			return 1;
		}
		if (this.getOrderList() == null) {
			return -1;
		}
		return this.getOrderList().compareTo(goodsImage.getOrderList());
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileSuffix() {
		return fileSuffix;
	}

	public void setFileSuffix(String fileSuffix) {
		this.fileSuffix = fileSuffix;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFileThumbnail() {
		return fileThumbnail;
	}

	public void setFileThumbnail(String fileThumbnail) {
		this.fileThumbnail = fileThumbnail;
	}

	public String getSourceImageFormatName() {
		return sourceImageFormatName;
	}

	public void setSourceImageFormatName(String sourceImageFormatName) {
		this.sourceImageFormatName = sourceImageFormatName;
	}

	public Integer getOrderList() {
		return orderList;
	}

	public void setOrderList(Integer orderList) {
		this.orderList = orderList;
	}

}