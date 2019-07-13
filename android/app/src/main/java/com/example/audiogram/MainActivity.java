package com.example.audiogram;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL_TD = "tdjsonlib";
  private static final String CHANNEL_MUSIC = "music";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    MethodChannel tdlibMc = new MethodChannel(getFlutterView(), CHANNEL_TD);
    tdlibMc.setMethodCallHandler(new TdlibChannelThread(this));

    MethodChannel musicMc = new MethodChannel(getFlutterView(), CHANNEL_MUSIC);
    musicMc.setMethodCallHandler((methodCall, result) -> {
      
    });
  }
}
