{
  description = ''Additions to the Nim's standard library, like boost for C++'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimboost-v0_5_5.flake = false;
  inputs.src-nimboost-v0_5_5.owner = "vegansk";
  inputs.src-nimboost-v0_5_5.ref   = "refs/tags/v0.5.5";
  inputs.src-nimboost-v0_5_5.repo  = "nimboost";
  inputs.src-nimboost-v0_5_5.type  = "github";
  
  inputs."patty".owner = "nim-nix-pkgs";
  inputs."patty".ref   = "master";
  inputs."patty".repo  = "patty";
  inputs."patty".type  = "github";
  inputs."patty".inputs.nixpkgs.follows = "nixpkgs";
  inputs."patty".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimboost-v0_5_5"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-nimboost-v0_5_5";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}