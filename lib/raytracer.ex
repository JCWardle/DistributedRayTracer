defmodule RayTracer do
  use Application
  @moduledoc """
  Documentation for RayTracer.
  """

  @doc """
  Hello world.

  ## Examples

      iex> RayTracer.hello
      :world

  """

  def test_scene() do
    %Scene {
        camera: %Camera {
            position: %Vector3{ x: 0, y: 1000, z: -1000 },
            direction: %Vector3{ x: 0, y: 0, z: 0 }
        },
        light: [],
        models: [ %Sphere {
            position: %Vector3{ x: 0, y: 0, z: 0 },
            radius: 500,
            colour: %Colour{ r: 255, g: 0, b: 0 }
        } ]
    }
  end

  def start(_type, _args) do
    scene = test_scene()
    IO.inspect scene
  end
end
