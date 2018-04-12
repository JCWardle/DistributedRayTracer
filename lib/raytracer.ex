defmodule RayTracer do
  use Application
  require Logger
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
            position: %Vector3{ x: 0, y: 1000, z: 500 },
            frame_y: 500
        },
        light: [],
        models: [ %Sphere {
            position: %Vector3{ x: 0, y: 0, z: 0 },
            radius: 250,
            colour: %Colour{ r: 255, g: 0, b: 0 }
        } ]
    }
  end

  def create_ray(camera, frame_x, frame_y) do
    
  end

  def scan_frame(scene, {image_x, image_y}) do
    frame_y = scene.camera.frame_y
    start_x = 0 - Integer.floor_div(image_x, 2)
    start_z = 250 - Integer.floor_div(image_y, 2)


    for x <- start_x..image_x,
        z <- start_z..image_y do
            camera_position = scene.camera.position
            frame_v = Vector3.new(x, frame_y, z)
            direction = Vector3.subtract(frame_v, camera_position)
            ray = Vector3.normalize(direction)
            IO.inspect ray
    end
  end

  def start(_type, _args) do
    scene = test_scene()

    scan_frame(scene, {500, 500})
  end
end
