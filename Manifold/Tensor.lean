-- import Mathlib.Data.Vector
-- import Mathlib.Data.List.Defs

import Predefs

def Tensor (rank : Nat) (dim : Nat) (R : Type u) : Type u := Vector (Fin dim) rank → R


namespace Tensor

class Derivable (I : Type u) (R : Type u) where
  dv : (I → R) → (I → R)
postfix:max "’" => Derivable.dv

class Floating (R : Type u)
  extends Add R, Sub R, Neg R, Div R, Pow R R, Zero R, One R, Mul R
        , Inhabited R, Derivable R R where
  default := zero
  half := one / (one + one)
  eps : R


instance : Floating Float where
  half := 0.5
  eps := 1e-4
  dv f x := let ε := 1e-4; (f (x + ε/2) - f (x - ε/2)) / ε


instance : Functor (Tensor rank dim) where
  map f t := fun v => f $ t v

instance : Applicative (Tensor rank dim) where
  pure x := fun _ => x
  seq tf t := fun v => tf v (t () v)

instance [Derivable I R] : Derivable I (Tensor rank dim R) where
  dv f x := fun v => (flip f v)’ x

instance [Zero R] : Zero (Tensor rank dim R) where
  zero := pure Zero.zero

instance [Add R] : Add (Tensor rank dim R) where
  add a b := Add.add <$> a <*> b

instance [Mul R] : HMul R (Tensor rank dim R) (Tensor rank dim R) where
  hMul x t := Functor.map (x * ·) t

@[simp]
def applyN (f : α → α) : Nat → α → α
  | 0 , a => a
  | n + 1, a => f (applyN f n a)

instance [r2s : ToString R] : ToString (applyN List 0 R) where
  toString t := r2s.toString t

instance applyNToStr [ToString R] [ToString (applyN List n R)]
  : ToString (applyN List (n + 1) R) where
  toString x := toString (α := List (applyN List n R)) x

def largerFins : List (Fin n) → List (Fin (n + k))
| [] => []
| ⟨x,prf⟩ ::xs => ⟨x, lt_add_right prf⟩ :: largerFins xs

def largerFinsVec : Vector (Fin n) m → Vector (Fin (n + k)) m
  | ![] => ![]
  | ⟨x,prf⟩#:xs => ⟨x, lt_add_right prf⟩ #:  largerFinsVec xs

theorem largerFins_keep_length : (largerFins (n:=n) (k:=k) f).length =  f.length := by
  cases f
  rfl
  simp[largerFins]
  apply largerFins_keep_length


def finRange n : List (Fin n) := match n with
  | 0 => []
  | n + 1 => (largerFins $ finRange n).concat ⟨ n , by apply Nat.lt.base ⟩

def finRangeVec n : Vector (Fin n) n := match n with
  | 0 => ![]
  | n+1 => (largerFinsVec $ finRangeVec n).concat ⟨n , by apply Nat.lt.base⟩

theorem concatLength : (ls : List α) → (ls.concat x).length = ls.length + 1
| [] => rfl
| y::ys => by simp

theorem finRangeNum : (n : Nat) → List.length (finRange n) = n
| 0 => rfl
| n + 1 => by
  simp[finRange,largerFins]
  let pre : (finRange n).length = n := finRangeNum n
  let a := (largerFins (n:=n) (k:=1) (finRange n)).length
  let h1 : a = (finRange n).length := largerFins_keep_length
  rw [pre] at h1
  exact h1

def toList : {n : Nat} → Tensor n dim R → applyN List n R
  | 0    , t => t Vector.nil
  | n + 1, t => List.map (fun i => toList fun v =>
        t (i #: v)
      ) $ finRange dim

def toVec : {n : Nat} → Tensor n dim R → applyN (fun α => Vector α dim) n R
  | 0, t => t Vector.nil
  | n+1, t => Vector.map (fun i => toVec fun v =>
        t (i #: v)
      ) $ finRangeVec dim

theorem toListLengthDim {tensor : Tensor (n+1) dim R} : List.length (toList tensor) = dim :=
by
  cases dim with
  | zero => rfl
  | succ d => simp[toList] ; apply finRangeNum

theorem lengthSuc : List.length (x :: xs) = n + 1 → List.length xs = n :=
by
  simp
  exact id

/-- This function may require specific `R`.-/
def fromList [Inhabited R] (dim : Nat) : {n : Nat} → applyN List n R → Tensor n dim R
  | 0    , x => fun _ => x
  | _ + 1, ls => fun (x#:xs) => match ls.get? x with
    | none => panic! "Out of index."
    | some x => fromList dim x xs


def mkMat (f : Fin dim → Fin dim → R) : Tensor 2 dim R := fun (x#:y#:Vector.nil) => f x y

instance [ToString R] [ToString (applyN List n R)] : ToString (Tensor n d R) where
    toString := toString ∘ toList

instance [ToString (Tensor n d R)] : Repr (Tensor n d R) where
  reprPrec s _ := Std.Format.text $ toString s

instance [ToString R] : ToString (Vector R dim) where
  toString s := toString s.toList

instance [ToString (Vector R dim)] : Repr (Vector R dim) where
  reprPrec s _ := Std.Format.text $ toString s

def delta [Floating R] {dim : Nat} : Tensor 2 dim R := mkMat fun x y => if x == y then One.one else Zero.zero

def dimension : Tensor rank d R → Nat := fun _ => d

#check []
-- def sum [Add R] [Zero R] (t : Fin dim → Tensor rank dim R) : Tensor rank dim R
--   := List.sum ∘ Functor.map t $ finRange dim

notation "sum[" x "|" i:max "<" n:max "]" => List.sum (List.map (fun i => x) (finRange n))
-- Memorization
notation "⟦" t "⟧" => Tensor.fromList (Tensor.dimension t) $ Tensor.toList t
namespace Test

-- def tensor : Tensor 2 2 Float := fun ⟨ [x,y] , _ ⟩ => UInt64.toFloat $ UInt64.ofNatCore (x.val * y.val) sorry
def testTensor : Tensor 2 2 (Int × Nat) := fun ![x,y] => (- x.val , y.val)

#eval toList $ fromList 2 testTensor.toList
#eval toList $ delta (dim := 3) (R := Float)
#eval toList $ delta (dim := 3) (R := Float) + delta (dim := 3) (R := Float)

end Test

end Tensor
