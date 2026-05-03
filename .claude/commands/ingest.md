Read CLAUDE.md first.

Then look at all files in raw/ that are NOT in raw/archive/.
For each unprocessed file:
1. Create a source summary page in wiki/sources/
2. Create or update pages in wiki/concepts/ and wiki/entities/
3. Add backlinks in related pages
4. Update wiki/index.md
5. Log the operation in wiki/log.md
6. Move the processed file to raw/archive/

When all files are processed, run:
git add .
git commit -m "ingest: [list source titles]"
git push