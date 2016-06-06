defmodule FDGTest do
  use ExUnit.Case

  test "input parsing can handle feature lists" do
    assert Map.fetch!(FDG.parse("(A,B,C,G,H)"), :features) == ["A", "B", "C", "G", "H"]
  end
  test "input parsing can handle dependencies" do
    assert Map.fetch!(FDG.parse("(A,B,C,G,H)[G->A,H->A,H->B]"), :deps) == ["G->A", "H->A", "H->B"]
  end
  
  test "input parsing can handle features across multiple specs" do
    assert Map.fetch!(FDG.parse("(A,B,C,G,H)[G->A,H->A,H->B]\n(D,E,F,I,J)[I->D,I->E,J->F,J->I,I->H]"), :features) == ["A", "B", "C", "G", "H", "D", "E", "F", "I", "J"]
  end

  test "dependency parsing fails if source feature does not exist" do
    assert_raise RuntimeError, fn -> FDG.parse("(G)[G->A]") end
  end

  test "dependency parsing fails if destination feature does not exist" do
    assert_raise RuntimeError, fn -> FDG.parse("(G)[G->A]") end
  end
end
