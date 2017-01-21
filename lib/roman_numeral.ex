defmodule RomanNumeral do
  @moduledoc """
  Convert Arabic numbers to and from Roman numerals.
  """

  @translations [
    { 1000, "M" },
    { 900, "CM" },
    { 500, "D" },
    { 400, "CD" },
    { 100, "C" },
    { 90, "XC" },
    { 50, "L" },
    { 40, "XL" },
    { 10, "X" },
    { 9, "IX" },
    { 5, "V" },
    { 4, "IV" },
    { 1, "I" }
  ]

  @doc """
  Convert Arabic number to Roman numeral.

  ## Examples

      iex> RomanNumeral.to_roman(6)
      "VI"

  """

  def to_roman(number) do
    to_roman(number, @translations)
  end

  defp to_roman(number, _) when number < 1 do
    ""
  end

  defp to_roman(number, [{ arabic, roman } | tail ]) when number >= arabic do
    roman <> to_roman(number - arabic, [{ arabic, roman } | tail])
  end

  defp to_roman(number, [_ | tail]) do
    to_roman(number, tail)
  end

  @doc """
  Convert Roman numeral to Arabic number.

  ## Examples

      iex> RomanNumeral.to_number("VI")
      6

  """

  def to_number(numeral) do
    numeral_list = String.split(numeral, "", include_captures: true, trim: true)
    to_number(numeral_list, @translations)
  end

  defp to_number([], _) do
    0
  end

  defp to_number([only_numeral], translations) do
    match =  Enum.find(translations, nil, fn({ _, r }) -> r == only_numeral end)
    if match do
      { arabic, _ } = match
      arabic
    else
      raise "Invalid numeral \"#{ only_numeral }\" provided."
    end
  end

  defp to_number([first_numeral, second_numeral], translations) do
    match  = Enum.find(translations, nil, fn({ _, r }) -> r == first_numeral <> second_numeral end)
    if match do
      { arabic, _ } = match
      arabic
    else
      to_number([first_numeral], @translations) + to_number([second_numeral], @translations)
    end
  end


  defp to_number([first_numeral, second_numeral | numeral_tail ], translations) do
    to_number([first_numeral, second_numeral], translations) + to_number(numeral_tail, @translations)
  end

  #defp to_number([numerals_head, numerals_tail], [{ _, roman} | translations_tail ]) do
    #{ match_one, _ } = Enum.find(@translations, fn({ a, r }) -> r == numerals_head end)
    #match_one + to_number(numerals_tail, @translations)
  #end

end
