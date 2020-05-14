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
            background_color: %Colour{r: 0, b: 0, g: 0},
            position: %Vector3{ x: 0, y: 0, z: 0 },
            direction: %Vector3{x: 0, y: 0, z: 0}, #implement later
            view_distance: 500,
            view_height: 500,
            view_width: 500
        },
        light: [],
        models: [ %Sphere {
            position: %Vector3{ x: 0, y: 0, z: 1000 },
            radius: 250,
            colour: %Colour{ r: 50, g: 50, b: 133 }
        } ]
    }
  end

  def create_ray(camera, frame_x, frame_y) do
    
  end

  def find_canvas_point_on_view_port(c_x, c_y, c_w, c_h, v_w, v_h, v_d) do
    Vector3.new(c_x * (v_w / c_w), c_y * (v_w / c_h), v_d)
  end

  def get_ray_direction(%Vector3{}= view_point, camera_position) do
    Vector3.subtract(view_point, camera_position)
  end

  def scan_frame(scene, {canvas_width, canvas_height}) do
    for canvas_x <- Kernel.trunc(-canvas_width / 2).. Kernel.trunc(canvas_width / 2),
        canvas_y <- Kernel.trunc(-canvas_height / 2).. Kernel.trunc(canvas_height / 2) do
          camera = scene.camera
          view_port_vector = find_canvas_point_on_view_port(
            canvas_x, 
            canvas_y,
            canvas_width,
            canvas_height,
            camera.view_height, 
            camera.view_width, 
            camera.view_distance)
          ray_direction = get_ray_direction(view_port_vector, camera.position)

          sphere = Enum.at(scene.models,0)
          case Sphere.check_collision(sphere, camera.position, ray_direction) do
            {a,b} -> Pixel.new(canvas_x, canvas_y, sphere.colour)
            nil -> Pixel.new(canvas_x, canvas_y, scene.colour.background_color)
          end
    end
  end

  def start(_type, _args) do
    scene = test_scene()
    width = 500
    height = 500
    frame_pixels = scan_frame(scene, {width, height})
    IO.inspect frame_pixels
    Output.write_to_file("output.png", frame_pixels, width, height)
  end
end
