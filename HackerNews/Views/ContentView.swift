//
//  ContentView.swift
//  HackerNews
//
//  Created by Ben Gabay on 2/26/23.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TopStoriesView(viewModel: HackerNewsViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

