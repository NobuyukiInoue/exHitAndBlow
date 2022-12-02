defmodule ExOffence do
  @spec main(args :: [String]) :: integer | nil
  def main(args) do
    {n, enable_print, answer_number} = ExCheckArguments.check_arguments(args)
    if is_nil(n) do
      "N must be 10 or less." |> IO.puts()
      exit 1
    end

    target_numbers = Lib_hit_and_blow.create_target_numbers(n)
    {result, history} = Lib_hit_and_blow.offence(n, target_numbers, enable_print, answer_number)
    Lib_hit_and_blow.print_offence_history(n, history, result)

    if result do
      Enum.count(history.response)
    else
      nil
    end
  end
end
