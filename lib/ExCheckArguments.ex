defmodule ExCheckArguments do
  @spec check_arguments(args :: [String]) :: {integer, nil, nil}
  def check_arguments(args) do
    # set N
    if Enum.count(args) < 1 do
      {4, nil, nil}
    else
      res = Integer.parse(Enum.at(args, 0))
      case res do
        :error ->
          Enum.at(args, 0) <> " is not decimal." |> IO.puts()
          {nil, nil, nil}
        _ ->
          n = String.to_integer(Enum.at(args, 0))
          if n < 2 or n > 10 do
            "Give n between 2 and 10 inclusive." |> IO.puts()
            "N ... " <> to_string(n) |> IO.puts()
            {nil, nil, nil}
          else
            "N ... " <> Integer.to_string(n) |> IO.puts()
            check_arguments(args, n)
          end
      end
    end
  end

  @spec check_arguments(args :: [String], n :: integer) :: {integer, boolean, nil}
  def check_arguments(args, n) do
    # set enable_print
    if Enum.count(args) < 2 do
      {n, false, nil}
    else
      if String.upcase(Enum.at(args, 1)) == "TRUE" do
        check_arguments(args, n, true)
      else
        check_arguments(args, n, false)
      end
    end
  end

  @spec check_arguments(args :: [String], n :: integer, enable_print :: boolean) :: {integer, boolean, String.t | nil}
  def check_arguments(args, n, enable_print) do
    # set answer number
    if Enum.count(args) < 3 do
      {n, enable_print, nil}
    else
      case Integer.parse(Enum.at(args, 2)) do
        :error ->
          Enum.at(args, 2) <> " is not decimal." |> IO.puts()
          {n, enable_print, nil}
        _ ->
          answer_number_str = Enum.at(args, 2)
          if String.length(answer_number_str) != n do
            "answer number " <> answer_number_str <> " digits is not " <> to_string(n) |> IO.puts()
            {n, enable_print, nil}
          else
            answer_number =
            for i <- 1..n do
              elem(Integer.parse(String.at(answer_number_str, i - 1)), 0)
            end
            "set answer number ... " <> Mylib.intList_to_string_join(answer_number) |> IO.puts()
            {n, enable_print, answer_number}
          end
      end
    end
  end

  @spec check_repeat_count(args :: [String]) :: integer
  def check_repeat_count(args) do
    if Enum.count(args) < 1 do
      0
    else
      res = Integer.parse(Enum.at(args, 0))
      case res do
        :error ->
          Enum.at(args, 0) <> " is not decimal." |> IO.puts()
          0
        _ ->
          String.to_integer(Enum.at(args, 0))
      end
    end
  end
end
