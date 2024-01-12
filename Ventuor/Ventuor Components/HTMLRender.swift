//
//  HTMLRender.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/12/24.
//

import WebKit
import SwiftUI

struct HTMLRender: UIViewRepresentable {
  @Binding var html: String
   
  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }
   
  func updateUIView(_ uiView: WKWebView, context: Context) {
    uiView.loadHTMLString(html, baseURL: nil)
  }
}
