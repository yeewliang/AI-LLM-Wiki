Read CLAUDE.md first.

Audit the entire wiki/ folder:
1. Find broken [[wikilinks]] where the target page does not exist
2. Find pages missing from wiki/index.md
3. Find concept pages with no backlinks (orphans)
4. Find entity pages with updated: dates older than 90 days
5. Find pages missing frontmatter fields

Output a prioritised list of issues.
Fix all critical issues immediately.
Log what was fixed in wiki/log.md.

Then run:
git add .
git commit -m "lint: [summary of fixes]"
git push