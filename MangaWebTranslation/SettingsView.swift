//
//  SettingsView.swift
//  MangaWebTranslation6
//
//  Created by Jules on 2025/11/17.
//
//  設定画面のビューを定義します。
//  初期表示URLの編集・保存ができます。
//

import SwiftUI

/// 設定画面を表すビュー。
struct SettingsView: View {

    // MARK: - プロパティ

    /// このビュー（シート）を閉じるための環境変数。
    @Environment(\.dismiss) private var dismiss

    /// 初期表示URLを編集するための状態変数。
    @State private var initialUrlString: String = ""

    /// UserDefaultsに初期URLを保存するためのキー。
    private let initialUrlKey = "initialUrl"

    // MARK: - ボディ

    var body: some View {
        NavigationView {
            // Formを使用して設定項目をグループ化します。
            Form {
                Section(header: Text("一般設定")) {
                    HStack {
                        Text("初期URL:")
                        // URLを入力するためのテキストフィールド。
                        TextField("https://...", text: $initialUrlString)
                            #if os(iOS)
                            .keyboardType(.URL) // URL入力に適したキーボードを表示
                            .autocapitalization(.none) // 自動大文字化を無効
                            #endif
                    }
                }
            }
            .navigationTitle("設定") // ナビゲーションバーのタイトル
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline) // タイトルの表示モード
            #endif
            .toolbar {
                // キャンセルボタン（macOS互換）
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss() // シートを閉じます。
                    }
                }
                // 保存ボタン（macOS互換）
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        saveInitialUrl() // 入力されたURLを保存します。
                        dismiss() // シートを閉じます。
                    }
                }
            }
            .onAppear(perform: loadInitialUrl) // ビューが表示されたときに保存済みのURLを読み込みます。
        }
    }

    // MARK: - ヘルパーメソッド

    /// UserDefaultsから初期URLを読み込み、`initialUrlString`を更新します。
    private func loadInitialUrl() {
        initialUrlString = UserDefaults.standard.string(forKey: initialUrlKey) ?? "https://www.google.com"
    }

    /// `initialUrlString`の内容をUserDefaultsに保存します。
    private func saveInitialUrl() {
        UserDefaults.standard.set(initialUrlString, forKey: initialUrlKey)
    }
}

// MARK: - プレビュー

/// Xcodeのプレビュー機能でこのビューを表示するためのコード。
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
