package com.softeem.easybuy.util;

import java.util.List;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.softeem.esaybuy.dto.Cart;

public class JsonUtils {

	private static Gson gson = new Gson();
	
	private JsonUtils() {
	}
	
	public static String toJson(Object obj){
		return gson.toJson(obj);
	}
	
	public static List<Cart> getCarts(String json){
		return gson.fromJson(json, new TypeToken<List<Cart>>(){}.getType());
	}
}
