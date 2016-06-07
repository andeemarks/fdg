defmodule FDG do
  require Logger

  @input_spec_re "~r/(?<features>\(.*\))(?<deps>\[.*\])/"

  def parse_features(input) do
    captured_features = Regex.named_captures(~r/(?<features>\(.*\))/, input, ungreedy: true)
    # Logger.info(captured_features)
    feature_spec = Map.fetch!(captured_features, "features")
    features = String.split(String.strip(String.strip(feature_spec, ?)), ?(), ",")
  end

  def parse_deps(input) do
    captured_deps = Regex.named_captures(~r/(?<deps>\[.*\])/, input, ungreedy: true)
    # Logger.info(captured_deps)
    if (captured_deps) do
      deps_spec = Map.fetch!(captured_deps, "deps")
      deps = String.split(String.strip(String.strip(deps_spec, ?]), ?[), ",")
    end

  end

  def parse(input) do
    features = parse_features(input)
    deps = parse_deps(input)
    if (deps) do
      features_in_deps = MapSet.new(Enum.uniq(Enum.flat_map(deps, fn (x) -> String.split(x, "->") end)))
      # Logger.info(features)
      all_deps_exist = MapSet.subset?(features_in_deps, MapSet.new(features))
      if (all_deps_exist) do
        %{features: features, deps: deps}
      else
        raise RuntimeError, "Found dependency pair referring to non-existant features"
      end
    else
      %{features: features, deps: nil}
    end
  end
end
