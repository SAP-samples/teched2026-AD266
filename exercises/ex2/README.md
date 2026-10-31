# Exercise 2 — Convert a JavaScript SAPUI5 project to TypeScript (30 min)

[← Previous: Exercise 1 — Create & enhance a JS app](../ex1/README.md) | [Back to Overview](../../README.md) | [Next: Exercise 3 — Modernize a legacy app →](../ex3/README.md)

In this exercise you convert the JavaScript app from Exercise 1 to **TypeScript** using the
dedicated **UI5 TypeScript conversion skill**, which applies the official conversion guidelines
(project setup, `tsconfig`, types packages, ES modules, typed event handlers). You then fix any
remaining type errors together with Claude Code and verify the result compiles, runs, and lints
clean.

## 2.0 Set up your starting point

> [!IMPORTANT]
> Each exercise works best in its **own Claude Code session** so the context stays focused.
> Follow the steps below before running the conversion skill.

### Copy your Exercise 1 app (or use the sample app)

**If you completed Exercise 1**, copy your finished app into a new folder: in File Explorer, copy the project folder and paste it with a new name inside `Desktop\apps`.

Then open a **new Claude Code session** pointed at the new project folder.

**If you did not complete Exercise 1**, download the ready-made sample app instead:

1. Download [sample-app.zip](https://github.com/UI5/sample-app/archive/refs/heads/main.zip) and save it to `Desktop\apps`.
2. In File Explorer, right-click the zip and choose **Extract All…** → extract into `Desktop\apps\ad266.products-ts`.
3. Open a terminal in `Desktop\apps\ad266.products-ts` and run:
   ```
   npm install
   ```

Then open a **new Claude Code session** pointed at `Desktop\apps\ad266.products-ts`.

> [!TIP]
> Starting a new session keeps the TypeScript conversion context clean and avoids carry-over
> tool state from Exercise 1.

## 2.1 Install the TypeScript conversion plugin

```bash
claude plugin install ui5-typescript-conversion@claude-plugins-official
```

> [!IMPORTANT]
> The conversion **skill** owns the full setup (dependencies, `tsconfig.json`, `ui5.yaml` transpile
> config, ES-module conversion). The UI5 MCP server also exposes a TypeScript-conversion guideline
> tool — **disable it** so the two don't overlap and the skill drives the conversion.
>
> Exit any running Claude Code session first, then start a new one with the tool disabled:
> ```bash
> claude --disallowedTools "mcp__plugin_ui5_ui5-mcp-server__get_typescript_conversion_guidelines"
> ```

## 2.2 Run the conversion skill

> [!TIP]
> 💡 **Task:** Point Claude Code at the Exercise 1 app and run:
> ```
> /ui5-typescript-conversion
> ```
> Approve the steps as it works. Watch it:
> - add `typescript`, `@sapui5/types` (matching the project's SAPUI5 version), and the
>   `ui5-tooling-transpile` tooling as dev dependencies;
> - add a `tsconfig.json` (with the `paths` map for the app namespace) and a `ts-typecheck` script;
> - update `ui5.yaml` with the transpile task and middleware.

## 2.3 Watch the code conversion

Claude Code converts the app modules from the proprietary SAPUI5 class syntax to standard ES classes
and ES imports:

- `Controller.extend("...", { ... })` → `export default class … extends Controller { … }` with a
  `@namespace` JSDoc comment.
- `sap.ui.define([...], function(...) {...})` → `import` statements + `export default`.
- Event handlers get **specific SAPUI5 event types**, e.g.:

```ts
import { Table$SelectionChangeEvent } from "sap/m/Table";

onSelectionChange(event: Table$SelectionChangeEvent): void {
    // event.getParameter(...) is now typed
}
```

> [!TIP]
> 💡 **Task:** Skim one converted controller. Confirm it imports real SAPUI5 types (no `sap.m.Button`
> global references, no `any`/`unknown` casts) and that all JSDoc comments were preserved.

## 2.4 Fix remaining type errors

> [!TIP]
> 💡 **Task:** Ask Claude Code:
> ```
> Run the type check and fix any remaining type errors.
> ```
> ```bash
> npx tsc --noEmit
> ```
> Common cases: casting the result of `this.byId(...)` / `getModel(...)` to the specific control or
> model type, and adding private member declarations to classes.

## Discussion

- Where did the type system surface a **latent bug** or an unclear assumption that the JavaScript
  version hid (e.g. an event parameter that was never actually available, a model that could be
  `undefined`)?
- Why is importing `Button$PressEvent` better than casting `event` to `any`?

## Verify

- [ ] `npx tsc --noEmit` passes with no errors.
- [ ] The app still runs and behaves as in Exercise 1.
- [ ] The UI5 linter is clean: *"Run the UI5 linter and report the findings."*

## Summary

You converted a SAPUI5 application to TypeScript with the conversion skill and verified it end-to-end. In
Exercise 3 you switch from *building* to *modernizing* — taking a deliberately legacy app and
bringing it up to current best practices with the modernization workflow.

---

[← Previous: Exercise 1 — Create & enhance a JS app](../ex1/README.md) | [Back to Overview](../../README.md) | [Next: Exercise 3 — Modernize a legacy app →](../ex3/README.md)
