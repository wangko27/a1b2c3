package net.shopxx.action.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.shopxx.bean.Pager;
import net.shopxx.bean.Setting;
import net.shopxx.util.CookieUtils;
import net.shopxx.util.JsonUtil;
import net.shopxx.util.SettingUtil;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import freemarker.ext.beans.BeansWrapper;
import freemarker.ext.beans.ResourceBundleModel;

/**
 * 后台Action类 - 后台基类
 * ============================================================================
 * 版权所有 2008-2010 长沙鼎诚软件有限公司,并保留所有权利。
 * ----------------------------------------------------------------------------
 * 提示：在未取得SHOP++商业授权之前,您不能将本软件应用于商业用途,否则SHOP++将保留追究的权力。
 * ----------------------------------------------------------------------------
 * 官方网站：http://www.shopxx.net
 * ----------------------------------------------------------------------------
 * KEY: SHOPXX2D71BE456F7F0EC9ACE75DCA35586C62
 * ============================================================================
 */

public class BaseAdminAction extends ActionSupport {

	private static final long serialVersionUID = 6718838822334455667L;
	
	private static final String HEADER_ENCODING = "UTF-8";
	private static final boolean HEADER_NO_CACHE = true;
	private static final String HEADER_TEXT_CONTENT_TYPE = "text/plain";
	private static final String HEADER_JSON_CONTENT_TYPE = "text/plain";
	
	public static final String VIEW = "view";
	public static final String LIST = "list";
	public static final String SUCCESS = "success";
	public static final String ERROR = "error";
	public static final String REDIRECT = "redirect";
	
	public static final String STATUS_PARAMETER_NAME = "status";// 操作状态参数名称
	public static final String MESSAGE_PARAMETER_NAME = "message";// 操作消息参数名称
	
	// 操作状态（警告、错误、成功）
	public enum Status {
		warn, error, success
	}
	
	protected String id;
	protected String[] ids;
	protected Pager pager = new Pager();
	protected String logInfo;// 日志记录信息
	protected String redirectUrl;// 跳转URL
	
	protected ResourceBundleModel bundle;
	
	{
		ResourceBundle resourceBundle = ResourceBundle.getBundle("i18n");
		bundle = new ResourceBundleModel(resourceBundle, new BeansWrapper());
	}
	
	public String input() {
		return NONE;
	}

	// 获取系统配置信息
	public Setting getSetting() {
		return SettingUtil.getSetting();
	}
	
	// 获取货币格式字符串
	public String getCurrencyFormat() {
		return SettingUtil.getCurrencyFormat();
	}
	
	// 判断是否为添加
	public Boolean getIsAddAction() {
		if (id == null) {
			return true;
		} else {
			return false;
		}
	}
	
	// 判断是否为编辑
	public Boolean getIsEditAction() {
		if (id != null) {
			return true;
		} else {
			return false;
		}
	}
	
