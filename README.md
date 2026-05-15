# Jokes for Cowork

A Microsoft 365 Copilot **Cowork** plugin that tells Dad Jokes and Chuck Norris
Jokes.

> [!NOTE]
> Cowork plugins use the standard **M365 Unified App Manifest** and the open
> **Agent Skills** standard (same `SKILL.md` format as Claude Code, VS Code
> Copilot, Cursor, etc.). Docs:
> <https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/cowork-plugin-development>

## Layout

```text
.
├── manifest.json              # M365 unified manifest (devPreview)
├── color.png                  # 192x192 brand icon
├── outline.png                # 32x32 white-on-transparent icon
├── assets/
│   └── yao-source.png         # Source artwork (regenerate icons from here)
├── skills/
│   └── tell-a-joke/
│       └── SKILL.md           # Uses the Jokes MCP connector
├── scripts/
│   └── build.ps1              # Builds dist/<packageName>-<version>.zip
└── dist/                      # Build output (gitignored)
```

## Build the package

```powershell
.\scripts\build.ps1
```

Produces `dist\com.laskewitz.jokes-for-cowork-1.0.0.zip`.

## Skills

This plugin includes the following skill:

### tell-a-joke

Fetches a joke from the **Jokes MCP** connector and presents it verbatim to
the user. Triggers on phrases like "tell me a joke", "make me laugh",
"tell me a dad joke", "tell me a Chuck Norris joke", or any request for a
joke in a specific category.

The skill uses four tools from the `jokes-mcp` connector:

| Tool | Purpose |
| --- | --- |
| `get-dad-joke` | Random dad joke |
| `get-chuck-joke` | Random Chuck Norris joke |
| `get-chuck-joke-by-category` | Chuck Norris joke in a specific category |
| `get-chuck-categories` | List available Chuck Norris categories |

## Upload to Microsoft 365 Admin Center

After building the package, upload the zip to your tenant:

1. Go to [Microsoft 365 Admin Center](https://admin.microsoft.com).
2. In the left navigation, click **Agents**.
3. Click **All agents**.
4. Click **...** (More options) in the top-right corner of the agents list.
5. Click **Add agent** and upload the `.zip` from the `dist/` folder.

Once uploaded, the plugin is available in Cowork.

## Spec references

* Cowork plugin build guide:
  <https://learn.microsoft.com/en-us/microsoft-365/copilot/cowork/cowork-plugin-development>
* M365 unified manifest schema (devPreview):
  <https://developer.microsoft.com/json-schemas/teams/vDevPreview/MicrosoftTeams.schema.json>
* `agentSkills` schema node:
  <https://learn.microsoft.com/en-us/microsoft-365/extensibility/schema/root-agent-skills>
* `agentConnectors` schema node:
  <https://learn.microsoft.com/en-us/microsoft-365/extensibility/schema/root-agent-connectors>
* Model Context Protocol (for connectors):
  <https://modelcontextprotocol.io/specification>
