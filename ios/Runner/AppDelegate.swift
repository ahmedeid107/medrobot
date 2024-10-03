import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.window.makeSecure()
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
extension UIWindow {
  func makeSecure() {
      let field = UITextField()
      field.isSecureTextEntry = true
      self.addSubview(field)
      field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
      field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
      self.layer.superlayer?.addSublayer(field.layer)
      field.layer.sublayers?.first?.addSublayer(self.layer)
    }
  }
