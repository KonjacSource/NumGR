import Predefs
import Manifold.Types
import Manifold.Schwarzschild

universe u v u1 u2 v1 v2

variable
  {Chart : Type u1} {R : Type v1} {dim : Nat}
  [Manifold Chart R dim]

def Shape (Chart : Type u1) (Msg : Type u) [Manifold Chart R dim]
  := ChartedPoint Chart → Option Msg

namespace TestTracer

inductive TwoColor | Black | White deriving Repr, BEq

def CheckerboardWallX (x δx rad : Float) (M : Float)  : Shape (Schwar M) TwoColor := fun
  | ⟨_, Schwar.Watcher _ _⟩   => none
  | ⟨p, Schwarzschild⟩ => let ![_,x',y',z'] := toCartesian p;
      if Float.abs (x - x') <= δx then
        some $
          let (y'', z'') := (floatMod y' (2*rad), floatMod z' (2*rad));
          if y'' <= rad && z'' <= rad || y'' >= rad && z'' >= rad then
            TwoColor.Black
          else TwoColor.White
      else none

partial def helper (x δx rad ε limit : Float)
  (now : Float) (ray : Ray (Schwar M)) : Option TwoColor :=
    match CheckerboardWallX x δx rad M ray.position with
    | none =>
        if now >= limit then none
        else match Schwar.nextRay ε ray with
          | none => none
          | some ⟨p, d⟩ => helper x δx rad ε limit (now + ε) ⟨p, ⟦d⟧⟩
    | color => color

def traceWall (x δx rad ε limit : Float) (ray : Ray (Schwar M)) : Option TwoColor :=
  helper x δx rad ε limit 0 ray
#check Schwar.Watcher

/-- Generate a local frame at `(0, x, pi/2, 0)`, `x > 0`. $e^1$ point to `-x` -/
def genWatcherX (M x : Float) : Vector (Tensor 1 4 Float) 4 := open Float in
  let (r, θ) := (x, pi / 2);
  ![
                                     Tensor.fromList 4 (
    /- t -/ [sqrt (1 / (1 - 2*M/r)),0.0,0.0,0.0] : List Float), Tensor.fromList 4 (
    /- x -/ [0.0,- sqrt (1 - 2*M/r),0.0,0.0] : List Float), Tensor.fromList 4 (
    /- y -/ [0.0,0.0,0.0, -1 / (r * sin θ) ] : List Float), Tensor.fromList 4 (
    /- z -/ [0.0,0.0, -1/r,0.0] : List Float),
  ]


open Tensor

def toFloat : Sum UInt64 UInt64 → Float
| Sum.inl x => - x.toFloat
| Sum.inr x => x.toFloat

def rangeUInt (n : UInt64) : Array UInt64 :=
  Array.map (fun ⟨x,h⟩ => UInt64.ofNatCore x (Nat.lt_trans h n.val.isLt)) (finRange n.val.val).toArray

def rangeInt (n : UInt64) : Array (Sum UInt64 UInt64) :=
  Array.map (fun
    | Sum.inl ⟨x,h⟩ => Sum.inl $ UInt64.ofNatCore (x+1) (by {
      apply Nat.lt_trans;
      let l2 : ∀ x y, x < y - 1 → x + 1 < y := by
        intros x y h
        cases y
        cases h
        exact Nat.succ_le_succ h
      exact l2 x n.val.val h
      exact n.val.isLt
    })
    | Sum.inr ⟨x,h⟩ => Sum.inr $ UInt64.ofNatCore x (Nat.lt_trans h n.val.isLt)
  ) (List.map Sum.inl (List.reverse $ finRange (n.val.val-1)) ++ List.map Sum.inr (finRange n.val.val)).toArray

def genRayX (M x : Float) (Δ : Float) (basis : Vector (Tensor 1 4 Float) 4) (i j : Sum UInt64 UInt64) (δy δz : Float) : Ray (Schwar M) :=
  ⟨⟨![0,x,Float.pi/2,0], Schwar.Schwarzschild⟩,
    -- `-t` means trace the ray backward in time.
    let (x,y,z) := (Δ, toFloat i * δy, toFloat j * δz)
    withBasis basis $ fromList 4 ([Float.sqrt (x^2 + y^2 + z^2), x,y,z] : List Float)
  ⟩
def genRaysX (M x : Float) (m n : UInt64) (Δy Δz : Float) : Array (Array (Ray (Schwar M))) := open Array in
  let basis := genWatcherX M x;
  let (δy, δz) := (Δy / (2 * m.toFloat), Δz / (2 * n.toFloat));
  map (fun i => map (fun j =>
    genRayX M x 1 basis i j δy δz
  ) $ rangeInt n) $ rangeInt m

def traceWithWallX (x δx rad ε limit : Float) (rays : Array (Array (Ray (Schwar M))))
  : Array (Array (Option TwoColor)) := open Array in
  map (fun rss => map (traceWall x δx rad ε limit) rss) rays

#eval (genRaysX 1.0 10 3 3 10 10)
-- #eval traceWithWallX (-5) 1 0.5 0.5 10 (genRaysX 1.0 10 3 3 10 10)
-- #[#[ ∎ ∎ none    ],
--   #[ ∎ ∎ none    ],
--   #[   ∎ none ∎  ],
--   #[     none ∎ ∎],
--   #[     none ∎ ∎]]

def testRay : Ray (Schwar 1) :=
  ⟨ ⟨![0, 10, 1.570796,0], Schwar.Schwarzschild⟩
  , fromList 4 ([3.010399, -0.894427, 0.250000, 0.000000] : List Float)⟩

def traceLs (ray : Ray (Schwar M)): Nat → List (Ray (Schwar M))
| 0 => [ray]
| n+1 =>
  match Schwar.nextRay 0.5 ray with
  | none => [ray]
  | some ⟨p, d⟩ => ray :: traceLs ⟨p, ⟦d⟧⟩ n



def traceLsWithSpec (ray : Ray (Schwar M)) (spec : Ray (Schwar M) → Nat → α) : Nat → List ((Ray (Schwar M)) × α)
| 0 => [(ray, spec ray 0)]
| n+1 =>
  match Schwar.nextRay 0.5 ray with
  | none => [(ray, spec ray (n+1))]
  | some ⟨p, d⟩ => (ray, spec ray (n+1))
              :: traceLsWithSpec ⟨p, ⟦d⟧⟩ spec n

def spec_connect_check (ray : Ray (Schwar M)) (n : Nat) : (Tensor 1 4 Float × List Float) :=
match ray.position with
| ⟨![t,r,θ,φ],_⟩ => let M := 1.0; open Float in
  (
    fun ![i] => Schwar.metric ray.position ![i,i],
    [   (Schwar.connect ray.position ![0,0,1]) - M/r^2 / (1 - 2 * M / r)
      , (Schwar.connect ray.position ![1,0,0]) - M/r^2 * (1 - 2 * M / r)
      , (Schwar.connect ray.position ![1,1,1]) + M / r^2 / (1 - 2 * M / r)
      , (Schwar.connect ray.position ![1,2,2]) + r * (1 - 2 * M / r)
      , (Schwar.connect ray.position ![1,3,3]) + r * (1 - 2 * M / r) * (sin θ)^2
      , (Schwar.connect ray.position ![2,1,2]) - 1/ r
      , (Schwar.connect ray.position ![2,3,3]) + sin θ * cos θ
      , (Schwar.connect ray.position ![3,1,3]) - 1/r
      , (Schwar.connect ray.position ![3,2,3]) - 1 / tan θ
    ]
  )
def spec_metric (ray : Ray (Schwar M)) (n : Nat) : Tensor 1 4 Float :=
  fun ![i] => Schwar.metric ray.position ![i,i]

def strange (ray : Ray (Schwar M)) (n : Nat) : Option $ Tensor 3 4 Float :=
match ray.position with
| ⟨![t,r,θ,φ],_⟩ => let M := 1.0; open Float in
  if n == 30 - 2 || n == 30 - 3 || n == 30 - 4 then
    some $ Schwar.connect ray.position
  else none

-- #eval traceLsWithSpec testRay strange 200

#check System.FilePath

def main : IO Unit := do
  let M := 1.0
  let camX := 6.0
  let (Δy, Δz) := (5.0,5.0)
  let (m, n) := (240, 240)
  let wallX := -5.0
  let wallδX := 2.5
  let wallRad := 0.5
  let ε := 0.3
  let limit := 30.0
  let fileName := System.FilePath.mk "SchwarTest.ppm"
  let stm := IO.FS.Stream.ofHandle (←IO.FS.Handle.mk fileName IO.FS.Mode.writeNew)
  stm.putStrLn "P3"
  stm.putStrLn s!"{2*m-1} {2*n-1}"
  stm.putStrLn "1"
  let toColor : Option TwoColor → String
    | none => "0 0 0 "
    | some TwoColor.Black => "1 0 0 "
    | some TwoColor.White => "0 0 1 "
  let rays := genRaysX M camX m.toUInt64 n.toUInt64 Δy Δz
  let mut count := 0
  let total := (2*m-1) * (2*n-1)
  for i in List.range rays.size do
    for j in List.range (rays.get! i).size do
      count := count + 1
      IO.println s!"tracing: {count}/{total}"
      stm.putStrLn $ toColor $ traceWall wallX wallδX wallRad ε limit ((rays.get! i).get! j)