	// 获取Request
	protected HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	// 获取Response
	protected HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}

	// 获取ServletContext
	protected ServletContext getServletContext() {
		return ServletActionContext.getServletContext();
	}

	// 获取Attribute
	protected Object getAttribute(String name) {
		return ServletActionContext.getRequest().getAttribute(name);
	}

	// 设置Attribute
	protected void setAttribute(String name, Object value) {
		ServletActionContext.getRequest().setAttribute(name, value);
	}

	// 获取Parameter
	protected String getParameter(String name) {
		return ServletActionContext.getRequest().getParameter(name);
	}

	// 获取Parameter数组
	protected String[] getParameterValues(String name) {
		return ServletActionContext.getRequest().getParameterValues(name);
	}

	// 获取Session
	protected Object getSession(String name) {
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		return session.get(name);
	}
	
	// 设置Session
	protected void setSession(String name, Object value) {
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		session.put(name, value);
	}

	// 移除Session
	protected void removeSession(String name) {
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		session.remove(name);
	}
	
	// 获取Cookie
	protected String getCookie(String name) {
		return CookieUtils.getCookie(ServletActionContext.getRequest(), name);
	}
	
	// 设置Cookie
	protected void setCookie(String name, String value) {
 		CookieUtils.addCookie(ServletActionContext.getRequest(), ServletActionContext.getResponse(), name, value, ServletActionContext.getRequest().getContextPath() + "/");
	}
	
	// 设置Cookie
	protected void setCookie(String name, String value, Integer maxAge) {
 		CookieUtils.addCookie(ServletActionContext.getRequest(), ServletActionContext.getResponse(), name, value, ServletActionContext.getRequest().getContextPath() + "/", maxAge, null, null);
	}

	// 移除Cookie
	protected void removeCookie(String name) {
		CookieUtils.removeCookie(ServletActionContext.getRequest(), ServletActionContext.getResponse(), name, ServletActionContext.getRequest().getContextPath() + "/");
	}

	// 获取真实路径
	protected String getRealPath(String path) {
		return ServletActionContext.getServletContext().getRealPath(path);
	}
	
	// 获取ContextPath
	protected String getContextPath() {
		return ServletActionContext.getRequest().getContextPath();
	}

	// AJAX输出
	protected String ajax(String content, String contentType) {
		try {
			HttpServletResponse response = initResponse(contentType);
			response.getWriter().write(content);
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return NONE;
	}

	// 根据文本内容输出AJAX
	protected String ajax(String text) {
		return ajax(text, HEADER_TEXT_CONTENT_TYPE);
	}
	
	// 根据操作状态输出AJAX
	protected String ajax(Status status) {
		HttpServletResponse response = initResponse(HEADER_JSON_CONTENT_TYPE);
		Map<String, String> jsonMap = new HashMap<String, String>();
		jsonMap.put(STATUS_PARAMETER_NAME, status.toString());
		JsonUtil.toJson(response, jsonMap);
		return NONE;
	}
	
	// 根据操作状态、消息内容输出AJAX
	protected String ajax(Status status, String message) {
		HttpServletResponse response = initResponse(HEADER_JSON_CONTENT_TYPE);
		Map<String, String> jsonMap = new HashMap<String, String>();
		jsonMap.put(STATUS_PARAMETER_NAME, status.toString());
		jsonMap.put(MESSAGE_PARAMETER_NAME, message);
		JsonUtil.toJson(response, jsonMap);
		return NONE;
	}
	
	// 根据Object输出AJAX
	protected String ajax(Object object) {
		HttpServletResponse response = initResponse(HEADER_JSON_CONTENT_TYPE);
			JsonUtil.toJson(response, object);
		return NONE;
	}
	
	// 根据boolean状态输出AJAX
	protected String ajax(boolean booleanStatus) {
		HttpServletResponse response = initResponse(HEADER_JSON_CONTENT_TYPE);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put(STATUS_PARAMETER_NAME, booleanStatus);
		JsonUtil.toJson(response, jsonMap);
		return NONE;
	}
	
	private HttpServletResponse initResponse(String contentType) {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(contentType + ";charset=" + HEADER_ENCODING);
		if (HEADER_NO_CACHE) {
			response.setDateHeader("Expires", 1L);
			response.addHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache, no-store, max-age=0");
		}
		return response;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String[] getIds() {
		return ids;
	}

	public void setIds(String[] ids) {
		this.ids = ids;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public String getLogInfo() {
		return logInfo;
	}

	public void setLogInfo(String logInfo) {
		this.logInfo = logInfo;
	}

	public String getRedirectUrl() {
		return redirectUrl;
	}

	public void setRedirectUrl(String redirectUrl) {
		this.redirectUrl = redirectUrl;
	}

	public ResourceBundleModel getBundle() {
		return bundle;
	}

	public void setBundle(ResourceBundleModel bundle) {
		this.bundle = bundle;
	}
}