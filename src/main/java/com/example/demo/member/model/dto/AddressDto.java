package com.example.demo.member.model.dto;

public class AddressDto {
	private int address_no;
	private String member_id;
	private String address;
	private String zip_code;
	private int address_level;

	public AddressDto() {
		super();
	}

	public AddressDto(int address_no, String member_id, String address, String zip_code, int address_level) {
		super();
		this.address_no = address_no;
		this.member_id = member_id;
		this.address = address;
		this.zip_code = zip_code;
		this.address_level = address_level;
	}

	public int getAddress_no() {
		return address_no;
	}

	public void setAddress_no(int address_no) {
		this.address_no = address_no;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getZip_code() {
		return zip_code;
	}

	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}

	public int getAddress_level() {
		return address_level;
	}

	public void setAddress_level(int address_level) {
		this.address_level = address_level;
	}

	@Override
	public String toString() {
		return "Address [address_no=" + address_no + ", member_id=" + member_id + ", address=" + address + ", zip_code="
				+ zip_code + ", address_level=" + address_level + "]";
	}

}
