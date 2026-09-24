---
name: calendar-scheduling
description: Read the user's Google Calendar and book time on it.
---

# Calendar scheduling

Always call `get-current-time` first, so that relative dates such as "tomorrow" resolve
against the user's own time zone rather than a guess.

To answer a question about the schedule, call `list-events` for the range in question and
summarise it. Never infer an event that the tool did not return.

To book time, confirm the date, the start time, and the duration with the user, then call
`create-event` once. Never edit or delete an existing event.
