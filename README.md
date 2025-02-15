# [The Committer](https://github.com/adeharo9/the-committer)

This project consists of a single scheduled GitHub action that decides when to generate a new commit next, and then
commits that schedule to the repository so it runs at that time. This behavior repeats in an infinite loop.

## Why?

Why not? It seemed fun.

## How does it work?

- `next-cron.tpl.yml`: template YAML file to generate the new scheduled GitHub action by substituting the next minute
and hour in the cron using envsubst. The action itself is simple:
  - Checkout the repository.
  - Determine the next cron value and generate the new GitHub action file.
  - Configure git.
  - Commit the change.
  - Push it to the repository.
- `next-cron.sh` is a simple script that:
  - Generates a random delta between 15 minutes and 24 hours.
  - Adds that to the current time.
  - Makes sure that the resulting time is correctly formed.
  - Generates the new GitHub action file with the next cron values.
  - Stores those values in a file for later use in the commit message (for no specific reason).
