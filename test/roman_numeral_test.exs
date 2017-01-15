defmodule RomanNumeralTest do

  use ExUnit.Case
  doctest RomanNumeral

  test "converts Arabic numbers" do
    expectations = [
      { 0, "" },
      { 1, "I" },
      { 2, "II" },
      { 4, "IV" },
      { 5, "V" },
      { 6, "VI" },
      { 9, "IX" },
      { 10, "X" },
      { 11, "XI" },
      { 2918, "MMCMXVIII" }
    ]
    Enum.each expectations, fn({ arabic, roman }) ->
      assert RomanNumeral.to_roman(arabic) == roman
    end
  end

  test "converts Roman numerals" do
    expectations = [
      { "", 0 },
      { "I", 1 },
    ]
    Enum.each expectations, fn({ roman, arabic }) ->
      assert RomanNumeral.to_number(roman) == arabic
    end
  end

end
