# app-modeling-fixtures

Golden file snapshots for the [app-modeling skill](https://github.com/kachawla/skills/tree/main/skills/app-modeling).

## Structure

```
fixtures/
└── <repo-name>/
    ├── metadata.yaml   # source repo, skill version, timestamp
    └── app.bicep       # expected generated output
```

## Workflow

1. Run the app-modeling skill against a target repo
2. Save the generated `app.bicep` under `fixtures/<repo-name>/`
3. Fill in `metadata.yaml` with source and skill commit SHAs
4. After skill updates, regenerate and diff to verify correctness

## Versioning

Use git tags (e.g., `skill-v1`) to mark stable checkpoints. Compare across versions with:

```
git diff skill-v1..skill-v2 -- fixtures/
```
