import Mathlib
import Manifold.Tensor

/-- A computible "manifold". The `Chart` is just a Type of tags. -/
class Manifold (Chart : Type u) (R : outParam (Type v)) (dim : outParam Nat) where
  /-- Is the point in the manifold? -/
  isPoint : (Vector R dim × Chart) → Bool
  /-- Is the point in the chart? -/
  inChart : (Vector R dim × Chart) → Chart → Bool
  /-- From a chart to a possible chart, `isPoint From` can be `False`. Return `none` if out of manifold.-/
  findChart : (From : Vector R dim × Chart) → Option (Vector R dim × Chart)
  /-- From a chart to a certain chart, `isPoint From` can be `False`. Return `none` if out of given chart.-/
  chartTrans : (From : Vector R dim × Chart) → (To : Chart) → Option (Vector R dim × Chart)
  /-- Is same point? -/
  pointEq : (Vector R dim × Chart) → (Vector R dim × Chart) → Bool
  -- chartTrans_to_right_chart : if let some p := chartTrans f t then p.snd = t else True
/-- A point is a coordinate with its chart. -/
def ChartedPoint Chart [Manifold Chart R dim]  := Vector R dim × Chart

structure Ray (Chart : Type u) [Manifold Chart R dim] where
  position : ChartedPoint Chart
  direction : Tensor 1 dim R

instance [ToString α] : ToString (Vector α n) where
  toString := fun ⟨l, _⟩ => l.toString


instance [Manifold Chart R dim] [ToString Chart] [ToString R] : ToString (Ray Chart) where
  toString := fun ⟨p, d⟩ => s!"Ray - from {p.1} toward {d} - "

open Manifold

def FieldM Chart [Manifold Chart R dim] (T : Type u) := ChartedPoint Chart → T
def TanVec Chart [Manifold Chart R dim] := ChartedPoint Chart × Tensor 1 dim R

/-- A computible "Riemannian manifold". -/
class RieManifold (Chart : Type u) (R : outParam (Type v)) (dim : outParam Nat) extends Manifold Chart R dim where
  /-- \(g_{μν}\)-/
  metric          : FieldM Chart (Tensor 2 dim R)
  /-- \(g^{μν}\)-/
  metricInv       : FieldM Chart (Tensor 2 dim R)
  /-- \(Γ^σ_{μν}\)-/
  connect         : FieldM Chart (Tensor 3 dim R)
  /-- Covarint derivative, only works on vector field (not dual vector). -/
  mdv             : FieldM Chart (Tensor 1 dim R) → FieldM Chart (Tensor 2 dim R)
  nextRay         : (ε : R) → Ray Chart → Option (Ray Chart)

open Tensor

/-- Coordinate derivative, `dir` to choose a direction. -/
def chartDv [Manifold Chart R dim] [Derivable R T] (f : FieldM Chart T) (dir : Fin dim) : FieldM Chart T
  := fun ⟨ p, chart ⟩ => (λ x ↦ f ⟨⟨p.val.set dir.val x, by simp⟩, chart⟩)’ (p.get dir)


def genConnect [Floating R] [Manifold Chart R dim]
  (metric metricInv : FieldM Chart (Tensor 2 dim R)) : FieldM Chart (Tensor 3 dim R)
  := fun pos@⟨ p, chart ⟩ => fun ⟨ [σ, μ, ν], _ ⟩ => open Floating RieManifold in half * sum[
      metricInv ⟨ p, chart ⟩ ⟨ [σ, ρ], by simp ⟩ * (
          chartDv (fun p' => metric p' ⟨ [ρ,μ], by simp ⟩) ν pos
        + chartDv (fun p' => metric p' ⟨ [ν,ρ], by simp ⟩) μ pos
        - chartDv (fun p' => metric p' ⟨ [μ,ν], by simp ⟩) ρ pos
      )
  | ρ < dim ]

def genMdv [Floating R] [Manifold Chart R dim] (connect : FieldM Chart (Tensor 3 dim R))
  (vec : FieldM Chart (Tensor 1 dim R)) : FieldM Chart (Tensor 2 dim R)
  := fun pos => fun ⟨ [μ, ν] , _ ⟩ =>
    chartDv (fun p' => vec p' ⟨[ν],by simp⟩) μ pos
      + sum[
        connect pos ⟨[ν,μ,σ],by simp⟩ * vec pos ⟨[σ],by simp⟩
      | σ < dim ]

def genNextRay [Floating R] [Manifold Chart R dim] (connect : FieldM Chart (Tensor 3 dim R))
  (ε : R)  (ray : Ray Chart) : Option (Ray Chart)
  := let nextPos := fromList dim ray.position.1.val + ε * ray.direction;
     let nextDir : Tensor 1 dim R := fun ⟨[μ], _ ⟩ =>
        ray.direction ⟨[μ], by simp⟩
      - ε * sum[ sum[
        connect ray.position ⟨[μ,ν,ρ] , by simp⟩
          * ray.direction ⟨[ν],by simp⟩
          * ray.direction ⟨[ρ],by simp⟩
      | ν < dim ] | ρ < dim ];
  match findChart ⟨ ⟨ toList nextPos, by apply toListLengthDim ⟩, ray.position.2 ⟩ with
  | none => none
  | some pos => some ⟨ pos, nextDir ⟩

-- class RieManifold (Chart : Type u) (R : outParam (Type v)) (dim : outParam Nat) extends Metric Chart R dim where
--   connect := fun ⟨ p, chart ⟩ => fun ⟨ [σ, μ, ν], _ ⟩ => sorry
--   mdv := sorry
--   geodesicPredict := sorry


-- Simple example
namespace Cartesian

inductive Cartesian (dim : Nat) | Cartesian

instance : Manifold (Cartesian dim) Float dim where
  isPoint _ := True
  inChart _ _ := True
  findChart := some
  chartTrans f _ := some f
  pointEq x y := x.fst.val == y.fst.val

end Cartesian
