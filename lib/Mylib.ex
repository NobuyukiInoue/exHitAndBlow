defmodule Mylib do
  @spec intList_to_string_join(nums :: [integer]) :: String.t
  def intList_to_string_join(nums) do
    if is_nil(nums) do
      "nil"
    else
      Enum.join(nums, "")
    end
  end

  @spec intList_to_string(nums :: [integer]) :: String.t
  def intList_to_string(nums) do
    Enum.join(nums, ", ")
  end

  @spec intIntList_to_string(nums :: [[integer]]) :: String.t
  def intIntList_to_string(nums) do
    res =
    for arr <- nums do
      "[" <> intList_to_string(arr) <> "]"
    end
    Enum.join(res, ", ")
  end

  @spec matrix_to_string(name :: String.t, nums :: [[integer]]) :: String.t
  def matrix_to_string(name, nums) do
    res =
    for arr <- nums do
      " [" <> intList_to_string(arr) <> "]"
    end
    name <> " = [\n" <> Enum.join(res, ",\n") <> "\n]"
  end

  @spec stringArray_to_string(arr :: [String]) :: String.t
  def stringArray_to_string(arr) do
    "[" <> Enum.join(arr, ", ") <> "]"
  end
end
