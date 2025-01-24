//
//  AppWidgetBundle.swift
//  AppWidget
//
//  Created by Softsuave-iOS dev on 24/01/25.
//

import WidgetKit
import SwiftUI

@main
struct AppWidgetBundle: WidgetBundle {
    var body: some Widget {
        AppWidget()
        AppWidgetLiveActivity()
    }
}
