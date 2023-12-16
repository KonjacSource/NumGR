import Mathlib
import Manifold.Tensor
import Manifold.Types

/-- A Schwarzschild coordinate system with given mass `M` of the central star. -/
inductive Schwar (M : Float) where
  /-- (t ∈ ℝ, r > 2*M, θ ∈ ℝ , φ ∈ ℝ) in ISO, the range of θ and φ are kind of ticky here.   -/
  | Schwarzschild
  /-- Proper frame with a Watcher at position `pos` (in `Schwarzschild` frame), and with local frame `axes`.-/
  | Watcher (pos : Vector Float 4) (axes : Vector (Tensor 1 4 Float) 4)
deriving Repr

def Float.pi := 3.14159265

/-- Make `x` in range \( [0,n] \)  by adding or subtracting `n`. -/
partial def floatMod (x : Float) (n : Float): Float :=
  if x < 0 then
    floatMod (x + n) n
  else if x < n then
    x
  else
    floatMod (x - n) n

/-- Make a θ and φ in the regular range. -/
def sphericalRegularize : Vector Float 4 → Vector Float 4
| ⟨[t,r,θ,φ], Eq.refl _⟩ => open Float in
    if 0 <= θ && θ <= pi then
      ⟨[t,r,θ,floatMod φ (2 * pi)], Eq.refl _⟩
    else let θ' := floatMod θ (2 * pi) ;
      if θ' > pi then
        ⟨[t,r,2 * pi - θ',floatMod (φ + pi) (2 * pi)], Eq.refl _⟩
      else ⟨[t,r,θ',floatMod φ (2 * pi)], Eq.refl _⟩

open Schwar

/-- Every point in `Watcher` frame is considered be out of manifold, since it's a local frame. -/
def Schwar.isPoint : Vector Float 4 × Schwar M → Bool
  | ⟨⟨[t,r,θ,φ], Eq.refl _⟩, Schwarzschild⟩ => r > 2 * M
  | _ => False

/-- There are no points in the `Watcher` chart, since it's a local frame. -/
def Schwar.inChart (p : Vector Float 4 × Schwar M ) (f : Schwar M)
  := Schwar.isPoint p

def Schwar.findChart : Vector Float 4 × Schwar M → Option (Vector Float 4 × Schwar M)
  | ⟨x@⟨[t,r,θ,φ], Eq.refl _⟩  , Schwarzschild⟩ => some ⟨sphericalRegularize x, Schwarzschild⟩
  | ⟨prop_coord@⟨[dt,dx,dy,dz], Eq.refl _⟩, Watcher pos axes⟩ => -- `prop_coord` is small.
      if Schwar.isPoint ⟨pos, Schwarzschild (M:= M)⟩ then open Tensor in
        some ⟨
          Vector.Applicative.seq (Vector.Functor.map (· + ·) pos) fun _ =>
            ⟨ toList (n:=1) (dim:=4) sum[
                prop_coord.get ix * axes.get ix
              | ix < 4 ]
            , by apply toListLengthDim ⟩
        , Schwarzschild ⟩
      else
        none

instance : Manifold (Schwar M) Float 4 where
  isPoint := Schwar.isPoint
  inChart := Schwar.inChart
  findChart := Schwar.findChart
  chartTrans := fun
    | ⟨v, Schwarzschild⟩, Schwarzschild => some ⟨sphericalRegularize v, Schwarzschild⟩
    | v@⟨_, Watcher _ _⟩, Schwarzschild => Schwar.findChart v
    | _, (Watcher _ _) => none
  pointEq := fun
    | ⟨v1, Schwarzschild⟩, ⟨v2, Schwarzschild⟩ =>
        (sphericalRegularize v1).val == (sphericalRegularize v2).val
    | _, _ => False

def Schwar.metric : FieldM (Schwar M) (Tensor 2 4 Float) := sorry
