# Telebot Sender

A GitHub Action that sends Telegram messages and/or files to users listed in a `users.csv` file.

## Setup

1. **Create a Telegram Bot**:
   - Message [@BotFather](https://t.me/BotFather) on Telegram
   - Create a new bot and get the API token

2. **Create users.csv**:
   - Create a file named `users.csv` in your repository root
   - Add Telegram user IDs (one per line):
     ```
     123456789
     987654321
     555555555
     ```

3. **Add the Action to your workflow**:

```yaml
name: Send Telegram Notification
on:
  push:
    branches: [main]

jobs:
  send-telegram:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        
      - name: Send Telegram Message
        uses: tree-1917/teleboter@main
        with:
          api_token: ${{ secrets.TELEGRAM_BOT_TOKEN }}
          message: "🚀 New deployment completed successfully!"
          # Optional:
          # file: "release.apk" # path to file 
          # caption: "Latest APK release" # caption of file 
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `api_token` | Telegram Bot API Token | Yes | - |
| `message` | Message text to send | Yes | - |
| `file` | Optional file path to send | No | - |
| `caption` | Optional caption for file | No | - |

## Secrets

Add your bot token as a repository secret:
- Go to your repository → Settings → Secrets → New secret
- Name: `TELEGRAM_BOT_TOKEN`
- Value: Your bot API token

## Usage Examples

**Send only message:**
```yaml
- uses: tree-1917/teleboter@main
  with:
    api_token: ${{ secrets.TELEGRAM_BOT_TOKEN }}
    message: "Build completed successfully! 🎉"
```

**Send message with file:**
```yaml
- uses: tree-1917/teleboter@main
  with:
    api_token: ${{ secrets.TELEGRAM_BOT_TOKEN }}
    message: "New release available!"
    file: "app-release.apk"
    caption: "Version 2.0.0 - Download now!"
```

## Notes

- The `users.csv` file must exist in your repository root
- Each line in `users.csv` should contain a single Telegram user ID
- The bot must be started by each user before it can send them messages
- Users must not have blocked the bot

## Error Handling

The action will fail if:
- `users.csv` file is not found
- Invalid API token is provided
- Network issues occur when sending messages

## License

MIT License - feel free to modify and use as needed.
