defmodule Main do
  @moduledoc """
  Documentation for `Main`.
  """
  @spec hello() :: :ok
  def hello() do
    "hello!" |> IO.puts()
  end

  @spec main(args :: [String.t]) :: :ok
  def main(args \\ []) do
    if Enum.count(args) < 1 do
      "Usage)\n" <>
      "./main defence [N [enable_print [answer_number]]]\n" <>
      "./main offence [N [enable_print [answer_number]]]\n" <>
      "./main repeat [repeat_count [N [enable print [answer number]]]]\n" <>
      "\n" <>
      "Example)\n" <>
      "./main defence 4\n" <>
      "./main defence 4 true 0123\n" <>
      "./main offence 4 true 0123\n" <>
      "./main repeat 100 4\n" <>
      "./main repeat 200 5 true\n" |> IO.puts()
      :ok
    else
      case Enum.at(args, 0) do
        "defence" ->
          ExDefence.main(args |> tl)
        "offence" ->
          ExOffence.main(args |> tl)
        "repeat" ->
          exectime = Benchmark.measure(fn ->
            ExRepeatOffence.main(args |> tl)
          end)
          "Total execution time ... " <> Float.to_string(Float.round(exectime, 3)) <> "[s]\n" |> IO.puts()
        _ ->
          "\"" <> Enum.at(args, 0) <> "\" is not define." |> IO.puts()
      end
      :ok
    end
  end
end
