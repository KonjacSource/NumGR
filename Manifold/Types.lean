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
  pointEq : (Vector R dim × Chart) → (Vector R dim × Chart) → Bool

def ChartedPoint Chart [Manifold Chart R dim]  := Vector R dim × Chart

structure Ray (Chart) [Manifold Chart R dim] where
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
  metric  : FieldM Chart (Mat dim R)
  connect : FieldM Chart (Tensor 3 dim R)
  mdv : FieldM Chart (Tensor n dim R) → TanVec Chart → FieldM Chart (Tensor n dim R)
  geodesicPredict : (ε : R) → Ray Chart → ChartedPoint Chart

open Tensor

def genConnect [Floating R] [Manifold Chart R dim] : FieldM Chart (Tensor 3 dim R) := sorry
def genMdv [Floating R] [Manifold Chart R dim] : FieldM Chart (Tensor n dim R) → TanVec Chart → FieldM Chart (Tensor n dim R) := sorry
def genGeodesicPredict [Floating R] [Manifold Chart R dim] : (ε : R) → Ray Chart → ChartedPoint Chart := sorry

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
