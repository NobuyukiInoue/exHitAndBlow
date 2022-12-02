defmodule ExRepeatOffence do
  @spec main(args :: [String]) :: integer | nil
  def main(args) do
    repeat_count = ExCheckArguments.check_repeat_count(args)
    {n, enable_print, answer_number} = ExCheckArguments.check_arguments(args |> tl)
    if is_nil(n) do
      "N must be 10 or less." |> IO.puts()
      exit 1
    end

    resultCount = loop_main(repeat_count, n, enable_print, answer_number)

    "\n==== ResultCount history =====" |> IO.puts()
    for i <- 0..Enum.count(resultCount) - 1 do
      "ResultCount[" <> Integer.to_string(i) <> "] = " <> Integer.to_string(Enum.at(resultCount, i)) |> IO.puts()
    end

    "======== distribution ========" |> IO.puts()
    result_max = Enum.max(resultCount)
    result_sum = Enum.sum(resultCount)
    result_average = result_sum / Enum.count(resultCount)
    cnts = Enum.frequencies(resultCount)
    for i <- 1..result_max do
      if is_nil(cnts[i]) do
        Integer.to_string(i) <> " ... 0"
      else
        Integer.to_string(i) <> " ... " <> Integer.to_string(cnts[i])
      end |> IO.puts()
    end
    "Distribution list Total = " <> Integer.to_string(Enum.count(resultCount)) |> IO.puts()
    "==============================\n" <>
    "Total Questions = " <> Integer.to_string(result_sum) <> "\n" <>
    "Total Average   = " <> Float.to_string(result_average) <> "\n" <>
    "==============================" |> IO.puts()
    result_sum
  end

  @spec loop_main(repeat_count :: integer, n :: integer, enable_print :: bool, answer_number :: [integer]) :: [integer]
  def loop_main(repeat_count, n, enable_print, answer_number) do
    loop_main(repeat_count, n, enable_print, answer_number, 1, 0, [])
  end

  @spec loop_main(repeat_count :: integer, n :: integer, enable_print :: bool, answer_number :: [integer], i :: integer, total :: integer, resultCount :: [integer]) :: [integer]
  def loop_main(repeat_count, n, enable_print, answer_number, i, total, resultCount) do
    if i > repeat_count do
      resultCount
    else
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

      new_total = total + Enum.count(history.response)
      "\n# Latest Average = " <> Float.to_string(new_total / i) |> IO.puts()
      loop_main(repeat_count, n, enable_print, answer_number, i + 1, new_total, resultCount ++ [Enum.count(history.response)])
    end
  end
end
