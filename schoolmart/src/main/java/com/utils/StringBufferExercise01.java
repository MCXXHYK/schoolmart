package com.yk.stringbuffer_;

import java.util.Scanner;

/**
 * @author YK
 * @version 1.0
 */
public class StringBufferExercise01 {
    public static void main(String[] args) {
        System.out.println("Hello, Git!");
	System.out.print("请输入商品名：");
        Scanner scanner = new Scanner(System.in);
        String name = scanner.next();
        System.out.print("请输入商品价格：");
        String price_ = scanner.next();
        StringBuffer price = new StringBuffer(price_);
        for (int i = price.lastIndexOf(".") - 3; i > 0; i -= 3) {
            price.insert(i, ",");
        }
        System.out.println(price);
    }
}


/*
*   输入商品名称和商品价格，要求打印效果示例，使用前面学习的方法完成：
    商品名 商品价格
    手机 123,564.59 //比如价格 3,456,789.88
* */
