defmodule AmbientLight do
    defstruct intensity: 0

    def new(intensity) do
        %AmbientLight{intensity: intensity}
    end
end