defmodule Lib_hit_and_blow do
  @spec enum_contains(arr :: [integer], target :: integer) :: bool
  def enum_contains(arr, target) do
    not is_nil(Enum.find_index(arr, fn item -> item == target end))
  end

  @spec enum_index(arr :: [integer], target :: integer) :: integer | nil
  def enum_index(arr, target) do
    Enum.find_index(arr, fn item -> item == target end)
  end

  @spec set_n(args :: [String]) :: integer
  def set_n(args) do
    if Enum.count(args) < 2 do
      4
    else
      String.to_integer(Enum.at(args, 1))
    end
  end

  @spec create_target_numbers(n :: integer) :: [[integer]]
  def create_target_numbers(n) do
    if n > 0 do
      target_numbers =
      for i <- 0..9 do
        create_target_numbers(n - 1, [i])
      end
      Enum.flat_map(target_numbers, fn array -> Enum.filter(array,fn item -> item != 0 end ) end)
    end
  end

  @spec create_target_numbers(n :: integer, work_number :: [integer]) :: [integer]
  def create_target_numbers(0, work_number) do
    work_number
  end

  def create_target_numbers(n, work_number) do
    target_numbers =
    for i <- 0..9, not enum_contains(work_number, i) do
      create_target_numbers(n - 1, work_number ++ [i])
    end
    if n > 1 do
      Enum.flat_map(target_numbers, fn array -> Enum.filter(array,fn item -> item != 0 end ) end)
    else
      target_numbers
    end
  end

  # allows duplicates version create_random_n_digits_number().
  @spec create_random_n_digits_number_allows_dupulicate(n :: integer) :: String.t
  def create_random_n_digits_number_allows_dupulicate(n) do
    nums = for _ <- 1..n do (:rand.uniform 10) - 1 end
    Enum.join(nums, "")
  end

  @spec create_random_n_digits_number_str(n :: integer) :: String.t
  def create_random_n_digits_number_str(n) do
#   :rand.seed :os.timestamp
    Enum.join(create_random_n_digits_number(n, []), "")
  end

  @spec create_random_n_digits_number(n :: integer) :: [integer]
  def create_random_n_digits_number(n) do
#   :rand.seed :os.timestamp
    create_random_n_digits_number(n, [])
  end

  @spec create_random_n_digits_number(n :: integer, nums :: [integer]) :: [integer]
  def create_random_n_digits_number(n, nums) do
    if Enum.count(nums) == n do
      nums
    else
      num = (:rand.uniform 10) - 1
      if enum_contains(nums, num) do
        create_random_n_digits_number(n, nums)
      else
        create_random_n_digits_number(n, [num] ++ nums)
      end
    end
  end

  @spec offence(n :: integer, target_numbers :: [[integer]], enable_print :: bool, answer_number :: [integer]) :: {bool, HistoryRecords}
  def offence(n, target_numbers, enable_print, answer_number) do
