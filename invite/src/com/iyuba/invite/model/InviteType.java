package com.iyuba.invite.model;

public enum InviteType {
	LINK(0), EMAIL(1);
	private int value;
	private InviteType(int value) {
		this.value = value;
	}
	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	}
}
