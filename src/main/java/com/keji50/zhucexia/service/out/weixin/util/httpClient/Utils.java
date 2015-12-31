package com.keji50.zhucexia.service.out.weixin.util.httpClient;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

public class Utils {

	public static String getOut(HttpURLConnection conn) throws IOException{
        if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
            return null;
        }
        // 获取响应内容体
        BufferedReader in = new BufferedReader(new InputStreamReader(
                conn.getInputStream(), "UTF-8"));
        String line = "";
        StringBuffer strBuf = new StringBuffer();
        while ((line = in.readLine()) != null) {
            strBuf.append(line).append("\n");
        }
        in.close();
        return  strBuf.toString().trim();
}


public static String SendGET(String url,String param){
   String result="";//访问返回结果
   BufferedReader read=null;//读取访问结果
     
   try {
    //创建url
    URL realurl=new URL(url+"?"+param);
    //打开连接
    URLConnection connection=realurl.openConnection();
     // 设置通用的请求属性
             connection.setRequestProperty("accept", "*/*");
             connection.setRequestProperty("connection", "Keep-Alive");
             connection.setRequestProperty("user-agent",
                     "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
             //建立连接
             connection.connect();
          // 获取所有响应头字段
//             Map<String, List<String>> map = connection.getHeaderFields();
             // 遍历所有的响应头字段，获取到cookies等
//             for (String key : map.keySet()) {
//                 System.out.println(key + "--->" + map.get(key));
//             }
             // 定义 BufferedReader输入流来读取URL的响应
             read = new BufferedReader(new InputStreamReader(
                     connection.getInputStream(),"UTF-8"));
             String line;//循环读取
             while ((line = read.readLine()) != null) {
                 result += line;
             }
   } catch (IOException e) {
    e.printStackTrace();
   }finally{
    if(read!=null){//关闭流
     try {
      read.close();
     } catch (IOException e) {
      e.printStackTrace();
     }
    }
   }
      
   return result; 
 }
}
