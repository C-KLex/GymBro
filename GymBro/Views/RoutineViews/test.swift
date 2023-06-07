//
//  test.swift
//  GymBro
//
//  Created by user239615 on 6/3/23.
//

import SwiftUI

struct test: View {
    
    @StateObject var vm = testVM.instance
    
    var body: some View {
        VStack {
            
            ForEach(vm.bigList, id: \.id) { big in
                self.rowView(big: big)
            }
            
        }
    }
}

extension test {
    
    func rowView(big: bigModel) -> some View {
        
        VStack {
            Text(big.bigName)
                .foregroundColor(.blue)
                .onTapGesture {
                    vm.tap(big: big)
                    print("TAP")
                }
            ForEach(big.smallList, id: \.id) { small in
                Text(small.name)
            }
        }
        
    }
}

class testVM: ObservableObject {
    static let instance = testVM()
    @Published var bigList: [bigModel] = []
    
    init() {
        let a = bigModel(bigName: "A")
        let b = bigModel(bigName: "B")
        self.bigList.append(a)
        self.bigList.append(b)
    }
    
//    func tap(big: bigModel) {
//        guard let index = self.bigList.firstIndex(where: { $0.id == big.id }) else { return }
//        var big = big
//        big.addToList(name: "NEWONE")
//        self.bigList.remove(at: index)
//        self.bigList.insert(big, at: index)
//    }
    func tap(big: bigModel) {
            guard let index = self.bigList.firstIndex(where: { $0.id == big.id }) else { return }
            self.bigList[index].addToList(name: "NEWONE")
        }
}


struct bigModel: Identifiable {
    let id = UUID().uuidString
    var smallList: [smallModel] = []
    let bigName: String
    
    init(bigName: String) {
        self.bigName = bigName
        let a = smallModel(name: "A")
        let b = smallModel(name: "B")
        self.smallList.append(a)
        self.smallList.append(b)
    }
    
    mutating func addToList(name: String) {
        let new = smallModel(name: name)
        self.smallList.append(new)
    }
}

struct smallModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
