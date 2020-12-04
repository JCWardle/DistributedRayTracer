defmodule Colour do
    defstruct   r: nil,
                g: nil,
                b: nil

    def new(r,g,b) do
        %Colour{ r: limit_color(r), g: limit_color(g), b: limit_color(b) }
    end

    def limit_color(c) do
        if(c > 255) do
            255
        else
            trunc(c)
        end
    end

    def to_binary(%Colour{} = colour) do
        <<trunc(colour.r), trunc(colour.g), trunc(colour.b)>>
    end

    def light_color(%Colour{} = colour, intensity) do
        new(colour.r * intensity, colour.g * intensity, colour.b * intensity)
    end
end
