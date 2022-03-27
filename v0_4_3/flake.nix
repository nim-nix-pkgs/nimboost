{
  description = ''Additions to the Nim's standard library, like boost for C++'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimboost-v0_4_3.flake = false;
  inputs.src-nimboost-v0_4_3.ref   = "refs/tags/v0.4.3";
  inputs.src-nimboost-v0_4_3.owner = "vegansk";
  inputs.src-nimboost-v0_4_3.repo  = "nimboost";
  inputs.src-nimboost-v0_4_3.dir   = "";
  inputs.src-nimboost-v0_4_3.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimboost-v0_4_3"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nimboost-v0_4_3";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}