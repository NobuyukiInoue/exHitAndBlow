defmodule ExRepeatOffence do
  @spec main(args :: [String]) :: integer | nil
  def main(args) do
    repeat_count = ExCheckArguments.check_repeat_count(args)
    {n, enable_print, answer_number} = ExCheckArguments.check_arguments(args |> tl)
    if is_nil(n) do
      "N must be 10 or less." |> IO.puts()
      exit 1
    end

    result = loop_main(repeat_count, n, enable_print, answer_number)

    "\n==== ResultCount history =====" |> IO.puts()
    for i <- 0..Enum.count(result) - 1 do
      "ResultCount[" <> Integer.to_string(i) <> "] = " <> Integer.to_string(Enum.at(result, i)) |> IO.puts()
    end

    "======== distribution ========" |> IO.puts()
    result_max = Enum.max(result)
    result_sum = Enum.sum(result)
    result_average = result_sum / Enum.count(result)
    cnts = Enum.frequencies(result)
    for i <- 1..result_max do
      if is_nil(cnts[i]) do
        Integer.to_string(i) <> " ... 0"
      else
        Integer.to_string(i) <> " ... " <> Integer.to_string(cnts[i])
      end |> IO.puts()
    end
    "Distribution list Total = " <> Integer.to_string(Enum.count(result)) |> IO.puts()
    "==============================\n" <>
    "Total Questions = " <> Integer.to_string(result_sum) <> "\n" <>
    "Total Average   = " <> Float.to_string(result_average) <> "\n" <>
    "==============================" |> IO.puts()
    result_sum
  end

  @spec loop_main(repeat_count :: integer, n :: integer, enable_print :: bool, answer_number :: [integer]) :: [integer]
  def loop_main(repeat_count, n, enable_print, answer_number) do
    result =
    for i <- 1..repeat_count do
      "#------------------------------#\n" <>
      "# Running ... " <> Integer.to_string(i) <> "/" <> Integer.to_string(repeat_count) <> "\n" <>
      "#------------------------------#" |> IO.puts()
      target_numbers = Lib_hit_and_blow.create_target_numbers(n)

      {result, history} =
      if is_nil(answer_number) do
        Lib_hit_and_blow.offence(n, target_numbers, enable_print, Lib_hit_and_blow.create_random_n_digits_number(n))
      else
        Lib_hit_and_blow.offence(n, target_numbers, enable_print, answer_number)
      end

      Lib_hit_and_blow.print_offence_history(n, history, result)

#     total = total + Enum.count(history.response)
#     average = total / i
#     "\n# Latest Average = " <> Float.to_string(average) |> IO.puts()

      if result do
        Enum.count(history.response)
      else
        0
      end
    end
    result
  end
end
