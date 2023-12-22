-- import Mathlib

class Zero (α : Type u) where
  zero : α

instance [Zero α] : OfNat α 0 where
  ofNat := Zero.zero

class One (α : Type u) where
  one : α

instance [One α] : OfNat α 1 where
  ofNat := One.one

instance : Zero Float where
  zero := 0.0

instance : One Float where
  one := 1.0

def List.sum [Add α] [Zero α] : List α → α :=
  foldl (· + ·) 0



@[simp]
theorem length_map : List.length (List.map f ls) = List.length ls := by simp

open Nat

@[simp]
def min' : Nat → Nat → Nat
  | zero, _ => zero
  | _, zero => zero
  | succ n, succ m => succ (min' n m)

@[simp]
def min_same : min' n n = n :=
by
  cases n
  simp
  simp
  apply min_same

theorem lt_add_right {x n k : Nat} (prf : x < n) : x < n + k :=
by
  match k with
  | 0 => exact prf
  | succ k' =>
      apply Nat.le.step
      apply lt_add_right
      exact prf


@[simp]
theorem length_zip : (List.zip a b).length = min' (a.length) (b.length) :=
by
  cases a
  cases b
  rfl
  rfl
  cases b
  rfl
  simp[List.zip, List.zipWith]
  apply length_zip

universe u v w

inductive Vector (α : Type u) : Nat → Type u where
  | nil : Vector α 0
  | cons : α → Vector α n → Vector α (n+1)

infixr:67 " #: " => Vector.cons

namespace Vector

@[simp]
theorem lt_succ : succ m < succ n → m < n := Nat.le_of_succ_le_succ

def mk (ls : List α) (prf : ls.length = n) : Vector α n := match n, ls with
  | 0, [] => nil
  | n + 1, (x::xs) => x #: mk xs (by {simp at prf; exact prf})

def get : Vector α n → Fin n → α
  | x#:_, ⟨zero,_⟩ => x
  | _#:xs, ⟨i+1,f⟩ => get xs ⟨i, lt_succ f⟩

def set : Vector α n → Fin n → α → Vector α n
  | _#:xs, ⟨zero, _⟩, x' => x' #: xs
  | x#:xs, ⟨i+1, f⟩ , x' => x #: set xs ⟨i, lt_succ f⟩ x'

def replicate (n : Nat) (x : α) : Vector α n := match n with
  | 0 => nil
  | n+1 => x #: replicate n x

def zip : Vector α n → Vector β n → Vector (α × β) n
  | nil, nil => nil
  | x#:xs,y#:ys => (x,y) #: zip xs ys

def map (f : α → β) : Vector α n → Vector β n
  | nil => nil
  | x#:xs => f x #: map f xs

def toList : Vector α n → List α
  | nil => List.nil
  | x#:xs => x :: xs.toList

def pure (x : α) : Vector α n := replicate n x

def seq (f : Vector (α → β) n) (ls : Unit → Vector α n) : Vector β n
  := map (fun (f,x) => f x) $ zip f (ls ())

def concat : Vector α n → α → Vector α (n+1)
  | nil , a => a #: nil
  | x#:xs, a => x #: xs.concat a

def Vector.Functor : Functor (fun x => Vector x n) where
  map := map

def Applicative : Applicative (fun x => Vector x n) where
  pure := pure
  seq  := seq

def eq [BEq α] : Vector α n → Vector α n → Bool
  | nil, nil => True
  | x#:xs, y#:ys => x == y && eq xs ys

instance [BEq α] : BEq (Vector α n) where
  beq := eq

open Lean
macro_rules
  | `(![ $elems,* ]) => do
    let rec expandVecLit (i : Nat) (skip : Bool) (result : TSyntax `term) : MacroM Syntax := do
      match i, skip with
      | 0,   _     => Pure.pure result
      | i+1, true  => expandVecLit i false result
      | i+1, false => expandVecLit i true  (← ``(Vector.cons $(⟨elems.elemsAndSeps.get! i⟩) $result))
    let size := elems.elemsAndSeps.size
    if size < 64 then
      expandVecLit size (size % 2 == 0) (← ``(Vector.nil))
    else
      `(%[ $elems,* | Vector.nil ])

end Vector
