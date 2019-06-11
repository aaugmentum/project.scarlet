package com.example.audiogram;

import android.os.Bundle;
import android.util.Log;

import org.drinkless.tdlib.JsonClient;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "tdjsonlib";
  private long client = 0;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    MethodChannel mC = new MethodChannel(getFlutterView(), CHANNEL);
    mC.setMethodCallHandler((call, result) -> {
        Log.i("Method", call.method);

        if (call.method.equals("create")) {
            client = JsonClient.create();
            Log.i("Client", String.valueOf(client));
            result.success(client);
        } else {
            String response;
            switch (call.method) {
                case "sendJson":
                    JsonClient.send(client, call.argument("request"));
                    result.success(null);
                    break;
                case "receiveJson":
                    response = JsonClient.receive(client, call.argument("timeout"));
                    result.success(response);
                    break;
                case "execute":
                    response = JsonClient.execute(client, call.argument("request"));
                    result.success(response);
                case "destroy":
                    JsonClient.destroy(client);
                    client = 0;
                    result.success(null);
                default:
                    result.notImplemented();
                    break;
            }
        }
    });
  }
}
