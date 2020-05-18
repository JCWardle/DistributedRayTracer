defmodule DirectionalLight do
    defstruct   direction: nil,
        intensity: 0

    def new(direction, intensity) do
        %DirectionalLight{direction: direction, intensity: intensity}
    end
end
