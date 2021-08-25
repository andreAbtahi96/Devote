//
//  ListRowItemView.swift
//  Devote
//
//  Created by Andre Abtahi on 8/24/21.
//

import SwiftUI

struct ListRowItemView: View {
    //  MARK: - PROPERTY
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item // CRUD design idea.
    
    
    //  MARK: - BODY
    var body: some View {
        Toggle(isOn: $item.completion, label: {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? Color.pink : Color.primary)
                .padding(.vertical, 12)
                .animation(.default)
        })// END OF TOGGLE
        .toggleStyle(CheckboxStyle())
        /*
         param1 = Publisher: is item.objectWillChange. Everytime there is a change a given action happens.
         
         param2 = Action: triggered each time when event happens.
         */
        .onReceive(item.objectWillChange, perform: { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        })
    }
}
