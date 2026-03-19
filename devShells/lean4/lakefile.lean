import Lake
open Lake DSL

package "hello" where
  version := v!"0.1.0"

lean_lib «Hello» where
  -- add library configuration options here

@[default_target]
lean_exe "hello" where
  root := `Main