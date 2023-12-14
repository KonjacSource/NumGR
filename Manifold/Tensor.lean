import Mathlib


def Tensor rank dim R := Vector (Fin dim) rank → R
@[simp]
def Mat := Tensor 2

namespace Tensor

class Derivable (I : Type u) (R : Type u) where
  dv : (I → R) → (I → R)
postfix:max "’" => Derivable.dv

class Floating (R : Type u)
  extends Add R, Sub R, Neg R, Div R, Pow R R, Zero R, One R, Mul R
        , Inhabited R, Derivable R R where
  default := zero
  half := div one (one + one)

instance : Floating Float where
  dv f x := let ε := 1e-4; (f (x + ε/2) - f (x - ε/2)) / ε

instance : Functor (Tensor rank dim) where
  map f t := fun v => f $ t v

instance [Derivable I R] : Derivable I (Tensor rank dim R) where
  dv f x := fun v => (flip f v)’ x

@[simp]
def applyN (f : α → α) : Nat → α → α
  | 0 , a => a
  | n + 1, a => f (applyN f n a)

instance [r2s : ToString R] : ToString (applyN List 0 R) where
  toString t := r2s.toString t

instance applyNToStr [ToString R] [ToString (applyN List n R)]
  : ToString (applyN List (n + 1) R) where

  toString x := toString (α := List (applyN List n R)) x

def finRange n : List (Fin n) := match n with
  | 0 => []
  | n + 1 => (finRange n : List (Fin (n + 1))).concat ⟨ n , by simp ⟩

def toList : {n : Nat} → Tensor n dim R → applyN List n R
  | 0    , t => t ⟨ [], by rfl ⟩
  | n + 1, t => List.map (fun i => toList fun v =>
        t ⟨ i :: v.val , by simp ⟩
      ) $ finRange dim

lemma lengthSuc : List.length (x :: xs) = n + 1 → List.length xs = n := by simp

def fromList [Inhabited R] (dim : Nat) : {n : Nat} → applyN List n R → Tensor n dim R
  | 0    , x => fun _ => x
  | _ + 1, ls => fun ⟨ x :: xs , prf ⟩ => match ls.get? x with
    | none => panic! "Out of index."
    | some x => fromList dim x ⟨ xs , lengthSuc prf ⟩


def mkMat (f : Fin dim → Fin dim → R) : Mat dim R := fun ⟨ [x,y] , _ ⟩ => f x y

instance [ToString R] [ToString (applyN List n R)] : ToString (Tensor n d R) where
    toString := toString ∘ toList

def delta [Floating R] {dim : Nat} : Mat dim R := mkMat fun x y => if x == y then One.one else Zero.zero

namespace Test

-- def tensor : Tensor 2 2 Float := fun ⟨ [x,y] , _ ⟩ => UInt64.toFloat $ UInt64.ofNatCore (x.val * y.val) sorry
def testTensor : Tensor 2 2 (Int × Nat) := fun ⟨ [x,y] , _ ⟩ => (- x.val , y.val)

#eval toList $ fromList 2 testTensor.toList


end Test

end Tensor
