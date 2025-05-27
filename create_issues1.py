import requests

# Replace with your actual token and repo
GITHUB_TOKEN = "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"
REPO_OWNER = "rob2rhyme"
REPO_NAME = "akkha-rik-sipal-flutter"

headers = {
    "Authorization": f"token {GITHUB_TOKEN}",
    "Accept": "application/vnd.github.v3+json",
}

issues = [
    {
        "title": "Setup Modular Feature Folder Structure",
        "body": "- Create `features/` directory with submodules for learn, practice, quiz, shared.\n- Prepare folders for vowels, consonants, matras, grammar.",
        "labels": ["setup", "structure"]
    },
    {
        "title": "Create DevanagariUnit Data Model",
        "body": "Define a `DevanagariUnit` class with character, pronunciationAudio, exampleWord, description, practiceQuestions.",
        "labels": ["model", "data"]
    },
    {
        "title": "Implement Vowel (स्वर) Learning Screen",
        "body": "- Grid or card layout\n- Character, audio, example word\n- Tap for details and audio",
        "labels": ["feature", "UI", "vowels"]
    },
    {
        "title": "Implement Consonant Learning UI",
        "body": "- Layout for consonants\n- Example and audio included\n- Use shared card widget",
        "labels": ["feature", "UI", "consonants"]
    },
    {
        "title": "Implement Matras Learning Module",
        "body": "- Visualize transformation (e.g. क + ा = का)\n- Show sample words with each matra",
        "labels": ["feature", "matra"]
    },
    {
        "title": "Add Grammar Essentials Module",
        "body": "- Rules for anuswar, visarga, chandrabindu\n- Use simple examples and mnemonics",
        "labels": ["feature", "grammar"]
    },
    {
        "title": "Build Interactive Practice UI",
        "body": "- Include drag-drop, match, or multiple choice\n- Link with data model",
        "labels": ["feature", "practice", "interaction"]
    },
    {
        "title": "Implement Quiz Feature with Scoring",
        "body": "- Multiple questions\n- Show correct/incorrect\n- Result summary",
        "labels": ["quiz", "gamification"]
    },
    {
        "title": "Add Audio Playback for Letters",
        "body": "- Use `audioplayers` package\n- Assets under `assets/audio/`\n- Tap to play",
        "labels": ["audio", "enhancement"]
    },
    {
        "title": "Add Stroke Animation for Letters",
        "body": "- Optional feature using Lottie or SVG\n- Show stroke order",
        "labels": ["animation", "optional"]
    },
    {
        "title": "Add Bottom Navigation Tabs (Learn, Practice, Quiz)",
        "body": "- Use `BottomNavigationBar`\n- Persistent across navigation",
        "labels": ["UI", "navigation"]
    },
    {
        "title": "Add XP or Star-based Progress System",
        "body": "- Track section completions\n- Reward users with stars/XP\n- Optional: store locally",
        "labels": ["gamification", "progress"]
    }
]

for issue in issues:
    response = requests.post(
        f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/issues",
        headers=headers,
        json=issue
    )
    if response.status_code == 201:
        print(f"Issue created: {issue['title']}")
    else:
        print(f"Failed to create issue: {issue['title']} - {response.status_code} - {response.text}")
