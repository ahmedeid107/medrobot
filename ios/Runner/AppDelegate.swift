import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        // مراقبة تسجيل الشاشة أو لقطة الشاشة
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(detectScreenCapture),
                                               name: UIScreen.capturedDidChangeNotification,
                                               object: nil)

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // دالة لإيقاف التطبيق عند اكتشاف تسجيل الشاشة أو لقطة الشاشة
    @objc func detectScreenCapture() {
        if UIScreen.main.isCaptured {
            exit(0) // إغلاق التطبيق عند اكتشاف تسجيل الشاشة
        }
    }
}
