package com.iyuba.invite.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class CookieOperation {
	/**
	 * 此方法为 cookie 中获取 iyuba 用户名
	 * @param request
	 * @return 若数据不存在则返回 null
	 */
	public static String getCookieParamWithUsername(HttpServletRequest request) {
		String username = null;
		
		Cookie [] cookies = request.getCookies();
		if (cookies != null && cookies.length > 0) {
			// 查找cookie
			username = getCookieValue(cookies, "iyuba_ZH");
		}
		return username;
	}
	
	/**
	 * 此方法为 cookie 中获取 iyuba 用户ID
	 * @param request
	 * @return 若数据不存在则返回 null
	 */
	public static String getCookieParamWithUserID(HttpServletRequest request) {
		String username = null;
		
		Cookie [] cookies = request.getCookies();
		if (cookies != null && cookies.length > 0) {
			// 查找cookie
			username = getCookieValue(cookies, "iyuba_ID");
		}
		return username;
//		return "890";
	}
	
	/**
	 * 此方法为 cookie 中获取 iyuba 密码
	 * @param request
	 * @return 若数据不存在则返回 null
	 */
	public static String getCookieParamWithPassword(HttpServletRequest request) {
		String password = null;
		
		Cookie [] cookies = request.getCookies();
		if (cookies != null && cookies.length > 0) {
			// 查找cookie
			password = getCookieValue(cookies, "iyuba_MM");
		}
		return password;
	}
	
	/**
	 * 此方法为 cookie 中获取某一个数据
	 * @param request
	 * @return 若数据不存在则返回 null
	 */
	public static String getCookieParamWithOther(HttpServletRequest request, String cookieName) {
		String cookieValue = null;
		
		Cookie [] cookies = request.getCookies();
		if (cookies != null && cookies.length > 0) {
			// 查找cookie
			cookieValue = getCookieValue(cookies, cookieName);
		}
		return cookieValue;
	}
	
	public static String getCookieValue(Cookie[] cookies, String str) {
		String result = null;
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(str)) {
				result = cookie.getValue();
				break;
			}
		}
		return result;
	}
}