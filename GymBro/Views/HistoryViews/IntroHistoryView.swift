//
//  IntroHistoryView.swift
//  GymBro
//
//  Created by user236772 on 4/9/23.
//




import SwiftUI

struct IntroHistoryView: View {
    
    @State private var items = ["Item 1", "Item 2", "Item 3"]
    
    var body: some View {
        
        VStack {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            
                            Button(
                                action: {
                                    deleteRoutine()
                                },
                                label: {
                                    Label("Delete", systemImage: "trash")
                                    
                                }
                            )
                            .tint(.red)
                            
                            Button(
                                action: {
                                    editRoutine()
                                },
                                label: {
                                    Label("Edit", systemImage: "restart")
                                }
                            )
                            .tint(.green)
                        }
                }
            }
            
            Button("hi") {
                print("hi")
            }
            
        }
        .navigationTitle("History")
        
     

    }
 
    func deleteRoutine() {
        print("delete")
    }
    func editRoutine() {
        print("edit")
        
    }
}


struct IntroHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            IntroHistoryView()
        }
    }
}
