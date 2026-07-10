[![Built with Ondos](https://img.shields.io/badge/built%20with-Ondos-0f9d8c?labelColor=1a1a2e)](https://github.com/Montanalabs/ondos-lang)

> **Ondos** — the injection-safe language. Here prompt injection isn't *detected*, it's
> *unrepresentable*: untrusted input must cross `extract<ClosedType>` before it can reach an
> effect. `check` proves it at compile time; the compiled binary re-clamps at run time.

# Plugin broker

A **hybrid** injection-safe service — privilege **centralized** in one module, each feature
a **vertical slice** that co-locates its own trust boundary, and an injection-safe router.

```
main.wave           import router; route()
  router.wave       the route selector is UNTRUSTED -> extract<Endpoint> -> match -> slice
  installer.wave          feature slice: closed type + quarantined { extract } + using provision { commit }
  runner.wave          feature slice: closed type + quarantined { extract } + using exec { commit }
  capabilities.wave EVERY grant (the whole privileged surface) + the program budget
```

- **Capabilities (centralized):** `provision`, `exec` — all grants in one auditable file, each irreversible with a cost + confidence floor, bounded by `budget 100`.
- **Feature slices (co-located boundary):** each owns its closed type and attenuates to just its own capability via `using` — a slice literally cannot call another's sink.
- **Injection-safe routing:** the route itself is extracted into a closed `Endpoint` set, so a request can't dispatch itself to an arbitrary handler.

## Routes

| Route | Closed command | Sink |
|-------|----------------|------|
| `Install` | `InstallDecision = Add(Package) | Reject` | `provision` |
| `Execute` | `RunDecision = Run(Op) | Deny` | `exec` |

## Run the demo

```sh
examples/services/plugin-broker/demo.sh
```

Proves `SAFE`, runs both routes, and rejects an injected route at the boundary (exit 3).
The `unsafe.wave` variant — which imports the centralized capabilities and calls a sink
with untrusted data directly — proves `UNSAFE`: the checker follows taint across modules.

## Files

- `capabilities.wave` — the centralized privileged surface (grants + budget).
- `installer.wave` / `runner.wave` — the feature slices. `router.wave` — injection-safe dispatch.
- `main.wave` — entry point · `unsafe.wave` — the negative example · `ondos.toml` — the manifest.

---

<sub>Part of the <b><a href="https://github.com/Montanalabs/ondos-lang">Ondos</a></b> example corpus — 200 self-contained,
injection-safe projects. Built with Ondos, a language whose type system makes prompt injection
structurally impossible. Run <code>./demo.sh</code> with the Ondos toolchain on your PATH.</sub>
