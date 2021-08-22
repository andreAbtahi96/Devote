//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Andre Abtahi on 8/21/21.
//

import SwiftUI

// code inside condition only runs when we can import UIKit framework
#if canImport(UIKit)
extension View{
    func hideKeyboard(){
        // as of now we can only do this through UIKit's framework.
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}// extension
#endif
