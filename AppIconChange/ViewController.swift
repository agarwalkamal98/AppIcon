//
//  ViewController.swift
//  AppIconChange
//
//  Created by kamal agarwal on 30/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    enum AppIcon: CaseIterable{
        
        case variant1, variant2
        
        var name:String?{
            switch self{
            case .variant1:
                return "variant1Icon"
            case .variant2:
                return "variant2Icon"
            }
        }
        
        
    }
    
    
    var current: AppIcon {
        return AppIcon.allCases.first(where: {$0.name == UIApplication.shared.alternateIconName}) ?? .variant1
    }

    func setIcon(_ appIcon: AppIcon, completion: ((Bool) -> Void)? = nil) {
        guard current != appIcon, UIApplication.shared.supportsAlternateIcons
        else { return }
        
        UIApplication.shared.setAlternateIconName(appIcon.name) { error in
            if let error = error {
                print("Error setting the alternate icon \(appIcon.name ?? ""): \(error.localizedDescription)")
            }
            completion?(error != nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let icon = UIApplicationShortcutIcon(type: .play)
        let item = UIApplicationShortcutItem(type: "IconPress", localizedTitle: "Change Icon", localizedSubtitle: "Change your appicon", icon: icon, userInfo: nil)
        
        let icon1 = UIApplicationShortcutIcon(type: .share)
        let item1 = UIApplicationShortcutItem(type: "SharePress", localizedTitle: "Share", localizedSubtitle: "Share app with friends", icon: icon1, userInfo: nil)
        
        UIApplication.shared.shortcutItems = [item,item1]
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationCall), name: Notification.Name("download_start"), object: nil)
    }
    
    @objc func notificationCall(){
        print("notificationCall")
        
        let items = [URL(string: "https://www.apple.com")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }

    @IBAction func btn1Action(_ sender: UIButton) {
        setIcon(.variant1)
    }
    
    @IBAction func btn2Action(_ sender: UIButton) {
        setIcon(.variant2)
    }
}

