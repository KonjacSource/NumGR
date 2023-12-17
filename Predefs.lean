-- import Mathlib

/-!
The type `Vector` represents lists with fixed length.
-/

universe u v w
/-- `Vector α n` is the type of lists of length `n` with elements of type `α`. -/
def Vector (α : Type u) (n : Nat) :=
  { l : List α // l.length = n }

namespace Vector

variable {α : Type u} {β : Type v} {φ : Type w}

variable {n : Nat}

instance [DecidableEq α] : DecidableEq (Vector α n) :=
  inferInstanceAs (DecidableEq {l : List α // l.length = n})

/-- The empty vector with elements of type `α` -/
@[match_pattern]
def nil : Vector α 0 :=
  ⟨[], rfl⟩

/-- If `a : α` and `l : Vector α n`, then `cons a l`, is the vector of length `n + 1`
whose first element is a and with l as the rest of the list. -/
@[match_pattern]
def cons : α → Vector α n → Vector α (Nat.succ n)
  | a, ⟨v, h⟩ => ⟨a :: v, congrArg Nat.succ h⟩


/-- The length of a vector. -/
@[reducible]
def length (_ : Vector α n) : Nat :=
  n

open Nat

/-- The first element of a vector with length at least `1`. -/
def head : Vector α (Nat.succ n) → α
  | ⟨[], h⟩ => by contradiction
  | ⟨a :: _, _⟩ => a

/-- The head of a vector obtained by prepending is the element prepended. -/
theorem head_cons (a : α) : ∀ v : Vector α n, head (cons a v) = a
  | ⟨_, _⟩ => rfl

/-- The tail of a vector, with an empty vector having empty tail.  -/
def tail : Vector α n → Vector α (n - 1)
  | ⟨[], h⟩ => ⟨[], congrArg pred h⟩
  | ⟨_ :: v, h⟩ => ⟨v, congrArg pred h⟩

/-- The tail of a vector obtained by prepending is the vector prepended. to -/
theorem tail_cons (a : α) : ∀ v : Vector α n, tail (cons a v) = v
  | ⟨_, _⟩ => rfl

/-- Prepending the head of a vector to its tail gives the vector. -/
@[simp]
theorem cons_head_tail : ∀ v : Vector α (succ n), cons (head v) (tail v) = v
  | ⟨[], h⟩ => by contradiction
  | ⟨a :: v, h⟩ => rfl

/-- The list obtained from a vector. -/
def toList (v : Vector α n) : List α :=
  v.1

-- porting notes: align to `List` API
/-- nth element of a vector, indexed by a `Fin` type. -/
def get : ∀ _ : Vector α n, Fin n → α
  | ⟨l, h⟩, i => l.get (by
    rw [h.symm] at i
    exact i
  )

/-- Appending a vector to another. -/
def append {n m : Nat} : Vector α n → Vector α m → Vector α (n + m)
  | ⟨l₁, h₁⟩, ⟨l₂, h₂⟩ => ⟨l₁ ++ l₂, by simp [*]⟩

end Vector

class Zero (α : Type u) where
  zero : α

instance [Zero α] : OfNat α 0 where
  ofNat := Zero.zero

class One (α : Type u) where
  one : α

instance [One α] : OfNat α 1 where
  ofNat := One.one


def List.sum [Add α] [Zero α] : List α → α :=
  foldl (· + ·) 0

@[simp]
theorem length_map : List.length (List.map f ls) = List.length ls := by simp

-- open Nat
-- theorem min_succ {n m : Nat} : min (succ n) (succ m) = succ (min n m) := match n, m with
--   | 0, m => by cases m ; rfl; rfl
--   | n + 1, 0 => by rfl
--   | n + 1, m + 1 => by
--     rw [(min_succ (n:=n) (m:=m))]
--     simp[ite]


-- @[simp]
-- theorem length_zip : (List.zip a b).length = min (a.length) (b.length) :=
-- by
--   cases a
--   cases b
--   rfl
--   rfl
--   cases b
--   rfl
--   simp
