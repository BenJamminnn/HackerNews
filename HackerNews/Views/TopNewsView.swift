//
//  TopNewsView.swift
//  HackerNews
//
//  Created by Ben Gabay on 2/28/23.
//

import SwiftUI

let hackerNewsBgColor = Color(uiColor: bgColor)

struct TopStoriesView: View {
    @Bindable var viewModel: HackerNewsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .initialLoad:
                    LoadingView()
                case .error(let errorMessage):
                    ErrorStateView(errorMessage: errorMessage) {
                        Task {
                            await viewModel.fetchTopStories()
                        }
                    }
                default:
                    StoriesList(viewModel: viewModel)
                        .padding(.vertical, 6)
                }
            }
            .background(hackerNewsBgColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Top Stories")
            .toolbarBackground(hackerNewsOrangeColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

// Hacky, find better solution
extension ScrollView {
    func onScrolledToBottom(perform action: @escaping() -> Void) -> some View {
        return ScrollView<LazyVStack> {
            LazyVStack {
                self.content
                Rectangle().size(.zero).onAppear {
                    action()
                }
            }
        }
    }
}

struct TopStoriesView_Previews: PreviewProvider {
    static var previews: some View {
        TopStoriesView(viewModel: HackerNewsViewModel())
    }
}
