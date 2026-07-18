---
start:
end:
tags:
milestone:
---

- [x] contrast between nodes and background ✅ 2026-07-17
- [ ] lock symbols?
- [ ] sum/average in diagrams
- [x] reachability (grey highlighting of visited nodes when pathfinding fails) ✅ 2026-07-17

---

```bash title="fix-pipeline.sh"
#!/bin/bash
echo "Starting Checks...."
echo "BACKEND"
cd backend
echo "black"
black .
echo "isort"
isort .
echo "flake8"
flake8 .
echo "mypy"
mypy .

echo "FRONTEND"
cd ../frontend
echo "npm run format"
npm run format
echo "lint"
npm run lint

cd ..

```

