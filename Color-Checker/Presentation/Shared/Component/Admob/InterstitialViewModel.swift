import GoogleMobileAds
import Combine

class InterstitialViewModel: NSObject, FullScreenContentDelegate, ObservableObject {
    private var interstitialAd: InterstitialAd?
    private var okBounce: Int = 20
    
    func loadAd() async {
        let keys = Bundle.main.infoDictionary?["ApiKeys"] as? [String: Any]
        let key = keys?["InterstitialKey"] as? String ?? ""
        print("InterstitialKey \(key)")
        do {
            // 広告のロード
            interstitialAd = try await InterstitialAd.load(
                with: key, request: Request())
            interstitialAd?.fullScreenContentDelegate = self
        } catch {
            print("Failed to load interstitial ad with error: \(error.localizedDescription)")
        }
    }
    // [END load_ad]
    
    // [START show_ad]
    func showAd() {
        guard let interstitialAd = interstitialAd else {
            return print("Ad wasn't ready.")
        }
        
        if randomIntBounce() {
            interstitialAd.present(from: nil)
        }
    }
    // [END show_ad]
    
    // MARK: - GADFullScreenContentDelegate methods
    
    // [START ad_events]
    func adDidRecordImpression(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidRecordClick(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func ad(
        _ ad: FullScreenPresentingAd,
        didFailToPresentFullScreenContentWithError error: Error
    ) {
        print("\(#function) called")
    }
    
    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adWillDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
        // Clear the interstitial ad.
        interstitialAd = nil
    }
    // [END ad_events]
    
    private func randomIntBounce() -> Bool {
        let bounce = Int.random(in: 0...100)
        if bounce <= okBounce {
            return true
        } else {
            return false
        }
    }
}
