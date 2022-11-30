package com.payten.dateafterpay;

import io.flutter.embedding.android.FlutterActivity;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import android.os.Bundle;
import android.content.ServiceConnection;
import android.content.Intent;
import android.content.Context;
import android.content.ComponentName;
import android.widget.Toast;
import android.os.IBinder;

import java.io.IOException;
import java.io.InputStream;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

import com.payten.service.PaytenAidlInterface;

import android.content.ContextWrapper;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import android.os.RemoteException;

public class MainActivity extends FlutterActivity {
  private PaytenAidlInterface paytenAidlInterface;
  private final Executor executor = Executors.newSingleThreadExecutor();
  private static final String CHANNEL = "com.payten.dateafterpay/ch1";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    // setContentView(R.layout.activity_main);

    if (paytenAidlInterface == null) {
      Intent it = new Intent();
      it.setClassName("com.payten.service", "com.payten.service.PaytenEcrService");
      bindService(it, connection, Context.BIND_AUTO_CREATE);
    }
  }

  protected ServiceConnection connection = new ServiceConnection() {
    @Override
    public void onServiceConnected(ComponentName componentName, IBinder iBinder) {
      // Receive the Object which is return by the Sever_Service on Bind Function
      paytenAidlInterface = PaytenAidlInterface.Stub.asInterface(iBinder);
      Toast.makeText(getApplicationContext(), "Service Connected", Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onServiceDisconnected(ComponentName componentName) {

    }
  };

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
        .setMethodCallHandler(
            (call, result) -> {
              // This method is invoked on the main thread.
              if (call.method.equals("printLogo")) {
                executor.execute(() -> {
                  try {
                    paytenAidlInterface.ecrResponse(
                        getAssetJsonData(
                            getApplicationContext(),
                            "printer_request_logo.json"));
                  } catch (RemoteException e) {
                    e.printStackTrace();
                  }
                });
              } else if (call.method.equals("getBattery")) {
                int batteryLevel = getBattery();

                if (batteryLevel != -1) {
                  result.success(batteryLevel);
                } else {
                  result.error("UNAVAILABLE", "Battery level not available.", null);
                }
              } else {
                result.notImplemented();
              }
            });
  }

  // BUILDING JSON STRING FROM ASSETS FOLDER
  public static String getAssetJsonData(Context context, String jsonString) {
    String json = null;
    try {
      InputStream is = context.getAssets().open(jsonString);
      int size = is.available();
      byte[] buffer = new byte[size];
      is.read(buffer);
      is.close();
      json = new String(buffer, "UTF-8");
    } catch (IOException ex) {
      ex.printStackTrace();
      return null;
    }
    return json;
  }

  private int getBattery() {
    int batteryLevel = -1;
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
    } else {
      Intent intent = new ContextWrapper(getApplicationContext()).registerReceiver(null,
          new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
      batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
          intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
    }

    return batteryLevel;
  }
}
