import UIKit
import Flutter
import GoogleMaps
import BackgroundTasks

@main
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
    
    // Register background tasks
    registerBackgroundTasks()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Function to register background tasks
  func registerBackgroundTasks() {
    BGTaskScheduler.shared.register(forTaskWithIdentifier: "br.com.azmina.penhas.bgFetch", using: nil) { task in
      self.handleBackgroundFetch(task: task)
    }
  }
  
  // Function to handle background task
  func handleBackgroundFetch(task: BGTask) {
    // Perform your background task here
    let queue = OperationQueue()
    
    // Example background task
    queue.addOperation {
      // Do your background work (e.g., fetch data)
      print("Running background task...")

      // After the background task completes, call setTaskCompleted
      task.setTaskCompleted(success: true)
    }

    // Set expiration handler
    task.expirationHandler = {
      // Code to clean up task if it runs out of time
      print("Background task expired.")
    }
    
    // Don't forget to call this to make sure the background task completes properly
    queue.addOperation {
      task.setTaskCompleted(success: true)
    }
  }

  // Request to start the background task
  func scheduleBackgroundFetch() {
    let request = BGAppRefreshTaskRequest(identifier: "com.yourcompany.yourapp.bgFetch")
    request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60) // 15 minutes from now
    do {
      try BGTaskScheduler.shared.submit(request)
    } catch {
      print("Failed to schedule background fetch task: \(error)")
    }
  }

  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler(.alert) // shows banner even if app is in foreground
  }
}
