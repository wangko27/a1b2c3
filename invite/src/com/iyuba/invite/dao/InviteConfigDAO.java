package com.iyuba.invite.dao;

import com.iyuba.invite.model.InviteConfig;

import net.paoding.rose.jade.annotation.DAO;
import net.paoding.rose.jade.annotation.SQL;

@DAO
public interface InviteConfigDAO {
	@SQL("insert into invite_config(uid, token, type) values(:1.uid, :1.token, :1.type)")
	public void insert(InviteConfig config);
	
	@SQL("select * from invite_config where uid = :1 and type = :2")
	public InviteConfig get(int uid, int type);
}
