package com.example.audiogram;

import android.util.Log;
import org.drinkless.tdlib.JsonClient;

import java.util.concurrent.locks.ReentrantLock;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class PlatformChannelThread implements MethodChannel.MethodCallHandler {
    private long client;
    private ReentrantLock lock = new ReentrantLock();

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        new Thread(() -> {
            lock.lock();
            String response;
            switch (call.method) {
                case "create":
                    client = JsonClient.create();
                    Log.i("Client", String.valueOf(client));
                    result.success(null);
                    break;
                case "send":
                    String req = call.argument("request");
                    Log.i("Request", req);
                    JsonClient.send(client, req);
                    result.success(null);
                    break;
                case "receive":
                    response = JsonClient.receive(client, call.argument("delay"));
                    result.success(response);
                    break;
                case "execute":
                    response = JsonClient.execute(client, call.argument("request"));
                    result.success(response);
                case "destroy":
                    JsonClient.destroy(client);
                    result.success(null);
                    break;
                default:
                    result.notImplemented();
                    break;
            }
            lock.unlock();
        }).start();
    }
}
