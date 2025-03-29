import UIKit
import Flutter
import GoogleMaps
import flutter_background_service_ios 

@main
@objc class AppDelegate: FlutterAppDelegate {
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Initialize Google Maps
    if let clientID = Bundle.main.infoDictionary?["GeoApiKey"] {
      GMSServices.provideAPIKey(clientID as! String)
    }

    //initialize background service
    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "SendPendingEscapeManualTask"

    GeneratedPluginRegistrant.register(with: self)
    UNUserNotificationCenter.current().delegate = self

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler(.alert) // Show notification banner even if app is in foreground
  }
}
