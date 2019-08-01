package com.example.audiogram;

import android.app.Activity;
import android.util.Log;
import org.drinkless.tdlib.JsonClient;
import java.util.concurrent.locks.ReentrantLock;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class TdlibChannelThread implements MethodChannel.MethodCallHandler {
    private long client;
    private ReentrantLock lock = new ReentrantLock();
    private Activity activity;

    TdlibChannelThread(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        new Thread(() -> {
            lock.lock();
            final String response;
            switch (call.method) {
                case "create":
                    client = JsonClient.create();
                    response(result, null);
                    break;
                case "send":
                    String req = call.argument("request");
                    JsonClient.send(client, req);
                    response(result, null);
                    break;
                case "receive":
                    response = JsonClient.receive(client, call.argument("delay"));
                    response(result, response);
                    break;
                case "execute":
                    response = JsonClient.execute(client, call.argument("request"));
                    response(result, response);
                    break;
                case "destroy":
                    response(result, null);
                    JsonClient.destroy(client);
                    break;
                default:
                    activity.runOnUiThread(result::notImplemented);
                    break;
            }

            lock.unlock();
        }).start();
    }

    private void response(MethodChannel.Result result, String response) {
        activity.runOnUiThread(() -> result.success(response));
    }
}
