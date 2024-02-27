import Manifold.Tensor
import Manifold.Types

/-- A Schwarzschild coordinate system with given mass `M` of the central star. -/
inductive Schwar (M : Float) where
  /-- `(t ∈ ℝ, r > 2*M, θ ∈ [pi/4, 3*pi/4] , φ ∈ ℝ )`
    The range of θ and φ are kind of ticky here.   -/
  | SchwarzschildA
  /-- `(t ∈ ℝ, r > 2*M, θ' ∈ [pi/4, 3*pi/4] , φ' ∈ ℝ )` -/
  | SchwarzschildB
  /-- Proper frame with a Watcher at position `pos` (in `SchwarzschildA` frame), and with local frame `axes` (in `SchwarzschildA` frame).-/
  | Watcher (pos : Vector Float 4) (axes : Vector (Tensor 1 4 Float) 4)
deriving Repr

def Float.pi := 3.14159265

/-- Make `x` in range \( [0,n] \) by adding or subtracting `n`. -/
def floatMod (x : Float) (n : Float): Float :=
  x - Float.floor (x / n) * n


/-- Make a θ and φ in the regular range. -/
def sphericalRegularize : Vector Float 4 → Vector Float 4
| ![t,r,θ,φ]=> open Float in
    if 0 <= θ && θ <= pi then
      ![t,r,θ,floatMod φ (2 * pi)]
    else let θ' := floatMod θ (2 * pi) ;
      if θ' > pi then
        ![t,r,2 * pi - θ',floatMod (φ + pi) (2 * pi)]
      else ![t,r,θ',floatMod φ (2 * pi)]

open Schwar

def Schwar.A2B : Vector Float 4 → Vector Float 4
  | ![t,r,θ,φ] => open Float in
      ![t, r, acos (sin θ * cos φ), atan2 (cos θ) (sin θ * sin φ)]

def Schwar.B2A : Vector Float 4 → Vector Float 4
  | ![t,r,θ',φ'] => open Float in
      ![t, r, acos (sin θ' * sin φ'), atan2 (sin θ' * cos φ') (cos θ')]

/-- Every point in `Watcher` frame is considered to be out of the manifold, since it's a local frame. -/
def Schwar.isPoint : Vector Float 4 × Schwar M → Bool
  | ⟨![t,r,θ ,φ ], SchwarzschildA⟩ => open Float in r > 2 * M && θ >= pi / 4 && θ <= 3 * pi / 4
  | ⟨![t,r,θ',φ'], SchwarzschildB⟩ => open Float in r > 2 * M && θ'>= pi / 4 && θ'<= 3 * pi / 4
  | _ => False

/-- There are no points in the `Watcher` chart, since it's a local frame. -/
def Schwar.inChart (p : Vector Float 4 × Schwar M ) (f : Schwar M)
  := Schwar.isPoint p


def Schwar.findChart : Vector Float 4 × Schwar M → Option (Vector Float 4 × Schwar M)
  | ⟨x@![t,r,θ,φ]  , SchwarzschildA⟩ =>
    if r < 2 * M then none else
    let sx := sphericalRegularize x;
    let p := ⟨sx, SchwarzschildA⟩;
    if isPoint p then
      some p
    else
      some ⟨A2B sx, SchwarzschildB⟩

  | ⟨x@![t,r,θ',φ']  , SchwarzschildB⟩ =>
    if r < 2 * M then none else
    let sx := sphericalRegularize x;
    let p := ⟨sx, SchwarzschildB⟩;
    if isPoint p then
      some p
    else
      some ⟨B2A sx, SchwarzschildA⟩
  | ⟨prop_coord@![dt,dx,dy,dz], Watcher pos axes⟩ => -- `prop_coord` is small.
      if Schwar.isPoint ⟨pos, SchwarzschildA (M:= M)⟩ then open Tensor in
        some ⟨
          Vector.Applicative.seq (Vector.map (· + ·) pos) fun _ =>
              sum[
                  prop_coord.get ix * axes.get ix
              | ix < 4 ].toVec
          , SchwarzschildA ⟩
      else if Schwar.isPoint ⟨pos, SchwarzschildB (M:= M)⟩ then open Tensor in
        let xa : Vector Float 4 := Vector.Applicative.seq (Vector.map (· + ·) pos) fun _ =>
              sum[
                  prop_coord.get ix * axes.get ix
              | ix < 4 ].toVec;
        some ⟨A2B xa , SchwarzschildB⟩
      else none

instance SchwarManifold : Manifold (Schwar M) Float 4 where
  isPoint := Schwar.isPoint
  inChart := Schwar.inChart
  findChart := Schwar.findChart
  chartTrans := fun
    | ⟨v, SchwarzschildA⟩, SchwarzschildA => some ⟨sphericalRegularize v, SchwarzschildA⟩
    | ⟨v, SchwarzschildB⟩, SchwarzschildB => some ⟨sphericalRegularize v, SchwarzschildB⟩
    | ⟨v, SchwarzschildA⟩, SchwarzschildB => some ⟨A2B v, SchwarzschildB⟩
    | ⟨v, SchwarzschildB⟩, SchwarzschildA => some ⟨B2A v, SchwarzschildA⟩
    | ⟨v, Watcher _ _⟩, SchwarzschildA =>
        if Schwar.isPoint (M:=M) ⟨v, SchwarzschildA⟩ then
          some ⟨v, SchwarzschildA⟩
        else none
    | ⟨v, Watcher _ _⟩, SchwarzschildB =>
        if Schwar.isPoint (M:=M) ⟨v, SchwarzschildB⟩ then
          some ⟨A2B v, SchwarzschildB⟩
        else none
    | _, (Watcher _ _) => none
  pointEq := fun
    | ⟨v1, SchwarzschildA⟩, ⟨v2, SchwarzschildA⟩ =>
        sphericalRegularize v1 == sphericalRegularize v2
    | ⟨v1, SchwarzschildB⟩, ⟨v2, SchwarzschildB⟩ =>
        sphericalRegularize v1 == sphericalRegularize v2
    | ⟨v1, SchwarzschildA⟩, ⟨v2, SchwarzschildB⟩ =>
        A2B v1 == sphericalRegularize v2
    | ⟨v1, SchwarzschildB⟩, ⟨v2, SchwarzschildA⟩ =>
        B2A v1 == sphericalRegularize v2
    | _, _ => False
  vecTrans := fun
    | (SchwarzschildA, SchwarzschildA) => fun _ => Tensor.delta
    | (SchwarzschildB, SchwarzschildB) => fun _ => Tensor.delta
    | (SchwarzschildA, SchwarzschildB) => fun (xs, chart) =>
      let xs' := match chart with
        | SchwarzschildA => A2B xs
        | SchwarzschildB => xs
        | Watcher pos _ => A2B pos
      let θ' := xs'.get 2
      let φ' := xs'.get 3
      open Float in Tensor.fromList 4
      ( [ [1,0,   0,   0]
        , [0,1,   0,   0]
        , [0,0, -(cos θ' * sin φ') / sqrt (1 - (sin φ')^2 * (sin θ')^2)
              , - (cos φ' * (sin θ')^2) / sqrt (1 - (sin φ')^2 * (sin θ')^2)]
        , [0,0, -((cos φ' * cos θ' ^ 2)/(cos θ' ^ 2 + cos φ' ^ 2 * sin θ' ^ 2)) - (cos φ' * sin θ' ^ 2)/(cos θ' ^ 2 + cos φ' ^ 2 * sin θ' ^ 2)
              , (cos θ' * sin φ' * sin θ')/(cos θ' ^ 2 + cos φ' ^ 2 * sin θ' ^ 2)]
        ]
      : List (List Float))
    | (SchwarzschildB, SchwarzschildA) => fun (xs, chart) =>
      let xs' := match chart with
        | SchwarzschildA => xs
        | SchwarzschildB => B2A xs
        | Watcher pos _ => pos
      let θ := xs'.get 2
      let φ := xs'.get 3
      open Float in Tensor.fromList 4
      (
        [ [1,0, 0,   0]
        , [0,1, 0,   0]
        , [0,0, -((cos φ*cos θ)/sqrt (1 - cos φ^2*sin θ^2))
              , (sin φ*sin θ)/sqrt (1 - cos φ^2*sin θ^2)]
        , [0,0, -((cos θ^2*sin φ)/(cos θ^2 + sin φ^2*sin θ^2)) - (sin φ*sin θ^2)/ (cos θ^2 + sin φ^2*sin θ^2)
              , -((cos φ*cos θ*sin θ)/(cos θ^2 + sin φ^2*sin θ^2))]
        ]
      : List (List Float))
    | _ => panic! "TODO"

protected def Schwar.g (M : Float) : Vector Float 4 → Tensor 2 4 Float
  | ![t,r,θ,φ] => open Float in Tensor.fromList 4
    ( [ [ - (1 - 2 * M/r), 0              , 0       , 0                     ]
      , [ 0              , 1 / (1 - 2*M/r), 0       , 0                     ]
      , [ 0              , 0              , r ^ 2   , 0                     ]
      , [ 0              , 0              , 0       , r^2 * (sin θ)^2       ]
      ]
    : List (List Float))

def Schwar.metric : Vector Float 4 × Schwar M → Tensor 2 4 Float
  | ⟨p, Schwar.SchwarzschildA⟩ => Schwar.g M p
  | ⟨p, Schwar.SchwarzschildB⟩ => Schwar.g M p
  | ⟨_, Watcher pos _⟩         => Schwar.g M pos

protected def Schwar.gInv (M : Float) : Vector Float 4 → Tensor 2 4 Float
  | ![t,r,θ,φ] => open Float in Tensor.fromList 4
    ( [ [ r / (2*M - r)  , 0              , 0       , 0                     ]
      , [ 0              , 1 - 2*M / r    , 0       , 0                     ]
      , [ 0              , 0              , 1 / r^2 , 0                     ]
      , [ 0              , 0              , 0       , 1 / (r^2 * (sin θ)^2) ]
      ]
    : List (List Float))

def Schwar.metricInv : Vector Float 4 × Schwar M → Tensor 2 4 Float
  | ⟨p, Schwar.SchwarzschildA⟩ => Schwar.gInv M p
  | ⟨p, Schwar.SchwarzschildB⟩ => Schwar.gInv M p
  | ⟨_, Watcher pos _⟩        => Schwar.gInv M pos

def Schwar.connect : FieldM (Schwar M) (Tensor 3 4 Float)
  := genConnect Schwar.metric Schwar.metricInv

def Schwar.mdv : FieldM (Schwar M) (Tensor 1 4 Float) → FieldM (Schwar M) (Tensor 2 4 Float)
  := genMdv Schwar.connect

def Schwar.nextRay : Float → Ray (Schwar M) → Option (Ray (Schwar M))
  := genNextRay Schwar.connect

instance : RieManifold (Schwar M) Float 4 where
  metric    := Schwar.metric
  metricInv := Schwar.metricInv
  connect   := Schwar.connect
  mdv       := Schwar.mdv
  nextRay   :=Schwar.nextRay

open Float Tensor

instance [Repr T] : Repr (Option T) where
  reprPrec s n := match s with
    | none => Std.Format.text "none"
    | some x => (Std.Format.text "some ").append (reprPrec x n)


def toCartesianA : Vector Float 4 → Vector Float 4
  | ![t,r,θ,φ] => ![t, r * sin θ * cos φ, r * sin θ * sin φ, r * cos θ]

def toCartesianB : Vector Float 4 → Vector Float 4
  | ![t,r,θ',φ'] => ![t, r * cos θ', r * sin θ' * cos φ', r * sin θ' * sin φ']

instance : Inhabited (Ray (Schwar M)) where
  default := Ray.mk
    ⟨![0, 3*M, 0, 0] , SchwarzschildA⟩
    (fromList 4 ([0,0,0,0] : List Float))

namespace Test


def testRay : Ray (Schwar 1.0) := ⟨
    ⟨![0, 10, pi/2, 0.0], SchwarzschildA⟩,
    fromList 4 ([1, -1, 0, 0] : List Float)
  ⟩


partial def helper (ray : Ray (Schwar M)) (now : Float) (l : Float) := if now <= l then
    match Schwar.nextRay 0.01 ray with
    | none => ray
    | some ⟨p, d⟩ => helper ⟨p, ⟦d⟧⟩ (now + 0.01) l
  else ray

def trace (ray : Ray (Schwar M)) (l : Float) : Ray (Schwar M) := helper ray 0 l

-- #eval (Floating.half : Float)
-- #eval Schwar.connect (M:=1.0) (testRay.position)
-- #eval (Floating.eps : Float)
-- #eval trace testRay 3
-- #eval Schwar.nextRay 0.01 testRay >>= Schwar.nextRay 0.01 >>= Schwar.nextRay 0.01
-- #eval (nextRay 0.01 (Ray.mk
--     ⟨
--   ![0.040080, 4.960026, 1.570796, 0.000000]
--     , Schwarzschild (M:=1.0)⟩
--     (fromList 4 (
--   [1.005384, -0.998283, 0.000000, 0.000000]
--     : List Float))
-- ))


end Test
