# Observations

## Installation

```js diffadd=6,11-13 diffrm=5,10
// Step 2: Install backend dependencies
console.log('\n📦 Installing backend (Django) dependencies...');
const activateCmd = process.platform === 'win32'
	? `.\\.venv\\Scripts\\activate && pip install -r requirements.txt`
	: `source ./.venv/bin/activate && pip install -r requirements.txt`;
	: `. ./.venv/bin/activate && pip install -r requirements.txt`;
  
// Step 2.5: Run migrations
console.log('\n📦 Installing backend (Django) dependencies...');
const runmigration = "(.venv\\Scripts\\python.exe manage.py migrate || ./.venv/bin/python manage.py migrate)";
const runmigration = process.platform === 'win32'
    ? `.venv\\Scripts\\python.exe manage.py migrate`
    : `./.venv/bin/python manage.py migrate`
runCommand(runmigration, { cwd: backendDir, shell: true });
```

```sh
[0] 
[0] > pix-e-root@0.0.0 start-backend
[0] > cd backend && (.venv\Scripts\python.exe manage.py runserver || ./.venv/bin/python manage.py runserver)
[0] 
[1] 
[1] > pix-e-root@0.0.0 start-frontend
[1] > cd frontend && npm run dev
[1] 
[0] sh: 1: .venvScriptspython.exe: not found
[1] 
```

- [ ] debug installation
