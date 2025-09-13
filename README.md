# 這個 Branch 主要拿來給大家看要怎麼使用 cloud functions 以及一些步驟

步驟
1. git clone 下來 (先不要進vscode)
2. 切到 branch
4. cd /teddySit/teddy_sit/
3. flutter 測試有沒有這個指令
4. flutter clean
5. flutter pub get
6. start ms-settings:developers， 開發人員模式開啟
7. npm install -g firebase-tools
8. firebase login
9. flutterfire configure (如果遇到403，要被我加進去firebase專案，然後再執行一次)
10. 開啟你的emulator
11. run debug mode
12. 測試 Do Not Disturb
----
加入
13. 在Vscode的Deubg Console搜尋，`Firebase Console for your project`
14. 找到 e 開頭的token
15. 進入firebase網站，到我們的專案
16. 找到 Build > App check > Apps > android三個點點 > Manage