#! installer slice — a self-contained trust boundary for the provision capability. The closed type, the
#! extract boundary, and the attenuated irreversible sink all live here, so this feature's
#! whole taint -> trust -> effect story is one file. Privilege is centralized in
#! capabilities.os and attenuated here to just provision via using (least authority).
#! @taint bridge — extract<InstallDecision> turns the tainted body into a trusted command
import capabilities

type Package = Linter | Formatter | Bundler
type InstallDecision = Add(Package) | Reject

fn installHandle() {
  let body = fetch<web>
  quarantined { let decision = extract<InstallDecision>(body) confidence 80 }
  using provision { commit { provision(decision) } }
}
