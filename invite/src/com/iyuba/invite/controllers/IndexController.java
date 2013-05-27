package com.iyuba.invite.controllers;

import java.util.UUID;

import net.paoding.rose.web.Invocation;
import net.paoding.rose.web.annotation.Path;
import net.paoding.rose.web.annotation.rest.Get;

import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.iyuba.invite.dao.InviteConfigDAO;
import com.iyuba.invite.dao.InviteRequestDAO;
import com.iyuba.invite.model.InviteConfig;
import com.iyuba.invite.model.InviteType;
import com.iyuba.invite.util.CookieOperation;

@Path("")
public class IndexController {
	@Autowired
	Invocation inv;
	
	@Autowired
	InviteConfigDAO inviteConfigDAO;
	@Autowired
	InviteRequestDAO inviteRequestDAO;
	
	@Get
	public String index() {
		int hostId = NumberUtils.toInt(CookieOperation.getCookieParamWithUserID(inv.getRequest()));
		InviteConfig linkConfig = inviteConfigDAO.get(hostId, InviteType.LINK.getValue());
		if (linkConfig == null) {
			linkConfig = new InviteConfig();
			linkConfig.setUid(hostId);
			linkConfig.setType(InviteType.LINK.getValue());
			linkConfig.setToken(UUID.randomUUID().toString());
			inviteConfigDAO.insert(linkConfig);
		}
		InviteConfig emailConfig = inviteConfigDAO.get(hostId, InviteType.EMAIL.getValue());
		if (emailConfig == null) {
			emailConfig = new InviteConfig();
			emailConfig.setUid(hostId);
			emailConfig.setType(InviteType.LINK.getValue());
			emailConfig.setToken(UUID.randomUUID().toString());
			inviteConfigDAO.insert(emailConfig);
		}
		inv.addModel("linkConfig", linkConfig);
		inv.addModel("emailConfig", linkConfig);
		return "invite";
	}
}
