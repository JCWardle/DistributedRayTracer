defmodule DefaultMaterial do
  # not shiny higher is shinier
  defstruct specular: 0,
            # between 0 and 1
            reflective: 0
end
