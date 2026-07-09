#! Router — the route selector is ITSELF untrusted, so it must cross extract<Endpoint>
#! (a closed set) before it can drive control flow. A request cannot route itself to an
#! arbitrary handler; an unknown route is rejected at the boundary.
import installer
import runner

type Endpoint = Install | Execute

fn route() {
  let sel = fetch<route>
  quarantined { let ep = extract<Endpoint>(sel) }
  match ep {
    Install => { installHandle() }
    Execute => { runHandle() }
  }
}
