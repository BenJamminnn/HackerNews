//
//  ErrorStateView.swift
//  HackerNews
//
//  Created by Ben Gabay on 3/12/23.
//

import SwiftUI

struct ErrorStateView: View {
    let errorMessage: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            Image("errorIcon")
            Text(errorMessage)
                .font(.custom("Verdana", size: 16))
                .foregroundColor(Color(.red))
            Spacer()
            Button {
                action()
            } label: {
                VStack {
                    Image("refresh")
                    Text("Refresh")
                        .font(.custom("Verdana", size: 16))
                        .foregroundColor(Color(.black))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 20)
    }
}


struct ErrorStateView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorStateView(errorMessage: "Hey this is an error!") {
            print("this is an action!")
        }
    }
}
