defmodule Colour do
    defstruct   r: nil, 
                g: nil,
                b: nil
    
    def new(r,g,b) do
        
        %Colour{ r: r, g: g, b: b }
    end
    
    def to_binary(%Colour{} = colour) do
        <<colour.r, colour.g, colour.b>>
    end
end