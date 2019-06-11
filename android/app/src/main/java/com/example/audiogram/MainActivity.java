package com.example.audiogram;

import android.os.Bundle;
import android.util.Log;

import org.drinkless.tdlib.JsonClient;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "tdjsonlib";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    MethodChannel mC = new MethodChannel(getFlutterView(), CHANNEL);
    mC.setMethodCallHandler((call, result) -> {
        Log.i("Method", call.method);
        String response;
        switch (call.method) {
            case "create":
                long client = JsonClient.create();
                Log.i("Client", String.valueOf(client));
                result.success(client);
                break;
            case "send":
                JsonClient.send(call.argument("client"), call.argument("request"));
                result.success(null);
                break;
            case "receive":
                response = JsonClient.receive(call.argument("client"), call.argument("timeout"));
                result.success(response);
                break;
            case "execute":
                response = JsonClient.execute(call.argument("client"), call.argument("request"));
                result.success(response);
            case "destroy":
                long temp = call.argument("client");
                System.out.println(temp);
                JsonClient.destroy(temp);
                result.success(true);
                break;
            default:
                result.notImplemented();
                break;
        }
    });
  }
}
