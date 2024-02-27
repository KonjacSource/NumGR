def f n := match n with
  | 0  => 1
  | m + 1 => (m + 1) * f m


def check n := match n with
  | 0 => 0
  | 1 => 1
  | m + 2 => check m
