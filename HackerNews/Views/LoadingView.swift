//
//  LoadingView.swift
//  HackerNews
//
//  Created by Ben Gabay on 3/12/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(hackerNewsBgColor)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
