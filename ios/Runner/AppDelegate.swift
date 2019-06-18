import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    //Td client
      var client : UnsafeMutableRawPointer!
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    //Platform channeling code
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: "tdjsonlib",
                                              binaryMessenger: controller)
    
    methodChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in

        switch(call.method){
        case "create":
            self?.client = td_json_client_create()
            result(nil)
            print("Created successfully");
        case "send":
            let args = call.arguments as! [String : Any]
            td_json_client_send(self?.client, args["request"] as! String)
            result(nil)
            print("Sent successfully");
        case "receive":
            let args = call.arguments as! [String : Any]
            if let res = td_json_client_receive(self?.client, args["delay"] as! Double) {
                let event = String(cString: res)
                result(event)
            }
            print("Received successfully");
        case "execute":
            let args = call.arguments as! [String : Any]
            if let res = td_json_client_execute(self?.client, args["request"] as! String) {
                let event = String(cString: res)
                result(event)
            }
            print("Executed successfully");
        case "destroy":
            td_json_client_destroy(self?.client)
            result(nil)
            print("Destroyed successfully");
        default:
            result(FlutterMethodNotImplemented)
            return
        }
    })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
    
}

func to_json(_ obj: Any) -> String {
    do {
        let obj = try JSONSerialization.data(withJSONObject: obj)
        return String(data: obj, encoding: .utf8)!
    } catch {
        return ""
    }
}
