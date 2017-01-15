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
    { 6, "VI" },
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

  defp to_number([numeral], [{ arabic, roman }]) when numeral == roman do
    arabic
  end

  defp to_number([numeral], [{ arabic, roman }]) do
    raise "Invalid numeral \"#{ numeral }\" provided."
  end

  defp to_number([numerals_head, numerals_tail],  [{arabic, roman } | _]) when numerals_head <> numerals_tail == roman do
    arabic
  end

  defp to_number([numerals_head, numerals_tail],  [{arabic, roman } | translations_tail]) do
    to_number([numerals_head, numerals_tail], translations_tail)
  end

  defp to_number([numeral], [{ arabic, roman } | other_translations ]) do
    if (numeral == roman) do
      arabic
    else
      to_number([numeral], other_translations)
    end
  end

  defp to_number([numerals_head | numerals_tail], [{ arabic, roman } | translations_tail ]) do
    if (numerals_head <> List.first(numerals_tail) == roman) do
      [ _, remaining_numerals ] = List.pop_at(numerals_tail, 0)
      arabic + to_number(remaining_numerals, @translations)
    else
      if (numerals_head == roman) do
        arabic + to_number(numerals_tail, @translations)
      else
        first_two = numerals_head <> List.first(numerals_tail)
        { match_two, _ } = Enum.find(@translations, fn({ a, r }) -> r == first_two end)
        if (match_two) do
          IO.puts(numerals_tail)
          [ _, remaining_numerals ] = List.pop_at(numerals_tail, 0)
          if (length(remaining_numerals > 1)) do
            match_two + to_number(remaining_numerals, @translations)
          else
            match_two
          end
        else
          { match_one, _ } = Enum.find(@translations, fn({ a, r }) -> r == numerals_head end)
          match_one + to_number(numerals_tail, @translations)
        end
      end
    end
  end

  defp to_number([head | tail], _) when head <> tail == "VI" do
    6
  end

  #defp to_number(numeral, [{ arabic, roman } | tail ]) do
    #if (numeral == roman)
      #arabic
    #else
      #to_number(numeral | tail)
    #end
  #end

end
