# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

from firebase_functions import https_fn
from firebase_functions.options import set_global_options
from firebase_admin import initialize_app, auth

# For cost control, you can set the maximum number of containers that can be
# running at the same time. This helps mitigate the impact of unexpected
# traffic spikes by instead downgrading performance. This limit is a per-function
# limit. You can override the limit for each function using the max_instances
# parameter in the decorator, e.g. @https_fn.on_request(max_instances=5).
set_global_options(max_instances=10)

initialize_app()


@https_fn.on_request(enforce_app_check=True)
def on_request_example(req: https_fn.Request) -> https_fn.Response:
    return https_fn.Response("Hello world!")

@https_fn.on_call(enforce_app_check=True)
def do_not_disturb(req: https_fn.CallableRequest):
    """
    此函數接收一個請求，並回傳一個簡單的 JSON 訊息。
    """
    # req.data 包含了從 Flutter 傳過來的任何資料，
    # 在此範例中我們沒有傳入資料，但您可以在此處存取。
    print("Python Cloud Function 'do_not_disturb' was called.")

    # 回傳一個包含 'message' 鍵的字典 (dictionary)，
    # 這個字典將會自動轉換成 JSON 格式並回傳給 Flutter。
    return {"message": "Clound function 成功被呼叫。"}