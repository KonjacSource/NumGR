import Manifold.Schwarzschild

open Float Schwar Tensor

-- def testRay : Ray (Schwar 1.0) := (Ray.mk
--     ⟨
--   ![0.040080, 4.960026, 1.570796, 0.000000]
--     , Schwarzschild (M:=1.0)⟩
--     (fromList 4 (
--   [1.005384, -0.998283, 0.000000, 0.000000]
--     : List Float))
-- )
-- #check Float


-- def main1 (n : Nat) : IO Unit := do
--   let mut ray := testRay
--   for _ in List.range n do
--     IO.println ray
--     match nextRay 0.01 ray with
--     | none => break
--     | some ⟨rp , d⟩ =>
--         ray := ⟨rp , ⟦d⟧⟩
--   IO.println "done."

-- #eval main1 10000
