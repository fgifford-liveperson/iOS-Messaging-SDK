//
//  App.swift
//  SampleApp
//
//  Created by Frans Gifford on 06/03/2020.
//  Copyright © 2020 LivePerson. All rights reserved.
//

import UIKit

class App: UIApplication {
    override func canOpenURL(_ url: URL) -> Bool {
        return super.canOpenURL(url)
    }

    override func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) {
        debugPrint("Overriding! for \(url)")
        return super.open(url, options: options, completionHandler: completion)
    }
}
