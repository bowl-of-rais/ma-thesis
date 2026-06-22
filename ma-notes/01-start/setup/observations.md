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
sudo docker compose up -d
sudo docker compose stop backend-dev
sudo docker compose cp ../backend/db.sqlite3 backend-dev:/app/data/db.sqlite3
sudo docker compose start backend-dev
```
