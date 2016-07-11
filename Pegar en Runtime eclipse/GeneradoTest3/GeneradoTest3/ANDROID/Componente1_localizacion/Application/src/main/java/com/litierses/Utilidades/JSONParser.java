package com.litierses.Utilidades;

import android.util.Log;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.List;

public class JSONParser {

    static InputStream is = null;
    static JSONArray jObj = null;
    static String json = "";

    // constructor
    public JSONParser() {

    }

    // function get json from url
    // by making HTTP POST or GET mehtod
    public JSONArray makeHttpRequest(String url, String method,
                                      String params) {

        // Making HTTP request
        try {

            // check for request method
            if(method == "POST"){
                DefaultHttpClient httpClient = new DefaultHttpClient();
                HttpPost httpPost = new HttpPost(url);
                httpPost.setEntity(new StringEntity(params));
                httpPost.setHeader("Accept", "application/json");
                httpPost.setHeader("Content-type", "application/json");
                HttpResponse httpResponse = httpClient.execute(httpPost);

            }else if(method == "GET"){
                DefaultHttpClient httpClient = new DefaultHttpClient();
                HttpGet httpGet = new HttpGet(url);
                httpGet.setHeader("Accept", "application/json");
                httpGet.setHeader("Content-type", "application/json");
                HttpResponse httpResponse = httpClient.execute(httpGet);
                HttpEntity httpEntity = httpResponse.getEntity();
                is = httpEntity.getContent();
            }
            else if(method == "DELETE"){
                // request method is GET
                DefaultHttpClient httpClient = new DefaultHttpClient();
                HttpDelete httpDelete = new HttpDelete(url);
                httpDelete.setHeader("Accept", "application/json");
                httpDelete.setHeader("Content-type", "application/json");
                HttpResponse httpResponse = httpClient.execute(httpDelete);
                HttpEntity httpEntity = httpResponse.getEntity();
                is = httpEntity.getContent();
            }
            else if(method == "PUT"){
                DefaultHttpClient httpClient = new DefaultHttpClient();
                HttpPut httpPut = new HttpPut(url);
                httpPut.setEntity(new StringEntity(params));
                httpPut.setHeader("Accept", "application/json");
                httpPut.setHeader("Content-type", "application/json");
                HttpResponse httpResponse = httpClient.execute(httpPut);
            }


        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (is != null)
        {



        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(
                    is, "iso-8859-1"), 8);
            StringBuilder sb = new StringBuilder();
            String line = null;
            while ((line = reader.readLine()) != null) {
                sb.append(line + "\n");
            }
            is.close();
            json = sb.toString();
        } catch (Exception e) {
            Log.e("Buffer Error", "Error converting result " + e.toString());
        }

        // try parse the string to a JSON object
        try {
            jObj = new JSONArray(json);
        } catch (JSONException e) {
            Log.e("JSON Parser", "Error parsing data " + e.toString());
        }

        // return JSON String
        }
        return jObj;

    }
}