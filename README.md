# AI ventures

I’ve been in IT for over 15 years, but coding has never really been my thing—it’s always felt like a tedious part of the job. Now that AI tools are getting good enough to handle a lot of that work, I’m finally interested in building stuff without dreading the process.

This repo is a personal, public space where I’m collecting notes, experiments, and thoughts as I explore how to use the latest AI tools to get things done with as little hands-on coding as possible.

## Tool configuration and quirks

### Make VSCode + Github copilot chat stop asking to confirm commands to run in terminal

In your VScode client configuration .json file, add the following. Note that "chat.tools.autoApprove" is marked experimental so they may change or rename this later.

```json
{
    "chat.tools.autoApprove": true,
    "chat.agent.maxRequests": 10000,
    "github.copilot.chat.agent.autoFix": true,
    "github.copilot.chat.agent.runTasks": true,
    "github.copilot.chat.agent.terminal.allowList": {
        "echo": true,
        "cd": true,
        "ls": true,
        "cat": true,
        "pwd": true,
        "find": true,
        "curl": true,
        "docker": true,
        "docker-compose": true,
        "mkdir": true,
        "which": true,
        "wc": true,
        "md-tree": true,
        "sleep": true,
        "npm": true,
        "git": true,
        "go": true,
        "Write-Host": true,
        "Set-Location": true,
        "Get-ChildItem": true,
        "Get-Content": true,
        "Get-Location": true
    }
}
```

Add this to your vscode, close the file, then open command palette in vscode ":>" and "Reload windows"