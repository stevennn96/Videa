//
//  AppDelegate.swift
//  Videa
//
//  Created by Steven - on 14/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if error == nil {
            
            GIDSignedInUser.accessToken = (GIDSignIn.sharedInstance()?.currentUser.authentication.accessToken)!
            print(GIDSignedInUser.accessToken)
            
            getDetail { (success) in
                if success {
//                    getPlaylistDetail()
                    getSearchByDate()
                    getSearchByView()
                }
            }
        } else {
            print("\(error?.localizedDescription)")
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                return
            }
            // User is signed in
            // ...
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

    var window: UIWindow?
    
    func getDetail(completion: (_ success: Bool) -> Void) {
        
        getChannelDetail()
        
        while GIDSignedInUser.channelDetail == nil {
            continue
        }
        
        completion(true)
    }
    
    func getChannelDetail() {
        let url = URL(string: "https://www.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails,statistics&mine=true&access_token=\(GIDSignedInUser.accessToken)")
        
        let getChannelTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                GIDSignedInUser.channelDetail = try JSONDecoder().decode(ChannelDetail.self, from: data!)
            } catch let error as NSError {
                print(error)
            }
            
            if GIDSignedInUser.channelDetail != nil {
                
                GIDSignedInUser.loadStatus += 1
                print("Channel Detail Retrieved")
                
                if GIDSignedInUser.channelDetail!.items?.count != 0 {
                   
                }
                else {
                    print("Channel detail empty")
                }
            }
            else {
                print("No channel detail found")
            }
        }
        
        getChannelTask.resume()
    }
    
    func getPlaylistDetail() {
        
        let playlistId = GIDSignedInUser.channelDetail?.items![0].contentDetails?.relatedPlaylists?.uploads
        let url = URL(string: "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=\(playlistId!)&part=snippet,contentDetails&key=\(GIDSignedInUser.apiKey)")
        
        let getPlaylistTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                GIDSignedInUser.playlistDetail = try JSONDecoder().decode(PlaylistDetail.self, from: data!)
            } catch let error as NSError {
                print(error)
            }
            
            if GIDSignedInUser.playlistDetail != nil {
                
                print("Playlist Detail Retrieved")
            }
        }
        
        getPlaylistTask.resume()
    }
    
    func getSearchByDate() {
        
        let channelId = GIDSignedInUser.channelDetail?.items![0].id
        
        let url = URL(string: "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&order=date&maxResults=50&channelId=\(channelId!)&key=\(GIDSignedInUser.apiKey)")
        
        let searchTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                
                GIDSignedInUser.searchByDate = try JSONDecoder().decode(SearchDetail.self, from: data!)
            } catch let error as NSError {
                print(error)
            }
            
            if GIDSignedInUser.searchByDate != nil {
                
                GIDSignedInUser.loadStatus += 1
                print("Search By Date Retrieved")
            }
        }
        
        searchTask.resume()
    }
        
    func getSearchByView() {
        
        let channelId = GIDSignedInUser.channelDetail?.items![0].id
        
        let url = URL(string: "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&order=viewCount&maxResults=50&channelId=\(channelId!)&key=AIzaSyCSSeFz17e2vePbWpS0_KWN7wHxWhCQoRU")
        
        let searchTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                
                GIDSignedInUser.searchByView = try JSONDecoder().decode(SearchDetail.self, from: data!)
            } catch let error as NSError {
                print(error)
            }
            
            if GIDSignedInUser.searchByView != nil {
                
                GIDSignedInUser.loadStatus += 1
                print("Search By View Retrieved")
            }
        }
        
        searchTask.resume()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().scopes = [
            "https://www.googleapis.com/auth/youtube.readonly",
            "https://www.googleapis.com/auth/yt-analytics.readonly",
            "https://www.googleapis.com/auth/yt-analytics-monetary.readonly",
            "https://www.googleapis.com/auth/youtube",
            "https://www.googleapis.com/auth/youtubepartner",
            "https://www.googleapis.com/auth/youtubepartner-channel-audit",
            "https://www.googleapis.com/auth/plus.login",
            "https://www.googleapis.com/auth/plus.me"]
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        let db = Firestore.firestore()
        //punya santos
//        // Kalau mau pke storyboard sndiri comment punya gw
        let authListener = Auth.auth().addStateDidChangeListener {auth, user in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            if user != nil {

                UserService.observeUserProfile(user!.uid) { userProfile in
                    UserService.currentUserProfile = userProfile
                }
                let controller = storyboard.instantiateViewController(withIdentifier: "SplashScreen2")
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()

            }else {
                UserService.currentUserProfile = nil

                //Menu Screen
                let controller = storyboard.instantiateViewController(withIdentifier: "onboardingVC")
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
            }
        }
        
  // Sampai sini
        
        // Kalau mau pke storyboard sndiri comand punya gw
//        let authListener = Auth.auth().addStateDidChangeListener {auth, user in
//            let storyboard = UIStoryboard(name: "SantosStoryboard", bundle: nil)
//
//            if user != nil {
//                let controller = storyboard.instantiateViewController(withIdentifier: "ProfileID")
//                self.window?.rootViewController = controller
//                self.window?.makeKeyAndVisible()
//
//            }else {
//                //Menu Screen
//                let controller = storyboard.instantiateViewController(withIdentifier: "LoginSignupVC")
//                self.window?.rootViewController = controller
//                self.window?.makeKeyAndVisible()
//            }
//        }
  // Sampai sini
        
        
        // Override point for customization after application launch.
//        self.window = UIWindow(frame: UIScreen.main.bounds)

        //punya kensen
//        let storyboard = UIStoryboard(name: "LevelStoryboard", bundle: nil)
//
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LevelVC")
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//
//
//        punya steven
//        let storyboard = UIStoryboard(name: "StevenStoryboard", bundle: nil)
//
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ChallengePage")
//        self.window = UIWindow(frame: UIScreen.main.bounds)

        
//        Ganti Background Navigation Bar pake Image
//        let img:UIImage = UIImage(named: "Top Tab Bar.pmg")!
//        UINavigationBar.appearance().setBackgroundImage(img, for: .default)
//
//
//        self.window?.rootViewController = initialViewController
//        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

