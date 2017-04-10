package com.softeem.easybuy.util;

/**
 * 订单状态常量
 * @author MRChai
 *
 */
public class OrderStatus {

	/**
	 * 未支付
	 */
	public static final int UNPAY = 0;
	/**
	 * 已支付
	 */
	public static final int PAYED = 1;
	/**
	 * 待发货
	 */
	public static final int PREPARE_SEND = 2;
	/**
	 * 已发货
	 */
	public static final int SENDED = 3;
	/**
	 * 已收货
	 */
	public static final int COMPLETE = 4;
	
	/**
	 * 办理退货
	 */
	public static final int RETURN = 7;
	/**
	 * 退货中
	 */
	public static final int RETURNING = 8;
	/**
	 * 退货完成
	 */
	public static final int RETURNED = 9;
}
