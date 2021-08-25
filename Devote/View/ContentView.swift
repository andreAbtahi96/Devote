//
//  ContentView.swift
//  Devote
//
//  Created by Andre Abtahi on 8/18/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //  MARK: - PROPERTY
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
    
    //default is light mode
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    //  MARK: - FETCHING DATA
    
        // managed object context = an environment where we can manipulate core data objects entirely in RAM
    @Environment(\.managedObjectContext) private var viewContext

        // allow us to load core data results that match our desired outcome
    @FetchRequest(
        // sortDescriptors = what we are querying
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    
    //  MARK: - FUNCTION
   

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                //  MARK: - MAIN VIEW
                VStack {
                    
                    HStack(spacing: 10){
                        // TITLE
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        // EDIT BUTTON
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 26)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 3)
                            )
                        // APPEARANCE BUTTON
                        Button(action: {
                            // TOGGLE APPEARANCE
                            isDarkMode.toggle()
                            
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                    }// HSTACK
                    .padding()
                    .foregroundColor(.white)
                    
                    //  MARK: - HEADER
                    Spacer(minLength: 80)
                    
                    //  MARK: - NEW TASK BUTTON
                    Button(action:{
                        showNewTaskItem = true
                    }, label:{
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: Color(red:0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                    //  MARK: - TASKS
                    
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }// LIST
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    // remove default vertical padding and maximize list for ipad devices.
                    .frame(maxWidth: 640)
                    
                }// VSTACK
                
                //  MARK: - NEW TASK ITEM
                if showNewTaskItem{
                    BlankView()
                        .onTapGesture {
                            withAnimation(){
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }// ZSTACK
            .onAppear(){
                UITableView.appearance().backgroundColor = UIColor.clear
            }
            .navigationBarTitle("Daily Tasks", displayMode: .large)
            .navigationBarHidden(true)
            
            
            .background(BackgroundImageView())
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
        }// NAVIGATIONVIEW
            //will make sure nav view will show single column view at a time for ipad.
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//  MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
