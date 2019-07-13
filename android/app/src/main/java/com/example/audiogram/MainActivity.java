package com.example.audiogram;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "tdjsonlib";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    MethodChannel tdlibMc = new MethodChannel(getFlutterView(), CHANNEL);
    tdlibMc.setMethodCallHandler(new TdlibChannelThread(this));
  }
}
