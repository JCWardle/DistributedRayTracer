defmodule PointLight do
    defstruct   position: nil,
        intensity: 0

    def new(position, intensity) do
        %PointLight{position: position, intensity: intensity}
    end
end
