package com.example.demo.Notification.Services;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class AndroidPushPeriodicNotifications {

    public static String PeriodicNotificationJson() throws JSONException {
        LocalDate localDate = LocalDate.now();

        String sampleData[] = {"fBO9lZ6LRHWXMiRzmlKwE7:APA91bEQsAEkknlDp0cSEw50crCvTJidlvT-EDn29SfpnyJEwYl4K7DV9LoUtiXR0cP-pccVb5_fpS0n9fGo952C8QfFilxBYZUdmDzJ0x_Fxu4cUxhJnulmAsvqyfvA1l5O-rD5mSZ0", 
        		"e6gryVbHTciepBG-SNfQjQ:APA91bEAvEv9Pewnjft8eoy2sBLL6eiZqzWIKBaJdrDXLyirrQ_6IYcZeR-6f3_0T0K666mG4jkKyD8NNiO7JtS-QTINNNmEr1cXbjEr4IAwE49puqGZURV17RsmgQSUZzDBVbNd34lf",
        		"e1JnnZHaRBeaNZXoFrNgvu:APA91bFw8AWf42kYYsbBgJNnGZl2I_grCVpw-uisQ8F64PoSTMrjlx5b3ZYD-c-yoU5NHcxBsQYPXKLW43SFHBpbjA7LbJ89hJuvo4VZD7bHu4VBWdgMvwy5uZs1wipFLrhXWkV6pUnS"};

        JSONObject body = new JSONObject();

        List<String> tokenlist = new ArrayList<String>();

        for(int i=0; i<sampleData.length; i++){
            tokenlist.add(sampleData[i]);
        }

        JSONArray array = new JSONArray();

        for(int i=0; i<tokenlist.size(); i++) {
            array.put(tokenlist.get(i));
        }

        body.put("registration_ids", array);

        JSONObject notification = new JSONObject();
        notification.put("title","Push Test !!!!!!!!!!!!!!");
        //notification.put("body","Today is "+localDate.getDayOfWeek().name()+"!");
        notification.put("body","AHAAHAAAAAAAAAAAAAAAAAAHAAAAAAAAAAAAAAAAAAAAAAA");

        body.put("notification", notification);

        System.out.println(body.toString());

        return body.toString();
    }
}
