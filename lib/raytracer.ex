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
        light: [ %AmbientLight{ intensity: 0.5 } ],
        models: [ %Sphere {
            position: %Vector3{ x: 0, y: 0, z: 1000 },
            radius: 250,
            colour: %Colour{ r: 50, g: 50, b: 133 },
        }, %Sphere {
            position: %Vector3{ x: 200, y: 200, z: 1000 },
            radius: 50,
            colour: %Colour{ r: 255, g: 255, b: 255 },
        }, %Plane {
            position: %Vector3{ x: 0, y: 0, z: 1000 },
            angle: %Vector3{x: -0.5, y: 0, z: 0.5},
            colour: %Colour{ r: 0, g: 200, b: 200 }
        }]
    }
  end

  def find_canvas_point_on_view_port(c_x, c_y, c_w, c_h, v_w, v_h, v_d) do
    Vector3.new(c_x * (v_w / c_w), c_y * (v_w / c_h), v_d)
  end

  def get_ray_direction(%Vector3{}= view_point, camera_position) do
    Vector3.subtract(view_point, camera_position)
  end

  def check(%Plane{} = plane, camera_position, ray_direction) do
    [%{:intersection => Plane.check_collision(plane, camera_position, ray_direction), 
      :colour => plane.colour}]
  end

  def check(%Sphere{} = sphere, camera_position, ray_direction) do
    case Sphere.check_collision(sphere, camera_position, ray_direction) do
      {t1, t2} -> [%{:intersection => t1, 
        :colour => sphere.colour},
          %{:intersection => t2,
        :colour => sphere.colour}]
      nil ->
        nil
    end
  end

  def find_closest_object(view_port_vector, scene) do
    camera = scene.camera
    ray_direction = get_ray_direction(view_port_vector, camera.position)

    results = Enum.map(scene.models, fn(model) ->
      check(model, camera.position, ray_direction)
    end)
    |> Enum.reject(fn(result) -> 
      result == nil #Remove items that didn't intersect
    end)
    |> Enum.concat()
    
    if(Enum.count(results) == 0) do
        Pixel.new(canvas_x, canvas_y, scene.camera.background_color)
      else
        
        closestPoint = Enum.min_by(results, fn (result) -> 
          result.intersection
        end)
        Pixel.new(canvas_x, canvas_y, closestPoint.colour)
    end
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

          closest_object = find_closest_object(view_port_vector, scene)
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
