package com.jordyhers.times_up_flutter;

import java.util.*;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import android.util.Log;
import android.app.usage.UsageStatsManager;
import android.app.usage.UsageEvents;
import android.app.usage.UsageEvents.Event;
import android.app.usage.UsageStats;
import android.content.Context;
import android.widget.Toast;

public class MainActivity extends FlutterActivity {

    private static final String methodChannelAppUsage = "times_up/appUsage";

    private HashMap<String, List<Long>> getEvents(Long interval_start_time, Long interval_end_time, String app_name){
        List<HashMap<Integer, String>> listOfEventTypes = new ArrayList<>();
        List<UsageEvents.Event> allEvents = new ArrayList<>();
        
        HashMap<String, List<Long>> result = new HashMap<String, List<Long>>();
        List<Long> temp;

        UsageStatsManager usageStatsManager = (UsageStatsManager) getSystemService(Context.USAGE_STATS_SERVICE);
        UsageEvents usageEvents = usageStatsManager.queryEvents(interval_start_time, interval_end_time);
        UsageEvents.Event currentEvent;

        while (usageEvents.hasNextEvent()) {
            currentEvent = new UsageEvents.Event();
            usageEvents.getNextEvent(currentEvent);
            
            if(currentEvent.getEventType() == 1 || currentEvent.getEventType() == 2 || currentEvent.getEventType() == 23){
                allEvents.add(currentEvent);
            }
        }

        HashMap<Integer,String> temp_map;

        for (UsageEvents.Event e : allEvents) {

            if(!result.containsKey(e.getPackageName())){
                temp = new ArrayList<Long>();
                if(e.getEventType() == 1){
                    
                    temp.add(0, - e.getTimeStamp());
                    temp.add(1, (long) 0);
                    temp.add(2, (long) - e.getTimeStamp());

                }else if(e.getEventType() == 2){
                    temp.add(0, e.getTimeStamp() - interval_start_time);
                    temp.add(1,(long) -1);
                    temp.add(2,(long) 0);
                }
            }else{
                temp = result.get(e.getPackageName());
                if(e.getEventType() == 1){
                    temp.set(0, temp.get(0) - e.getTimeStamp());
                    temp.set(1, (long) 0);
                    temp.set(2, temp.get(2) - e.getTimeStamp());

                }else if(e.getEventType() == 2){

                    temp.set(0, (temp.get(1) > 0 ? -temp.get(1) : 0) + temp.get(0) + e.getTimeStamp());
                    temp.set(1, (long) -1);
                    temp.set(2,  temp.get(2) + e.getTimeStamp());

                }else if(e.getEventType() == 23){                    
                    if(temp.get(1) != -1){
                        temp.set(0, temp.get(0) + e.getTimeStamp());
                        temp.set(1, (long) e.getTimeStamp());
                    }
                    
                    // if(temp.get(2) != 0 && temp.get(1) == -1){
                    //     temp.set(0, temp.get(0) + e.getTimeStamp());
                    //     temp.set(2,  (long) 0);
                    // }
                }
            }
            
            result.put(e.getPackageName(), temp);
            temp_map = new HashMap<Integer,String>();
            temp_map.put(e.getEventType(), e.getPackageName() + " " + e.getTimeStamp());
            listOfEventTypes.add(temp_map);
        }
        
        for(Map.Entry<String, List<Long>> e : result.entrySet()){
            temp = e.getValue();
            
            if(temp.get(0) < 0){
                temp.set(0, interval_end_time + temp.get(0));
            }

            if(temp.size() > 1 && temp.get(1) != -1){
                temp.set(0, temp.get(0) + (interval_end_time - temp.get(1)));
            }
            
            if(temp.get(1) != 0 &&  temp.get(2) > 0 && temp.get(0) > 0 && temp.get(0) > temp.get(2)){
                temp.set(0, temp.get(2));
            }

            if(temp.get(1) == 0){
                temp.set(0, temp.get(0) + interval_end_time + temp.get(2));
            }
            
            result.put(e.getKey(), temp);
        }


        return result;
    }
       
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), methodChannelAppUsage)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("getAppUsage")) {
                                
                                Long interval_start_time = call.argument("interval_start_time");
                                Long interval_end_time = call.argument("interval_end_time");
                                String app_name = call.argument("app_name");
                                result.success(getEvents(interval_start_time, interval_end_time, app_name));

                            }else {
                                result.notImplemented();
                            }
                        });
    }

}