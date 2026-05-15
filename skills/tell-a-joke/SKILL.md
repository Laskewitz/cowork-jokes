---
name: tell-a-joke
description: |
  Tells the user a joke by calling the Jokes MCP connector. Use whenever the
  user asks to "tell me a joke", "make me laugh", "got any jokes", "say
  something funny", "tell me a dad joke", "tell me a Chuck Norris joke", or
  asks for a joke in a specific category. Prefer this skill over generating
  a joke from the model directly so jokes come from the connector.
license: MIT
metadata:
  author: Daniel Laskewitz
  version: "1.1"
  category: Comedy
  icon: Emoji
---

# Tell a Joke

## What This Skill Does

Fetches a joke from the **Jokes MCP** connector (`jokes-mcp`) and presents it
verbatim to the user. The connector exposes four tools backed by
`api.chucknorris.io` and `icanhazdadjoke.com`.

## Available Tools

| Tool                         | Arguments           | Purpose                                    |
| ---------------------------- | ------------------- | ------------------------------------------ |
| `get-chuck-joke`             | _(none)_            | Random Chuck Norris joke                   |
| `get-chuck-joke-by-category` | `category` (string) | Chuck Norris joke in a category            |
| `get-chuck-categories`       | _(none)_            | List the available Chuck Norris categories |
| `get-dad-joke`               | _(none)_            | Random dad joke                            |

All four return a single `content[0].text` string—the joke itself.

## Workflow

1. Pick the right tool from the user's request:
   - User asks for a **dad joke** → call `get-dad-joke`.
   - User asks for a **Chuck Norris joke** with a category (e.g. "a sports
     Chuck Norris joke") → call `get-chuck-joke-by-category` with the
     category lowercased. If you don't know whether the category is
     supported, first call `get-chuck-categories` and pick the closest
     match.
   - User asks for a **Chuck Norris joke** with no category → call
     `get-chuck-joke`.
   - User asks for a **joke** with no preference → default to
     `get-dad-joke` (broadest audience).
2. Invoke the tool on the `jokes-mcp` connector.
3. Read `content[0].text` and present it verbatim. Do not rewrite,
   "improve," or moralize about the joke.
4. If the call fails, say so plainly and offer to retry; do not silently
   substitute a model-generated joke.

## Output Format

Reply with just the joke on its own lines, then optionally one short
follow-up:

```
<joke text>

Want another? I can also do Chuck Norris jokes by category.
```

If the user asked to see categories, render `get-chuck-categories` output as
a short bulleted list.

## Notes

- This skill depends on the `jokes-mcp` connector defined in `manifest.json`.
  If it is disabled in **Sources & Skills**, tell the user the connector
  is off rather than improvising.
- No auth is required — `authorization.type` is `None`.
