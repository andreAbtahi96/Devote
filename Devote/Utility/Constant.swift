//
//  Constant.swift
//  Devote
//
//  Created by Andre Abtahi on 8/20/21.
//

import SwiftUI

//  MARK: - FORMATTER
let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//  MARK: - UI
var backgroundGradient: LinearGradient{
    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

var backgroundGradientForWidget: LinearGradient{
    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.pink, Color.blue, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

//  MARK: - UX
let feedback = UINotificationFeedbackGenerator()
