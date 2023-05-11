//
//  MInfoView_AchiSheet_QPopup.swift
//  GymBro
//
//  Created by user239615 on 5/10/23.
//

import SwiftUI

struct MInfoView_AchiSheet_QPopup: View {
    
    @Binding var isPresented: Bool
    @Binding var option: OptionModel?
    
    var body: some View {
        
        
        if isPresented {
            
            VStack {
                
                if let o = self.option {
                    
                    VStack(spacing: 0) {
                        VStack {
                            Text(o.optionName)
                                .font(.title2)
                                .fontWeight(.medium)
                                .padding()
                                .frame(maxWidth: .infinity)
                                
                        }
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 3)
                            .cornerRadius(10)
                            .padding(.horizontal, 10)
                        
                        VStack(alignment: .leading) {
                            Text(o.introduction)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                }
                
                Spacer()
                
                HStack {
                    Text("OK")
                        .font(.title2).foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(25)
                        .padding()
                }
                .onTapGesture {
                    self.isPresented = false
                }
                    
                    
                
            }
            .frame(width: 350, height: 450)
            .background(Color("lightGray"))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 5)
            
            
        }
        
        
        
        
    }
}

struct MInfoView_AchiSheet_QPopup_Previews: PreviewProvider {
    static var previews: some View {
        MInfoView_AchiSheet(isPopupActive: true)
    }
}
