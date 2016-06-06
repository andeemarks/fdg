defmodule FDGTest do
  use ExUnit.Case

  test "input parsing can handle feature lists" do
    assert Map.fetch!(FDG.parse("(A,B,C,G,H)"), :features) == ["A", "B", "C", "G", "H"]
  end
  test "input parsing can handle dependencies" do
    assert Map.fetch!(FDG.parse("(A,B,C,G,H)[G->A,H->A,H->B]"), :deps) == ["G->A", "H->A", "H->B"]
  end
end
