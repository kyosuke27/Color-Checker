import Foundation
import SwiftUI
import GoogleMobileAds

struct AdmobBannerView: UIViewRepresentable {
    typealias UIViewType = BannerView
    let adSize: AdSize
    
    init(_ adSize: AdSize) {
        self.adSize = adSize
    }
    
    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: adSize)
        banner.adUnitID = "ca-app-pub-3940256099942544/2435281174"
        banner.load(Request())
        banner.delegate = context.coordinator
        return banner
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {}
    
    func makeCoordinator() -> BannerCoordinator {
        return BannerCoordinator(self)
    }
    
    class BannerCoordinator: NSObject, BannerViewDelegate {

        let parent: AdmobBannerView

        init(_ parent: AdmobBannerView) {
          self.parent = parent
        }

        // MARK: - GADBannerViewDelegate methods

        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
          print("✅ Success Admob Received")
        }

        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
          print("FAILED TO RECEIVE AD: \(error.localizedDescription)")
        }
      }
}
