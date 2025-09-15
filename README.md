# 這個 Branch 主要拿來給大家看要怎麼使用 cloud functions 以及一些步驟

## 步驟
  1. git clone 下來 (先不要進vscode)
  2. 切到 branch
  3. 進入專案
      - ```bash
          cd /teddySit/teddy_sit/
  5. 測試 flutter 是否在你的環境變數裡面
      - ```bash
          flutter
  7. 執行 `flutter clean`
  8. 執行 `flutter pub get`
  9. 執行 `start ms-settings:developers`， 開發人員模式開啟 (如果你還沒開的話)
  10. 執行 `npm install -g firebase-tools`
  11. 執行 `dart pub global activate flutterfire_cli`
  12. 執行 `firebase login`
  13. 執行 `flutterfire configure` (如果遇到403，要被我加進去 Firebase 專案，然後再執行一次)
      - 選擇我們的DB
      - <details><img width="519" height="59" alt="image" src="https://github.com/user-attachments/assets/83920fc2-cf9b-4940-b0f9-27142d2e048c" /></details>
  14. 在專案中開啟你的 emulator (手機模擬器)
  15. 回到 `main.dart` ， run debug mode <img width="25" height="18" alt="image" src="https://github.com/user-attachments/assets/6c4618a5-adab-4d69-8231-79e2cab1ed7c" />
      - 一定要等 Gradle 建置完成
      - <details><img width="308" height="38" alt="image" src="https://github.com/user-attachments/assets/7479fb23-e7d4-4ca8-b011-e490c4dba8ed" /></details>
  16. 測試 Do Not Disturb (點擊 UI 上的按鈕)
  17. 你會看到 Unauthenticated 的相關訊息
----
## 讓 APP 獲得 Cloud function 觸發的權限
  18. 在Vscode 的 DEBUG CONSOLE 搜尋，`Firebase Console for your project`
      - DEBUG CONSOLE 在 Terminal 那邊的視窗
  19. 找到 e 開頭的 token
      - 可能長得像這樣 `exxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`
  20. 進入 [Firebase 網站](https://console.firebase.google.com/u/0/project/teddysitdb/appcheck/products)，到我們的專案
  21. 找到 Build > App check > [Apps](https://console.firebase.google.com/u/0/project/teddysitdb/appcheck/apps) > android 三個點點 > Manage (管理偵錯...) > 命名你的 APP ，並且把你的 Token 丟進去
