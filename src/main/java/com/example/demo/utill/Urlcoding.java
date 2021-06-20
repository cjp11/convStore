package com.example.demo.utill;

import org.apache.commons.codec.binary.Base64;

public class Urlcoding {
	
	public String urlincode(String url) {
		
		byte[] encoded = Base64.encodeBase64(url.getBytes());
		String urlencoded = new String(encoded);
		
		return urlencoded;
	}
	
	public String urlDecode(String url) {
		byte[] decoded = Base64.decodeBase64(url.getBytes());
		String urlencoded = new String(decoded);
		return urlencoded;
	}
	
}
