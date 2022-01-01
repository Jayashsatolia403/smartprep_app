import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdScreen extends StatefulWidget {
  const AdScreen({Key? key}) : super(key: key);

  @override
  _AdScreenState createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {
  late RewardedAd rewardedAd;
  late InterstitialAd interstitialAd;

  @override
  void initState() {
    super.initState();
  }

  void loadVideoAd() async {
    RewardedAd.load(
        adUnitId: RewardedAd.testAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          loadVideoAd();
        }));
  }

  void showVideoAd() {
    loadVideoAd();
    rewardedAd.show(onUserEarnedReward: (RewardedAd ad, RewardItem rpoint) {
      print("Reward Earned ${rpoint.amount}");
    });

    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdFailedToShowFullScreenContent: (ad, error) => print(error),
      onAdShowedFullScreenContent: (ad) => print("Working"),
    );
  }

  // void loadInterstitial() async {
  //   interstitialAd = InterstitialAd(
  //     adUnitId: InterstitialAd.testAdUnitId,
  //     request: AdRequest(),
  //     listener: AdListener(onAdLoaded: (Ad ad) {
  //       interstitialAd.show();
  //     }, onAdClosed: (Ad ad) {
  //       interstitialAd.dispose();
  //     }),
  //   );

  //   interstitialAd.load();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showVideoAd();
              },
              child: const Text("Show Video Ad"),
            ),
            // FlatButton(
            //   onPressed: () {
            //     loadInterstitial();
            //   },
            //   child: Text("Show Interstitial Ad"),
            // ),
          ],
        ),
      ),
    );
  }
}
