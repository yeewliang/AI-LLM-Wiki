Read CLAUDE.md first.

Generate a structured technical briefing on: $ARGUMENTS

Synthesise across all relevant pages in wiki/.
Structure the output with clear sections.
Save the result to output/YYYY-MM-DD-[topic]-report.md
Log the operation in wiki/log.md.

Then run:
git add output/
git commit -m "report: $ARGUMENTS"
git push