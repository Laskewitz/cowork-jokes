# 😄 Jokes for Cowork

![Jokes for Cowork](color.png)

**A Microsoft 365 Copilot Cowork plugin that brings Dad Jokes and Chuck Norris Jokes straight into your workday.**

_Because every standup deserves a punchline._

---

> [!NOTE]
> Cowork plugins use the standard **M365 Unified App Manifest** and the open
> **Agent Skills** standard (same `SKILL.md` format as Claude Code, VS Code
> Copilot, Cursor, etc.). [Docs](https://learn.microsoft.com/microsoft-365/copilot/cowork/cowork-plugin-development)

## 📁 Layout

```text
.
├── manifest.json              # M365 unified manifest (devPreview)
├── color.png                  # 192x192 brand icon
├── outline.png                # 32x32 white-on-transparent icon
├── assets/
│   └── yao-source.png         # Source artwork
├── skills/
│   └── tell-a-joke/
│       └── SKILL.md           # Uses the Jokes MCP connector
├── scripts/
│   └── build.ps1              # Builds dist/<packageName>-<version>.zip
└── dist/                      # Build output (gitignored)
```

## 🔨 Build the package

```powershell
.\scripts\build.ps1
```

Produces `dist\com.laskewitz.jokes-for-cowork-<version>.zip`.

## 🎭 Skills

### 💬 tell-a-joke

Fetches a joke from the **Jokes MCP** connector and delivers it verbatim to
the user. Just ask Cowork to make you laugh — it knows what to do. 😄

Triggers on phrases like _"tell me a joke"_, _"make me laugh"_,
_"tell me a dad joke"_, _"tell me a Chuck Norris joke"_, or any request for a
joke in a specific category.

The skill uses four tools from the `jokes-mcp` connector:

| Tool | What it does |
| --- | --- |
| `get-dad-joke` | 👴 Random dad joke |
| `get-chuck-joke` | 💪 Random Chuck Norris joke |
| `get-chuck-joke-by-category` | 🎯 Chuck Norris joke in a specific category |
| `get-chuck-categories` | 📋 List available Chuck Norris categories |

> [!TIP]
> Not sure which category to pick? Ask Cowork to list the Chuck Norris
> categories first — then go for _"tell me a sport Chuck Norris joke"_. 🏆

## 🚀 Upload to Microsoft 365 Admin Center

After building the package, upload the zip to your tenant:

1. Go to [Microsoft 365 Admin Center](https://admin.microsoft.com).
2. In the left navigation, click **Agents**.
3. Click **All agents**.
4. Click **...** (More options) in the top-right corner of the agents list.
5. Click **Add agent** and upload the `.zip` from the `dist/` folder.

Once uploaded, the plugin is available in Cowork — time to get joking! 🎉

## 📚 Spec references

| Resource | Link |
| --- | --- |
| Cowork plugin build guide | [learn.microsoft.com](https://learn.microsoft.com/microsoft-365/copilot/cowork/cowork-plugin-development) |
| M365 unified manifest schema | [schema ref](https://developer.microsoft.com/json-schemas/teams/vDevPreview/MicrosoftTeams.schema.json) |
| `agentSkills` schema node | [learn.microsoft.com](https://learn.microsoft.com/microsoft-365/extensibility/schema/root-agent-skills) |
| `agentConnectors` schema node | [learn.microsoft.com](https://learn.microsoft.com/microsoft-365/extensibility/schema/root-agent-connectors) |
| Model Context Protocol | [modelcontextprotocol.io](https://modelcontextprotocol.io/specification) |

## 🙏 Credits

The jokes in this plugin are powered by two awesome free APIs:

| API | What it provides |
| --- | --- |
| [icanhazdadjoke.com](https://icanhazdadjoke.com) | 👴 The internet's largest collection of dad jokes |
| [api.chucknorris.io](https://api.chucknorris.io) | 💪 A free JSON API for hand-curated Chuck Norris facts |

Big thanks to the maintainers of these APIs for keeping the laughs free and public. 🎉
