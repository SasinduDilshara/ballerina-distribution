---
name: standup-update
description: Compose a daily standup update from the user's recent GitHub pull request activity.
---

# Standup update

Build the update from live GitHub data only.

1. Call `get_me` to resolve the current GitHub user.
2. Call `search_pull_requests` for pull requests that user authored or reviewed in the last day.
3. Read anything that needs detail with `pull_request_read`.

Report in three short sections: what moved yesterday, what is in review, and what is blocked.
Name each pull request by its number and title. If there was no activity, say so plainly
rather than padding the update.
