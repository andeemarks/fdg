defmodule FDG do
  def parse(input) do
    spec_elements = Regex.named_captures(~r/(?<features>\(.*\))(?<deps>\[.*\])/, "(A,B,C,G,H)[G->A,H->A,H->B]", ungreedy: true)
    feature_spec = Map.fetch!(spec_elements, "features")
    deps_spec = Map.fetch!(spec_elements, "deps")
    features = String.split(String.strip(String.strip(feature_spec, ?)), ?(), ",")
    deps = String.split(String.strip(String.strip(deps_spec, ?]), ?[), ",")
    %{features: features, deps: deps}
  end
end
