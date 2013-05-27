package com.iyuba.invite.dao;

import com.iyuba.invite.model.InviteRequest;

import net.paoding.rose.jade.annotation.DAO;
import net.paoding.rose.jade.annotation.SQL;

@DAO
public interface InviteRequestDAO {
	@SQL("insert into invite_request(uid, type, target, create_time) values(:1.uid, :1.type, :1.target, now())")
	public void insert(InviteRequest request);
}
