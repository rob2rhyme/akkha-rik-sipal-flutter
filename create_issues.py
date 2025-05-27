#!/usr/bin/env python3
import os
import sys
import requests

# ─── CONFIG ────────────────────────────────────────────────────────────────────

# You can set GITHUB_TOKEN in your env, e.g.:
#    export GITHUB_TOKEN="ghp_..."
GITHUB_TOKEN = os.getenv("GITHUB_TOKEN", "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")
if not GITHUB_TOKEN or GITHUB_TOKEN.startswith("ghp_") is False:
    print("⚠️  Please set a valid GITHUB_TOKEN environment variable.")
    sys.exit(1)

REPO_OWNER = "rob2rhyme"
REPO_NAME = "akkha-rik-sipal-flutter"
API_BASE = f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}"

HEADERS = {
    "Authorization": f"token {GITHUB_TOKEN}",
    "Accept": "application/vnd.github.v3+json",
}

# ─── NEW ISSUES ────────────────────────────────────────────────────────────────

new_issues = [
    {
        "title": "Setup App Navigation",
        "body": (
            "Create the main navigation skeleton so users can switch between all sections:\n"
            "- Use a BottomNavigationBar or Drawer with these items:\n"
            "  1. Home / Dashboard\n"
            "  2. Learn\n"
            "  3. Quizzes\n"
            "  4. Progress\n"
            "  5. Settings / About\n"
            "- Ensure navigation state is preserved when switching tabs."
        ),
        "labels": ["feature", "navigation"]
    },
    {
        "title": "Implement Home / Dashboard Screen",
        "body": (
            "Build the Home/Dashboard UI to give learners a quick snapshot of their progress:\n"
            "- Display overall completion % and recent activity.\n"
            "- Show cards for “Recently Studied Topics” and “Last Quiz Score.”\n"
            "- Include a motivational header or banner (e.g. “Keep going!”).\n"
            "- Placeholder for future “daily tip” or “streak” feature."
        ),
        "labels": ["feature", "ui", "dashboard"]
    },
    {
        "title": "Implement Learn Section",
        "body": (
            "Develop the core “Learn” section for structured Devanagari lessons:\n"
            "- Sub-pages/categories:\n"
            "  - Alphabet (अ–अः, क–ज्ञ)\n"
            "  - Matras (vowel signs)\n"
            "  - Numbers (०–९)\n"
            "  - Grammar modules (nouns, verbs, pronouns, tenses, postpositions)\n"
            "- Each lesson should load from SQLite and display title + content.\n"
            "- Navigation between lessons within a topic."
        ),
        "labels": ["feature", "ui", "learning"]
    },
    {
        "title": "Implement Quizzes Section",
        "body": (
            "Create the “Quizzes” UI/UX for self-assessment:\n"
            "- List available quizzes by topic.\n"
            "- Support randomized question order and cumulative quizzes.\n"
            "- Question types: MCQ, matching, fill-in-the-blank.\n"
            "- On completion, show score and correct/incorrect feedback."
        ),
        "labels": ["feature", "quiz", "ui"]
    },
    {
        "title": "Implement Progress Screen",
        "body": (
            "Build a “Progress” dashboard to visualize learning:\n"
            "- For each topic, show:\n"
            "  - % of lessons completed\n"
            "  - Best quiz score\n"
            "  - Last studied date\n"
            "- Use progress bars or simple charts.\n"
            "- Optionally filter by module (e.g. “Alphabet,” “Grammar”)."
        ),
        "labels": ["feature", "ui", "progress"]
    },
    {
        "title": "Implement Settings / About Screen",
        "body": (
            "Add a Settings/About section for app info and preferences:\n"
            "- Display app version, developer credits.\n"
            "- Placeholder for future features: theme toggle, data reset.\n"
            "- Include basic “About Devanagari” info or link."
        ),
        "labels": ["feature", "ui", "settings"]
    },
]

# ─── HELPERS ──────────────────────────────────────────────────────────────────

def fetch_existing_titles():
    """Return a set of all existing issue titles (open & closed)."""
    titles = set()
    page = 1
    per_page = 100
    while True:
        resp = requests.get(
            f"{API_BASE}/issues",
            headers=HEADERS,
            params={"state": "all", "page": page, "per_page": per_page}
        )
        resp.raise_for_status()
        data = resp.json()
        if not data:
            break
        for issue in data:
            titles.add(issue["title"].strip())
        page += 1
    return titles

def create_issue(issue):
    resp = requests.post(f"{API_BASE}/issues", headers=HEADERS, json=issue)
    if resp.status_code == 201:
        print(f"✅ Created: {issue['title']}")
    else:
        print(f"❌ Failed ({resp.status_code}): {issue['title']}\n{resp.json()}")

# ─── MAIN ─────────────────────────────────────────────────────────────────────

def main():
    print("🔍 Fetching existing issues…")
    existing = fetch_existing_titles()

    for issue in new_issues:
        title = issue["title"].strip()
        if title in existing:
            print(f"⏭ Skipping (already exists): {title}")
        else:
            create_issue(issue)

if __name__ == "__main__":
    main()
