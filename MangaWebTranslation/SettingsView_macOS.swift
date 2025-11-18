//
//  SettingsView_macOS.swift
//  MangaWebTranslation6
//
//  Created by Jules on 2025/11/17.
//
//  macOS専用の設定画面を定義します。
//

import SwiftUI

struct SettingsView_macOS: View {

    // MARK: - プロパティ

    @Environment(\.dismiss) private var dismiss
    @State private var initialUrlString: String = ""
    private let initialUrlKey = "initialUrl"

    // MARK: - ボディ

    var body: some View {
        VStack(spacing: 0) {
            Text("設定")
                .font(.headline)
                .padding()

            Divider()

            Form {
                Section(header: Text("一般設定")) {
                    HStack {
                        //Text("初期URL:")
                        TextField("初期URL:", text: $initialUrlString)
                    }
                }
            }
            .padding()

            Spacer()

            Divider()

            HStack {
                Button("キャンセル") {
                    dismiss()
                }
                Spacer()
                Button("保存") {
                    saveInitialUrl()
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
            }
            .padding()
        }
        .frame(width: 480, height: 200) // macOSに適したウィンドウサイズ
        .onAppear(perform: loadInitialUrl)
    }

    // MARK: - ヘルパーメソッド

    private func loadInitialUrl() {
        initialUrlString = UserDefaults.standard.string(forKey: initialUrlKey) ?? "https://www.google.com"
    }

    private func saveInitialUrl() {
        UserDefaults.standard.set(initialUrlString, forKey: initialUrlKey)
    }
}

// MARK: - プレビュー
struct SettingsView_macOS_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView_macOS()
    }
}
