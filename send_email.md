# Postmark - Mail Service

## Send Email using Curl

```shell
curl "https://api.postmarkapp.com/email" \                                                                                                                                              ─╯
-X POST \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "X-Postmark-Server-Token: ${POSTMARK_SERVER_TOKEN}" \
-d '{
"From": "info@yourdomain.com",
"To": "user1@domain.com",
"Subject": "Postmark - Service Testing",
"TextBody": "Hello dear Postmark user.",
"HtmlBody": "<html><body><strong>Hello</strong> dear Postmark user.</body></html>"
}'
```

Success:

```shell
{
  "ErrorCode":0,
  "Message":"OK",
  "MessageID":"c853d476-5dbc-4157-a631-8f994b03cda2",
  "SubmittedAt":"2024-02-03T16:35:33.585448Z",
  "To":"user1@domain.com"
}
```