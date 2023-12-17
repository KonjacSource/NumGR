import Lake
open Lake DSL

package «numGR» {
  -- add any package configuration options here
}

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib «NumGR» {
  -- add any library configuration options here
}

lean_lib «Manifold» {}

lean_lib «Predefs» {}


@[default_target]
lean_exe «numGR» {
  root := `Manifold.Schwarzschild
}
