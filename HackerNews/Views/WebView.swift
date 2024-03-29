//
//  WebView.swift
//  HackerNews
//
//  Created by Ben Gabay on 3/14/23.
//

import SwiftUI
import WebKit
import Observation

@Observable
class WebViewModel {
    var isLoading: Bool = false
    var canGoBack: Bool = false
    var shouldGoBack: Bool = false
    var title: String = ""
    
    var url: String
    
    init(story: Story) {
        self.url = story.url ?? ""
        self.title = story.title
    }
}

struct WebViewContainer: UIViewRepresentable {
    var webViewModel: WebViewModel
    
    func makeCoordinator() -> WebViewContainer.Coordinator {
        Coordinator(self, webViewModel)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.webViewModel.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        // https://developer.apple.com/forums/thread/712074?page=4
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if webViewModel.shouldGoBack {
            uiView.goBack()
            webViewModel.shouldGoBack = false
        }
    }
}

extension WebViewContainer {
    class Coordinator: NSObject, WKNavigationDelegate {
        @Bindable private var webViewModel: WebViewModel
        private let parent: WebViewContainer
        
        init(_ parent: WebViewContainer, _ webViewModel: WebViewModel) {
            self.parent = parent
            self.webViewModel = webViewModel
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            webViewModel.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webViewModel.isLoading = false
            webViewModel.title = webView.title ?? ""
            webViewModel.canGoBack = webView.canGoBack
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            webViewModel.isLoading = false
        }
    }
}

struct WebView: View {
    @Bindable var webViewModel: WebViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                WebViewContainer(webViewModel: webViewModel)
                if webViewModel.isLoading {
                    ProgressView()
                        .frame(height: 30)
                }
            }
            .toolbarBackground(
                hackerNewsOrangeColor,
                for: .navigationBar)
            .navigationBarTitle(Text(webViewModel.title), displayMode: .inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}
