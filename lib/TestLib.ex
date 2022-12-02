defmodule TestLib do
  @spec enum_contains2(arr :: [integer], target :: integer) :: bool
  def enum_contains2(arr, target) do
    if arr == [] do
      false
    else
      if arr |> hd == target do
        true
      else
        enum_contains2(arr |> tl, target)
      end
    end
  end

  @spec my_string_contains(arr :: String.t, target :: String.t) :: bool
  def my_string_contains(arr, target) do
    len_arr = String.length(arr)
    len_target = String.length(target)
    if len_arr < len_target do
      false
    else
      if String.slice(arr, 0, len_target) == target do
        true
      else
        my_string_contains(String.slice(arr, 1, len_arr - 1), target)
      end
    end
  end
end
