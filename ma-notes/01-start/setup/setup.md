
## First Commit

- [x] get setup to run ⏳ 2025-11-14 ✅ 2025-11-14
- [x] add card with project description ⏳ 2025-11-14 ✅ 2025-11-14
	- `frontend/app/pages/index.vue`
	- branch `rai` -> rebase + force push. then open merge request

---

## Tech Stack

- webstorm/pycharm IDE
- `.env` file -> copy paste from example. llm api key
- nuxt -> vue.js -> js
- app folder: alle skripte

vue files:
- script tag (js), template tag (html), style tag
- define components -> reusable

**nuxt ui** library already contains many components
- [docs](https://ui.nuxt.com/docs/components)
- extensive functionality, uniform styling -> use :)

bugs/observations -> open an issue

## Git Conventions

1. **commit messages**:
	- verb (present!) + description
2. **merge request**:
	- push on personal branch
	- merge regularly (with new functionality)
3. **pipeline**:
	- formatting/styling, migration tests

>[!star] Local testing
>- `Ctrl+Alt+L` in jetbrains ides
>- or see [wiki](https://github.com/gamedevlabs/pix-e/wiki/How-to-test-code-locally-before-PRs)

### Merge Requests

- branch to be merged should be up to date
- if not: **rebase** + force push

```sh
git checkout new
git rebase main
git push origin main --force
```
