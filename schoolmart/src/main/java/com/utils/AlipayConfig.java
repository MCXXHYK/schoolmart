package com.utils;

import java.io.FileWriter;
import java.io.IOException;

public class AlipayConfig {

//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

    // 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
    public static String app_id = "2021000117645828";

    // 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCONBR6PaZhWBJ7GnA8dLJA0RZ6BgzjsL8OtYydE8eP40VqJc8J73BqHJ23qE4IGyG2XawX+AAl5Wk1upH0+lBMKCiLhSQeHDl0hHjLgBMF5EFfEsFFNAD9Ux9tElklc+B0CFSaDfz73fLKRxRVbs4j55zm4A1uIeNb3kgmv+31vKLtf60pf+KlloO3wurDFvDAdtrtVtPLnaIlp2HmqUWszqXzFbYJU+fAedd4LWLBd3AawYfrM76VV5dfRXKXie9Z5IRL+RwwP+sr8DklqsAQdmhAd4NA3qx0HWvLazKw0t6ZYkldHXfEg+We09PI7DrSul/jkEryI0ysT5ScnknvAgMBAAECggEAHeFtqB4KNww1ne55RQrUZfBJg8x/qtx52RJnAJ6mYWLFND/LmG/atEFdFrlj5ConVFWsksDG7y+cgvC4OLzcYJRTqLWKWFVf8U7gvwojdSp4Xgzn1a3Ow2xS/y1K1CbcNCWH+XMVBKunl7+F00ncQQkrHAxaZhjy2FwF1zafPvJbIwWdDOloGqXc3OlJFWN7gWL0kf9E5aLJYw8RPgFSedHYlhwXC0dKzBDOWmBKLpccMRzgUKQyB/z9S0dIDoT99mfpQqbpAcGXNgo6CakKz0AK14LL/tt5L/wOl2HGW5mSWR3kej81E4T/HyrbBylc6mQiKn+QC4BAb5E1uq3UaQKBgQDFXTt2C8Y59d1HLQAuIfvc1vCnyJ2ZKMgAW/LDKEWdXM7v8fy0uVw8D9Xs1KHHD7XgoMz4ACCZ3gzVmqRxeKdY2iJ7jGqGHk6AwldBOtBRKim0NC6dPrevOIvUWsg93Ewr6HxLPUGqYWDd0U5u92luNoh8KB9BdyBQhWkGHUoTywKBgQC4c4gCy3A12zSpx6O15+dc6q/SuBZ6NwUEVdOyVgQFzEQAllxyLsdHsFmpQVLTGBsmEXE3pPHRaWaBl1Vf+C4le/yPoBTPkxM/7FATkADjAYlSqhTktqtF901uQWShMBBIMiYUR+gok0OzDIW0ypaYkDQcKLemSMIIjgGUpxUF7QKBgQCUj1g5xCUi7cnxUJNJJnWCRxyA/0Z5yjO56XxzoDW+fOSbwqf4lWozH6xkh616vH2oJwICT346s+UvSCct7qbw/8li/FAWwmtPCnpJdG7oGXeo2HqaDGKRd1vxrZ/6yH9hsa8Vp3dtO72BWpLSflOTDWNxKXZVfckKM1HZs2RWPwKBgCefObJP/TS0d+WYqwQiYsLE7yv2u21ZcEx0G1uNuqN8M4dkxUsJ3Wj66ue+zonl/b75tDZdykxPteNUnNRWvaLztVcs7guA7numybTKFEavR85oFsDitHv9Gbb7eSBe8MBxdViZ8bb1m29U20vw0NTI9UivPnQL4RJxXsmN8qgpAoGBALs5pW2y39zBm/NwKBxDZghNeOihGA9EBiKIcVqnn5nE1bdSPb09+xICtqQnFqjwrtan+0rhA4VSbHaS+PQSbkl3PJmH6kWyZFHW4fvjwzE3LI6rWEqkaXi6xox6HflNDVlM2W2mHX87MwF2EwGzEKBi0XnYp04oPJe+5rPCKoGe";

    // 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAhUEIC1klXaDTtKeVVTgLYiXg1H5xFbU5KM45eRpLLgaB3n7zXU2Ehp+asCZb7qaZVJlcEEJdub0eSuoGMDvsImcVJ0YgJhcoFl0gKxG2Ck7a9Fqv2rikvQI9Gr+UJy15MQF51y+heA1O3MBY+AmhxmP3VlpoW9fKNq72zhU2Pb0KQXB/mwMRIOoUBZicOQB9o1oSFA+AbUvssO1jRjb7CmLFv2PYI35fN5hll/MHTzKre3fe6B6eeetPZzkUCHpFIP2TXP26QhpcpvCc9SvtQqPMD5mjpWu6Ov6R4PNNewQ4BTRjOsbnCah4Z1alQ9Rr0mEX7TT19TBWaP04QMJ7NwIDAQAB";

    // 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    public static String notify_url = "";

    // 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    public static String return_url = "http://localhost:8080/order/alipayReturnNotice";

    // 签名方式
    public static String sign_type = "RSA2";

    // 字符编码格式
    public static String charset = "utf-8";

    // 支付宝网关
    public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";

    // 支付宝网关
    public static String log_path = "C:\\";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /**
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     *
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis() + ".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
