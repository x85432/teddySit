# 這個 Branch 主要拿來給大家看要怎麼使用 cloud functions 以及一些步驟

這些步驟不用做了，已經做好
<details>

  ## Global installation
  ```bash
  npm install -g firebase-tools
  dart pub global activate flutterfire_cli
  ```

  ## login Firebase
  ```bash
  cd teddy_sit
  firebase login
  firebae configure
  ```

  ## Add dependencies
  ```yaml
  dependencies:
    flutter:
      sdk: flutter
    google_fonts: ^6.3.1

    # firebase
    firebase_core: ^4.1.0    <--- This one
    # cloud functions
    cloud_firestore: ^6.0.1
    cloud_functions: ^6.0.1
  ```
</details>
