import UIKit
import Flutter
import GoogleMaps
import workmanager

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    if let clientID = Bundle.main.infoDictionary?["GeoApiKey"] {
      GMSServices.provideAPIKey(clientID as! String)
    }

    GeneratedPluginRegistrant.register(with: self)
    UNUserNotificationCenter.current().delegate = self

    WorkmanagerPlugin.setPluginRegistrantCallback { registry in
      // The following code will be called upon WorkmanagerPlugin's registration.
      // All of the app's plugins may not be required in this context
      // instead of using GeneratedPluginRegistrant.register(with: registry),
      // you may want to register only specific plugins.
      GeneratedPluginRegistrant.register(with: registry)
    }

    if let taskIdentifiers = Bundle.main.infoDictionary?["BGTaskSchedulerPermittedIdentifiers"] {
      for taskIdentifier in taskIdentifiers as! [String] {
        WorkmanagerPlugin.registerTask(withIdentifier: taskIdentifier)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler(.alert) // shows banner even if app is in foreground
  }
}
