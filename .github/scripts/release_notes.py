"""Extract the latest released section of CHANGELOG.md as release notes.

A released section has a level-two heading of the form ``## [VERSION]`` or
``## [VERSION] - YYYY-MM-DD``. Headings without brackets (e.g. ``## UNRELEASED``)
are skipped. When ``--tag`` is given, the latest released section must name
exactly that tag.
"""

from __future__ import annotations

import argparse
import datetime
import re
import sys
from pathlib import Path

CHANGELOG_HEADING = re.compile(r"^##[ \t]+([^\n]+)$", re.MULTILINE)
VERSION_HEADING = re.compile(r"\[(.+?)\](?:[ \t]+-[ \t]+(.+))?")


def latest_release(content: str) -> tuple[str, str]:
    """Return (version, body) of the first bracketed level-two section."""
    headings = list(CHANGELOG_HEADING.finditer(content))
    for index, match in enumerate(headings):
        title = match[1].strip()
        entry = VERSION_HEADING.fullmatch(title)
        if entry is None:
            if "[" in title or "]" in title:
                raise ValueError(f"Invalid changelog heading: {title}")
            continue
        version, date = entry[1], entry[2]
        if date is not None:
            try:
                datetime.date.fromisoformat(date.strip())
            except ValueError as error:
                raise ValueError(f"Invalid date in heading: {title}") from error
        end = headings[index + 1].start() if index + 1 < len(headings) else len(content)
        body = content[match.end() : end].strip()
        if not re.sub(r"^#+[^\n]*", "", body, flags=re.MULTILINE).strip():
            raise ValueError(f"Changelog section [{version}] has no description")
        return version, body + "\n"
    raise ValueError("No released section (## [VERSION]) found in changelog")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("changelog", type=Path)
    parser.add_argument("--tag", help="require the latest release to match this tag")
    parser.add_argument(
        "--check", action="store_true", help="validate only; do not print notes"
    )
    args = parser.parse_args()

    try:
        version, notes = latest_release(args.changelog.read_text(encoding="utf-8"))
        if args.tag is not None and version != args.tag:
            raise ValueError(
                f"Latest changelog entry [{version}] does not match tag {args.tag}"
            )
    except (OSError, ValueError) as error:
        print(f"error: {error}", file=sys.stderr)
        return 2

    if args.check:
        print(f"Latest changelog entry: [{version}]")
    else:
        sys.stdout.write(notes)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
