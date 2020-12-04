defmodule Pixel do
  defstruct x: nil,
            y: nil,
            colour: nil

  def new(x, y, colour) do
    %Pixel{x: x, y: y, colour: colour}
  end
end