#   :rand.seed :os.timestamp
    offence(n, target_numbers, enable_print, answer_number, %HistoryRecords{challenge: [], response: [], remaining_count: []}, 0, 0)
  end

  @spec offence(n :: integer, target_numbers :: [[integer]], enable_print :: bool, answer_number :: [integer], history :: HistoryRecords, challenge_count :: integer, hit :: integer) :: {bool, HistoryRecords}
  def offence(n, target_numbers, enable_print, answer_number, history, challenge_count, hit) do
    if hit == n do
      {true, history}
    else
      remaining_count = print_and_count_remaining(target_numbers, enable_print, answer_number)
      history = %{history | remaining_count: history.remaining_count ++ [remaining_count]}
      if remaining_count <= 0 do
        {false, history}
      else
 #      if n == 4 do
 #        selected_number = Lib_hit_and_blow.create_canidiate_number4_Minimum_question_strategy(n, target_numbers, history)
 #      # selected_number = Lib_hit_and_blow.create_canidiate_number4_Highest_winning_strategy(n, target_numbers, history)
 #      # selected_number = Lib_hit_and_blow.create_canidiate_number(n, target_numbers, history)
 #      else
 #        selected_number = Lib_hit_and_blow.create_canidiate_number(n, target_numbers, history)
 #      end
        selected_number = create_canidiate_number(n, target_numbers, history)
        history = %{history | challenge: history.challenge ++ [selected_number]}

        # print canidiate number.
        "Is your number " <> Mylib.intList_to_string_join(selected_number) <> " ?" |> IO.puts()

        # input response.
        {hit, blow} = get_hit_and_blow_count(n, answer_number, selected_number, challenge_count)
        "input response is Hit = " <> Integer.to_string(hit) <> ", Blow = " <> Integer.to_string(blow) |> IO.puts()

        history = %{history | response: history.response ++ [{hit, blow}]}

        # create new canidiates numbers list.
        new_target_numbers =
        for current_number <- target_numbers, answer_check(n, current_number, selected_number, hit, blow) do
          # new candidates number add.
          current_number
        end

        offence(n, new_target_numbers , enable_print, answer_number, history, challenge_count + 1, hit)
      end
    end
  end

  @spec defence(n :: integer, target_numbers :: [integer], enable_print :: bool, answer_number :: [integer]) :: {bool, HistoryRecords}
  def defence(n, target_numbers, enable_print, answer_number) do
    if is_nil(answer_number) do
      defence(n, target_numbers, enable_print, create_random_n_digits_number(n), %HistoryRecords{challenge: [], response: [], remaining_count: []}, 0)
    else
      "When you want to end on the way, please input 0\n" |> IO.puts()
      defence(n, target_numbers, enable_print, answer_number, %HistoryRecords{challenge: [], response: [], remaining_count: []}, 0)
    end
  end

  @spec defence(n :: integer, target_numbers :: [integer], enable_print :: bool, answer_number :: [integer], history :: HistoryRecords, challenge_count :: integer) :: {bool, HistoryRecords}
  def defence(n, target_numbers, enable_print, answer_number, history, challenge_count) do
    selected_number = input_selected_number(n, challenge_count)

    if is_nil(selected_number) do
        "break." |> IO.puts()
        {false, history}
    end

    history = %{history | remaining_count: history.remaining_count ++ [-1]}
    history = %{history | challenge: history.challenge ++ [selected_number]}

    {hit, blow} = response_check(answer_number, selected_number)

    history = %{history | response: history.response ++ [{hit, blow}]}

    "input response is Hit = " <> Integer.to_string(hit) <> ", Blow = " <> Integer.to_string(blow) <> "" |> IO.puts()

    if hit == n do
      "\n"
      <> "congratulations!!!\n"
      <> "my answer number is " <> Mylib.intList_to_string_join(answer_number) |> IO.puts()
      {true, history}
    else
      defence(n, target_numbers, enable_print, answer_number, history, challenge_count + 1)
    end
  end

  @spec get_hit_and_blow_count(n :: integer, answer_number :: [integer], selected_number :: [integer], challenge_count :: integer) :: {integer, integer}
  def get_hit_and_blow_count(n, answer_number, selected_number, challenge_count) do
    # input response.
    if not is_nil(answer_number) do
      response_check(answer_number, selected_number)
    else
      response_input(n, challenge_count + 1)
    end
  end

  @spec create_canidiate_number(n :: integer, target_numbers :: [[integer]], history :: HistoryRecords) :: [integer]
  def create_canidiate_number(n, target_numbers, history) do
    candidate = Enum.random(target_numbers)
    if history.challenge == [] do
      candidate
    else
      if enum_contains(history.challenge, candidate) do
        create_canidiate_number(n, target_numbers, history)
      else
        candidate
      end
    end
  end

  @spec response_check(answer_number :: [integer], target_number :: [integer]) :: {integer, integer}
  def response_check(answer_number, target_number) do
    for {n, m} <- Enum.zip(answer_number, target_number), reduce: {0, 0} do
      {hit, blow} ->
        cond do
          n == m -> {hit + 1, blow}
          n in target_number -> {hit, blow + 1}
          true -> {hit, blow}
        end
    end
  end

  @spec response_input(n :: integer, challenge_count :: integer) :: {integer, integer}
  def response_input(n, challenge_count) do
    "[" <> Integer.to_string(challenge_count) <> "] : please input H, B = " |> IO.write()
    workStr = String.replace(IO.gets(""), "\n", "")
    if workStr == Integer.to_string(n) do
      {n, 0}
    else
      response_input_check(n, challenge_count, workStr)
    end
  end

  @spec input_selected_number(n :: integer, challenge_count :: integer) :: [integer]
  def input_selected_number(n, challenge_count) do
    "[" <> Integer.to_string(challenge_count) <> "] : select number " <> String.pad_leading("x", n, "x") <> " = " |> IO.write()
    # input number.
    selected_number_str = String.replace(IO.gets(""), "\n", "")

    if String.length(selected_number_str) != n do
      selected_number_str <> " is invalid number." |> IO.puts()
      input_selected_number(n, challenge_count)
    else
      case Integer.parse(selected_number_str) do
        :error ->
          selected_number_str <> " is not decimal." |> IO.puts()
          input_selected_number(n, challenge_count)
        _ ->
          if String.length(selected_number_str) != n do
            "select number " <> selected_number_str <> " digits is not " <> to_string(n) |> IO.puts()
            input_selected_number(n, challenge_count)
          else
            selected_number =
            for i <- 1..n do
              elem(Integer.parse(String.at(selected_number_str, i - 1)), 0)
            end
            "set select number ... " <> Mylib.intList_to_string_join(selected_number) |> IO.puts()

            if check_uniq_digits(n, selected_number) do
              selected_number
            else
              selected_number_str <> " is invalid number." |> IO.puts()
              input_selected_number(n, challenge_count)
            end
        end
      end
    end
  end

  @spec check_uniq_digits(n :: integer, selected_number :: [integer]) :: bool
  def check_uniq_digits(n, selected_number) do
    check_uniq_digits(n, selected_number, 0, 0)
  end

  @spec check_uniq_digits(n :: integer, selected_number :: [integer], src_col :: integer, dst_col :: integer) :: bool
  def check_uniq_digits(n, selected_number, src_col, dst_col) do
    cond do
      src_col >= n ->
        true
      dst_col >= n ->
        check_uniq_digits(n, selected_number, src_col + 1, 0)
      src_col == dst_col ->
        check_uniq_digits(n, selected_number, src_col, dst_col + 1)
      Enum.at(selected_number, src_col) == Enum.at(selected_number, dst_col) ->
        false
      true ->
        check_uniq_digits(n, selected_number, src_col, dst_col + 1)
    end
  end

  @spec response_input_check(n :: integer, challenge_count :: integer, workStr :: String.t) :: {integer, integer}
  def response_input_check(n, challenge_count, workStr) do
    workStr = String.replace(workStr, " ", "")

    if String.contains?(workStr, ",") do
      flds = String.split(workStr, ",")
      response_input_check(n, challenge_count, workStr, flds)
    else
      if String.contains?(workStr, " ") do
        flds = String.split(workStr, " ")
        response_input_check(n, challenge_count, workStr, flds)
      else
        if String.length(workStr) == 2 do
          flds = [String.at(workStr, 0), String.at(workStr, 1)]
          response_input_check(n, challenge_count, workStr, flds)
        else
          workStr <>  " is invalid." |> IO.puts()
          response_input(n, challenge_count)
        end
      end
    end
  end

  @spec response_input_check(n :: integer, challenge_count :: integer, workStr :: String.t, flds :: [String.t]) :: {integer, integer}
  def response_input_check(n, challenge_count, workStr, flds) do
    if Enum.count(flds) != 2 do
      response_input(n, challenge_count)
    else
      hit = String.to_integer(Enum.at(flds, 0))
      blow = String.to_integer(Enum.at(flds, 1))
      if hit == n and blow == 0 do
        {n, 0}
      else
        if (hit + blow > n) or (hit < 0 or hit > n) or (blow < 0 or blow > n) or (hit == n - 1 and blow == 1) do
          workStr <>  " is invalid." |> IO.puts()
          response_input(n, challenge_count)
        else
          {hit, blow}
        end
      end
    end
  end

  @spec answer_check(n :: integer, table_number :: [integer], target_number :: [integer], hit :: integer, blow :: integer) :: bool
  def answer_check(n, table_number, target_number, hit, blow) do
    check_hit = count_hit(n, target_number, table_number, 0, 0)
    if check_hit != hit do
      false
    else
      check_blow = count_blow(n, target_number, table_number, 0, 0, 0)
      if check_blow != blow do
        false
      else
        true
      end
    end
  end

  @spec count_hit(n :: integer, target_number :: [integer], table_number :: [integer], col :: integer, blow :: integer) :: bool
  def count_hit(n, target_number, table_number, col, hit) do
    if col >= n do
      hit
    else
      if Enum.at(target_number, col) == Enum.at(table_number, col) do
        count_hit(n, target_number, table_number, col + 1, hit + 1)
      else
        count_hit(n, target_number, table_number, col + 1, hit)
      end
    end
  end

  @spec count_blow(n :: integer, target_number :: [integer], table_number :: [integer], col1 :: integer, col2 :: integer, blow :: integer) :: bool
  def count_blow(n, target_number, table_number, col1, col2, blow) do
    cond do
      col2 >= n ->
        count_blow(n, target_number, table_number, col1 + 1, 0, blow)
      col1 >= n ->
        blow
      col1 == col2 ->
        count_blow(n, target_number, table_number, col1, col2 + 1, blow)
      Enum.at(target_number, col1) == Enum.at(table_number, col2) ->
        count_blow(n, target_number, table_number, col1, col2 + 1, blow + 1)
      true ->
        count_blow(n, target_number, table_number, col1, col2 + 1, blow)
    end
  end

  @spec print_and_count_remaining(target_numbers :: [[integer]], enable_print :: bool, answer_number :: [integer]) :: integer
  def print_and_count_remaining(target_numbers, enable_print, answer_number) do
    if not is_nil(answer_number) and enable_print do
      "answer_number = " <> Mylib.intList_to_string_join(answer_number) |> IO.puts()
    end

    if enable_print == true do
      "----+-----" |> IO.puts()
    end

    {remaining_count, is_left_answer} = get_remaining_count(target_numbers, answer_number, enable_print, 0, false)

    if enable_print == true do
      "----+-----" |> IO.puts()
    end
    if not is_nil(answer_number) do
      if is_left_answer == false do
        "Error!! The answer " <> Mylib.intList_to_string_join(answer_number) <> " is not left." |> IO.puts()
        0
      end
    end

    "\n(remaining count = " <> String.pad_leading(Integer.to_string(remaining_count), 4) <> ") " |> IO.write()
    remaining_count
  end

  def get_remaining_count(target_numbers, answer_number, enable_print, remaining_count, is_left_answer) do
    if target_numbers == [] do
      {remaining_count, is_left_answer}
    else
      current_number = target_numbers |> hd
      if enable_print == true do
        Integer.to_string(remaining_count) <> ": " <> Mylib.intList_to_string_join(current_number) |> IO.puts()
      end
      if current_number == answer_number do
        get_remaining_count(target_numbers |> tl, answer_number, enable_print, remaining_count + 1, true)
      else
        get_remaining_count(target_numbers |> tl, answer_number, enable_print, remaining_count + 1, is_left_answer)
      end
    end
  end

  @spec print_offence_history(n :: integer, history :: HistoryRecords, result :: bool) :: :ok
  def print_offence_history(n, history, result) do
    if result do
      "calculate successful." |> IO.puts()
    else
      "calculate failed." |> IO.puts()
    end

    "\n===== challenge history ======" |> IO.puts()
    print_offence_history(n, 0, history, result)
  end

  @spec print_offence_history(n :: integer, i :: integer, history :: HistoryRecords, result :: bool) :: :ok
  def print_offence_history(n, i, history, result) do
    if i >= Enum.count(history.challenge) do
      :ok
    else
      {h, b} = Enum.at(history.response, i)
      "[" <> Integer.to_string(i + 1) <> "] ("
        <> String.pad_leading(Integer.to_string(Enum.at(history.remaining_count, i)), n)
        <> ") --> " <> Mylib.intList_to_string_join(Enum.at(history.challenge, i))
        <> " (" <> Integer.to_string(h)
        <> ", " <> Integer.to_string(b)
        <> ")" |> IO.puts()
      print_offence_history(n, i + 1, history, result)
    end
  end

  @spec print_defence_history(n :: integer, history :: HistoryRecords, result :: bool) :: :ok
  def print_defence_history(n, history, result) do
#    format_str = "[{0}]  .... {1} ({2}, {3})"
    "\n===== challenge history ======" |> IO.puts()
    print_defence_history(n, 0, history, result)
  end

  @spec print_defence_history(n :: integer, i :: integer, history :: HistoryRecords, result :: bool) :: :ok
  def print_defence_history(n, i, history, result) do
    if i >= Enum.count(history.challenge) do
      :ok
    else
      {h, b} = Enum.at(history.response, i)
      "[" <> Integer.to_string(i + 1) <> "] "
        <> " ... " <> Mylib.intList_to_string_join(Enum.at(history.challenge, i))
        <> " (" <> Integer.to_string(h)
        <> ", " <> Integer.to_string(b)
        <> ")" |> IO.puts()
      print_defence_history(n, i + 1, history, result)
    end
  end

end
